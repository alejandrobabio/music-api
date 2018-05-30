require 'bands/create.rb'

module MusicAPI
  class Bands < Grape::API
    resources :bands do
      mount Create
    end
  end
end
