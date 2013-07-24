module Pulse
  module Actions
    module Where
      extend ActiveSupport::Concern

      module ClassMethods
        def where(params = {})
          params.merge!('resource' => resource_name)
          build_response(params)
        end

        private

        def build_response(params)
          response = Pulse::Client.request(:get, params)
          self.build_from(response, params)
        end
      end

    end
  end
end