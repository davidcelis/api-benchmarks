require 'lib/api/benchmark/framework'
require 'lib/api/benchmark/table'

module API
  class Benchmark
    FRAMEWORKS = Dir['*.ru'].map { |ru| Framework.new(ru.match(/(.+)\.ru/)[1]) }
    PATHS = %w[/wiggles /wiggles/1 /wiggles/1/comments]

    def initialize(*frameworks)
      @frameworks = frameworks
    end

    def run!
      puts "Benchmarking #{@frameworks.first.pretty}..." unless @frameworks.size > 1

      PATHS.each do |path|
        puts "\n### `#{path.sub(/\d+/, ':id')}`"

        table = API::Benchmark::Table.new

        @frameworks.each do |framework|
          framework.benchmark!(path: path, report: table)
        end

        puts "\n#{table.sort.to_s.lines[1..-2].join}"
      end
    end
  end
end
