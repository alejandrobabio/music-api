module MusicAPI
  module UseCases
    module CreateArtist
      def self.included(base)
        base.class_eval do
          attr_reader :model_class
          private :model_class
        end
      end

      def initialize(model_class)
        @model_class = model_class
      end

      def call(params)
        model_class.create!(params)
      end
    end
  end
end
