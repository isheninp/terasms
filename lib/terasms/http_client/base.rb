require 'net/http'
require 'uri'
require 'json'

module Terasms
  class HttpClient
    def submit url, params, method = 'GET', type = 'text', body =''
      begin
        uri = URI.parse(url)
        uri.query = URI.encode_www_form(params)
        http = Net::HTTP.new(uri.host, uri.port)
        http.use_ssl = true
        http.read_timeout = 10
        headers = case type
        when 'json'
          {'Content-Type' => 'application/json'}
        when 'text'
          {'Content-Type' => 'text/html'}
        else 
          raise 'unknown type'
        end
        response = case method
        when 'GET'
          http.get(uri.request_uri, headers)
        when 'POST'
          http.post(uri.request_uri, body, headers)
        else
          raise 'unknown http method'
        end
        result = case type
        when 'json'
          JSON.parse(response.body)
        when 'text'
          response.body
        end
        {"status"=> "success", "result" => result}
      rescue => error
        {"status"=> "error", "info" => error.to_s}
      end
    end
  end
end