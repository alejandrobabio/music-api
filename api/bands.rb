require 'bands/index.rb'
require 'bands/create.rb'
require 'bands/delete.rb'

module MusicAPI
  class Bands < Grape::API
    resources :bands do
      mount Index
      mount Create
      mount Delete
    end
  end
end
