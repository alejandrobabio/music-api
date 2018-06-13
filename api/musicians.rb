require 'musicians/create.rb'
require 'musicians/delete.rb'
require 'musicians/index.rb'

module MusicAPI
  class Musicians < Grape::API
    resources :musicians do
      mount Index
      mount Create
      mount Delete
    end
  end
end
