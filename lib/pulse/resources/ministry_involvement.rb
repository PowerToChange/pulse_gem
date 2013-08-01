module Pulse
  class MinistryInvolvement < BaseResource
    resource :ministry_involvements

    class << self
      def build_from(resp, request_params = {})
        if resp.is_a?(Array)
          new_resp = resp.first['ministry_involvements']['ministry_involvement']

          # Include some user meta data for convenience
          ['first_name', 'last_name', 'email', 'guid', 'civicrm_id'].each do |user_attribute|
            new_resp.each do |mi|
              mi['user'] ||= {}
              mi['user'][user_attribute] = resp.first['ministry_involvements'][user_attribute]
            end
          end
        else
          new_resp = resp
        end

        super(new_resp, request_params)
      end
    end

  end
end