---
layout: post
title: "Резервное копирование GitLab с помощью rsync"
date: 2015-05-18 20:00:00
update_date: 2015-05-31 22:00:00
tags: gitlab rsync cron backup hipchat whenever
summary: "Мини-проект для автоматического резервного копирования GitLab c помощью Ruby и rsync."
---

На днях я задался целью, полностью автоматизировать процесс резервного копирования GitLab. Для решения этой задачи я решил использовать [rsync](https://ru.wikipedia.org/wiki/Rsync). На другой машине запустил rsync-сервер. Осталось дело за малым, написать shell-скрипт и добавить его в [cron](https://ru.wikipedia.org/wiki/Cron), но я решил пойти немного другим путем...

Задачи:

* Настроить резервное копирование GitLab с помощью `rsync`;
* Запускать задачу резервного копирования по `cron`, раз в сутки;
* Отправлять уведомления через HipChat.

Версия ПО:

* Ubuntu Server 15.04;
* GitLab 7.10.4;
* ZSH 5.0.7.

Первым делом, создаем необходимую структуру для нашего мини-проекта:

{% highlight bash %}
$ mkdir ~/gitlab_backup && cd ~/gitlab_backup
$ for dir (bin config lib models); do mkdir $dir; done
$ touch Gemfile
{% endhighlight %}

Добавляем в `Gemfile` необходимые библиотеки:

{% highlight ruby %}
source 'https://rubygems.org'

# Easy full stack backup operations on UNIX-like systems
# https://github.com/backup/backup
gem 'backup'

# Cron jobs in Ruby
# https://github.com/javan/whenever
gem 'whenever', require: false

# Loads environment variables from `.env`
# https://github.com/bkeepers/dotenv
gem 'dotenv'
{% endhighlight %}

И устанавливаем их:

{% highlight bash %}
$ bundle install
{% endhighlight %}

Основные настройки нашего мини-проекта буду храниться в файле `.env`:

{% highlight bash %}
ROOT_PATH="$HOME/gitlab_backup"

HIPCHAT_TOKEN=test_token
HIPCHAT_ROOMS=Backup

RSYNC_HOST=example.com
RSYNC_SSH_USER=user
RSYNC_PATH=/home/user/backup
{% endhighlight %}

А тепень подробнее о каждом из них:

* `ROOT_PATH` - местоположение проекта;
* `HIPCHAT_TOKEN` - ключ, необходимый для работы с HipChat;
* `HIPCHAT_ROOMS` - список комнат, куда будут отправляться уведомления;
* `RSYNC_HOST` - адрес rsync-сервера;
* `RSYNC_SSH_USER` - имя пользователя, для доступа по ssh;
* `RSYNC_PATH` - путь, куда будет выполняться резервное копирование на rsync-сервере.

Чтобы иметь возможность, выполнять резервное копирование системных файлов, необходимо запускать `rsync` через `sudo`. Для этого, потребуется немного доработать библиотеку backup. Создаем файл `lib/rsync.rb`:

{% highlight ruby %}
# encoding: utf-8

require 'backup'

module Backup
  module Syncer
    module RSync
      class Push
        attr_accessor :use_sudo

        private

        def rsync_command
          command = (super << compress_option << password_option << transport_options)
          command = "#{utility(:sudo)} #{command}" if use_sudo
          command
        end
      end
    end
  end
end
{% endhighlight %}

Теперь нужно подключить наш небольшой патч к библиотеке backup. Для этого создаем файл `bin/backup`:

{% highlight ruby %}
#!/usr/bin/env ruby

require 'pathname'
ENV['BUNDLE_GEMFILE'] ||= File.expand_path("../../Gemfile",
  Pathname.new(__FILE__).realpath)

require 'rubygems'
require 'bundler/setup'

require File.expand_path('../lib/rsync', __dir__)

load Gem.bin_path('backup', 'backup')
{% endhighlight %}

Следующим шагом будет создание файла `config.rb`, в котором будут храниться настройки библиотеки backup:

{% highlight ruby %}
# encoding: utf-8
# Backup v4.x Configuration
require 'dotenv'
Dotenv.load

root_path ENV['ROOT_PATH']
tmp_path  'tmp'
data_path 'data'

Syncer::RSync::Push.defaults do |rsync|
  rsync.use_sudo = true
  rsync.mode = :ssh
  rsync.host = ENV['RSYNC_HOST']
  rsync.port = 22
  rsync.ssh_user = ENV['RSYNC_SSH_USER']
  rsync.additional_ssh_options = "-i '#{ENV['HOME']}/.ssh/id_rsa'"
  rsync.mirror   = true
  rsync.compress = true
  rsync.path = ENV['RSYNC_PATH']
end

Compressor::Gzip.defaults do |compression|
  compression.level = 6
  compression.rsyncable = true
end

Notifier::Hipchat.defaults do |hipchat|
  hipchat.on_success = true
  hipchat.on_warning = true
  hipchat.on_failure = true

  hipchat.success_color = 'green'
  hipchat.warning_color = 'yellow'
  hipchat.failure_color = 'red'

  hipchat.token = ENV['HIPCHAT_TOKEN']
  hipchat.from = 'Backup'
  hipchat.rooms_notified = ENV['HIPCHAT_ROOMS'].split(',').collect(&:strip)
end
{% endhighlight %}

После того, как созданы все файлы с настройками, можно приступить к созданию модели для резервного копирования. Создаем файл `models/rsync_backup.rb`:

{% highlight ruby %}
# encoding: utf-8

require 'dotenv'
Dotenv.load

Model.new(:rsync_backup, 'Rsync backup') do
  before do
    system('sudo gitlab-rake gitlab:backup:create')
  end

  sync_with RSync::Push do |rsync|
    rsync.directories do |directory|
      directory.add '/etc/gitlab'
      directory.add '/var/opt/gitlab/backups'
    end
  end

  compress_with Gzip

  notify_by Hipchat
end
{% endhighlight %}

Здесь указываем, что в самом начале должен запуститься скрипт `sudo gitlab-rake gitlab:backup:create`, который создаст резервную копию БД и всех проектов из GitLab в директории `/var/opt/gitlab/backups`. Только после этого запуститься процесс резервного копирования.

Чтобы в процессе создания резервной копии, постоянно не вводить пароль для доступа к rsync-серверу, нужно сгенерировать ssh-ключи без пароля и скопировать их на удаленный сервер:

{% highlight bash %}
$ ssh-keygen -t rsa
$ ssh-copy-id -i ~/.ssh/id_rsa.pub user@example.com
{% endhighlight %}

Необходимо так же добавить правило в `/etc/sudoers`, чтобы `rsync` не запрашивал пароль, при каждом запуске через `sudo`:

{% highlight bash %}
$ sudo -s
$ echo "user ALL= NOPASSWD: /usr/bin/rsync, /usr/bin/gitlab-rake" >> /etc/sudoers
$ exit
{% endhighlight %}

**Важно!** Замените `user` - на реального пользователя вашей системы, например `ubuntu`.

Для запуска резервного копирования можно воспользоваться следующей командой:

{% highlight bash %}
$ chmod +x bin/backup
$ bin/backup perform -t rsync_backup -r ~/gitlab_backup
{% endhighlight %}

Осталось только автоматизировать этот процесс, для этого создаем файл `config/schedule.rb`:

{% highlight ruby %}
require 'dotenv'
Dotenv.load

set :job_template, "/usr/bin/zsh -l -c 'source #{ENV['HOME']}/.zshrc && :job'"
job_type :run_backup, 'cd :path && ./bin/backup perform -t :task -c :config_path'

every 1.day, at: '02:00 am' do
  run_backup 'rsync_backup', config_path: "#{ENV['ROOT_PATH']}/config.rb"
end
{% endhighlight %}

И добавляем задачу в `cron`:

{% highlight bash %}
$ whenever --update-crontab
{% endhighlight %}

В данном примере, резервное копирование будет выполняться каждый день в 2 часа ночи.

На этом можно поставить точку, все наши GitLab-проекты теперь в полной целостности и сохранности.

Исходный код: [https://github.com/mgrachev/gitlab_backup](https://github.com/mgrachev/gitlab_backup)
