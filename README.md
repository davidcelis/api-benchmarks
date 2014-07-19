# API Benchmarks

This repository provides applications in various Ruby web frameworks for the purposes of easy benchmarking. All benchmarks are currently run using [wrk][wrk], though more benchmarking tools may be used in the future. Each web framework implements a sample application that I like to call "Wiggles".

## Setup

Here's the software used to run these benchmarks:

* [Ruby 2.1.2][ruby] (with bundler: `gem install bundler`)
* [PostgreSQL][postgresql]
* [wrk][wrk]

If one of these isn't installed:

```bash
# Ruby
$ brew install chruby ruby-install
$ ruby-install ruby 2.1.2
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

To run benchmarks on Heroku (recommended, so that the web servers are not competing with the load generation tool for resources), first set up Heroku:

```bash
$ brew install heroku
$ bundle exec rake heroku:setup
$ heroku run rake db:migrate db:seed
```

Then, you can run benchmarks:

```bash
$ HEROKU=true rake benchmark:all

# Or, run benchmarks for one framework
$ HEROKU=true rake benchmark:rails
```

### Benchmarking Information

All applications boot via `rackup` using the [Puma][puma] dispatcher. Each application defines three endpoints:

 * `/wiggles` (renders 100 wiggles as JSON)
 * `/wiggles/:id` (renders a single wiggle as JSON)
 * `/wiggles/:id/comments` (renders 25 comments on a single wiggle as JSON)

Each endpoint is hit consecutively for 3 minutes using `wrk -t 2 -c 10 -d 3m`.

## Results

Note: _I've ordered results by the average number of requests/sec each framework was able to handle. Response time seems to vary, and I'm unsure of whether the response time reported is actually an average or some other metric._

### `/wiggles`

| Framework                   | Requests | Response Time | Requests/sec |
|-----------------------------|----------|---------------|--------------|
| [Crepe][crepe]              | 40000    | 46.27ms       | 222.21       |
| [Hobbit][hobbit]            | 33847    | 54.59ms       | 188.03       |
| [Camping][camping]          | 33535    | 39.06ms       | 186.30       |
| [Cuba][cuba]                | 33352    | 44.18ms       | 185.28       |
| [Sinatra][sinatra]          | 32014    | 56.99ms       | 177.83       |
| [Grape][grape]              | 31368    | 41.52ms       | 174.25       |
| [Rails::Metal][rails-metal] | 28569    | 63.22ms       | 158.71       |
| [Rails::API][rails-api]     | 26190    | 69.10ms       | 145.50       |
| [Rails][rails]              | 24791    | 72.85ms       | 137.72       |

### `/wiggles/:id`

| Framework                   | Requests | Response Time | Requests/sec |
|-----------------------------|----------|---------------|--------------|
| [Hobbit][hobbit]            | 185011   | 12.60ms       | 1027.83      |
| [Camping][camping]          | 170794   | 12.98ms       | 948.85       |
| [Cuba][cuba]                | 168209   | 13.20ms       | 934.49       |
| [Crepe][crepe]              | 153986   | 14.26ms       | 855.46       |
| [Sinatra][sinatra]          | 146987   | 14.38ms       | 816.59       |
| [Grape][grape]              | 124995   | 15.79ms       | 694.41       |
| [Rails::Metal][rails-metal] | 119957   | 4.59ms        | 666.29       |
| [Rails::API][rails-api]     | 88076    | 20.83ms       | 489.31       |
| [Rails][rails]              | 75076    | 24.04ms       | 417.07       |

### `/wiggles/:id/comments`

| Framework                   | Requests | Response Time | Requests/sec |
|-----------------------------|----------|---------------|--------------|
| [Hobbit][hobbit]            | 59352    | 30.73ms       | 329.73       |
| [Camping][camping]          | 58510    | 25.38ms       | 325.05       |
| [Cuba][cuba]                | 57968    | 28.49ms       | 322.03       |
| [Crepe][crepe]              | 54267    | 4.79ms        | 301.37       |
| [Sinatra][sinatra]          | 53252    | 30.93ms       | 295.83       |
| [Grape][grape]              | 52289    | 35.21ms       | 290.48       |
| [Rails::Metal][rails-metal] | 46612    | 38.74ms       | 258.94       |
| [Rails::API][rails-api]     | 42185    | 42.85ms       | 234.34       |
| [Rails][rails]              | 36886    | 48.73ms       | 204.91       |

### System Information

Load is generated on a 15" Retina MacBook Pro with the following specifications:

 * CPU: 2.3 GHz Intel Core i7
 * RAM: 16 GB 1600 MHz DDR3
 * GPU: Intel HD Graphics 4000 1024 MB
 * OS: Mac OS X 10.9.2

All web applications were run on Heroku, using a single free dyno.

[camping]: https://github.com/camping/camping
[cuba]: https://github.com/soveran/cuba
[crepe]: https://github.com/crepe/crepe
[grape]: https://github.com/intridea/grape
[hobbit]: https://github.com/patriciomacadden/hobbit
[nyny]: https://github.com/alisnic/nyny
[rails]: https://github.com/rails/rails
[rails-api]: https://github.com/rails-api/rails-api
[rails-metal]: http://api.rubyonrails.org/classes/ActionController/Metal.html
[sinatra]: https://github.com/sinatra/sinatra/
[postgresql]: http://www.postgresql.org
[puma]: https://github.com/puma/puma
[ruby]: https://github.com/ruby/ruby
[wrk]: https://github.com/wg/wrk
