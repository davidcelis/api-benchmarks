# API Benchmarks

This repository provides applications in various Ruby web frameworks for the purposes of easy benchmarking. All benchmarks are currently run using [wrk][wrk], though more benchmarking tools may be used in the future. Each web framework implements a sample application that I like to call "Wiggles".

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

 * `/wiggles` (renders 100 wiggles as JSON)
 * `/wiggles/:id` (renders a single wiggle as JSON)
 * `/wiggles/:id/comments` (renders 25 comments on a single wiggle as JSON)

Each endpoint is hit consecutively for 10 minutes using `wrk -t 2 -c 10 -d 10m`.

## Results

Note: _I've ordered results by the average number of requests/sec each framework was able to handle. Response time seems to vary, and I'm unsure of whether the response time reported is actually an average or some other metric._

### `/wiggles`

| Framework                   | Requests | Response Time | Requests/sec |
|-----------------------------|----------|---------------|--------------|
| [Crepe][crepe]              | 71314    | 84.94ms       | 118.85       |
| [Sinatra][sinatra]          | 66989    | 36.54ms       | 111.64       |
| [Camping][camping]          | 58280    | 105.42ms      | 97.13        |
| [Cuba][cuba]                | 55599    | 65.58ms       | 92.66        |
| [Grape][grape]              | 54185    | 89.22ms       | 90.30        |
| [Rails::Metal][rails-metal] | 49648    | 121.40ms      | 82.74        |
| [Rails][rails]              | 46793    | 130.72ms      | 77.99        |
| [Rails::API][rails-api]     | 45188    | 93.13ms       | 75.31        |

### `/wiggles/:id`

| Framework                   | Requests | Response Time | Requests/sec |
|-----------------------------|----------|---------------|--------------|
| [Camping][camping]          | 542121   | 16.30ms       | 903.52       |
| [Cuba][cuba]                | 531888   | 12.15ms       | 886.48       |
| [Crepe][crepe]              | 480618   | 2.22ms        | 800.88       |
| [Sinatra][sinatra]          | 467033   | 13.29ms       | 778.39       |
| [Grape][grape]              | 429378   | 14.23ms       | 715.63       |
| [Rails::Metal][rails-metal] | 354732   | 1.72ms        | 591.15       |
| [Rails::API][rails-api]     | 273402   | 21.99ms       | 455.67       |
| [Rails][rails]              | 240836   | 24.97ms       | 401.39       |

### `/wiggles/:id/comments`

| Framework                   | Requests | Response Time | Requests/sec |
|-----------------------------|----------|---------------|--------------|
| [Crepe][crepe]              | 169281   | 4.21ms        | 282.04       |
| [Camping][camping]          | 145763   | 41.77ms       | 242.93       |
| [Cuba][cuba]                | 138622   | 44.07ms       | 231.03       |
| [Grape][grape]              | 138591   | 43.73ms       | 230.98       |
| [Sinatra][sinatra]          | 138042   | 43.97ms       | 230.07       |
| [Rails::Metal][rails-metal] | 125403   | 48.18ms       | 209.00       |
| [Rails::API][rails-api]     | 118786   | 15.24ms       | 197.98       |
| [Rails][rails]              | 100009   | 6.04ms        | 166.62       |

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
