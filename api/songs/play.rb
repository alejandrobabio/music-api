module MusicAPI
  class Songs < Grape::API
    class Play < Grape::API
      helpers do
        def file_directory(file)
          file.storage.directory.sub(/\/#{file.storage.prefix}$/,'').to_s + file.url.to_s
        end
      end

      desc 'Play a Song via streaming'
      route_param :id, type: Integer do
        get 'play' do
          file = Song.find(params[:id]).track
          stream file_directory(file)
        end
      end
    end
  end
end
