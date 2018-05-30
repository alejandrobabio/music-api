$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'api'))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'app'))

require 'boot'

require 'erb'

db_config = YAML.load(ERB.new(File.read("config/database.yml")).result)[ENV['RACK_ENV']]
ActiveRecord::Base.default_timezone = :utc
ActiveRecord::Base.establish_connection(db_config)

Dir[File.expand_path('../../app/models', __FILE__) + '/**/*.rb'].sort.each { |f| require f }
require 'base'
