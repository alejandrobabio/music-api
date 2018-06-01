module MusicAPI
  module UseCases
    module DeleteArtist
      def self.included(base)
        base.class_eval do
          attr_reader :model_class
          private :model_class
        end
      end

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
