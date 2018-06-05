module MusicAPI
  class AssociateArtistValidator < Grape::Validations::Base
    def validate_param!(attr_name, params)
      if params[attr_name][:id] && params[attr_name].keys.size > 1
        fail Grape::Exceptions::Validation, params: [@scope.full_name(attr_name)],
          message: "Don't inform other attributes when :id is provided"
      end
    end
  end
end
