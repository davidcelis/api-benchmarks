FRAMEWORKS = Dir['*.ru'].map { |ru| ru.match(/(.+)\.ru/)[1] }

WIGGLES_TABLE  = Terminal::Table.new({
  headings: ['Framework', 'URL', 'Requests', 'Response Time', 'Requests/sec'],
  style: { border_i: '|' }
})
WIGGLE_TABLE   = Terminal::Table.new({
  headings: ['Framework', 'URL', 'Requests', 'Response Time', 'Requests/sec'],
  style: { border_i: '|' }
})
COMMENTS_TABLE = Terminal::Table.new({
  headings: ['Framework', 'URL', 'Requests', 'Response Time', 'Requests/sec'],
  style: { border_i: '|' }
})

print_table = true

namespace :benchmark do
  FRAMEWORKS.each do |framework|
    task framework => [:environment] do
      rackup = "bundle exec rackup #{framework}.ru"
      pid    = Process.spawn(rackup, out: '/dev/null', err: '/dev/null')

      pretty_framework = framework.gsub('-', '/').camelize
      puts "Benchmarking #{pretty_framework}..." if print_table

      until system('curl -sS "0.0.0.0:9292" &>/dev/null')
        # Allow the server to start up.
      end

      begin
        ['/wiggles', '/wiggles/1', '/wiggles/1/comments'].each do |path|
          results = `wrk -t 2 -c 10 -d 10s -H "Accept: application/json" "http://0.0.0.0:9292#{path}"`

          url        = path.sub(/\d+/, ':id')
          requests   = results.match(/(\d+) requests in/)[1]
          avg_ms     = results.match(/Latency\s+([\d.]+)ms/)[1]
          per_second = results.match(/Requests\/sec:\s+([\d.]+)/)[1]

          table = case path
          when '/wiggles'            then WIGGLES_TABLE
          when '/wiggles/1'          then WIGGLE_TABLE
          when '/wiggles/1/comments' then COMMENTS_TABLE
                  end

          table << [
            "[#{pretty_framework}][#{framework}]",
            url,
            { value: requests,      alignment: :right },
            { value: "#{avg_ms}ms", alignment: :right },
            { value: per_second,    alignment: :right }
          ]
        end

        if print_table
          puts "\n#{WIGGLES_TABLE.to_s.lines[1..-2].join}"
          puts "\n#{WIGGLE_TABLE.to_s.lines[1..-2].join}"
          puts "\n#{COMMENTS_TABLE.to_s.lines[1..-2].join}"
        end
      ensure
        Process.kill('SIGINT', pid)
      end
    end
  end

  task :all do
    print_table = false
    puts 'Benchmarking all frameworks...'

    FRAMEWORKS.each { |framework| Rake::Task["benchmark:#{framework}"].invoke }

    puts "\n#{WIGGLES_TABLE.to_s.lines[1..-2].join}"
    puts "\n#{WIGGLE_TABLE.to_s.lines[1..-2].join}"
    puts "\n#{COMMENTS_TABLE.to_s.lines[1..-2].join}"
  end
end
