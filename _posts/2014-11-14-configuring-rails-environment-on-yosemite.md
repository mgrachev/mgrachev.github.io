---
layout: post
title: "Настройка Rails-окружения на OS X Yosemite"
date: 2014-11-17 10:00:00
update_date: 2015-05-22 09:00:00
tags: apple yosemite ruby rails git homebrew zsh rbenv rubygems bundler
summary: "Полноценное рабочее окружение на OS X 10.10 Yosemite: Ruby, Homebrew, Oh My ZSH, rbenv и многое другое."
---

![OS X Yosemite]({{ site.url }}/assets/images/2014-11-14-configuring-rails-environment-on-yosemite/Q6qdz69S3mw.png){: .center-image }

В прошлом месяце, компания Apple, выпустила новую версию своей операционной системы - OS X 10.10 Yosemite. В этой статье я расскажу, как развернуть полноценное рабочее окружение на новой ОС от Apple.

Для начала определимся с тем, что нам понадобится для комфортной разработки на фреймворке Ruby on Rails:

* Современная командная оболочка;
* Удобный менеджер пакетов;
* Мощная система контроля версий;
* Простой менеджер версий Ruby.

Итак, начнем...

#### Command Line Developer Tools

Первым делом, устанавливаем gcc и git, которые входят в состав Command Line Developer Tools. Для этого, запускаем терминал и набираем команду `git`. Появится диалоговое окно, которое предложит установить недостающие компоненты.

![Command Line Developer Tools]({{ site.url }}/assets/images/2014-11-14-configuring-rails-environment-on-yosemite/lkP4rpmzyMY.png){: .center-image }

#### Homebrew

Далее устанавливаем менеджер пакетов [Homebrew](http://brew.sh/index_ru.html){:target='_blank'}. Он легко позволяет устанавливать недостающие пакеты, включая все зависимости, а так же предоставляет удобный способ их обновления. При этом система всегда остается чистой.

{% highlight bash %}
$ ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
{% endhighlight %}

После установки, запускаем команду `brew doctor`, чтобы проверить систему на наличие потенциальных проблем.

![Brew doctor]({{ site.url }}/assets/images/2014-11-14-configuring-rails-environment-on-yosemite/pwC_XCoMO6s.png){: .center-image }

#### Homebrew Cask

Следующим шагом является установка [Homebrew Cask](http://caskroom.io){:target='_blank'} - расширения Homebrew, которое позволяет просто и удобно управлять обычными OS X приложениями, такими как Google Chrome или Skype.

{% highlight bash %}
$ brew install caskroom/cask/brew-cask
{% endhighlight %}

Так же ставим необходимые для разработки приложения: Atom и iTerm2.

{% highlight bash %}
$ brew cask install atom iterm2
{% endhighlight %}

#### ZSH

Далее, устанавливаем [ZSH](https://ru.wikipedia.org/wiki/Zsh){:target='_blank'} - современную командную оболочку UNIX.

{% highlight bash %}
$ brew install zsh
{% endhighlight %}

Добавляем ZSH в `/etc/shells`:

{% highlight bash %}
$ which zsh | sudo tee -a /etc/shells
{% endhighlight %}

#### Oh My ZSH

Затем устанавливаем [Oh My ZSH](http://ohmyz.sh){:target='_blank'} - фреймворк для управления настройками ZSH. Он включает в себя большое количество полезных функций, плагинов и тем.

{% highlight bash %}
$ curl -L http://install.ohmyz.sh | sh
{% endhighlight %}

![Oh My ZSH]({{ site.url }}/assets/images/2014-11-14-configuring-rails-environment-on-yosemite/xxCEQdwrSyE.png){: .center-image }

Для настройки ZSH, необходимо открыть файл `~/.zshrc`. В нем есть 2 главных параметра:

1. `ZSH_THEME` - основная тема, которую можно выбрать [здесь](https://github.com/robbyrussell/oh-my-zsh/wiki/themes){:target='_blank'};
2. `plugins` - список используемых плагинов, который можно посмотреть [здесь](https://github.com/robbyrussell/oh-my-zsh/wiki/Plugins){:target='_blank'}.

Для начала можно использовать следующие настройки:

{% highlight bash %}
ZSH_THEME="robbyrussell"
plugins=(brew-cask brew bundler encode64 gem git-extras git gitignore heroku history last-working-dir osx rails rake rbenv urltools)
{% endhighlight %}

#### Git

После обновляем Git до последней версии, а так же устанавливаем небольшое дополнение к нему - [git-extras](https://github.com/tj/git-extras){:target='_blank'}.

{% highlight bash %}
$ brew install git git-extras
{% endhighlight %}

Приступаем к настройке Git. Указываем имя и адрес электронной почты:

{% highlight bash %}
$ git config --global user.name 'Mikhail Grachev'
$ git config --global user.email 'work@mgrachev.com'
{% endhighlight %}

Создаем `.gitignore`. Для этого можно воспользоваться сервисом [gitignore.io](https://www.gitignore.io/){:target='_blank'}.

{% highlight bash %}
$ curl -s 'https://www.gitignore.io/api/archives,jekyll,osx,rails,ruby,rubymine,sass,vagrant,windows' >> ~/.gitignore_global
$ git config --global core.excludesfile ~/.gitignore_global
{% endhighlight %}

В качестве редактора используем Atom.

{% highlight bash %}
$ git config --global core.editor 'atom --wait'
{% endhighlight %}

Так же необходимо будет добавить параметр `push.default`, чтобы при выполнении команды `git push`, изменения отправлялись только в текущую удаленную ветку.

{% highlight bash %}
$ git config --global push.default simple
{% endhighlight %}

#### rbenv

Далее, устанавливаем менеджер версий Ruby - [rbenv](https://github.com/sstephenson/rbenv){:target='_blank'}. Почему rbenv? Ответ можно получить [здесь](https://github.com/sstephenson/rbenv/wiki/Why-rbenv%3F){:target='_blank'}.

{% highlight bash %}
$ brew install rbenv ruby-build rbenv-gem-rehash rbenv-vars rbenv-binstubs
{% endhighlight %}

Настраиваем ZSH для работы с rbenv:

{% highlight bash %}
$ echo 'export RBENV_ROOT=/usr/local/var/rbenv' >> ~/.zshrc
$ echo 'if which rbenv > /dev/null; then eval "$(rbenv init - zsh)"; fi' >> ~/.zshrc
{% endhighlight %}

#### Ruby

Устанавливаем последнюю версию языка Ruby:

{% highlight bash %}
$ rbenv install 2.1.3
{% endhighlight %}

Делаем новую версию Ruby по умолчанию во всей системе и перезагружаем ZSH:

{% highlight bash %}
$ rbenv global 2.1.3
$ zsh
{% endhighlight %}

#### RubyGems

Последним шагом является настройка RubyGems. Для этого создаем файл `~/.gemrc` и помещаем в него следующее содержимое:

{% highlight bash %}
---
:verbose: true
:backtrace: false
:update_sources: true
:sources:
- http://rubygems.org/
gem: --no-document
{% endhighlight %}

Более подробно про это можно узнать [здесь](http://guides.rubygems.org/command-reference/#gem-environment){:target='_blank'}.

Затем устанавливаем Bundler и Ruby on Rails:

{% highlight bash %}
$ gem install bundler rails
{% endhighlight %}

После этого остается только настроить Bundler, чтобы он хранил гемы в директории проекта - `vendor/bundle`:

{% highlight bash %}
$ bundle config --global path vendor/bundle
$ bundle config --global bin vendor/bundle/bin
{% endhighlight %}

На этом можно завершить настройку рабочего окружения на OS X Yosemite. Этого вполне хватит, для комфортной разработки на языке Ruby и фреймворке Ruby on Rails.
