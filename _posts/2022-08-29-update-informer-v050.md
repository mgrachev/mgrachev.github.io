---
layout: post
title: "Update-informer v0.5.0"
date: 2022-08-29 08:00:00
tags: update-informer rust crate library cli github crates pypi registry
summary: "⭐️ Overview of key changes included in the new version"
---

![update-informer]({{ site.url }}/assets/images/2022-08-29-update-informer-v050/update-informer-v050-hf83hjdknfdubw2gh6s.png){: .center-image }

[Update-informer](https://github.com/mgrachev/update-informer){:target='_blank'} is a crate for CLI applications that written in Rust — such as [git-cliff](https://github.com/orhun/git-cliff){:target='_blank'} and [dotenv-linter](https://github.com/dotenv-linter/dotenv-linter){:target='_blank'}.
It checks for a new version on [Crates.io](https://github.com/mgrachev/update-informer#cratesio){:target='_blank'} and [GitHub](https://github.com/mgrachev/update-informer#github){:target='_blank'}.

Also, it has the minimum number of dependencies — only [directories](https://github.com/dirs-dev/directories-rs){:target='_blank'}, [ureq](https://github.com/algesten/ureq){:target='_blank'}, [semver](https://github.com/dtolnay/semver){:target='_blank'} and [serde](https://github.com/serde-rs/serde){:target='_blank'}.

The idea is actually not new.
This feature has long been present in the [GitHub CLI application](https://github.com/cli/cli/blob/trunk/internal/update/update.go){:target='_blank'} and [npm](https://github.com/npm/cli/blob/latest/lib/utils/update-notifier.js){:target='_blank'}.
There is also a popular [JavaScript library](https://github.com/yeoman/update-notifier){:target='_blank'}.

## What is new in v0.5.0?

### PyPi support

Now `update-informer` can check for a new version on [PyPi](https://pypi.org){:target='_blank'}:

```rust
use update_informer::{registry, Check};

let informer = update_informer::new(registry::PyPI, "package_name", "0.1.0");
informer.check_version();
```

### Configurable check frequency and request timeout

By default, the first check will start only after the interval has expired (= 24 hours), but you can change it:

```rust
use std::time::Duration;
use update_informer::{registry, Check};

const EVERY_HOUR: Duration = Duration::from_secs(60 * 60);

let informer = update_informer::new(registry::Crates, "crate_name", "0.1.0").interval(EVERY_HOUR);
informer.check_version(); // The check will start only after an hour
```

It is also possible to change the request timeout (default 5 seconds).

### Disabling caching

To avoid spam requests to the registry API, `update-informer` creates a file in the cache directory.
In order not to cache requests, use a zero interval:

```rust
use std::time::Duration;
use update_informer::{registry, Check};

let informer = update_informer::new(registry::Crates, "crate_name", "0.1.0").interval(Duration::ZERO);
informer.check_version();
```

### Implementing your own registry

You can implement your own registry to check updates. For example:

```rust
use std::time::Duration;
use update_informer::{registry, Check, Package, Registry, Result};

struct YourOwnRegistry;

impl Registry for YourOwnRegistry {
const NAME: &'static str = "your_own_registry";

    fn get_latest_version(pkg: &Package, _timeout: Duration) -> Result<Option<String>> {
        let url = format!("https://your_own_registry.com/{}/latest-version", pkg);
        let result = ureq::get(&url).call()?.into_string()?;
        let version = result.trim().to_string();

        Ok(Some(version))
    }
}

let informer = update_informer::new(YourOwnRegistry, "package_name", "0.1.0");
informer.check_version();
```

---

Please support the project 🙏
* Star on [GitHub](https://github.com/mgrachev/update-informer){:target='_blank'} ⭐️
* Become a sponsor on [OpenCollective](https://opencollective.com/update-informer){:target='_blank'} ❤️
