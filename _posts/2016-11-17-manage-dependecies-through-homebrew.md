---
layout: post
title: "Управление зависимостями через Homebrew"
date: 2016-11-17 11:00:00
tags: homebrew linuxbrew bundle bundler ruby zsh
summary: "Управление внешними зависимостями проекта c помощью Homebrew Bundle."
---

![Homebrew]({{ site.url }}/assets/images/2016-11-17-manage-dependecies-through-homebrew/2960edcf98e4b.png)

Для управления зависимостями в проектах на Ruby мы используем [Bundler](http://bundler.io){:target='_blank'}. Он позволяет с легкостью устанавливать в проект необходимые нам библиотеки, вместе со всеми зависимостями.

Но что делать с внешними зависимостями проекта, такими как Redis или Node.js?
Ситуация усугубляется, когда тебя подключают к новому проекту с большим багажом таких зависимостей. И вместо того, чтобы разбираться в проекте, ты тратишь целый день на установку всего этого зоопарка.

### Homebrew Bundle

Для решения этой проблемы можно воспользоваться [Homebrew Bundle](https://github.com/Homebrew/homebrew-bundle){:target='_blank'}. Он позволяет управлять внешними зависимостями проекта так же, как и Bundler внутренними, с помощью специального файла - `Brewfile`.

Итак, приступим. Устанавливаем Homebrew Bundle:

{% highlight bash %}
$ brew tap Homebrew/bundle
==> Tapping homebrew/bundle
Cloning into '/usr/local/Homebrew/Library/Taps/homebrew/homebrew-bundle'...
remote: Counting objects: 57, done.
remote: Compressing objects: 100% (53/53), done.
remote: Total 57 (delta 5), reused 16 (delta 2), pack-reused 0
Unpacking objects: 100% (57/57), done.
Checking connectivity... done.
Tapped 0 formulae (126 files, 154.5K)
{% endhighlight %}

Теперь необходимо создать `Brewfile` в корне проекта и добавить туда все необходимые зависимости. Это можно сделать вручную или запустить команду `brew bundle dump`, которая создаст файл со всеми установленными пакетами из Homebrew, например:

{% highlight bash %}
tap prosody/prosody

brew 'node'
brew 'redis'
brew 'prosody'
brew 'rabbitmq'
brew 'phantomjs'
brew 'postgresql'
brew 'imagemagick'
{% endhighlight %}

Запускаем команду `brew bundle`, чтобы установить или обновить все зависимости.

{% highlight bash %}
$ brew bundle
Succeeded in installing node
Succeeded in installing redis
Succeeded in installing prosody
Succeeded in installing rabbitmq
Succeeded in installing phantomjs
Succeeded in installing postgresql
Succeeded in installing imagemagick

Success: 7 Fail: 0
{% endhighlight %}

На этом можно было закончить, но что делать, если в команде есть разработчики на Linux? У них ведь нет Homebrew.

### Linuxbrew

Homebrew - нет, но есть аналог - [Linuxbrew](http://linuxbrew.sh){:target='_blank'}. Он абсолютно так же работает, как и Homebrew на macOS.

Для его использования потребуется установить несколько дополнительных пакетов в свой дистрибутив:

{% highlight bash %}
$ sudo apt-get install build-essential curl git python-setuptools ruby
{% endhighlight %}

Далее устанавливаем Linuxbrew:

{% highlight bash %}
$ ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Linuxbrew/install/master/install)"
==> This script will install:
/home/ubuntu/.linuxbrew/bin/brew
/home/ubuntu/.linuxbrew/Library/...
/home/ubuntu/.linuxbrew/share/doc/homebrew
/home/ubuntu/.linuxbrew/share/man/man1/brew.1
/home/ubuntu/.linuxbrew/share/zsh/site-functions/_brew
/home/ubuntu/.linuxbrew/etc/bash_completion.d/brew
/home/ubuntu/.cache/Homebrew/

Press RETURN to continue or any other key to abort
==> Downloading and installing Linuxbrew...
remote: Counting objects: 1040, done.
remote: Compressing objects: 100% (930/930), done.
remote: Total 1040 (delta 106), reused 481 (delta 75), pack-reused 0
Receiving objects: 100% (1040/1040), 1.01 MiB | 325.00 KiB/s, done.
Resolving deltas: 100% (106/106), done.
From https://github.com/Linuxbrew/brew
 * [new branch]      master     -> origin/master
HEAD is now at b75ca7b CONTRIBUTING.md: Update Contributing to Linuxbrew
==> Homebrew has enabled anonymous aggregate user behaviour analytics
Read the analytics documentation (and how to opt-out) here:
  https://git.io/brew-analytics
==> Tapping homebrew/core
Cloning into '/home/ubuntu/.linuxbrew/Library/Taps/homebrew/homebrew-core'...
remote: Counting objects: 3773, done.
remote: Compressing objects: 100% (3663/3663), done.
remote: Total 3773 (delta 12), reused 335 (delta 1), pack-reused 0
Receiving objects: 100% (3773/3773), 3.05 MiB | 577.00 KiB/s, done.
Resolving deltas: 100% (12/12), done.
Checking connectivity... done.
Tapped 3651 formulae (3,800 files, 9.5M)
Warning: /home/ubuntu/.linuxbrew/bin is not in your PATH.
==> Installation successful!
==> Next steps
Install the Linuxbrew dependencies:

Debian, Ubuntu, etc.:
  `sudo apt-get install build-essential`

Fedora, Red Hat, CentOS, etc.:
  `sudo yum groupinstall 'Development Tools'`

See http://linuxbrew.sh/#dependencies for more information.

Add to your ~/.zshrc by running
  echo 'export PATH="/home/ubuntu/.linuxbrew/bin:$PATH"' >>~/.zshrc
  echo 'export MANPATH="/home/ubuntu/.linuxbrew/share/man:$MANPATH"' >>~/.zshrc
  echo 'export INFOPATH="/home/ubuntu/.linuxbrew/share/info:$INFOPATH"' >>~/.zshrc

We recommend you install GCC by running `brew install gcc`.
Run `brew help` to get started
Further documentation: https://git.io/brew-docs
==> Homebrew has enabled anonymous aggregate user behaviour analytics
Read the analytics documentation (and how to opt-out) here:
  https://git.io/brew-analytics
{% endhighlight %}

Затем добавляем пути в `~/.zshrc`:

{% highlight bash %}
$ echo 'export PATH="/home/ubuntu/.linuxbrew/bin:$PATH"' >> ~/.zshrc
$ echo 'export MANPATH="/home/ubuntu/.linuxbrew/share/man:$MANPATH"' >> ~/.zshrc
$ echo 'export INFOPATH="/home/ubuntu/.linuxbrew/share/info:$INFOPATH"' >> ~/.zshrc
{% endhighlight %}

Перезапускаем zsh:

{% highlight bash %}
$ source ~/.zshrc
{% endhighlight %}

И всё, теперь можно перейти в проект и выполнить команду `brew bundle`. Все необходимые зависимости для вашего проекта будут установлены.
