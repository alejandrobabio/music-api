require 'rubygems'
require 'bundler/setup'
require 'erb'

Bundler.require :default, ENV['RACK_ENV']

require_relative '../api/base'

db_config = YAML.load(ERB.new(File.read("config/database.yml")).result)[ENV['RACK_ENV']]
ActiveRecord::Base.default_timezone = :utc
ActiveRecord::Base.establish_connection(db_config)
