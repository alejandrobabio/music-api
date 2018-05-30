Dir[File.expand_path('../../app/entities', __FILE__) + '/**/*.rb'].sort.each { |f| require f }
Dir[File.expand_path('../../app/services', __FILE__) + '/**/*.rb'].sort.each { |f| require f }

require_relative './bands.rb'

module MusicAPI
  class Base < Grape::API
    default_format :json

    helpers do
      def logger
        Grape::API.logger
      end
    end

    rescue_from ActiveRecord::RecordNotFound do |exception|
      logger.warn exception
      error!('Product not found', 404)
    end

    rescue_from ActiveRecord::RecordInvalid do |exception|
      logger.warn exception
      error!(exception.message, 409)
    end

    mount MusicAPI::Bands
  end
end
