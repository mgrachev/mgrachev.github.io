---
layout: post
title: "Dotenv-linter v3.0.0"
date: 2021-01-28 09:00:00
tags: dotenv-linter dotenv linter env 12factor .env api export github
summary: "⚡️Обзор ключевых изменений вошедших в новый релиз 🎉"
---

Прошло 2 с половиной месяца с момента прошлого релиза, а мы уже готовы вам представить новую версию [dotenv-linter](https://github.com/dotenv-linter/dotenv-linter){:target='_blank'} - v3.0.0 🎉

![dotenv-linter]({{ site.url }}/assets/images/2021-01-28-dotenv-linter-v300/dotenv-linter-v300-cover-sn29fh5ma.png){: .center-image }

###  Что такое `.env` файлы?

`.env` или `dotenv` файлы — это простые текстовые файлы, содержащие в себе переменные окружения проекта.
Файлы имеют формат «ключ-значение», например: `FOO=BAR`.
Хранение [конфигурации в переменных окружения](https://12factor.net/config){:target='_blank'} является одним из принципов манифеста [Twelve-Factor App](https://12factor.net){:target='_blank'}.

Вот обзор ключевых изменений, которые попали в этот релиз.

### 1. Улучшение API 👍

В предыдущей версии, у `dotenv-linter` было несколько флагов, которые по сути являлись отдельными командами - `--fix` и `--show-checks`:

```
FLAGS:
    -f, --fix            Automatically fixes warnings
    -h, --help           Prints help information
        --no-backup      Prevents .env files from being backed up when modified by -f/--fix
    -q, --quiet          Doesn't display additional information
    -r, --recursive      Recursively search and check .env files
        --show-checks    Shows list of available checks
    -v, --version        Prints version information
```

Это приводило к небольшой путанице, т.к. эти флаги конфликтовали и не работали друг с другом:

```
$ dotenv-linter --fix --show-checks
```

В новой версии мы исправили это и вынесли флаги `--fix` и `--show-checks` в отдельные команды `fix` и `list`:

```
FLAGS:
    -h, --help         Prints help information
    -q, --quiet        Doesn't display additional information
    -r, --recursive    Recursively searches and checks .env files
    -v, --version      Prints version information

SUBCOMMANDS:
    fix        Automatically fixes warnings [aliases: f]
    list       Shows list of available checks [aliases: l]
```

PR: [#342](https://github.com/dotenv-linter/dotenv-linter/pull/342){:target='_blank'} ([@mgrachev](https://github.com/mgrachev){:target='_blank'})

### 2. Сравнение `.env` файлов 🤲

Также, в новой версии мы добавили новую команду `compare`, которая позволяет сравнивать ключи в `.env` файлах:

```
$ dotenv-linter compare .env .env.example
Comparing .env
Comparing .env.example
.env is missing keys: BAR
.env.example is missing keys: FOO
```

PR: [#282](https://github.com/dotenv-linter/dotenv-linter/pull/282){:target='_blank'} ([@mstruebing](https://github.com/mstruebing){:target='_blank'})

### 3. Отображение проверяемых файлов 👀

При наличии нескольких `.env` файлов, не всегда было понятно, какие из них проверил `dotenv-linter`, а какие нет.

Это могло быть связано с нестандартным именем файла, либо с отсутствием каких-либо проблем в этих файлах.

Поэтому в новой версии мы добавили отображение проверяемых файлов:

```
$ dotenv-linter
Checking .env
.env:1 LeadingCharacter: Invalid leading character detected

Checking .env.example
Checking .env.test

Found 1 problem
```

Отключить такое поведение можно с помощью флага `--quiet/-q`:

```
$ dotenv-linter --quiet
.env:1 LeadingCharacter: Invalid leading character detected
```

PR: [#311](https://github.com/dotenv-linter/dotenv-linter/pull/311){:target='_blank'} ([@Anthuang](https://github.com/anthuang){:target='_blank'}), [#336](https://github.com/dotenv-linter/dotenv-linter/pull/336){:target='_blank'} ([@DDtKey](https://github.com/DDtKey){:target='_blank'})

### 4. Цветной вывод 🌈

Для улучшения удобства использования, мы добавили цветной вывод предупреждений:

![colored-output]({{ site.url }}/assets/images/2021-01-28-dotenv-linter-v300/dotenv-linter-v300-colored_output-hhd82h4kd9.png){: .center-image }

Отключить цветной вывод можно с помощью флага `--no-color`.

PR: [#307](https://github.com/dotenv-linter/dotenv-linter/pull/307){:target='_blank'} ([@Nikhil0487](https://github.com/Nikhil0487){:target='_blank'})

### 5. Поддержка многострочных значений 💪

В `.env` файлах можно хранить многострочные значения. Один из вариантов выглядит следующим образом:

```
# .env
MULTILINE="new\nline"
```

Но при проверке таких значений, `dotenv-linter` всегда выводил предупреждение:

```
$ dotenv-linter
.env:1 QuoteCharacter: The value has quote characters (', ")

Found 1 problem
```

Мы исправили это и теперь `dotenv-linter` не выводит предупреждения для многострочных значений, обернутых кавычками.

PR: [#341](https://github.com/dotenv-linter/dotenv-linter/pull/341){:target='_blank'} ([@artem-russkikh](http://github.com/artem-russkikh){:target='_blank'})

### 6. Поддержка `export` префикса 🔥

Некоторые библиотеки для работы с `.env` файлами, такие как: [dotenv](https://github.com/bkeepers/dotenv){:target='_blank'}, [godotenv](https://github.com/joho/godotenv){:target='_blank'} и [python-dotenv](https://github.com/theskumar/python-dotenv){:target='_blank'} поддерживают `export` префикс:

```
# .env
export S3_BUCKET=YOURS3BUCKET
export SECRET_KEY=YOURSECRETKEYGOESHERE
```

`export` префикс дает возможность экспортировать переменные окружения из файла с помощью команды `source`:

```
$ source .env
```

При проверке таких файлов, `dotenv-linter` всегда выводил предупреждения:

```
$ dotenv-linter
.env:1 IncorrectDelimiter: The export S3_BUCKET key has incorrect delimiter
.env:1 LowercaseKey: The export S3_BUCKET key should be in uppercase
.env:2 IncorrectDelimiter: The export SECRET_KEY key has incorrect delimiter
.env:2 LowercaseKey: The export SECRET_KEY key should be in uppercase

Found 4 problems
```

В новой версии мы добавили поддержку `export` префикса и теперь `dotenv-linter` не выводит никаких предупреждений.

PR: [#340](https://github.com/dotenv-linter/dotenv-linter/pull/340){:target='_blank'} ([@skonik](https://github.com/skonik){:target='_blank'})

### 7. Поддержка пробелов 🙌

Ещё одним из улучшений стала поддержка пробелов в значениях, обернутых кавычками:

```
# .env
WHITESPACES="a b c"
```

Теперь, для таких значения `dotenv-linter` не будет выводить предупреждения.

PR: [#349](https://github.com/dotenv-linter/dotenv-linter/pull/349){:target='_blank'} ([@sebastiantoh](https://github.com/sebastiantoh){:target='_blank'})

### 8. Улучшенная проверка 👌

Также, мы исправили проблему, при которой `dotenv-linter` мог выводить не все предупреждения за один раз:

```
$ dotenv-linter fix .env
Fixing .env
Original file was backed up to: ".env_1606422805"

.env:1 KeyWithoutValue: The test key should be with a value or have an equal sign

All warnings are fixed. Total: 1

$ dotenv-linter .env
Checking .env
.env:1 LowercaseKey: The test key should be in uppercase

Found 1 problem
```

PR: [#348](https://github.com/dotenv-linter/dotenv-linter/pull/348){:target='_blank'} ([@vbrandl](https://github.com/vbrandl){:target='_blank'})

### 9. Улучшение производительности 🚀

И последнее, но не по значению - мы улучшили производительность и без того быстрого `dotenv-linter`, что теперь максимальное время запуска уменьшилось с `9.3` мс до `4.3` мс (более чем на `50%`) 🙀

Для подтверждения этого, мы сделали бенчмарк с помощью утилиты [hyperfine](https://github.com/sharkdp/hyperfine){:target='_blank'}:

| Command                              |    Mean [ms] | Min [ms] | Max [ms] |      Relative |
| :----------------------------------- | -----------: | -------: | -------: | ------------: |
| `dotenv-linter/dotenv-linter .env`   |    2.7 ± 0.4 |      2.0 |      4.3 |          1.00 |
| `wemake-services/dotenv-linter .env` | 162.6 ± 12.1 |    153.0 |    201.3 | 60.83 ± 10.20 |

PR: [#350](https://github.com/dotenv-linter/dotenv-linter/pull/350){:target='_blank'} ([@vbrandl](https://github.com/vbrandl){:target='_blank'})

Это все ключевые изменения, которые вошли в новый релиз [v3.0.0](https://github.com/dotenv-linter/dotenv-linter/releases/tag/v3.0.0){:target='_blank'}.
Спасибо всем кто участвовал в подготовке этого релиза 🙏

Вы можете поддержать проект 😉
* Поставить звездочку на [GitHub](https://github.com/dotenv-linter/dotenv-linter){:target='_blank'} ⭐️
* Стать спонсором на [GitHub Sponsors](https://github.com/sponsors/dotenv-linter){:target='_blank'} или [OpenCollective](https://opencollective.com/dotenv-linter){:target='_blank'} ❤️
