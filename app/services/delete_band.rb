module MusicAPI
  module Services
    class DeleteBand
      attr_reader :model_class
      private :model_class

      def initialize(model_class)
        @model_class = model_class
      end

      def call(id)
        model_class.destroy(id)
        ''
      end
    end
  end
end
