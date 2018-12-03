---
layout: post
title: "Автоматическая проверка кода с помощью Vexor"
date: 2017-03-20 12:00:00
tags: pronto vexor github hound rubocop overcommit
summary: "Пошаговая инструкция, что для этого нужно сделать."
---

Я думаю многим известен сервис [Hound](https://houndci.com/){:target='_blank'}, который занимается автоматической проверкой кода. Когда вы создаете новый Pull Request на GitHub, Hound запускает проверку вашего кода на основе таких решений, как [rubocop](https://github.com/bbatsov/rubocop){:target='_blank'}, [haml-lint](https://github.com/brigade/haml-lint){:target='_blank'} или [scss-lint](https://github.com/brigade/scss-lint){:target='_blank'}. Если в процессе проверки всплывают какие-то проблемы, Hound сообщит об этом, добавив соответствующий комментарий в ваш Pull Request. Это отличный инструмент для работы, но как говорится, за всё хорошее, приходится платить.

![Hound Price]({{ site.url }}/assets/images/2017-03-20-automatic-code-review-with-vexor/hound_price_65d0c3b2.png){: .center-image }

Не каждая компания готова платить такие деньги, поэтому я решил пойти другим путём. За основу взял библиотеку [pronto](https://github.com/mmozuras/pronto){:target='_blank'}, которая из коробки умеет всё тоже самое, что и Hound. Осталось дело за малым - интегрировать pronto с [Vexor](https://vexor.io/){:target='_blank'}. Далее идет пошаговая инструкция, что для этого понадобится сделать.

Первым делом заходим на [GitHub](https://github.com/settings/tokens/new){:target='_blank'} и генерируем персональный токен.

![Access Token]({{ site.url }}/assets/images/2017-03-20-automatic-code-review-with-vexor/access_token_fa6c4cc3.png){: .center-image }

Затем, добавляем 2 переменные окружения в настройках вашего проекта на Vexor.

![Env Variables]({{ site.url }}/assets/images/2017-03-20-automatic-code-review-with-vexor/env_97b84eb4.png){: .center-image }

Далее, добавляем pronto и несколько его плагинов в `Gemfile` вашего проекта. Список доступных плагинов можно найти по этой [ссылке](https://github.com/mmozuras/pronto#runners){:target='_blank'}.

{% highlight ruby %}
group :test do
  gem 'pronto'
  gem 'pronto-brakeman', require: false
  gem 'pronto-coffeelint', require: false
  gem 'pronto-fasterer', require: false
  gem 'pronto-flay', require: false
  gem 'pronto-haml', require: false
  gem 'pronto-jshint', require: false
  gem 'pronto-rails_best_practices', require: false
  gem 'pronto-reek', require: false
  gem 'pronto-rubocop', require: false
  gem 'pronto-scss', require: false
end
{% endhighlight %}

Для запуска pronto нам потребуется создать файл `bin/pronto`:

{% highlight ruby %}
#!/usr/bin/env ruby

require 'bundler/setup'
require 'pronto'
require 'pronto/cli'

begin
  Pronto::CLI.start
rescue Octokit::NotFound
  puts 'Pull Request Not Found'
end
{% endhighlight %}

И дать ему права на выполнение:

{% highlight bash %}
$ chmod +x bin/pronto
{% endhighlight %}

Теперь нам остаётся только добавить несколько команд в `.vexor.yml`:

{% highlight ruby %}
language: ruby

script:
  - git remote set-branches origin '*'
  - git fetch
  - git checkout $CI_BRANCH
  - bin/pronto run -f github_pr -c $DEFAULT_BRANCH
  - bundle exec rake
{% endhighlight %}

И всё, можно проверять.

![Pull Request]({{ site.url }}/assets/images/2017-03-20-automatic-code-review-with-vexor/pr_1530758d.png){: .center-image }

Кто-то может возразить, зачем всё это нужно, если есть [overcommit](https://github.com/brigade/overcommit){:target='_blank'}? Новые разработчики на проекте часто забывают настроить overcommit и это обнаруживается только спустя несколько дней, когда другой разработчик не может отправить свои изменения на сервер. Чтобы исключить подобные ситуации, я рекомендую использовать эти инструменты вместе.

P.S. Хочу поблагодарить [Сашу Кириллова](https://github.com/saratovsource){:target='_blank'}, за помощь с интеграцией pronto и Vexor.
