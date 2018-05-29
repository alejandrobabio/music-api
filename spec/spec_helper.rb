ENV['RACK_ENV'] = 'test'
require File.expand_path('../../config/environment', __FILE__)

RSpec.configure do |config|
  config.include(Rack::Test::Methods, type: :request)
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
