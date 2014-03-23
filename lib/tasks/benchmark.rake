require 'lib/api/benchmark'

namespace :benchmark do
  API::Benchmark::FRAMEWORKS.each do |framework|
    task framework => [:environment] do
      API::Benchmark.new(framework).run!
    end
  end

  task :all do
    puts 'Benchmarking all frameworks...'

    API::Benchmark.new(*API::Benchmark::FRAMEWORKS).run!
  end
end
