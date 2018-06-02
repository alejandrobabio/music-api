require 'albums/create'

module MusicAPI
  class Albums < Grape::API
    resources :albums do
      mount Create
    end
  end
end
