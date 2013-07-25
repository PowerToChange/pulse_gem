module Pulse
  module Errors
    class Unauthorized < StandardError; end;
    class InternalError < StandardError; end;
    class Forbidden < StandardError; end;
    class BadRequest < StandardError; end;
    class NotFound < StandardError; end;
  end
end