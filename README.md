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

Each endpoint is hit consecutively for 10 minutes using `wrk -t 2 -c 10 -d 10m`.

## Results

Note: _I've ordered results by the average number of requests/sec each framework was able to handle. Response time seems to vary, and I'm unsure of whether the response time reported is actually an average or some other metric._

### `/wiggles`

| Framework                   | Requests | Response Time | Requests/sec |
|-----------------------------|----------|---------------|--------------|
| [Crepe][crepe]              | 12845    | 138.05ms      | 71.35        |
| [Rails::Metal][rails-metal] | 12365    | 149.31ms      | 68.68        |
| [Cuba][cuba]                | 12308    | 149.14ms      | 68.37        |
| [Sinatra][sinatra]          | 12258    | 153.87ms      | 68.08        |
| [Camping][camping]          | 11343    | 162.89ms      | 63.01        |
| [Rails::API][rails-api]     | 11195    | 163.06ms      | 62.18        |
| [Rails][rails]              | 11075    | 162.34ms      | 61.52        |
| [Hobbit][hobbit]            | 10047    | 192.06ms      | 55.80        |
| [NYNY][nyny]                | 8780     | 96.03ms       | 48.77        |
| [Grape][grape]              | 6297     | 325.15ms      | 34.97        |

### `/wiggles/:id`

| Framework                   | Requests | Response Time | Requests/sec |
|-----------------------------|----------|---------------|--------------|
| [Sinatra][sinatra]          | 15305    | 117.90ms      | 85.03        |
| [Camping][camping]          | 15136    | 121.07ms      | 84.08        |
| [Hobbit][hobbit]            | 15039    | 121.25ms      | 83.54        |
| [Crepe][crepe]              | 14861    | 120.93ms      | 82.54        |
| [Grape][grape]              | 14575    | 124.94ms      | 80.97        |
| [Cuba][cuba]                | 14393    | 123.45ms      | 79.95        |
| [Rails::API][rails-api]     | 14379    | 124.76ms      | 79.88        |
| [Rails::Metal][rails-metal] | 14296    | 125.13ms      | 79.39        |
| [Rails][rails]              | 13654    | 135.26ms      | 75.84        |
| [NYNY][nyny]                | 10086    | 123.56ms      | 56.03        |

### `/wiggles/:id/comments`

| Framework                   | Requests | Response Time | Requests/sec |
|-----------------------------|----------|---------------|--------------|
| [Camping][camping]          | 13828    | 131.78ms      | 76.81        |
| [Hobbit][hobbit]            | 13543    | 132.41ms      | 75.23        |
| [Grape][grape]              | 13455    | 133.76ms      | 74.74        |
| [Crepe][crepe]              | 13431    | 132.55ms      | 74.61        |
| [Rails::Metal][rails-metal] | 13018    | 139.38ms      | 72.31        |
| [Rails][rails]              | 12794    | 138.68ms      | 71.08        |
| [Cuba][cuba]                | 11698    | 170.63ms      | 64.98        |
| [Sinatra][sinatra]          | 11494    | 165.45ms      | 63.85        |
| [NYNY][nyny]                | 11208    | 119.96ms      | 62.25        |
| [Rails::API][rails-api]     | 7659     | 253.80ms      | 42.54        |

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
