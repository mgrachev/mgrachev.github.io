---
layout: post
title: "Настройка Passenger для работы с Action Cable"
date: 2016-02-25 17:00:00
tags: rails action cable websockets phusion passenger nginx
summary: "Решаем проблему работы WebSocket-сервера через Phusion Passenger."
---

В декабре прошлого года, была представлена [5 версия](http://weblog.rubyonrails.org/2015/12/18/Rails-5-0-beta1){:target='_blank'}, всеми любимого фреймворка Ruby on Rails. Главной особенностью новой версии стал Action Cable, который позволяет легко интегрировать WebSockets с остальной частью вашего Rails приложения.

### Action Cable

На днях появилась задача, считать количество онлайн пользователей на сайте. Для этих целей я решил использовать Action Cable, тем более готовый пример уже был в [документации](https://github.com/rails/rails/tree/master/actioncable#channel-example-1-user-appearances){:target='_blank'}.

Реализовав задачу и отправив все изменения на сервер, я столкнулся с проблемой подключения к WebSocket серверу через браузер Safari.

![Safari]({{ site.url }}/assets/images/2016-02-25-configuring-passenger-to-work-with-action-cable/2bjj7navgRrodbRv.png){: .center-image }

### Phusion Passenger

В качестве сервера приложений я использую Phusion Passenger. По умолчанию каждый процесс Passenger может одновременно обрабатывать только 1 запрос. Для работы WebSockets этого будет недостаточно.

Начиная с версии 5.0.22, Passenger имеет опцию `passenger_force_max_concurrent_requests_per_process`, которая позволяет указазать, какое количество запросов может обработать каждый процесс одновременно. Если в качестве параметра передать `0`, то количество запросов будет неограничено.

Приступаем к настройке. Первым делом обновляем Passenger. На данный момент, самая последняя версия - [5.0.25](https://blog.phusion.nl/2016/02/18/passenger-5-0-25/){:target='_blank'}, в ней улучшена интеграция с Rails 5 и Action Cable.

Рассмотрим ситуацию, когда Action Cable сервер работает внутри основного приложения:

{% highlight ruby %}
# config/routes.rb
Example::Application.routes.draw do
  mount ActionCable.server => '/cable'
end
{% endhighlight %}

Открываем настройки виртуального хоста для вашего проекта из директории `/etc/nginx/sites-available` и добавляем следующие строчки внутрь блока `server`:

{% highlight bash %}
server {
  ...
  location /cable {
    passenger_app_group_name YOUR_APP_NAME_action_cable;
    passenger_force_max_concurrent_requests_per_process 0;
  }
}
{% endhighlight %}

Если Action Cable сервер запущен в отдельном процессе, то виртуальный хост будет выглядить следующим образом:

{% highlight bash %}
server {
    listen YOUR_ACTION_CABLE_PORT_NUMBER;
    server_name YOUR_ACTION_CABLE_HOST_NAME;
    root /path-to-your-app/public;
    passenger_enabled on;
    passenger_app_group YOUR_APP_NAME_action_cable;
    passenger_app_type rack;
    passenger_startup_file config/cable.ru;
    passenger_force_max_concurrent_requests_per_process 0;
}
{% endhighlight %}

Чтобы изменений вступили в силу, перезагружаем сервер:

{% highlight bash %}
$ sudo service nginx restart
{% endhighlight %}

И вуаля, все работает.
