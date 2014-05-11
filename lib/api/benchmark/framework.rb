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
          Process.kill('KILL', @pid) unless heroku?
        end
      end

      def pretty
        @name.gsub('-', '/').camelize
      end

      def to_s
        @name
      end

      def heroku?
        !!ENV['HEROKU']
      end

      private

      def rackup!
        if heroku?
          `heroku config:set HEROKU_RACKUP_FILE="#{@name}.ru"`
        else
          @pid = Process.spawn("bundle exec rackup #{@name}.ru", {
            out: '/dev/null',
            err: '/dev/null'
          })
        end

        # Allow the server to start up.
        sleep 1 until system("curl -sS '#{url}' &>/dev/null")
      end

      def wrk!(path)
        `wrk -t 2 -c 10 -d 3m -H "Accept: application/json" "#{url}#{path}"`
      end

      def url
        if heroku?
          heroku_info = `heroku apps:info --shell`
          heroku_info.match(/^web_url=(.+)\/$/)[1]
        else
          "http://0.0.0.0:9292"
        end
      end
    end
  end
end
