require File.expand_path('../config/environment.rb', __FILE__)
Bundler.setup(:default, :camping)
require 'camping'

Camping.goes :Benchmarks

module Benchmarks
  module Controllers
    class Empty < R '/empty'
      def get
        @headers['Content-Type'] = 'application/json; charset=utf-8'
        ''
      end
    end

    class Numbers < R '/numbers/(\d+)'
      def get(count)
        @headers['Content-Type'] = 'application/json; charset=utf-8'
        (1..count.to_i).to_a.to_json
      end
    end
  end
end

run Benchmarks
