---
layout: post
title: "Класс Set и уникальные коллекции объектов"
date: 2016-03-31 18:00:00
tags: ruby set ddd api
summary: "Рассмотрим решение одной задачи с использованием класса Set и DDD."
---

На одном проекте мне понадобилось получать список форматов для баннеров из одной рекламной платформы.
Задача с виду простая, но возникла одна проблема - список форматов приходит не уникальный.
Для решения этой проблемы я решил использовать встроенный в Ruby класс `Set` и немного [DDD](https://ru.wikipedia.org/wiki/Проблемно-ориентированное_проектирование){:target='_blank'}.

Итак, по порядку.

Список форматов мы будем получать по API, для этого создадим сервис:

{% highlight ruby %}
# app/services/my_target_service.rb
class MyTargetService
  API_URL = 'https://example.com'

  def self.banner_formats
    response = RestClient.get("#{API_URL}/api/banner_formats.json")
    JSON.parse(response, symbolize_names: true)
  end
end
{% endhighlight %}

В ответ нам приходит массив примерно следующего вида:

{% highlight ruby %}
[
  {
    :id => 1,
    :status => 'active',
    :name => 'Format 1',
    :description => '...',
    :width => 240,
    :height => 400
  },
  {
    :id => 1,
    :status => 'active',
    :name => 'Format 1',
    :description => '...',
    :width => 240,
    :height => 400
  },
  {
    :id => 2,
    :status => 'inactive',
    :name => 'Format 2',
    :description => '...',
    :width => 1080,
    :height => 607
  }
]
{% endhighlight %}

Как видно из примера, форматы в списке повторяются.
Воспользуемся классом `Set`, чтобы сделать этот список уникальным:

{% highlight ruby %}
# app/services/my_target_service.rb
require 'set'

class MyTargetService
  API_URL = 'https://example.com'

  def self.banner_formats
    response = RestClient.get("#{API_URL}/api/banner_formats.json")
    formats = JSON.parse(response, symbolize_names: true)

    banner_formats = Set.new
    formats.each do |format|
      banner_formats << format
    end

    banner_formats
  end
end
{% endhighlight %}

Для удобства работы, обернем каждый формат в отдельную сущность.
Для этого создадим класс `BannerFormatEntity`:

{% highlight ruby %}
# app/entities/banner_format_entity.rb
class BannerFormatEntity
  attr_reader :format

  def initialize(format)
    @format = format
  end

  def id
    format[:id]
  end

  def name
    format[:name]
  end

  def description
    format[:description]
  end

  def size
    "#{format[:width]}x#{format[:height]}"
  end
  
  def active?
    format[:status] == 'active'
  end
end
{% endhighlight %}

Теперь обновим наш сервис, чтобы использовать класс `BannerFormatEntity`.
Так же добавим условие, чтобы в списке были только активные форматы:

{% highlight ruby %}
# app/services/my_target_service.rb
require 'set'

class MyTargetService
  API_URL = 'https://example.com'

  def self.banner_formats
    response = RestClient.get("#{API_URL}/api/banner_formats.json")
    formats = JSON.parse(response, symbolize_names: true)

    banner_formats = Set.new
    formats.each do |format|
      banner_format = BannerFormatEntity.new(format)
      banner_formats << banner_format if banner_format.active?
    end

    banner_formats
  end
end
{% endhighlight %}

Остается последний штрих.
Для того чтобы Set мог определять уникальность наших объектов, необходимо определить в классе `BannerFormatEntity` 2 метода: `Object#eql?` и `Object#hash`. 

{% highlight ruby %}
# app/entities/banner_format_entity.rb
class BannerFormatEntity
  attr_reader :format

  def initialize(format)
    @format = format
  end

  def id
    format[:id]
  end

  def name
    format[:name]
  end

  def description
    format[:description]
  end

  def size
    "#{format[:width]}x#{format[:height]}"
  end

  def active?
    format[:status] == 'active'
  end
  
  def eql?(other)
    id == other.id
  end
  
  def hash
    id.hash
  end
end
{% endhighlight %}

Вот таким простым и элегантным способом, мы решили нашу задачу с получением уникального списка форматов для баннеров.
Сервис `MyTargetService` отправляет запрос к API рекламной площадки и возвращает уникальную коллекцию объектов `BannerFormatEntity`. 
