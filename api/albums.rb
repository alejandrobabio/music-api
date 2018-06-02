require 'albums/create'
require 'albums/delete'

module MusicAPI
  class Albums < Grape::API
    resources :albums do
      mount Create
      mount Delete
    end
  end
end
