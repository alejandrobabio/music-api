require 'rubygems'
require 'bundler'

begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts 'Run `bundle install` to install missing gems'
  exit e.status_code
end

task :environment do
  ENV['RACK_ENV'] ||= 'development'
  require File.expand_path('../config/environment', __FILE__)
end

desc "API Routes"
task routes: :environment do
  MusicAPI::Base.routes.each do |api|
    method = api.request_method.ljust(10)
    path   = api.path
    puts "     #{method} #{path}"
  end
end

unless  ENV['RACK_ENV'] == 'production'
  require 'rspec/core'
  require 'rspec/core/rake_task'

  RSpec::Core::RakeTask.new(:spec)
end

#Load tasks
Dir.glob('lib/tasks/*.rake').each { |task| load task }
