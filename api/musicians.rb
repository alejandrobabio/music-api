require 'musicians/create.rb'
require 'musicians/delete.rb'

module MusicAPI
  class Musicians < Grape::API
    resources :musicians do
      mount Create
      mount Delete
    end
  end
end
