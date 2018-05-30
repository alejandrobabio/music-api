require File.expand_path('../boot', __FILE__)

require 'erb'

db_config = YAML.load(ERB.new(File.read("config/database.yml")).result)[ENV['RACK_ENV']]
ActiveRecord::Base.default_timezone = :utc
ActiveRecord::Base.establish_connection(db_config)

Dir[File.expand_path('../../app/models', __FILE__) + '/**/*.rb'].sort.each { |f| require f }
require_relative '../api/base'
