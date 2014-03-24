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
| [Crepe][crepe]              | 1672     | 6.88ms        | 167.12       |
| [Sinatra][sinatra]          | 1191     | 75.62ms       | 119.08       |
| [Grape][grape]              | 1172     | 82.93ms       | 117.17       |
| [Camping][camping]          | 1165     | 18.90ms       | 116.48       |
| [Rails::Metal][rails-metal] | 1127     | 17.84ms       | 112.67       |
| [Rails::API][rails-api]     | 1011     | 97.00ms       | 101.06       |
| [Rails][rails]              | 978      | 100.81ms      | 97.75        |

### `/wiggles/:id`

| Framework                   | Requests | Response Time | Requests/sec |
|-----------------------------|----------|---------------|--------------|
| [Camping][camping]          | 8383     | 13.52ms       | 838.22       |
| [Sinatra][sinatra]          | 7395     | 2.84ms        | 739.34       |
| [Crepe][crepe]              | 7279     | 2.94ms        | 727.76       |
| [Grape][grape]              | 7045     | 14.21ms       | 704.47       |
| [Rails::Metal][rails-metal] | 6056     | 16.49ms       | 605.56       |
| [Rails::API][rails-api]     | 4522     | 21.99ms       | 452.18       |
| [Rails][rails]              | 3265     | 34.10ms       | 326.46       |

### `/wiggles/:id/comments`

| Framework                   | Requests | Response Time | Requests/sec |
|-----------------------------|----------|---------------|--------------|
| [Crepe][crepe]              | 3013     | 33.02ms       | 301.27       |
| [Camping][camping]          | 2623     | 37.22ms       | 262.28       |
| [Grape][grape]              | 2330     | 42.85ms       | 232.93       |
| [Rails::Metal][rails-metal] | 2183     | 45.56ms       | 218.28       |
| [Sinatra][sinatra]          | 1989     | 31.40ms       | 198.84       |
| [Rails::API][rails-api]     | 1724     | 5.96ms        | 172.38       |
| [Rails][rails]              | 1682     | 59.66ms       | 168.19       |

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
