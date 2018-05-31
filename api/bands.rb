require 'bands/create.rb'
require 'bands/delete.rb'

module MusicAPI
  class Bands < Grape::API
    resources :bands do
      mount Create
      mount Delete
    end
  end
end
