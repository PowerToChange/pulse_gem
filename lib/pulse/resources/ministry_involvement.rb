module Pulse
  class MinistryInvolvement < BaseResource
    resource :ministry_involvements

    class << self
      def build_from(resp, request_params = {})
        resp = resp.is_a?(Array) ? resp.first['ministry_involvements']['ministry_involvement'] : resp
        super(resp, request_params)
      end
    end

  end
end