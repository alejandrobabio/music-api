ENV['RACK_ENV'] = 'test'
require File.expand_path('../../config/environment', __FILE__)

require 'database_cleaner'
require 'factory_bot'
require 'shoulda-matchers'

Dir[File.expand_path('../support', __FILE__) + '/**/*.rb'].each { |f| require f }

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.library :active_record
    with.test_framework :rspec
  end
end

RSpec.configure do |config|
  config.include(Shoulda::Matchers::ActiveModel, type: :model)
  config.include(Shoulda::Matchers::ActiveRecord, type: :model)

  config.include(FactoryBot::Syntax::Methods)

  config.before(:suite) do
    FactoryBot.find_definitions
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
  end

  config.around(:each) do |example|
    DatabaseCleaner.cleaning do
      example.run
    end
  end
end
