module Pulse
  class BaseResource < Pulse::Resource
    include Pulse::Actions::Where
  end
end