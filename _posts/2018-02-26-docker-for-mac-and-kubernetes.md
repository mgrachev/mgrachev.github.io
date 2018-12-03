---
layout: post
title: "Docker for Mac и Kubernetes"
date: 2018-02-26 18:00:00
tags: docker kubernetes helm go mac minikube postgres postgresql nginx homebrew
summary: "Небольшой эксперимент с Docker for Mac и Kubernetes."
---

Начиная с версии 17.12 CE Edge, Docker for Mac поставляется вместе с [Kubernetes](https://docs.docker.com/docker-for-mac/kubernetes){:target='_blank'}. Теперь для создания локального Kubernetes кластера нет необходимости в использовании дополнительных инструментов, таких как [Minikube](https://github.com/kubernetes/minikube){:target='_blank'}. В качестве эксперимента, попробуем развернуть на кластере небольшой сервис и посмотрим, что из этого получится.

На момент написания статьи, у меня установлена самая последняя версия Docker for Mac - 18.02.0.

![Docker For Mac]({{ site.url }}/assets/images/2018-02-26-docker-for-mac-and-kubernetes/docker-ja2lcwo8.png){: .center-image }

Для эксперимента, я написал простой генератор коротких ссылок на Go - [brevity](https://github.com/mgrachev/brevity){:target='_blank'}. Сервис разделен на 2 части: API для генерация коротких ссылок и их обработчик. Для хранения данных используется PostgreSQL.

Чтобы развернуть его и все необходимые зависимости, нам потребуется [Helm](https://helm.sh){:target='_blank'} - пакетный менеджер для Kubernetes, который заметно упрощает процесс развертывания и дальнейшей поддержки различных сервисов. Для его установки мы воспользуемся [Homebrew](https://brew.sh){:target='_blank'}:

{% highlight bash %}
$ brew install kubernetes-helm
{% endhighlight %}

После установки, нам нужно будет инициализировать Helm:

{% highlight bash %}
$ helm init
{% endhighlight %}

Если у вас настроен доступ к нескольких Kubernetes кластерам, то вам необходимо будет переключиться на локальный:

{% highlight bash %}
$ kubectl config use-context docker-for-desktop
{% endhighlight %}

Подготовка завершена, теперь приступаем к установке необходимых сервисов. Первым делом устанавливаем PostgreSQL:

{% highlight bash %}
$ helm install --name pg --namespace db --set postgresPassword=postgres,persistence.size=1Gi stable/postgresql
{% endhighlight %}

Helm позволяет переопределять значения по-умолчанию и тем самым настроить сервис под собственные нужды. Список сервисов, которые можно установить через Helm можно найти здесь - [hub.kubeapps.com](https://hub.kubeapps.com){:target='_blank'}.

Теперь нам нужно удостовериться, что сервис установлен и работает корректно:

{% highlight bash %}
$ kubectl get pods -n db
NAME                            READY     STATUS                       RESTARTS   AGE
pg-postgresql-bbd4bbb5c-njkzs   0/1       CreateContainerConfigError   0          <invalid>
{% endhighlight %}

Сервис не запущен из-за ошибки. Чтобы узнать подробности, достаточно выполнить следующую команду:

{% highlight bash %}
$ kubectl describe pods -n db pg-postgresql-bbd4bbb5c-njkzs | tail -n 1
Warning  Failed                 <invalid> (x4 over 19s)  kubelet, docker-for-desktop  Error: lstat /Users/mgrachev/.docker/Volumes/pg-postgresql/pvc-588afa8b-0e90-11e8-8d22-025000000001: no such file or directory
{% endhighlight %}

Kubernetes не видит директорию, хотя она на самом деле есть. Оказалось, что Docker for Mac не  понимает опцию `subPath` в конфигурации [PostgreSQL](https://github.com/kubernetes/charts/blob/master/stable/postgresql/templates/deployment.yaml#L77){:target='_blank'} для Kubernetes. В Minikube тоже была такая проблема, но её уже [исправили](https://github.com/kubernetes/minikube/issues/2256){:target='_blank'}.

Для решения этой проблемы, нам понадобится отредактировать `Deployment` для PostgreSQL:

{% highlight bash %}
$ kubectl edit deployment -n db pg-postgresql
{% endhighlight %}

И удалить следующую строчку:

{% highlight yaml %}
subPath: postgresql-db
{% endhighlight %}

Теперь, если мы еще раз посмотрим на список запущенных подов, то увидим, что ошибок нет и сервис запущен:

{% highlight bash %}
$ kubectl get pods -n db
NAME                             READY     STATUS    RESTARTS   AGE
pg-postgresql-5c954c46c6-6bt2t   1/1       Running   0          26s
{% endhighlight %}

Далее, нам нужно создать БД для brevity. Сначала зайдем в контейнер:

{% highlight bash %}
$ kubectl exec -it -n db pg-postgresql-5c954c46c6-6bt2t bash
{% endhighlight %}

Внутри контейнера запускаем `psql` от имени пользователя `postgres` и создаем БД:

{% highlight bash %}
root@pg-postgresql-5c954c46c6-6bt2t:/# gosu postgres psql
postgres=# CREATE DATABASE brevity_production;
{% endhighlight %}

Чтобы наше приложение было доступно из кластера, нам понадобится [Ingress Controller](https://kubernetes.io/docs/concepts/services-networking/ingress/#ingress-controllers){:target='_blank'}. Для этих целей отлично подойдет `nginx`:

{% highlight bash %}
$ helm install --name nginx stable/nginx-ingress
{% endhighlight %}

Переходим к установке brevity. Склонируем проект и запустим команду `helm install`, только в качестве аргумента передадим путь к заранее подготовленному [чарту](https://github.com/mgrachev/brevity/tree/master/helm){:target='_blank'} (пакеты в Helm называются чартами):

{% highlight bash %}
$ git clone https://github.com/mgrachev/brevity
$ cd brevity
$ helm install --name brevity ./helm
{% endhighlight %}

Проверяем, что все сервисы запущены:

{% highlight bash %}
$ kubectl get pods
NAME                                                   READY     STATUS    RESTARTS   AGE
brevity-brevity-778799dd4-zlb6g                        1/1       Running   0          1h
nginx-nginx-ingress-controller-c8cf56768-h4txk         1/1       Running   0          1h
nginx-nginx-ingress-default-backend-864c9484bf-rfdq4   1/1       Running   0          1h
{% endhighlight %}

Далее попробуем сгенерировать короткую ссылку, отправив POST запрос к API brevity:

{% highlight bash %}
$ curl -X "POST" "http://localhost/api/v1/shortlink" --data-urlencode "url=https://github.com/mgrachev"
{"shortlink":"http://localhost/MyAyEy"}
{% endhighlight %}

Переходим по ней, чтобы удостовериться, что все работает. Так же мы можем посмотреть логи:

{% highlight bash %}
$ kubectl logs brevity-brevity-778799dd4-zlb6g
time="2018-02-19T09:31:03Z" level=info msg="HTTP Server started at port: 80"
time="2018-02-19T09:32:35Z" level=info msg="Successful returns a short link, short: http://localhost/MyAyEy, original: https://github.com/mgrachev"
time="2018-02-19T09:32:43Z" level=info msg="Redirect to https://github.com/mgrachev, using token: MyAyEy"
{% endhighlight %}

Как видно из логов, сервис успешно обработал короткую ссылку и перенаправил на страницу [github.com/mgrachev](https://github.com/mgrachev){:target='_blank'}. На этом можно закончить наш эксперимент.

В заключение скажу, что Docker for Mac с поддержкой Kubernetes меня порадовал. Достаточно в настройках поставить всего одну галочку и в твоем распоряжение будет полностью готовый к работе кластер с Kubernetes на борту. Из минусов отмечу, что это пока нестабильная версия и могут встречаться разного рода ошибки. Но даже сейчас, он вполне пригоден для локальной разработки и тестирования.
