module API
  class Base < Grape::API
    default_format :json

    get '/' do
      { hello: 'world!' }
    end
  end
end
