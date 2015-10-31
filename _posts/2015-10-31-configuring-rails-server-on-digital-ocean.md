---
layout: post
title: "Настройка Rails-сервера на DigitalOcean"
date: 2015-10-31 16:00:00
tags: rails ruby digitalocean ubuntu deploy redis postgresql nginx passenger rbenv zsh
summary: "В прошлой статье мы говорили о настройке Rails-окружения для разработки. Теперь пришло время для настройки боевого сервера."
---


![DigitalOcean]({{ site.url }}/assets/2015-10-31-configuring-rails-server-on-digital-ocean/VcTfDWmDK_a8D6jAz8cDJQ.png)

В прошлой статье мы говорили о [настройке Rails-окружения для разработки]({{ site.url }}/2014/11/17/configuring-rails-environment-on-yosemite/). Теперь пришло время для настройки боевого сервера.

Для этого необходимо зарегистрироваться на [DigitalOcean](https://www.digitalocean.com/?refcode=8168323dd7e6) (реферальная ссылка, после регистрации вы получити $10 на свой счет) и создать [Droplet](https://www.digitalocean.com/community/tutorials/how-to-create-your-first-digitalocean-droplet-virtual-server). В качестве ОС необходимо выбрать Ubuntu 14.04.

#### Настройка сервера

Заходим на сервер под `root`:

{% highlight bash %}
$ ssh root@[IP-адрес сервера]
{% endhighlight %}

В первую очередь создаем нового пользователя:

{% highlight bash %}
root@droplet:~# adduser deploy
{% endhighlight %}

Добавляем его в группу `sudo`, чтобы у него были привилегии `root`:

{% highlight bash %}
root@droplet:~# gpasswd -a deploy sudo
{% endhighlight %}

Затем настраиваем вход на сервер по ssh-ключам. Для этого генерируем ключ на локальном компьютере:

{% highlight bash %}
$ ssh-keygen -t rsa
{% endhighlight %}

Заходим на сервер под новым пользователем:

{% highlight bash %}
root@droplet:~# su - deploy
{% endhighlight %}

Создаем директорию `ssh`:

{% highlight bash %}
deploy@droplet:~$ mkdir .ssh
deploy@droplet:~$ chmod 700 .ssh
{% endhighlight %}

Копируем публичный ключ с локального компьютера:

{% highlight bash %}
$ cat ~/.ssh/id_rsa.pub
{% endhighlight %}

И сохраняем его в файл `~/.ssh/authorized_keys` на сервере. Далее меняем права на этот файл и переключаемся снова на пользователя `root`:

{% highlight bash %}
deploy@droplet:~$ chmod 600 .ssh/authorized_keys
deploy@droplet:~$ exit
{% endhighlight %}

Для большей безопасности, запрещаем вход на сервере через `ssh` под пользователем `root`. Для этого открываем файл `/etc/ssh/sshd_config` и находим следующую строчку:

{% highlight bash %}
PermitRootLogin yes
{% endhighlight %}

Меняем её на:

{% highlight bash %}
PermitRootLogin no
{% endhighlight %}

И перезапускаем `ssh`:

{% highlight bash %}
root@droplet:~# service ssh restart
{% endhighlight %}

Обратно заходим под пользователем `deploy`:

{% highlight bash %}
root@droplet:~#su - deploy
{% endhighlight %}

Приступаем к настройке временной зоны. Выбираем из списка "Europe/Moscow":

{% highlight bash %}
deploy@droplet:~$ sudo dpkg-reconfigure tzdata
{% endhighlight %}

Настраиваем локаль, для этого открываем файл `/etc/default/locale` и добавляем туда следующее:

{% highlight bash %}
LANGUAGE='en_US.UTF-8'
LC_ALL='en_US.UTF-8'
LANG='en_US.UTF-8'
LC_TYPE='en_US.UTF-8'
{% endhighlight %}

Запускаем команду перенастройки:

{% highlight bash %}
deploy@droplet:~$ locale-gen en_US.UTF-8
deploy@droplet:~$ sudo dpkg-reconfigure locales
{% endhighlight %}

#### Установка ПО

С настройкой сервера мы закончили, приступаем к установке ПО. Устанавливаем `ntp` для автоматической синхронизации времени:

{% highlight bash %}
deploy@droplet:~$ sudo apt-get update
deploy@droplet:~$ sudo apt-get install ntp
{% endhighlight %}

Для более комфортной работы с командной строкой, устанавливаем [Oh My ZSH](http://ohmyz.sh):

{% highlight bash %}
deploy@droplet:~$ sudo apt-get install git zsh
deploy@droplet:~$ sh -c "$(wget https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
{% endhighlight %}

Далее устанавливаем Redis и PostgreSQL:

{% highlight bash %}
deploy@droplet:~$ sudo apt-get install redis-server postgresql libpq-dev
{% endhighlight %}

#### Установка Ruby

Устанавливаем необходимые зависимости:

{% highlight bash %}
deploy@droplet:~$ sudo apt-get install autoconf bison build-essential libssl-dev libyaml-dev libreadline6-dev zlib1g-dev libncurses5-dev libffi-dev libgdbm3 libgdbm-dev
{% endhighlight %}

В качестве менеджера версий Ruby, мы будем использовать [rbenv](https://github.com/sstephenson/rbenv). После установки перезапускаем `zsh`:

{% highlight bash %}
deploy@droplet:~$ git clone https://github.com/sstephenson/rbenv.git ~/.rbenv
deploy@droplet:~$ echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.zshrc
deploy@droplet:~$ echo 'eval "$(rbenv init -)"' >> ~/.zshrc
deploy@droplet:~$ exec zsh -l
{% endhighlight %}

Устанавливаем дополнительные плагины, необходимые для установки Ruby:

{% highlight bash %}
deploy@droplet:~$ git clone https://github.com/sstephenson/ruby-build.git "$(rbenv root)/plugins/ruby-build"
deploy@droplet:~$ git clone https://github.com/sstephenson/rbenv-gem-rehash.git "$(rbenv root)/plugins/rbenv-gem-rehash"
deploy@droplet:~$ git clone https://github.com/rkh/rbenv-update.git "$(rbenv root)/plugins/rbenv-update"
deploy@droplet:~$ git clone https://github.com/ianheggie/rbenv-binstubs.git "$(rbenv root)"/plugins/rbenv-binstubs
{% endhighlight %}

Находим последнюю стабильную версию Ruby:

{% highlight bash %}
deploy@droplet:~$ rbenv install -l
{% endhighlight %}

На момент написания статьи - это 2.2.3:

{% highlight bash %}
2.2.0
2.2.1
2.2.2
2.2.3
2.3.0-dev
{% endhighlight %}

Устанавливаем Ruby и перезапускаем `zsh`:

{% highlight bash %}
deploy@droplet:~$ rbenv install 2.2.3
deploy@droplet:~$ rbenv global 2.2.3
deploy@droplet:~$ exec zsh -l
{% endhighlight %}

Устанавливаем и настраиваем Bundler, чтобы он хранил все гемы в директори проекта:

{% highlight bash %}
deploy@droplet:~$ gem install bundler
deploy@droplet:~$ bundle config --global path vendor/bundle
deploy@droplet:~$ bundle config --global bin vendor/bundle/bin
{% endhighlight %}

#### Установка Nginx и Passenger

В качестве веб-сервера у нас будет выступать Nginx, а сервера приложений - Passenger. Для установки необходимо добавить PGP-ключ:

{% highlight bash %}
deploy@droplet:~$ sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 561F9B9CAC40B2F7
{% endhighlight %}

Создаем файл `/etc/apt/sources.list.d/passenger.list` и добавляем в него новый источник:

{% highlight bash %}
deploy@droplet:~$ deb https://oss-binaries.phusionpassenger.com/apt/passenger trusty main
{% endhighlight %}

Меняем права на этот файл:

{% highlight bash %}
deploy@droplet:~$ sudo chown root: /etc/apt/sources.list.d/passenger.list
deploy@droplet:~$ sudo chmod 600 /etc/apt/sources.list.d/passenger.list
{% endhighlight %}

Обновляем список пакетов и устанавливаем Nginx и Passenger:

{% highlight bash %}
deploy@droplet:~$ sudo apt-get update
deploy@droplet:~$ sudo apt-get install nginx-extras passenger
{% endhighlight %}

Переходим к настройке Nginx, открываем файл `/etc/nginx/nginx.conf` и находим там следующие строчки:

{% highlight bash %}
# passenger_root /usr/lib/ruby/vendor_ruby/phusion_passenger/locations.ini;
# passenger_ruby /usr/bin/ruby;
{% endhighlight %}

Их необходимо заменить на:

{% highlight bash %}
passenger_root /usr/lib/ruby/vendor_ruby/phusion_passenger/locations.ini;
passenger_ruby /usr/local/bin/ruby;
{% endhighlight %}

#### Создание тестового проекта

Теперь остается только проверить, что все работает, для этого создадим тестовый проект. Для этого нам понадобится установить Ruby on Rails и SQLite:

{% highlight bash %}
deploy@droplet:~$ gem install rails --no-document
deploy@droplet:~$ sudo apt-get install libsqlite3-dev
{% endhighlight %}

Создаем новый проект:

{% highlight bash %}
deploy@droplet:~$ rails new testapp --skip-bundle
deploy@droplet:~$ cd testapp
{% endhighlight %}

Для запуска тестового проекта нам понадобится JavaScript runtime библиотека. Открываем `Gemfile` и находим строчку:

{% highlight bash %}
# gem 'therubyracer',  platforms: :ruby
{% endhighlight %}

Заменяем её на:

{% highlight bash %}
gem 'therubyracer',  platforms: :ruby
{% endhighlight %}

Запускаем установку зависимостей проекта:

{% highlight bash %}
deploy@droplet:~$ bundle
{% endhighlight %}

Для того чтобы наш тестовый проект был доступен по IP-адресу, необходимо отключить настройки по умолчанию у Nginx. Для этого открываем файл `/etc/nginx/sites-available/default` и находим следующие строчки:

{% highlight bash %}
listen 80 default_server;
listen [::]:80 default_server;
{% endhighlight %}

Меняем их на:

{% highlight bash %}
# listen 80 default_server;
# listen [::]:80 default_server;
{% endhighlight %}

Создаем файл настроек для тестового проекта:

{% highlight bash %}
deploy@droplet:~$ sudo touch /etc/nginx/sites-available/testapp
{% endhighlight %}

И добавляем туда следующее содержимое:

{% highlight bash %}
server {
  listen 80 default_server;
  server_name www.mydomain.com;
  passenger_enabled on;
  passenger_app_env development;
  passenger_ruby /home/deploy/.rbenv/shims/ruby;
  root /home/deploy/testapp/public;
}
{% endhighlight %}

Создаем символьную ссылку для этого файла:

{% highlight bash %}
deploy@droplet:~$ sudo ln -s /etc/nginx/sites-available/testapp /etc/nginx/sites-enabled/testapp
{% endhighlight %}

Перезапускаем nginx:

{% highlight bash %}
deploy@droplet:~$ sudo nginx -s reload
{% endhighlight %}

На этом все, настройка сервера завершена. Теперь можно открыть в браузере страницу с IP-адресом вашего сервера и увидеть, что все работает.

Источники:

* [Initial Server Setup with Ubuntu 14.04](https://www.digitalocean.com/community/tutorials/initial-server-setup-with-ubuntu-14-04);
* [Additional Recommended Steps for New Ubuntu 14.04 Servers](https://www.digitalocean.com/community/tutorials/additional-recommended-steps-for-new-ubuntu-14-04-servers);
* [How To Deploy a Rails App with Passenger and Nginx on Ubuntu 14.04](https://www.digitalocean.com/community/tutorials/how-to-deploy-a-rails-app-with-passenger-and-nginx-on-ubuntu-14-04).
