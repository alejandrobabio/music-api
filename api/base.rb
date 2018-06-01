Dir[File.join(File.dirname(__FILE__), '../app/entities/**/*.rb')].sort.each { |f| require f }
Dir[File.join(File.dirname(__FILE__), '../app/services/**/*.rb')].sort.each { |f| require f }

require 'bands.rb'

module MusicAPI
  class Base < Grape::API
    default_format :json

    helpers do
      def logger
        Logger.new "log/#{ENV['RACK_ENV']}.log"
      end
    end

    rescue_from ActiveRecord::RecordNotFound do |exception|
      logger.warn exception
      error!('Product not found', 404)
    end

    rescue_from ActiveRecord::RecordInvalid do |exception|
      logger.warn exception
      error!(exception.message, 422)
    end

    mount MusicAPI::Bands

    add_swagger_documentation mount_path: '/api/swagger_doc'
  end
end
