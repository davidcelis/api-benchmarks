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
| [Crepe][crepe]              | 21816    | 84.02ms       | 121.19       |
| [Rails::Metal][rails-metal] | 20559    | 17.89ms       | 114.18       |
| [Sinatra][sinatra]          | 20128    | 65.29ms       | 111.81       |
| [Camping][camping]          | 19868    | 92.90ms       | 110.36       |
| [Cuba][cuba]                | 17546    | 74.20ms       | 97.47        |
| [NYNY][nyny]                | 17421    | 105.40ms      | 96.76        |
| [Hobbit][hobbit]            | 17346    | 105.85ms      | 96.36        |
| [Grape][grape]              | 16686    | 77.68ms       | 92.70        |
| [Rails::API][rails-api]     | 15014    | 122.02ms      | 83.41        |
| [Rails][rails]              | 14493    | 126.50ms      | 80.50        |

### `/wiggles/:id`

| Framework                   | Requests | Response Time | Requests/sec |
|-----------------------------|----------|---------------|--------------|
| [Hobbit][hobbit]            | 172482   | 13.60ms       | 958.22       |
| [Cuba][cuba]                | 168676   | 8.61ms        | 937.07       |
| [Camping][camping]          | 162839   | 14.40ms       | 904.65       |
| [Crepe][crepe]              | 147020   | 12.14ms       | 816.77       |
| [Sinatra][sinatra]          | 136731   | 15.21ms       | 759.61       |
| [NYNY][nyny]                | 128233   | 15.36ms       | 712.40       |
| [Grape][grape]              | 125908   | 14.11ms       | 699.48       |
| [Rails::Metal][rails-metal] | 111451   | 4.09ms        | 619.08       |
| [Rails::API][rails-api]     | 80768    | 22.65ms       | 448.70       |
| [Rails][rails]              | 70997    | 25.78ms       | 394.42       |

### `/wiggles/:id/comments`

| Framework                   | Requests | Response Time | Requests/sec |
|-----------------------------|----------|---------------|--------------|
| [Crepe][crepe]              | 59356    | 8.20ms        | 329.69       |
| [Hobbit][hobbit]            | 46322    | 39.86ms       | 257.33       |
| [NYNY][nyny]                | 44155    | 10.48ms       | 245.30       |
| [Cuba][cuba]                | 43855    | 37.85ms       | 243.63       |
| [Camping][camping]          | 41497    | 44.54ms       | 230.53       |
| [Grape][grape]              | 41356    | 44.72ms       | 229.75       |
| [Sinatra][sinatra]          | 39211    | 46.91ms       | 217.83       |
| [Rails::Metal][rails-metal] | 36801    | 39.67ms       | 204.43       |
| [Rails::API][rails-api]     | 33272    | 49.21ms       | 184.81       |
| [Rails][rails]              | 29002    | 63.00ms       | 161.12       |

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
