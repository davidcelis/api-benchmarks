# API Benchmarks

This repository provides applications in various Ruby web frameworks for the purposes of easy benchmarking. All benchmarks are currently run using [wrk][wrk], though other benchmarking tools may be used in the future.

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
$ heroku create
```

Then, you can run benchmarks:

```bash
$ HEROKU=true rake benchmark:all

# Or, run benchmarks for one framework
$ HEROKU=true rake benchmark:rails
```

### Benchmarking Information

All applications boot via `rackup` using the [Puma][puma] dispatcher. Each application defines two endpoints:

 * `/empty` (renders an empty response body)
 * `/numbers/:count` (renders an array of `:count` numbers as JSON, defaults to 1000 numbers)

Each endpoint is hit consecutively for 3 minutes using `wrk -t 2 -c 10 -d 3m`.

## Results

Note: _I've ordered results by the average number of requests/sec each framework was able to handle. Response time seems to vary, and I'm unsure of whether the response time reported is actually an average or some other metric._

### `/empty`

| Framework                   | Requests | Response Time | Requests/sec |
|-----------------------------|----------|---------------|--------------|
| [Hobbit][hobbit]            | 391970   | 13.74ms       | 2177.60      |
| [Cuba][cuba]                | 365010   | 12.26ms       | 2027.83      |
| [Camping][camping]          | 346946   | 12.84ms       | 1927.47      |
| [Crepe][crepe]              | 337712   | 10.30ms       | 1876.18      |
| [Sinatra][sinatra]          | 253480   | 9.48ms        | 1408.21      |
| [Grape][grape]              | 237833   | 12.27ms       | 1321.29      |
| [Rails::Metal][rails-metal] | 197913   | 11.37ms       | 1099.50      |
| [Rails::API][rails-api]     | 131132   | 14.49ms       | 728.50       |
| [Rails][rails]              | 124766   | 16.22ms       | 693.14       |

### `/numbers/1000`

| Framework                   | Requests | Response Time | Requests/sec |
|-----------------------------|----------|---------------|--------------|
| [Hobbit][hobbit]            | 282693   | 16.24ms       | 1570.50      |
| [Camping][camping]          | 262113   | 11.02ms       | 1456.18      |
| [Cuba][cuba]                | 258000   | 11.29ms       | 1433.32      |
| [Sinatra][sinatra]          | 204070   | 8.82ms        | 1133.53      |
| [Crepe][crepe]              | 186288   | 20.36ms       | 1034.93      |
| [Grape][grape]              | 174436   | 14.60ms       | 969.07       |
| [Rails::Metal][rails-metal] | 102592   | 18.11ms       | 569.93       |
| [Rails::API][rails-api]     | 58518    | 32.47ms       | 325.09       |
| [Rails][rails]              | 56863    | 33.32ms       | 315.90       |

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
