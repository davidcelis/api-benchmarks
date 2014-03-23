require 'active_support/core_ext/string/inflections'

module API
  class Benchmark
    class Framework
      def initialize(name)
        @name = name
      end

      def benchmark!(options = {})
        raise ArgumentError unless options[:path] && options[:report]

        begin
          rackup!

          results = wrk!(options[:path])

          options[:report].add_row(self, results)
        ensure
          Process.kill('SIGINT', @pid)
          @pid = nil
        end
      end

      def pretty
        @name.gsub('-', '/').camelize
      end

      def to_s
        @name
      end

      private

      def rackup!
        @pid = Process.spawn("bundle exec rackup #{@name}.ru", {
          out: '/dev/null',
          err: '/dev/null'
        })

        # Allow the server to start up.
        sleep 1 until system('curl -sS "0.0.0.0:9292" &>/dev/null')
      end

      def wrk!(path)
        `wrk -t 2 -c 10 -d 10s -H "Accept: application/json" "http://0.0.0.0:9292#{path}"`
      end
    end
  end
end
