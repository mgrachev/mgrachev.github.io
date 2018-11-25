---
layout: post
title: "Автоматическая проверка кода на Go"
date: 2018-11-26 08:00:00
tags: go reviewdog pronto ruby github gitlab golint golangci-lint gometalinter travis circle git diff checkstyle
summary: "Обзор инструмента для автоматической проверки кода на Go."
---

В прошлый раз, я уже писал небольшую инструкцию про то, как [настроить автоматическую проверку кода](http://www.mgrachev.com/2017/03/20/automatic-code-review-with-vexor){:target='_blank'} с помощью [pronto](https://github.com/prontolabs/pronto){:target='_blank'}. Это отличный инструмент, который позволяет проверить качество кода при помощи всевозможных линтеров и получить результат в виде комментариев на GitHub или GitLab. Но, он написан на Ruby, следовательно, подключить его к проектам на других языках программирования, не представляется возможным. Поэтому, я начал искать альтернативу и нашел - [reviewdog](https://github.com/haya14busa/reviewdog){:target='_blank'}.

![reviewdog]({{ site.url }}/assets/images/2018-11-26-automatic-code-review-in-go/reviewdog-dh9ga6g0.png){: .center-image }

В отличие от pronto, reviewdog написан на Go. Его можно скомпилировать и подключить к любому проекту, вне зависимости от языка программирования.

Также, он может работать с любыми линтерами, достаточно лишь перенаправить результат работы линтера на вход reviewdog и определить формат сообщения. Для этого, reviewdog нужно запустить с флагом `-efm` и передать в качестве параметра строку вида: `"%f:%l:%c: %m"`. Для примера, возьмем [golint](https://github.com/golang/lint){:target='_blank'}:

{% highlight bash %}
$ golint ./... | reviewdog -efm="%f:%l:%c: %m" -diff="git diff master"
{% endhighlight %}

Флаг `-diff` обязателен лишь для локального запуска, он позволяет отфильтровать результат и вывести сообщения только для новых изменений. 

Чтобы постоянно не определять формат для каждого линтера, reviewdog поставляется с уже предопределенными форматами. Список можно получить, запустив его с флагом `-list`:

{% highlight bash %}
$ reviewdog -list
eslint		(eslint [-f stylish]) A fully pluggable tool for identifying and reporting on patterns in JavaScript	- https://github.com/eslint/eslint
eslint-compact	(eslint -f compact) A fully pluggable tool for identifying and reporting on patterns in JavaScript	- https://github.com/eslint/eslint
golint		linter for Go source code										- https://github.com/golang/lint
govet		Vet examines Go source code and reports suspicious problems						- https://golang.org/cmd/vet/
pep8		Python style guide checker										- https://pypi.python.org/pypi/pep8
phpstan		(phpstan --errorFormat=raw) PHP Static Analysis Tool - discover bugs in your code without running it!	- https://github.com/phpstan/phpstan
rubocop		A Ruby static code analyzer, based on the community Ruby style guide					- https://github.com/bbatsov/rubocop
sbt		the interactive build tool										- http://www.scala-sbt.org/
sbt-scalastyle	Scalastyle - SBT plugin											- http://www.scalastyle.org/sbt.html
scalac		Scala compiler												- http://www.scala-lang.org/
scalastyle	Scalastyle - Command line										- http://www.scalastyle.org/command-line.html
stylelint	A mighty modern CSS linter										- https://github.com/stylelint/stylelint
tsc		TypeScript compiler											- https://www.typescriptlang.org/
tslint		An extensible linter for the TypeScript language							- https://github.com/palantir/tslint
checkstyle	checkstyle XML format											- http://checkstyle.sourceforge.net/
{% endhighlight %}

Список небольшой, но он включает все популярные линтеры для разных языков программирования. Теперь, вместо определения формата, можно передать его название с помощью флага `-f`:

{% highlight bash %}
$ golint ./... | reviewdog -f=golint -diff="git diff master"
{% endhighlight %}

Этот же формат можно использовать и для других линтеров, например для [golangci-lint](https://github.com/golangci/golangci-lint){:target='_blank'}:

{% highlight bash %}
$ golangci-lint run | reviewdog -f=golint -diff="git diff master"
{% endhighlight %}

Отдельно стоит упомянуть поддержку XML-формата [checkstyle](http://checkstyle.sourceforge.net){:target='_blank'}. С его помощью можно работать с такими линтерами, как например [gometalinter](https://github.com/alecthomas/gometalinter){:target='_blank'}: 

{% highlight bash %}
$ gometalinter --checkstyle | reviewdog -f=checkstyle -diff="git diff master"
{% endhighlight %}

Для более удобного запуска нескольких линтеров, reviewdog поддерживает конфигурационные файлы следующего формата:

{% highlight yaml %}
# .reviewdog.yml
runner:
  <tool-name>:
    cmd: <command> # (required)
    errorformat: # (optional if there is supporeted format for <tool-name>. see reviewdog -list)
      - <list of errorformat>
    name: <tool-name> # (optional. you can overwrite <tool-name> defined by runner key)

  # examples
  golint:
    cmd: golint ./...
    errorformat:
      - "%f:%l:%c: %m"
  govet:
    cmd: go tool vet -all -shadowstrict .
{% endhighlight %}

Теперь достаточно просто запустить reviewdog и он сам все сделает:

{% highlight bash %}
$ reviewdog -diff="git diff master"
{% endhighlight %}

По умолчанию reviewdog выводит весь результат работы в консоль. Для того, чтобы опубликовать результат на GitHub, нужно объявить переменную окружения `REVIEWDOG_GITHUB_API_TOKEN` и запустить reviewdog с флагом `-reporter=github-pr-review`:

{% highlight bash %}
$ export REVIEWDOG_GITHUB_API_TOKEN="<token>"
$ reviewdog -reporter=github-pr-review
{% endhighlight %}

В таком случае флаг `-diff` уже не нужен, reviewdog получит необходимые данные из переменных окружения:

{% highlight bash %}
$ export CI_PULL_REQUEST=7
$ export CI_REPO_OWNER=mgrachev
$ export CI_REPO_NAME=gastly
$ export CI_COMMIT=$(git rev-parse HEAD)
{% endhighlight %}

На этом плюсы reviewdog не заканчиваются, т.к. он из коробки поддерживает несколько популярных CI, таких как: Travis CI, Circle CI и GitLab CI. Если вы используете один из этих сервисов, то вам не нужно объявлять эти переменные окружения.

Это лишь малая часть тех возможностей, на что способен reviewdog. Более подробную информацию можно получить на странице проекта [haya14busa/reviewdog](https://github.com/haya14busa/reviewdog){:target='_blank'}. 
