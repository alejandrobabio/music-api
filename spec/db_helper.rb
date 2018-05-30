require 'spec_helper'

require 'database_cleaner'
require 'factory_bot'

Dir[File.expand_path('../../app/models', __FILE__) + '/**/*.rb'].sort.each { |f| require f }
Dir[File.expand_path('./factories', __FILE__) + '/**/*.rb'].each { |f| require f }


RSpec.configure do |config|
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
