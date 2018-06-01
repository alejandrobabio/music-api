require 'musicians/create.rb'

module MusicAPI
  class Musicians < Grape::API
    resources :musicians do
      mount Create
    end
  end
end
