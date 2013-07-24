module Pulse
  class Resource
    class_attribute :resource_name
    attr_accessor :attributes

    def initialize(values = {})
      @attributes = values.with_indifferent_access

      @attributes.each do |attribute, value|
        initialize_attribute_accessor(attribute, value)
      end
    end

    def to_hash
      attributes
    end

    private

    def initialize_attribute_accessor(attribute, value)
      class <<self
        self
      end.class_eval do
        attr_accessor attribute
      end
      self.send("#{ attribute }=", value)
    end

    class << self
      def resource(name)
        self.resource_name = name
      end

      def build_from(resp, request_params = {})
        case resp
        when Array
          resp.map { |values| build_from(values, request_params) }
        when Hash
          resource = self.new(resp)
          resource
        else
          resp
        end
      end
    end

  end
end