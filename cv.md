---
layout: page
permalink: /cv/
---

<div class="cv clearfix">
    <div class="left" style="height:220px;">
        <img width="220" height="220" src="https://avatars3.githubusercontent.com/u/700998" alt="Mikhail Grachev" class="avatar" />
    </div>
    <h2>Грачёв Михаил</h2>
    <h3>Rust Developer / Team Lead / Dev Advocate</h3>

    work<i class="fas fa-at"></i>mgrachev.com
    <br>
    <i class="fab fa-github fa-lg"></i> <a href="https://github.com/mgrachev" target="_blank">mgrachev</a>
    <br>
    <i class="fab fa-telegram fa-lg"></i> <a href="https://t.me/grachevm" target="_blank">grachevm</a>
</div>

## TL;DR

<i class="fas fa-address-card fa-lg" style="margin-left:2px; margin-right: 1px;"></i> Мне 33 года.
<br>
<i class="fas fa-laptop-code fa-lg"></i> Backend-разработчик и Team Lead. Опыт профессиональной разработки <i class="fas fa-angle-right"></i> {{ site.time | date: '%Y' | minus: 2008 }} лет.
<br>
<i class="fab fa-rust fa-lg" style="margin-left:2px; margin-right: 5px;"></i> В основном пишу код на Rust, но так же хорошо знаю Go и Ruby.
<br>
<i class="fab fa-docker fa-lg"></i> DevOps инженер. Могу поднять и настроить Kubernetes кластер с нуля.
<br>
<i class="fas fa-microphone fa-lg" style="margin-left:5px; margin-right: 10px;"></i> Выступаю на <a href="/speaks" target="_blank">митапах / конференциях</a><sup class="counter">{{ site.counters.speaks }}</sup>
<br>
<i class="fab fa-osi fa-lg" style="margin-left:1px; margin-right: 5px;"></i> Open Source активист и <a href="/oss" target="_blank">контрибьютор</a><sup class="counter">{{ site.counters.oss }}</sup>
<br>
<i class="fab fa-github fa-lg" style="margin-left:1px; margin-right: 5px;"></i> Core-контрибьютор: <a href="https://github.com/dotenv-linter/dotenv-linter" target="_blank">dotenv-linter</a><sup class="counter">rust</sup>, <a href="https://github.com/datanymizer/datanymizer" target="_blank">datanymizer</a><sup class="counter">rust</sup>, <a href="https://github.com/goreleaser/goreleaser" target="_blank">goreleaser</a><sup class="counter">go</sup>, <a href="https://github.com/reviewdog/reviewdog" target="_blank">reviewdog</a><sup class="counter">go</sup>
<br>
<i class="fas fa-laptop-house fa-lg"></i> Работаю удалённо более <i class="fas fa-angle-right"></i> {{ site.time | date: '%Y' | minus: 2013 }} лет.
<br>
<i class="fas fa-language fa-lg"></i> Уровень английского — B2. Изучаю в Skyeng.
<br><br>

## Содержание:
* [Профессиональный опыт](#профессиональный-опыт)
* [Профессиональные навыки](#профессиональные-навыки)
* [Open Source активность](#open-source-активность)
* [Образование](#образование)
<br><br>

## Профессиональный опыт

**Февраль 2016 — По настоящее время, Evrone**<br>
**Backend разработчик (Rust, Go, Ruby), Team Lead, DevOps-инженер**

Список проектов, в которых я принимал участие:

**[BS Limousine](https://www.bslimousine.com){:target='_blank'}** — аналог Uber, только с лимузинами.

Мое участие в проекте:
* Управление командой, планирование спринтов, постановка задач, контроль качества исполнения;
* Реализация проекта на фреймворке Ruby on Rails за короткий срок.

<hr>

**[Cofoundit](https://cofoundit.ru){:target='_blank'}** — онлайн-сервис поиска работы в стартапах под инициативой ФРИИ.

Мое участие в проекте:
* Разработка проекта с нуля, от проектирования и написание ТЗ до полной сдачи проекта в эксплуатацию;
* Планирование спринтов, декомпозиция задач, контроль качества работы, управление командой.

<hr>

**[Invendor](https://invendor.ru){:target='_blank'}** — агрегатор сервисных центров.

Мое участие в проекте:
* Разработка проекта с нуля, от проектирования и написание ТЗ до полной сдачи проекта в эксплуатацию;
* Управление командой, планирование спринтов, постановка задач, контроль качества исполнения;
* Реализация проекта на фреймворке Ruby on Rails c использованием DDD;
* Написание сложных SQL-запросов и материализованных представлений с использованием PostGIS;
* Настройка CI/CD.

<hr>

**[Hunamiq](https://humaniq.com){:target='_blank'}** — децентрализованный банк нового поколения на базе блокчейна Ethereum. 

Мое участие в проекте:
* Разботка микросервисов на Go для работы с блокчейном Ethereum;
* Реализация сервиса по распознаванию лиц на Go;
* Настройка и поддержка Kubernetes кластеров на Google Cloud Platform;
* Настройка CI/CD, написание helm-чартов для развертывания сервисов в Kubernetes кластеры.

<hr>

**Mystery Mentor** — проект для автоматизации процесса ментроства внутри компании.

Мое участие в проекте:
* Разработка проекта с нуля, от проектирования и написание ТЗ до полной сдачи проекта в эксплуатацию;
* Планирование спринтов, декомпозиция задач, контроль качества работы, управление командой;
* Реализация CLI приложения на Go;
* Реализация микросервиса подстветки синтаксиса на Node.js и фреймворке Express;

<hr>

**Внутренняя ERP система** — внутренний проект компании для автоматизации рабочих процессов.

Мое участие в проекте:
* Управление командой, планирование спринтов, постановка задач, контроль качества исполнения;
* Менторство новых разработчиков в рамках этого проекта;
* Разделение проекта на микросервисы;
* Разработка gem-библиотек на Ruby;
* Разработка сервиса уведомлений (slack, mail) на Go с использованием RabbitMQ и Protocol Buffers;
* Реализация сервис произодственного календаря на Rust;
* Настройка CI/CD, Kubernetes кластера, написание helm-чартов.

<hr>

**OpenUrban** - сервис отслеживания движения транспорта в Санкт-Петербурге, аналог Яндекс.Транспорт.

Мое участие в проекте:
* Настройка и развертывание Kubernetes кластера с нуля на bare metal;
* Настройка CI/CD, миграция на Docker-образы, написание helm-чартов;
* Реализация сервиса для предсказания движения транспорта на Rust.

<hr>

**[Cryptopay](https://cryptopay.me){:target='_blank'}** — сервис по продаже/покупке криптовалюты.

Мое участие в проекте:
* Управление командой, планирование спринтов, постановка задач, контроль качества исполнения;
* Разботка микросервисов на Rust и Go;
* Настройка CI/CD, Kubernetes кластера, написание helm-чартов.

<hr>

Помимо разработки, я так же принимал участие в:
* Развитие OSS направления — популизация open source в компании, помощь коллегам с их контрибьютами;
* Развитие Rust направления — популизация языка, менторство коллег;
* Написание статей для open source проектов и их продвижение;
* Проведение собеседований на позиции Rust, Go и Ruby разработчиков.

<hr>

**Август 2015 — Февраль 2016, MDK**<br>
**Team Lead (Ruby, Rails)**

Основные обязаности:
* Построенние рабочего процесса с нуля;
* Выбор инструментов для командой разработки;
* Удаленное управление командой разработчиков;
* Планирование спринтов, постановка задач, контроль качества исполнения;
* Установка и настройка серверов.

Основной проект — сервис ставок на свои игры в Counter-Strike: Global Offensive и Dota.

Мое участие в проекте:
* Разработка проекта с нуля, от проектирования и написание ТЗ до полной сдачи проекта в эксплуатацию;
* Внутри проекта мной было реализовано: Интеграция со Steam (аутентификация, прием/вывод платежей), разработка своей внутренней валюты, внутренний API для работы с сервисом, мониторинг результатов игры, написание библиотек для работы с API сторонних сервисов.

<hr>

**Июль 2014 — Август 2015, Лаборатория Электронных Учебников**<br>
**Team Lead (Ruby, Rails)**

[«Электронная Образовательная Среда»](https://uchebnik.mos.ru){:target='_blank'} — это единое образовательное поле, в котором размещены различные идеи:
* планшет учащегося синхронизирован с интерактивной доской и может выступать в качестве пульта для голосования, учебника, интерактивного пособия или справочника
* планшет учителя — это инструмент создания урока, его проведения, заполнения сведений об образовательных достижениях учащихся
* интерактивная доска — она позволяет отображать не только учебный материал, результаты экспресс-опросов или содержание планшетов учащихся, но и дает возможность активно моделировать процессы окружающего мира, характерные для предметного направления
* электронный дневник — с его помощью учащиеся могут просматривать домашние задания и расписание занятий в режиме онлайн, а их родители всегда в курсе успеваемости детей
* информационная система «Посещение и питание» — в школах, оснащенных данной системой, ученики проходят в здание по электронной карте — своеобразный эквивалент визитки школьника и удобный платёжный инструмент.

Проект разделен на несколько подпроектов:<br>

**1/ Система управления обучением** — сердце проекта «Электронная Образовательная Среда», содержит в себе логику по созданию расписания, работе с пользователями, проведению уроков и многое другое.

Мое участие в проекте:
* Планирование разработки, декомпозиция задач, контроль качества работы;
* Разработка логики и API, покрытие кода тестами (acceptance, unit, views), написание документации;
* Оптимизация API, запросов к БД, систем авторизации и кэширования, тестов (более 9000), перенос логики из моделей в сервисы и фоновые задачи, перенос логики из представлений в декораторы;
* Настройка развертывания и непрерывная интеграция приложения через TeamCity.

**2/ Система управления контентом** — проект по управлению электронными учебниками и созданию пользовательского контента с помощью редактора.

Мое участие в проекте:
* Разработка проекта с нуля, проектирование, декомпозиция задач, контроль качества работы, управление командой;
* Создание нескольких микросервисов, настройка их взаимодействия между собой через API;
* Разработка библиотеки для хранения пользовательских материалов в формате XML и дальнейшей их компиляции в бинарный формат;
* Написание библиотек для работы с API сторонних сервисов. Полное тестирование проекта и взаимодействия между микросервисами;
* Реализация фоновой обработки материалов содержащих видео. Разработка менеджера очереди для компиляции материалов;
* Настройка развертывания и непрерывная интеграция приложения через TeamCity.

<hr>

**Ноябрь 2013 — Июль 2014, Вольтекс Технолоджи**<br>
**Team Lead (Ruby, Rails)**

«Doka.Box» — программно-аппаратный комплекс, который позволяет за считанные минуты организовать работу малого офиса, включая беспроводную локальную сеть, доступ в интернет, телефон и программное обеспечение для коллективной работы сотрудников.

Мое участие в проекте:
* Управление командой разработчиков (Backend/Frontend): постановка задач, выставления сроков выполнения, контроль качества работы, обучение команды, написание технической документации;
* Помимо управления командой, основную часть времени занимался разработкой веб-интерфейса «Doka.Box»: реализация API для работы с аппаратной частью, доработка сторонних библиотек под нужды проекта, полное тестирование проекта с помощью RSpec и Capybara;
* Написание внутренних библиотек для работы с железом, с использованием протокола AMQP для передачи сообщений.

<hr>

**Июль 2013 — Октябрь 2013, BlueFox**<br>
**Ведущий backend-разработчик (Ruby, Rails)**

«Mercury» — внутренний проект для французской компании BlueFox.
Основные функции проекта — CRM, Billing, Stock Management.
Проект построен на основе Active Admin.

Мое участие в проекте:
* Интеграция Rails Money, разработка дополнительных решений, для работы с разными валютами, автоматическое обновление курса валют через Eu Central Bank;
* Работа с фоновыми задачами с использованием Sidekiq, контроль их выполнения;
* Генерация и парсинг Excel файлов;
* Разработка решений для интеграции проекта с сервисом Amazon S3 и Heroku.

<hr>

**Январь 2013 — Июль 2013, Ivory Interactive**<br>
**Backend-разработчик (Ruby, Rails)**

«BusStop» — проект по разработке системы "Digital Signage" для информационных терминалов на остановках общественного транспорта города Москвы.
Проект состоит из двух частей — клиентская часть (терминалы) и серверная (API, интерфейс управления для клиентов, интерфейс администратора).

Мое участие в проекте:
* Создание интерфейса управления терминалами;
* Разработка решений для сбора и отображения статистики, генерация тепловой карты кликов по терминалам;
* Написание парсера новостных лент и генератора PDF-отчетов.

<hr>

**Октябрь 2012 — Январь 2013, FeedMan**<br>
**Backend-разработчик (Ruby, Rails)**

«FeedMan» - сервис отложенных публикаций в социальные сети.

Мое участие в проекте:
* Разработка биллинг системы, подключение оплаты через Robokassa.
* Написание RSS и FeedBurner парсеров для автоматического сбора пользовательких статей и публикации их в социальные сети;
* Настройка автоматического развертывания и резервного копирования проекта.

<hr>

**Июль 2012 — Октябрь 2012, Cafe Digital**<br>
**Backend-разработчик (Ruby, Rails)**

«Диета Инны Воловичевой» — проект по распространению диеты, посредством смс-подписок.
Одновременно с этим проектом разрабатывалась платформа, для работы с контент-провайдерами.
Проект включает в себя API, систему биллинга, сервис статистики, личный кабинет.
Работа с подписками осуществлялась через API сторонних сервисов — Platinot, A1 Sms Market, МосКомСвязь, 7hlp.

Мое участие в проекте:
* Написание библиотек для работы с API сторонних сервисов, тестирование кода;
* Разработка сервиса статистики (Backend/Frontend) и системы биллинга.

<hr>

**Ноябрь 2011 — Июль 2012, Lebrand Creative Russia**<br>
**Веб-разработчик (PHP/1С-Битрикс, JavaScript)**

Разработка проектов:
* интернет-магазин мебели «Столплит»;
* портал о топливных картах «Топкарта»;
* несколько проектов для банка «2TBank»;
* агрегатор CPA-сетей и рекламная платформа «ARBOOST».

<hr>

**Июль 2010 — Ноябрь 2011, 4TE**<br>
**Веб-разработчик (PHP, JavaScript)**

Разработка и поддержка внутренних проектов компании:
* мерчендайзинг товаров для компании LG;
* система «Тайный покупатель» для компаний Роснефть и Газпром нефть.

<hr>

**Ноябрь 2009 — Июль 2010, Masterhost**<br>
**Системный администратор**

Установка, настройка, админинстрирование и мониторинг:
* серверов на базе Linux/FreeBSD;
* почтовых кластеров(Exim, Qmail).<br>

Написание shell-скриптов для автоматизации рабочих процессов.

<hr>

**Сентябрь 2008 — Октябрь 2009, ТТК**<br>
**Системный администратор**

Настройка и администрирование:
* серверов на базе ОС Linux/Windows;
* офисной локальной сети;
* почтовых серверов;
* сайтов и хостингов.
<br><br>

## Профессиональные навыки

### Backend

Хорошее знание Rust, Go, Ruby (Rails, Hanami, Sinatra).

Есть опыт написания как микросервисов, так и полноценных CLI приложений.

Опыт разработки на Node.js с использованием фреймворка Express.

### Базы данных

С 2012 года, в качестве СУБД использую PostgreSQL, до этого работал с MySQL. Из NoSQL решений предпочитаю использовать Redis, есть опыта работы с MongoDB и Memcached.

### DevOps

Docker и Docker Compose использую на всех проектах.

Большой опыт настройки и развертывания с нуля Kubernetes кластеров, как на Google Cloud Platform, так и на bare metal.

В качестве CI/CD предпочитаю использовать GitHub Actions, но есть опыт работы и с другими сервисами.

Работал с Ansible, Chef, Capistrano, Mina.

Так же есть большой опыт работы с ОС семейства Unix: Gentoo, Debian, RHEL, Ubuntu, когда-то в прошлом и FreeBSD.
<br><br>

## Open Source активность

**Core-контрибьютор**:
* В одном проекте на Rust: [datanymizer](https://github.com/datanymizer/datanymizer);
* И в двух проектах на Go: [goreleaser](https://github.com/goreleaser/goreleaser) и [reviewdog](https://github.com/reviewdog/reviewdog).

Мои коммиты можно найти в таких проектах: <a href="/oss" target="_blank">rails, hanami, micro, intellij-rust, etc</a><sup class="counter">{{ site.counters.oss }}</sup>

**Мои OSS проекты**:
* [dotenv-linter](https://github.com/dotenv-linter/dotenv-linter) — линтер для `.env` файлов, написанный на Rust.
  В рамках этого проекта я так же выступаю в роли ментора и помогаю всем желающим начать контрибьютить в open source проекты на Rust;
* [gastly](https://github.com/mgrachev/gastly) — библиотека на Ruby для создания скриншотов сайтов. Под капотом используется Phantom.js и MiniMagick;
* [capistrano-hanami](https://github.com/mgrachev/capistrano-hanami) — библиотека на Ruby для развертывания проекта на Hanami через Capistrano;
* [mina-hanami](https://github.com/mgrachev/mina-hanami) — библиотека на Ruby для развертывания проекта на Hanami через Mina;
* [brevity](https://github.com/mgrachev/brevity) — сокращалка ссылок на Go с готовым helm-чартов для развертывания в Kubernetes кластере;
* [queue_manager](https://github.com/mgrachev/queue_manager) — менеджер очереди уникальных задач на Ruby. Под капотом Redis Sorted Sets. Поддерживает ActiveJob и Global ID;
* [pivotal_tracker_telegram_bot](https://github.com/mgrachev/pivotal_tracker_telegram_bot) — телеграм бот на Ruby для получения уведомлений из Pivotal Tracker. Под капотом Sinatra и Redis PubSub.

В рамках проекта [reviewdog](https://github.com/reviewdog/reviewdog) создал несколько GitHub Actions для запуска популярных линтеров:
* [action-reek](https://github.com/reviewdog/action-reek)
* [action-rubocop](https://github.com/reviewdog/action-rubocop)
* [action-hadolint](https://github.com/reviewdog/action-hadolint)
* [action-brakeman](https://github.com/reviewdog/action-brakeman)
* [action-dotenv-linter](https://github.com/dotenv-linter/action-dotenv-linter)
<br><br>

## Образование

2008 - 2012, МГУ им. Н.П. Огарёва, АСОиУ