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
| [Crepe][crepe]              | 1339     | 69.56ms       | 133.86       |
| [Grape][grape]              | 1152     | 85.36ms       | 115.17       |
| [Sinatra][sinatra]          | 1150     | 62.16ms       | 114.98       |
| [Rails::Metal][rails-metal] | 1105     | 90.26ms       | 110.46       |
| [Rails::API][rails-api]     | 996      | 97.25ms       | 99.57        |
| [Rails][rails]              | 951      | 103.53ms      | 95.08        |

### `/wiggles/:id`

| Framework                   | Requests | Response Time | Requests/sec |
|-----------------------------|----------|---------------|--------------|
| [Crepe][crepe]              | 8254     | 12.49ms       | 825.28       |
| [Sinatra][sinatra]          | 7859     | 13.52ms       | 785.82       |
| [Grape][grape]              | 6999     | 14.53ms       | 699.87       |
| [Rails::Metal][rails-metal] | 6202     | 16.05ms       | 620.16       |
| [Rails::API][rails-api]     | 4770     | 10.63ms       | 476.95       |
| [Rails][rails]              | 4033     | 24.58ms       | 403.25       |

### `/wiggles/:id/comments`

| Framework                   | Requests | Response Time | Requests/sec |
|-----------------------------|----------|---------------|--------------|
| [Crepe][crepe]              | 3243     | 30.52ms       | 324.21       |
| [Sinatra][sinatra]          | 2550     | 38.75ms       | 254.95       |
| [Grape][grape]              | 2443     | 37.63ms       | 244.25       |
| [Rails::Metal][rails-metal] | 2020     | 5.14ms        | 201.92       |
| [Rails::API][rails-api]     | 1959     | 10.42ms       | 195.82       |
| [Rails][rails]              | 1803     | 54.62ms       | 180.24       |

### System Information

These benchmarks are run on a 15" Retina MacBook Pro with the following specifications:

 * CPU: 2.3 GHz Intel Core i7
 * RAM: 16 GB 1600 MHz DDR3
 * GPU: Intel HD Graphics 4000 1024 MB
 * OS: Mac OS X 10.9.2

[crepe]: https://github.com/crepe/crepe
[grape]: https://github.com/intridea/grape
[rails]: https://github.com/rails/rails
[rails-api]: https://github.com/rails-api/rails-api
[rails-metal]: http://api.rubyonrails.org/classes/ActionController/Metal.html
[sinatra]: https://github.com/sinatra/sinatra/
[postgresql]: http://www.postgresql.org
[puma]: https://github.com/puma/puma
[ruby]: https://github.com/ruby/ruby
[wrk]: https://github.com/wg/wrk
