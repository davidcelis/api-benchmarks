# API Benchmarks

This repository provides applications in various Ruby web frameworks for the purposes of easy benchmarking. All benchmarks are currently run using [wrk][wrk], though more benchmarking tools may be used in the future.

## Setup

Here's the software used to run these benchmarks:

* [Ruby 2.1.1][ruby] (with bundler: `gem install bundler`)
* [PostgreSQL][postgresql]
* [wrk][wrk]

If one of these isn't installed:

```bash
# Ruby
$ brew install chruby ruby-install
$ ruby-install ruby 2.1.1
$ chruby ruby-2.1

# PostgreSQL
$ brew install postgresql

# wrk
$ brew install wrk
```

## Running benchmarks

First, set up the benchmarking database:

```bash
$ bundle install
$ bundle exec rake db:setup
```

Then, you can run benchmarks:

```bash
$ rake benchmark:all

# Or, run benchmarks for one framework
$ rake benchmark:rails
```

### Benchmarking Information

All applications boot via `rackup` using the [Puma][puma] dispatcher. Each application defines three endpoints:

 * `/posts` (renders 100 posts as JSON)
 * `/posts/:id` (renders a single post as JSON)
 * `/posts/:id/comments` (renders 25 comments on a single post as JSON)

Each endpoint is hit consecutively for 10 seconds using `wrk -t 2 -c 10 -d 10S`.

## Results

Note: _I've ordered results by what I believe is the more important metric: Requests/sec_

### `/wiggles`

| Framework                   | Requests | Response Time | Requests/sec |
|-----------------------------|----------|---------------|--------------|
| [Sinatra][sinatra]          | 1102     | 91.08ms       | 110.18       |
| [Rails::API][rails-api]     | 992      | 99.65ms       | 99.17        |
| [Rails][rails]              | 930      | 105.19ms      | 92.97        |
| [Grape][grape]              | 886      | 112.66ms      | 88.57        |
| [Rails::Metal][rails-metal] | 857      | 116.56ms      | 85.69        |

### `/wiggles/:id`

| Framework                   | Requests | Response Time | Requests/sec |
|-----------------------------|----------|---------------|--------------|
| [Sinatra][sinatra]          | 7915     | 12.25ms       | 791.46       |
| [Grape][grape]              | 7094     | 14.18ms       | 709.27       |
| [Rails::Metal][rails-metal] | 6304     | 15.87ms       | 630.29       |
| [Rails::API][rails-api]     | 4727     | 21.01ms       | 472.64       |
| [Rails][rails]              | 3940     | 2.74ms        | 393.88       |

### `/wiggles/:id/comments`

| Framework                   | Requests | Response Time | Requests/sec |
|-----------------------------|----------|---------------|--------------|
| [Sinatra][sinatra]          | 2511     | 40.11ms       | 250.85       |
| [Grape][grape]              | 2445     | 40.25ms       | 244.43       |
| [Rails::Metal][rails-metal] | 2172     | 46.04ms       | 217.17       |
| [Rails::API][rails-api]     | 1948     | 51.03ms       | 194.78       |
| [Rails][rails]              | 1861     | 10.83ms       | 186.06       |

### System Information

These benchmarks are run on a 15" Retina MacBook Pro with the following specifications:

 * CPU: 2.3 GHz Intel Core i7
 * RAM: 16 GB 1600 MHz DDR3
 * GPU: Intel HD Graphics 4000 1024 MB
 * OS: Mac OS X 10.9.2

[rails]: https://github.com/rails/rails
[postgresql]: http://www.postgresql.org
[puma]: https://github.com/puma/puma
[ruby]: https://github.com/ruby/ruby
[wrk]: https://github.com/wg/wrk
