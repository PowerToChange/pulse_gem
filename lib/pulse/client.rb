module Pulse
  class Client
    class << self

      def request(method, params = {})
        params = params.with_indifferent_access
        raise Pulse::Errors::Unauthorized, "Please specify Pulse.api_key" unless Pulse.api_key
        raise Pulse::Errors::Unauthorized, "Please specify TheKey guid parameter" unless params[:guid].present?
        Pulse::XML.parse(response(method, params))
      end

      private

      def headers
        { :user_agent => "Pulse RubyClient/#{Pulse::VERSION}" }
      end

      def response(method, params)
        execute(build_opts(method, params)).body
      end

      def build_opts(method, params)
        opts = {
          :method => method,
          :timeout => 80,
          :headers => headers
        }
        resource = params.delete(:resource)

        # build params
        case method.to_s.downcase.to_sym
        when :get, :head, :delete
          path = params.count > 0 ? stringify_params(params) : ''
        else
          opts[:payload] = stringify_params(params)
        end
        opts[:url] = Pulse.api_url(path: path, resource: resource)
        opts
      end

      def execute(opts)
        RestClient::Request.execute(opts)
      rescue RuntimeError => e
        case e.http_code.to_i
        when 400
          raise Pulse::Errors::BadRequest, e.http_body
        when 401
          raise Pulse::Errors::Unauthorized, e.http_body
        when 403
          raise Pulse::Errors::Forbidden, e.http_body
        when 404
          raise Pulse::Errors::NotFound, e.http_body
        when 500
          raise Pulse::Errors::InternalError, e.http_body
        else
          raise e
        end
      end

      def uri_escape(key)
        URI.escape(key.to_s, Regexp.new("[^#{URI::PATTERN::UNRESERVED}]"))
      end

      def flatten_params(params, parent_key = nil)
        result = []
        params.each do |key, value|
          flatten_key = parent_key ? "#{parent_key}[#{uri_escape(key)}]" : uri_escape(key)
          result += value.is_a?(Hash) ? flatten_params(value, flatten_key) : [[flatten_key, value]]
        end
        result
      end

      def stringify_params(params)
        flatten_params(params).collect{|key, value| "#{key}=#{uri_escape(value)}"}.join('&')
      end

    end
  end
end