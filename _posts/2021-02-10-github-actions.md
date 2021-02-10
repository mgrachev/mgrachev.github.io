---
layout: post
title: "GitHub Actions to guard your workflow"
date: 2021-02-10 08:00:00
tags: github actions docker reviewdog dotenv-linter rubocop brakeman reek hadolint ruby go rust dockerfile
summary: "Automated code review with GitHub Actions 🐶"
---

Modern development is so complex that it is simply impossible to keep everything in mind, especially various practices for writing code. This is where linters come to the rescue. They help maintain certain standards in the project and keep the code base in order.

I develop projects in a variety of programming languages such as: Rust, Go, Ruby and I connect different linters to each project. To make sure my code meets all quality standards, I run linters using CI services for every commit submitted to GitHub.

![github-actions]({{ site.url }}/assets/images/2021-02-10-github-actions/github-actions-h843askf87f.png){: .center-image }

### Reviewdog

It is very important to me that the result of linters' work is always visible on GitHub, for example, in the form of comments to pull requests. To do this, I use [reviewdog](https://github.com/reviewdog/reviewdog){:target='_blank'}, which automates code review and provides seamless integration of any linter with GitHub. Here’s why reviewdog is so good:

* It is written in Go and can be compiled into a binary file and connected to any project, regardless of the programming language;
* It can work with any linters, you just need to redirect the linter result to the `reviewdog` input and define the linter output format, for example, `$ dotenv-linter | reviewdog -efm="%f:%l %m"`;
* It supports a large number of linters out of the box, such as [dotenv-linter](https://github.com/dotenv-linter/dotenv-linter){:target='_blank'}, [rubocop](https://github.com/rubocop-hq/rubocop){:target='_blank'} and others.

### GitHub Actions

As cool as reviewdog is, I still had to spend time setting up CI services to run linters for each project. But that all changed when GitHub announced [GitHub Actions](https://github.com/features/actions){:target='_blank'}, a new tool for automating workflows. Simply put, this is a full-fledged CI/CD service with great capabilities that allows you to create your own actions and share them with the community.

Having switched to GitHub Actions, I decided to write my own actions to run popular linters. By doing this, I could simplify the process of connecting linters to any project. This is what I ended up with:
* [action-rubocop](https://github.com/reviewdog/action-rubocop){:target='_blank'}
* [action-brakeman](https://github.com/reviewdog/action-brakeman){:target='_blank'}
* [action-reek](https://github.com/reviewdog/action-reek){:target='_blank'}
* [action-hadolint](https://github.com/reviewdog/action-hadolint){:target='_blank'}
* [action-dotenv-linter](https://github.com/dotenv-linter/action-dotenv-linter){:target='_blank'}

All of my actions can publish linter comments in two modes.

* As an annotation in the code (`github-pr-check`):

![example-github-pr-check]({{ site.url }}/assets/images/2021-02-10-github-actions/example-github-pr-check-83gsjdoj2.png){: .center-image }

* And in the form of comments to pull requests (`github-pr-review`):

![example-github-pr-review]({{ site.url }}/assets/images/2021-02-10-github-actions/example-github-pr-review-cm72hdkis7.png){: .center-image }

### Ruby Actions

The first 3 actions ([action-rubocop](https://github.com/reviewdog/action-rubocop){:target='_blank'}, [action-brakeman](https://github.com/reviewdog/action-brakeman){:target='_blank'} and [action-reek](https://github.com/reviewdog/action-reek){:target='_blank'}) allow you to run popular linters from the Ruby community: [rubocop](https://github.com/rubocop-hq/rubocop){:target='_blank'}, [brakeman](https://github.com/presidentbeef/brakeman){:target='_blank'} and [reek](https://github.com/troessner/reek){:target='_blank'}. To connect these actions to your project, you just need to create a `.github/workflows/linters.yml` file with the following content:

```yaml
# .github/workflows/linters.yml
name: linters
on: [pull_request]
jobs:
  linters:
    name: runner / linters
    runs-on: ubuntu-latest
    steps:
      - name: Check out code
        uses: actions/checkout@v1
      - name: rubocop
        uses: reviewdog/action-rubocop@v1
        with:
          rubocop_version: gemfile
          rubocop_extensions: rubocop-rails:gemfile rubocop-rspec:gemfile
      - name: brakeman
        uses: reviewdog/action-brakeman@v1
        with:
          brakeman_version: gemfile
      - name: reek
        uses: reviewdog/action-reek@v1
        with:
          reek_version: gemfile
```

For all these action it is possible to specify the linter version. There are 3 options available:

1. An empty value or no version - the latest version will be installed;
2. `gemfile` - the version from `Gemfile.lock` will be installed;
3. `1.0.0` - the specified version will be installed.

Action-rubocop also provides the ability to install additional extensions. The following extensions are installed by default: `rubocop-rails`, `rubocop-performance`, `rubocop-rspec`, `rubocop-i18n`, `rubocop-rake`. But this can be overridden using the `rubocop_extensions` attribute.

### Dockerfile Action

The next action, [action-hadolint](https://github.com/reviewdog/action-hadolint){:target='_blank'}, looks for all `Dockerfile` in the project and checks them using the [hadolint](https://github.com/hadolint/hadolint){:target='_blank'} linter. Usage example:

```yaml
# .github/workflows/hadolint.yml
name: hadolint
on: [pull_request]
jobs:
  hadolint:
    name: runner / hadolint
    runs-on: ubuntu-latest
    steps:
      - name: Check out code
        uses: actions/checkout@v1
      - name: hadolint
        uses: reviewdog/action-hadolint@v1
        with:
          hadolint_ignore: DL3008
```

### Dotenv-linter Action

And last but not least, is [action-dotenv-linter](https://github.com/dotenv-linter/action-dotenv-linter){:target='_blank'}. It allows you to easily and simply check all `.env` files on the project. Usage example:

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
        uses: dotenv-linter/action-dotenv-linter@v2
        with:
          dotenv_linter_flags: --skip UnorderedKey
```

Find more GitHub Actions on the [GitHub Marketplace](https://github.com/marketplace?type=actions&query=reviewdog){:target='_blank'} page.

GitHub Actions is a cool workflow automation tool that allows you to completely replace all existing CI/CD services on a project. I wrote several GitHub Actions to launch popular linters, which allowed me to significantly simplify the process of connecting and configuring linters on each project.
