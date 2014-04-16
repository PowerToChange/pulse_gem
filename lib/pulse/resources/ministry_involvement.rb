module Pulse
  class MinistryInvolvement < BaseResource
    resource :ministry_involvements

    class << self
      def build_from(resp, request_params = {})
        if resp.is_a?(Array)
          # Get the ministry involvements in an array of hashes
          new_resp = [resp.first['ministry_involvements']['ministry_involvement']].flatten

          # Include some user meta data for convenience
          new_resp.each do |mi|
            mi['user'] ||= {}
            ['first_name', 'last_name', 'email', 'guid', 'civicrm_id', 'id'].each do |user_attribute|
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