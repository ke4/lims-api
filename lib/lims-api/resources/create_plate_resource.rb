require 'lims-api/core_action_resource'
require 'lims-api/resources/create_container'

module Lims::Api
  module Resources
    class CreatePlateResource < CoreActionResource
      include CreateContainer

      def self.element_attr
        'wells_description'
      end

      def self.element_attr_sym
        :wells_description
      end
    end
  end
end
