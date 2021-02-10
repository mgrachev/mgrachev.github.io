---
layout: post
title: "Dotenv-linter: линтер .env файлов"
date: 2020-04-20 17:00:00
update_date: 2021-01-02 18:00:00
tags: dotenv-linter dotenv linter env 12factor rust docker compose github actions reviewdog golang ruby php elixir javascript haskell python homebrew 
summary: "⚡️Молниеносный инструмент для проверки <code>.env</code> файлов 🦀"
---

При разработке приложений я всегда стараюсь придерживаться манифеста [двенадцати факторов](https://12factor.net){:target='_blank'}. Такой подход позволяет избежать большого количества проблем, связанных с развертыванием приложений и их дальнейшей поддержкой.

[Один из принципов](https://12factor.net/config){:target='_blank'} этого манифеста гласит, что все настройки должны хранится в переменных окружения. Это позволяет менять их под разные окружения (Staging, QA, Production) без изменения кода.

![dotenv-linter]({{ site.url }}/assets/images/2020-04-20-dotenv-linter/dotenv-linter-cover-zgs7ns5ah2m5.png){: .center-image }

Однако, во время разработки могут возникать сложности при работе с такими переменными. С ростом проекта, обычно также увеличивается количество переменных окружения и с ними становится не так удобно работать. Нужно каждый раз указывать их все при запуске приложения:

```bash
$ RAILS_ENV=development REDIS_URL=redis://redis:6379 DATABASE_URL=postgres://postgres:postgres@db:5432 bundle exec rails server
```

<br/>

И тут на помощь приходят `.env` файлы. Они предоставляют удобный способ хранения всех переменных окружения в одном месте:

```bash
# .env
RAILS_ENV=development
REDIS_URL=redis://redis:6379
DATABASE_URL=postgres://postgres:postgres@db:5432
```

Для работы с `.env` файлами есть довольно много библиотек на разных языках программирования. Всё что они делают &mdash; это загружают переменные из `.env` файла при запуске приложения:

* Rust: [https://github.com/dotenv-rs/dotenv](https://github.com/dotenv-rs/dotenv){:target='_blank'};
* Golang: [https://github.com/joho/godotenv](https://github.com/joho/godotenv){:target='_blank'};
* Ruby: [https://github.com/bkeepers/dotenv](https://github.com/bkeepers/dotenv){:target='_blank'};
* PHP: [https://github.com/vlucas/phpdotenv](https://github.com/vlucas/phpdotenv){:target='_blank'};
* Elixir: [https://github.com/avdi/dotenv_elixir](https://github.com/avdi/dotenv_elixir){:target='_blank'};
* JavaScript: [https://github.com/motdotla/dotenv](https://github.com/motdotla/dotenv){:target='_blank'};
* Haskell: [https://github.com/stackbuilders/dotenv-hs](https://github.com/stackbuilders/dotenv-hs){:target='_blank'};
* Python: [https://github.com/theskumar/python-dotenv](https://github.com/theskumar/python-dotenv){:target='_blank'}.

При использовании Docker и Docker Compose переменные окружения можно указать с помощью ключа `environment` в файле `docker-compose.yml`:

```yaml
# docker-compose.yml
version: '2.4'
services:
  app:
    build:
      context: .
    environment:
      RAILS_ENV: development
      REDIS_URL: redis://redis:6379
      DATABASE_URL: postgres://postgres:postgres@db:5432
```

Но, как я уже писал ранее, с ростом проекта также увеличивается количество переменных, а вместе с ними и количество сервисов, которые необходимы вашему приложению, например Redis, RabbitMQ и т.д. И со временем, `docker-compose.yml` увеличивается в размерах и становится просто нечитаемым. В такой ситуации опять же могут помочь `.env` файлы, в которые можно вынести все переменные окружения и подключить их к `docker-compose.yml` с помощью ключа `env_file`:

```yaml
# docker-compose.yml
version: '2.4'
services:
  app:
    build:
      context: .
    env_file:
      - .env
```

<br/>

В процессе работы с `.env` файлами, часто могут возникать проблемы, которые можно не заметить с первого взгляда и даже пропустить при проверке кода, но которые могут стать причиной неправильной работы приложения:

**1. Дублирование ключей**

Такую проблему можно встретить, если в проекте есть `.env` файл, который содержит большое количество строк. В этой ситуации, легко не заметить появление новых переменных окружения с уже существующими ключами. В таком случае, новые переменные перезапишут старые значения:

```bash
# .env
FOO=BAR
# ...
FOO=FOO
```

**2. Неправильный разделитель**

Для удобства ключи переменных окружения можно разделять с помощью символа `_`. Однако в процессе разработки можно легко ошибиться и использовать другой символ, например `-`:

```bash
# .env
# Неправильно
FOO-BAR=FOOBAR

# Правильно
FOO_BAR=FOOBAR
```

**3. Переменные без значения**

Иногда бывают ситуации, когда нужно добавить новую переменную в приложение, но пока неизвестно, какое значение у неё будет. В таком случае обычно добавляют пустую переменную окружения. Но и здесь можно допустить ошибку, забыв указать символ `=`:

```bash
# .env
# Неправильно
FOO

# Правильно
FOO=
```

**4. Некорректный первый символ**

Не все знают, но есть ограничения при наименование переменных окружения. Они не могут начинаться с цифр и других символов, за исключением символа `_`:

```bash
# .env
# Неправильно
 FOO=BAR
.FOO=BAR
*FOO=BAR
1FOO=BAR

# Правильно
_FOO=BAR
```

**5. Ключи в нижнем регистре**

Продолжая тему ограничений, нельзя не упомянуть, что все ключи переменных окружения должны быть в верхнем регистре:

```bash
# .env
# Неправильно
foo=bar

# Правильно
FOO=bar
```

**6. Пробелы**

Ещё одной проблемой могут стать пробелы. Особенно, если они присутствуют между ключом и значением переменной окружения:

```bash
# .env
# Неправильно
FOO = BAR

# Правильно
FOO=BAR
```

**7. Сортировка по алфавиту**

Сортировка, конечно, не является проблемой, но куда приятнее работать с `.env` файлами, где все ключи отсортированы по алфавиту:

```bash
# .env
# Неправильно
FOO=BAR
BAR=FOO

# Правильно
BAR=FOO
FOO=BAR
```

<br/>

Все проблемы, описанные выше, взяты из реальных проектов. На протяжение всей своей работы я постоянно сталкивался с ними, что доставляло различные неудобства в процессе разработки, а в некоторых случаях даже приводило к неправильной работе приложений.

Поэтому в один прекрасный день я решил создать инструмент, который позволил бы мне избежать подобных проблем в будущем, раз и навсегда.

И вот так появился [dotenv-linter](https://github.com/dotenv-linter/dotenv-linter){:target='_blank'} &mdash; линтер для `.env` файлов. Он позволяет проверить `.env` файлы на наличие всех проблем, описанных выше &mdash; от дублирования ключей и до сортировки.

Его ключевые особенности:

* Молниеносно быстрый и всё благодаря тому, что он написан на [Rust](https://www.rust-lang.org){:target='_blank'} 🦀
* Можно использовать на любом проекте, вне зависимости от языка программирования 🔥
* Возможна интеграция с [reviewdog](https://github.com/reviewdog/reviewdog){:target='_blank'} и CI сервисами (включая [GitHub Actions](https://github.com/dotenv-linter/action-dotenv-linter){:target='_blank'}) 🚀

### Установка

Есть несколько вариантов установки dotenv-linter. Самый простой вариант &mdash; скачать бинарный файл с помощью `curl` или `wget`:

```bash
# Linux / macOS / Windows (MINGW и т.д.). По умолчанию устанавливается в директорию ./bin
$ curl -sSfL https://raw.githubusercontent.com/dotenv-linter/dotenv-linter/master/install.sh | sh -s

# Можно указать директорию установки и версию
$ curl -sSfL https://raw.githubusercontent.com/dotenv-linter/dotenv-linter/master/install.sh | sh -s -- -b usr/local/bin v2.0.0

# Alpine Linux (wget)
$ wget -q -O - https://raw.githubusercontent.com/dotenv-linter/dotenv-linter/master/install.sh | sh -s
```

Другой вариант &mdash; установить через [Homebrew](https://brew.sh){:target='_blank'}:

```bash
$ brew install dotenv-linter
```

Так же есть возможность запуска dotenv-linter с помощью Docker:

```bash
$ docker run --rm -v `pwd`:/app -w /app dotenvlinter/dotenv-linter
```

Другие варианты установки можно найти на сайте проекта [dotenv-linter.github.io](https://dotenv-linter.github.io/#/installation){:target='_blank'}.

### Использование

По умолчанию dotenv-linter проверяет все `.env` файлы в текущей директории:

```bash
$ dotenv-linter
.env:2 DuplicatedKey: The FOO key is duplicated
.env:3 UnorderedKey: The BAR key should go before the FOO key
.env.test:1 LeadingCharacter: Invalid leading character detected
```

Чтобы проверить другую директорию, достаточно передать её путь в качестве аргумента. Этот же подход работает, если нужно проверить какие-нибудь файлы по отдельности:

```bash
$ dotenv-linter dir1 dir2/.my-env-file
dir1/.env:1 LeadingCharacter: Invalid leading character detected
dir1/.env:3 IncorrectDelimiter: The FOO-BAR key has incorrect delimiter
dir2/.my-env-file:1 LowercaseKey: The bar key should be in uppercase
```

Исключить какой-нибудь файл из проверки можно с помощью аргумента `--exclude`:

```bash
$ dotenv-linter --exclude .env.test
.env:2 DuplicatedKey: The FOO key is duplicated
.env:3 UnorderedKey: The BAR key should go before the FOO key
```

### Интеграция

Отдельно стоит упомянуть про возможность интеграции dotenv-linter с [reviewdog](https://github.com/reviewdog/reviewdog){:target='_blank'}, что позволяет получать предупреждения от линтера в виде комментариев на GitHub или GitLab.

```bash
$ dotenv-linter | reviewdog -f=dotenv-linter -diff="git diff master"
```

При использование [GitHub Actions](https://github.com/features/actions){:target='_blank'}, достаточно будет подключить к проекту [dotenv-linter/action-dotenv-linter](https://github.com/dotenv-linter/action-dotenv-linter){:target='_blank'}:

```yaml
# .github/workflows/dotenv_linter.yml
name: dotenv-linter
on: [pull_request]
jobs:
  dotenv-linter:
    name: runner / dotenv-linter
    runs-on: ubuntu-latest
    steps:
      - name: Check out code
        uses: actions/checkout@v1
      - name: dotenv-linter
        uses: dotenv-linter/action-dotenv-linter@v1
```

Больше информации вы можете найти на сайте проекта [dotenv-linter.github.io](https://dotenv-linter.github.io){:target='_blank'}.

---

С самого начала dotenv-linter разрабатывался силами Open Source сообщества.<br/>
Поэтому, если у вас есть желание поизучать [Rust](https://www.rust-lang.org){:target='_blank'} и заодно поучаствовать в разработке замечательного Open Source проекта, то [dotenv-linter](https://github.com/dotenv-linter/dotenv-linter){:target='_blank'} &mdash; это то, что вам нужно!<br/>
Мы будем рады любой помощи!
