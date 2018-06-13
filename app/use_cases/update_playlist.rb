module MusicAPI
  module UseCases
    class UpdatePlaylist
      attr_reader :model_class
      private :model_class

      def initialize(model_class)
        @model_class = model_class
      end

      def call(params)
        model_class.find(params[:id]).update!(name: params[:name])
      end
    end
  end
end
