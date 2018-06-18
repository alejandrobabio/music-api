require 'musicians/index.rb'
require 'musicians/create.rb'
require 'musicians/update.rb'
require 'musicians/delete.rb'

module MusicAPI
  class Musicians < Grape::API
    resources :musicians do
      mount Index
      mount Create
      mount Update
      mount Delete
    end
  end
end
