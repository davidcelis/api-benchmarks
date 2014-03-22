require 'erb'

task :environment do
  spec = YAML.load(ERB.new(File.read('config/database.yml')).result)
  ActiveRecord::Base.establish_connection(spec[ENV['RACK_ENV']])
end


namespace :db do
  task :connect do
    spec = YAML.load(ERB.new(File.read('config/database.yml')).result)
    ActiveRecord::Base.establish_connection(spec['postgres'])
  end

  desc 'Create the benchmarking database'
  task create: [:connect] do
    puts '-- create_database(:api_benchmarks)'
    start = Time.now
    ActiveRecord::Base.connection.create_database('api_benchmarks')
    puts "   -> #{(Time.now - start).round(4)}s"
  end

  desc 'Drop the benchmarking database'
  task drop: [:connect] do
    puts '-- drop_database(:api_benchmarks)'
    start = Time.now
    ActiveRecord::Base.connection.drop_database('api_benchmarks')
    puts "   -> #{(Time.now - start).round(4)}s"
  end

  desc 'Migrate the benchmarking database'
  task migrate: [:environment] do
    ActiveRecord::Schema.define do
      create_table :wiggles, force: true do |t|
        t.string :name
      end

      create_table :comments, force: true do |t|
        t.references :wiggle
        t.string     :body
      end
    end
  end

  desc 'Seed the benchmarking database with Wiggles'
  task seed: [:environment] do
    require 'app/models/wiggle'
    adjectives = File.read('lib/adjectives.txt').split("\n")

    puts '-- seed_database(:api_benchmarks)'
    start = Time.now

    100.times do
      wiggle = Wiggle.create(name: "#{adjectives.sample} #{adjectives.sample} wiggle")

      25.times { wiggle.comments.create(body: "This wiggle is #{adjectives.sample}") }
    end

    puts "   -> #{(Time.now - start).round(4)}s"
  end

  desc 'Create, migrate, and seed the benchmarking database'
  task setup: ['db:create', 'db:migrate', 'db:seed']

  desc 'Drop the database, then recreate and re-seed it'
  task reset: ['db:drop', 'db:setup']
end
