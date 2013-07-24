require 'active_support/concern'
require 'active_support/deprecation'
require 'active_support/core_ext/module'
require 'active_support/core_ext/hash'
require 'active_support/inflector'
require 'active_support/hash_with_indifferent_access'
require 'rest-client'
require 'active_model'

# Internal
require 'pulse/version'
require 'pulse/client'
require 'pulse/xml'
require 'pulse/errors'
require 'pulse/actions/where'
require 'pulse/resource'
require 'pulse/resources/base'
require 'pulse/resources/ministry_involvement'

module Pulse
  @@api_key = nil
  @@api_base = nil

  mattr_accessor :api_key, :api_base

  def self.api_url(options = {})
    base = "#{ api_base }/api/#{ options[:resource] }?#{ options[:path] }"
    base += "&api_key=#{ api_key }" if api_key
    base
  end
end
