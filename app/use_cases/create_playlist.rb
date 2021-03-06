module MusicAPI
  module UseCases
    class CreatePlaylist
      attr_reader :model_class
      private :model_class

      def initialize(model_class)
        @model_class = model_class
      end

      def call(params)
        model_class.create!(params)
      end
    end
  end
end
