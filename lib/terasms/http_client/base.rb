require 'net/http'
require 'uri'

module Terasms
  class HttpClient
    def submit url, params
      begin
        uri = URI.parse(url)
        uri.query = URI.encode_www_form(params)
        header = {'Content-Type': 'text/html'}
        http = Net::HTTP.new(uri.host, uri.port)
        http.use_ssl = true
        http.read_timeout = 10
        request = Net::HTTP::Get.new(uri.request_uri, header)
        http.request(request).body
      rescue => error
        error.to_s
      end
    end
  end
end