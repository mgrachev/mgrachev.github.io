---
layout: page
permalink: /cv/
---

<div class="cv clearfix">
    <div class="left" style="height:220px;">
        <img width="220" height="220" src="https://avatars3.githubusercontent.com/u/700998" alt="Mikhail Grachev" class="avatar" />
    </div>
    <h2>Mikhail Grachev</h2>
    <h3>Rust Developer / Team Lead / Dev Advocate</h3>

    work<i class="fas fa-at"></i>mgrachev.com
    <br>
    <i class="fab fa-github fa-lg"></i> <a href="https://github.com/mgrachev" target="_blank">mgrachev</a>
    <br>
    <i class="fab fa-telegram fa-lg"></i> <a href="https://t.me/grachevm" target="_blank">grachevm</a>
</div>

## TL;DR (EN | [RU](/cv_ru))

<i class="fas fa-address-card fa-lg" style="margin-left:2px; margin-right: 1px;"></i> I'm 35 years old.
<br>
<i class="fas fa-laptop-code fa-lg"></i> Backend developer and Team Lead. Professional development experience <i class="fas fa-angle-right"></i> {{ site.time | date: '%Y' | minus: 2008 }} years.
<br>
<i class="fab fa-rust fa-lg" style="margin-left:2px; margin-right: 5px;"></i> I mostly write code in Rust, but I also know Go, Ruby and Elixir very well.
<br>
<i class="fab fa-docker fa-lg"></i> DevOps engineer. I can set up and configure a Kubernetes cluster from scratch. 
<br>
<i class="fas fa-microphone fa-lg" style="margin-left:5px; margin-right: 10px;"></i> I speak at <a href="/speaks" target="_blank">meetups / conferences</a><sup class="counter">{{ site.counters.speaks }}</sup>
<br>
<i class="fas fa-fire fa-lg" style="margin-left:5px; margin-right: 10px;"></i> I'm part of program committee <a href="https://rustcon.ru" target="_blank">RustCon</a>.
<br>
<i class="fab fa-osi fa-lg" style="margin-left:1px; margin-right: 5px;"></i> Open Source activist and <a href="/oss" target="_blank">contributor</a><sup class="counter">{{ site.counters.oss }}</sup>
<br>
<i class="fab fa-github fa-lg" style="margin-left:1px; margin-right: 5px;"></i> Core contributor: <a href="https://github.com/dotenv-linter/dotenv-linter" target="_blank">dotenv-linter</a><sup class="counter">rust</sup>, <a href="https://github.com/datanymizer/datanymizer" target="_blank">datanymizer</a><sup class="counter">rust</sup>, <a href="https://github.com/goreleaser/goreleaser" target="_blank">goreleaser</a><sup class="counter">go</sup>, <a href="https://github.com/reviewdog/reviewdog" target="_blank">reviewdog</a><sup class="counter">go</sup>
<br>
<i class="fas fa-laptop-house fa-lg"></i> I work remotely more than <i class="fas fa-angle-right"></i> {{ site.time | date: '%Y' | minus: 2013 }} years.
<br>
<i class="fas fa-language fa-lg"></i> English level - B1.
<br><br>

## Table of contents:
* [Professional experience](#professional-experience)
  * [Foxford](#foxford)
  * [Evrone](#evrone)
  * [MDK](#mdk)
  * [Laboratory of Electronic Textbooks](#laboratory-of-electronic-textbooks) 
  * [Voltex Technology](#voltex-technology)
  * [BlueFox](#bluefox)
  * [Ivory Interactive](#ivory-interactive)
  * [FeedMan](#feedman)
  * [Cafe Digital](#cafe-digital)
  * [Lebrand Creative Russia](#lebrand-creative-russia)
  * [4TE](#4te)
  * [Masterhost](#masterhost)
  * [TransTeleCom](#transtelecom)
* [Professional skills](#professional-skills)
  * [Backend](#backend)
  * [Database](#database)
  * [DevOps](#devops)
* [Open Source activity](#open-source-activity)
  * [My projects](#my-oss-projects)
* [Education](#education)
<br><br>

## Professional experience

### Foxford
**Backend developer (Rust)**<br>
_February 2022 — Present_

**[Foxford](https://foxford.ru){:target='_blank'}** — An online school for students of grades 1-11, preschoolers, teachers and parents.

My participation in the project:
* Development of our own platform for holding webinars in real time (Live Streaming), transcoding and distribution of records of past events (VoD), instant messaging and events.

The project code is open and available on GitHub: [github.com/foxford](https://github.com/foxford){:target='_blank'}

<hr>

### Evrone
**Backend developer (Rust, Go, Ruby, Elixir), Team Lead, DevOps engineer**<br>
_February 2016 - January 2022_

**_In addition to development, I also took part in:_**
* Development of OSS directions - popularization of open source in the company, helping colleagues with their contributions;
* Development of the Rust direction - the popularization of the language, mentoring of colleagues;
* Writing articles for open source projects and their promotion;
* Interviewing for Rust, Go, Ruby and Elixir developers.

**_List of projects in which I took part:_**

**[Jiseki Health](https://www.jisekihealth.com/){:target='_blank'}** (_**Elixir**_) — a medical concierge service,
which helps clients to take care of their health and improve their quality of life.

My participation in the project:
* Development of the project in Elixir using the Phoenix framework;
* Implementation of a three-stage data parsing script with a schedule of doctors' availability;
* Implementation of a process pipeline for loading new users using the Broadway framework (Amazon SQS);
* Implementation of a library for working with the Box.com API (upload / download large files in chunks);
* Implementation of user authentication via API and GraphQL using the Guardian library;
* Implementation of parsing large CSV files and storing them on Amazon S3.

<hr>

**[Cryptopay](https://cryptopay.me){:target='_blank'}** (_**Rust**_, _**Go**_, _**DevOps**_) — a multifunctional cryptocurrency payment service.

My participation in the project:
* Team management, planning sprints, setting tasks, quality control of execution;
* Development of microservices in Rust and Go for processing transactions through the services ClearBank and Clear Junction;
* Implementation of the CLI application in Rust for testing automation by the QA department;
* Setting up CI/CD and a Kubernetes cluster, writing helm charts.

<hr>

**OpenUrban** (_**Rust**_, _**Ruby**_, _**DevOps**_) - a traffic tracking service in St. Petersburg (analogue of Yandex.Transport).

My participation in the project:
* Configuring and deploying a Kubernetes cluster from scratch to bare metal;
* Setting up CI/CD, migrating to Docker images, writing helm charts;
* Deploying a large number of services in Ruby and Node.js and setting up their interaction;
* Implementation of a service for working with data in GTFS and GTFS Realtime format;
* Integration of projects with Kafka for messaging (using Schema Registry and Avro);
* Implementation of a traffic forecasting service in Rust.

<hr>

**Internal ERP system** (_**Rust**_, _**Ruby**_, _**Go**_, _**DevOps**_) — an internal project of the company to automate work processes.

My participation in the project:
* Team management, planning sprints, setting tasks, quality control of execution;
* Mentoring new developers in this project;
* Sawing a large monolith into microservices;
* Development of gem-libraries in Ruby for messaging between services;
* Development of a notification service (slack, mail) in Go using RabbitMQ and Protocol Buffers;
* Implementation of the production calendar service in Rust;
* Setting up CI/CD, Kubernetes cluster, writing helm charts.

<hr>

**Mystery Mentor** (_**Go**_, _**Node.js**_, _**Ruby**_, _**DevOps**_) — a marketplace for mentors that provides complete automation of the entire code review process.

My participation in the project:
* Development of the project from scratch, from design and writing of technical specifications to complete commissioning of the project;
* Sprint planning, task decomposition, work quality control, team management;
* Implementation of the client-server architecture of the project;
* Implementation of a full-fledged CLI application in Go;
* Automation of the CLI application distribution process on OS: macOS, Windows, Linux;
* Implementation of syntax highlighting microservice in Node.js and Express framework.

<hr>

**[Hunamiq](https://humaniq.com){:target='_blank'}** (_**Go**_, _**DevOps**_) — a new generation decentralized bank based on the Ethereum blockchain.

My participation in the project:
* Development of microservices in Go for:
  * User authentication/authorization;
  * Works with the Ethereum blockchain;
  * Face recognition;
  * Shortening links;
  * Work of the referral program;
  * Processing of internal transactions (without commission);
  * Sending notifications via Firebase Cloud Messaging (FCM).
* Configuring and maintaining Kubernetes clusters on the Google Cloud Platform;
* Setting up CI/CD, writing helm charts for deploying services to Kubernetes clusters.

<hr>

**[Invendor](https://invendor.ru){:target='_blank'}** (_**Ruby**_) — an aggregator of service centers.

My participation in the project:
* Development of the project from scratch, from design and writing of technical specifications to complete commissioning of the project;
* Team management, planning sprints, setting tasks, quality control of execution;
* Implementation of a personal account for users and service centers;
* Implementation of two-factor authentication (TFA);
* Implementation of the search for the nearest service centers using PostGIS;
* Setting up CI/CD.

<hr>

**[Cofoundit](https://cofoundit.ru){:target='_blank'}** (_**Ruby**_) — a online job search service in startups under the initiative of IIDF.

My participation in the project:
* Development of the project from scratch, from design and writing of technical specifications to complete commissioning of the project;
* Sprint planning, task decomposition, work quality control, team management;
* Implementation of the recruitment service;
* Implementation of close integration with other IIDF projects.

<hr>

**[BS Limousine](https://www.bslimousine.com){:target='_blank'}** (_**Ruby**_) — a service for ordering business-class cars in Moscow (analogous to Uber).

My participation in the project:
* Team management, planning sprints, setting tasks, quality control of execution;
* Implementation of service for ordering cars;
* Implementation of payment for orders through Russian Standard Bank;
* Build trip routes via Google Maps API;
* Generation of travel reports in PDF format.

<hr>

### MDK
**Team Lead (Ruby, Rails)**<br>
_August 2015 - February 2016_

Main responsibilities:
* Building a workflow from scratch;
* Selection of tools for the development team;
* Remote management of the development team;
* Planning sprints, setting tasks, quality control of execution;
* Installation and configuration of servers.

The main project is a betting service for their games in Counter-Strike: Global Offensive and Dota.

My participation in the project:
* Development of the project from scratch, from design and writing of technical specifications to complete commissioning of the project;
* Inside the project, I have implemented:
  * Integration with Steam (authentication, acceptance/withdrawal of payments);
  * Development of its own internal currency;
  * Internal API for working with the service;
  * Monitoring of game results;
  * Writing libraries for working with API of third-party services;
  * Writing Telegram bots for the internal needs of the project.

<hr>

### Laboratory of Electronic Textbooks
**Team Lead (Ruby, Rails)**<br>
_July 2014 - August 2015_

**_[Electronic Educational Environment](https://uchebnik.mos.ru){:target='_blank'}_** — it is a unified educational field in which various ideas are placed:
* the student's tablet is synchronized with the interactive whiteboard and can act as a remote control for voting, textbook, interactive tutorial or reference book;
* the teacher's tablet is a tool for creating a lesson, conducting it, filling out information about the educational achievements of students;
* interactive whiteboard - it allows you to display not only educational material, the results of express surveys or the content of students' tablets, but also makes it possible to actively simulate the processes of the surrounding world, characteristic of the subject area;
* electronic diary - with its help students can view homework and class schedules online, and their parents are always aware of the progress of their children;
* Information system "Attendance and Meals" - in schools equipped with this system, students enter the building using an electronic card - a kind of equivalent of a student's business card and a convenient payment instrument.

The project is divided into several sub-projects:<br>

**1/ Learning Management System** - the heart of the "Electronic Educational Environment" project, contains the logic for creating a schedule, working with users, conducting lessons and much more.

My participation in the project:
* Development planning, task decomposition, work quality control;
* Development of logic and API, code coverage with tests (acceptance, unit, views), writing documentation;
* Optimization of API, database queries, authorization and caching systems, tests (over 9000), transferring logic from models to services and background tasks, transferring logic from views to decorators;
* Customize deployment and continuous application integration through TeamCity.

**2/ Content Management System** - a project for managing electronic textbooks and creating user-generated content using an editor.

My participation in the project:
* Development of the project from scratch, design, decomposition of tasks, quality control of work, team management;
* Creation of several microservices, setting up their interaction with each other through the API;
* Development of a library for storing custom materials in XML format and their further compilation into a binary format;
* Writing libraries for working with API of third-party services. Full testing of the project and interaction between microservices;
* Implementation of background processing of materials containing video. Development of a queue manager for compiling materials;
* Customize deployment and continuous application integration through TeamCity.

<hr>

### Voltex Technology
**Team Lead (Ruby, Rails)**<br>
_November 2013 - July 2014_

**_Doka.Box_** is a software and hardware complex that allows for few minutes to organize the work of a small office, including a wireless local area network, Internet access, telephone and software for collective staff work.

My participation in the project:
* Management of the development team (Backend/Frontend): setting tasks, setting deadlines, quality control of work, team training, writing technical documentation;
* In addition to managing the team, I spent most of my time developing the _Doka.Box_ web interface: implementing an API for working with the hardware, finalizing third-party libraries for the needs of the project, fully testing the project using RSpec and Capybara;
* Writing internal libraries for working with hardware, using the AMQP protocol for message transfer.

<hr>

### BlueFox
**Lead backend developer (Ruby, Rails)**<br>
_July 2013 - October 2013_

**_Mercury_** is an internal project for the French company BlueFox.
The main features of the project - CRM, Billing, Stock Management.
The project is based on Active Admin.

My participation in the project:
* Integration of Rails Money, development of additional solutions for working with different currencies, automatic updating of exchange rates through Eu Central Bank;
* Working with background tasks using Sidekiq, monitoring their execution;
* Generation and parsing of Excel files;
* Development of solutions for integrating the project with Amazon S3 and Heroku.

<hr>

### Ivory Interactive
**Backend developer (Ruby, Rails)**<br>
_January 2013 - July 2013_

**_BusStop_** is a project to develop a Digital Signage system for information terminals at public transport stops in Moscow.
The project consists of two parts - the client part (terminals) and the server part (API, management interface for clients, administrator interface).

My participation in the project:
* Creation of a terminal management interface;
* Development of solutions for collecting and displaying statistics, generating a heatmap of clicks on terminals;
* Writing a news feed parser and a PDF report generator.

<hr>

### FeedMan
**Backend developer (Ruby, Rails)**<br>
_October 2012 - January 2013_

**_FeedMan_** - a service of deferred publications on social networks.

My participation in the project:
* Development of a billing system, connection of payment through Robokassa.
* Writing RSS and FeedBurner parsers to automatically collect custom articles and publish them to social networks;
* Setting up automatic deployment and backup of the project.

<hr>

### Cafe Digital
**Backend developer (Ruby, Rails)**<br>
_July 2012 - October 2012_

**_Diet of Inna Volovicheva_** — a project for the dissemination of the diet through SMS subscriptions.
Simultaneously with this project, a platform was developed for working with content providers.
The project includes API, billing system, statistics service, personal account.
Work with subscriptions was carried out through the API of third-party services - Platinot, A1 Sms Market, MosKomSvyaz, 7hlp.

My participation in the project:
* Writing libraries for working with API of third-party services, testing code;
* Development of statistics service (Backend/Frontend) and billing system.

<hr>

### Lebrand Creative Russia
**Web developer (PHP/1С-Bitrix, JavaScript)**<br>
_November 2011 - July 2012_

Project development:
* Internet furniture store **_Stolplit_**;
* Portal about fuel cards **_Topkart_**;
* Several projects for the bank **_2TBank_**;
* Aggregator of CPA networks and advertising platform **_ARBOOST_**.

<hr>

### 4TE
**Web developer (PHP, JavaScript)**<br>
_July 2010 - November 2011_

Development and support of internal projects of the company:
* Merchandising of goods for LG;
* **_Mystery shopping_** system for Rosneft and Gazprom Neft.

<hr>

### Masterhost
**System administrator**<br>
_November 2009 - July 2010_

Installation, configuration, administration and monitoring:
* Servers based on Linux/FreeBSD;
* Mail clusters (Exim, Qmail).<br>

Writing shell scripts to automate workflows.

<hr>

### TransTeleCom
**System administrator**<br>
_September 2008 - October 2009_

Configuration and administration:
* Servers based on OS: Linux/Windows;
* Office local area network;
* Mail servers;
* Sites and hosting.
<br><br>

## Professional skills

### Backend

Good knowledge of Rust, Go, Ruby (Rails, Hanami, Sinatra), Elixir (Phoenix).

There is experience in writing both microservices and full-fledged CLI applications.

As well as development experience on Node.js using Express framework.

### Database

Since 2012, I have been using PostgreSQL as a DBMS, before that I worked with MySQL.

From NoSQL solutions I prefer to use Redis, I have experience with MongoDB and Memcached.

### DevOps

I use Docker and Docker Compose on all projects.

Extensive experience in setting up and deploying from zero Kubernets clusters, both on Google Cloud Platform and on Bare Metal.

I prefer to use GitHub Actions as CI/CD, but I have experience with other services as well.

I also have extensive experience with Unix operating systems: Gentoo, Debian, RHEL, Ubuntu, FreeBSD.
<br><br>

## Open Source activity

**Core contributor**:
* Rust: [dotenv-linter](https://github.com/dotenv-linter/dotenv-linter), [datanymizer](https://github.com/datanymizer/datanymizer);
* Go: [goreleaser](https://github.com/goreleaser/goreleaser), [reviewdog](https://github.com/reviewdog/reviewdog).

My commits can be found in projects like this: <a href="/oss" target="_blank">rails, hanami, micro, intellij-rust, etc</a><sup class="counter">{{ site.counters.oss }}</sup>

### My OSS projects
* [dotenv-linter](https://github.com/dotenv-linter/dotenv-linter) — a linter for `.env` files written in Rust.
  Within this project, I also act as a mentor and help everyone who wants to start contributing to open source projects in Rust;
* [update-informer](https://github.com/mgrachev/update-informer) - a Rust crate for checking updates in CLI applications;
* [brevity](https://github.com/mgrachev/brevity) — a shortening links service in Go with ready-made helm charts for deployment in a Kubernetes cluster;
* [gastly](https://github.com/mgrachev/gastly) — a Ruby library for creating screenshots of sites. Phantom.js and MiniMagick are used under the hood;
* [capistrano-hanami](https://github.com/mgrachev/capistrano-hanami) — a Ruby library for deploying a Hanami project via Capistrano;
* [mina-hanami](https://github.com/mgrachev/mina-hanami) — a Ruby library for deploying a Hanami project via Mina;
* [queue_manager](https://github.com/mgrachev/queue_manager) — a unique task queue manager in Ruby. Under the hood, Redis Sorted Sets. Supports ActiveJob and Global ID;
* [pivotal_tracker_telegram_bot](https://github.com/mgrachev/pivotal_tracker_telegram_bot) — a Telegram bot in Ruby for receiving notifications from Pivotal Tracker. Under the hood is Sinatra and Redis PubSub.

As part of the project [reviewdog](https://github.com/reviewdog/reviewdog), I created several GitHub Actions to run popular linters:
* [action-reek](https://github.com/reviewdog/action-reek)
* [action-rubocop](https://github.com/reviewdog/action-rubocop)
* [action-hadolint](https://github.com/reviewdog/action-hadolint)
* [action-brakeman](https://github.com/reviewdog/action-brakeman)
* [action-dotenv-linter](https://github.com/dotenv-linter/action-dotenv-linter)
<br><br>

## Education

2008 - 2012, Moscow State University N.P. Ogareva, ASOiU
