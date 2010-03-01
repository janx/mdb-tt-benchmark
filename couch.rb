require 'rubygems'
require 'curb'

module Couch
  class Server
    def initialize(host, port, options = nil)
      @host = host
      @port = port
      @options = options
    end

    def delete(uri)
      raise "Not supported"
    end

    def get(path)
      request to_uri(path)
    end

    def put(path, json)
      c = Curl::Easy.new(to_uri(path)) do |curl|
        curl.headers["content-type"] = "application/json"
      end
      c.http_put(json)
    end

    def post(path, json)
      c = Curl::Easy.new(to_uri(path)) do |curl|
        curl.headers["content-type"] = "application/json"
      end
      c.http_post(json)
    end

    def request(req)
      Curl::Easy.perform(to_uri(req))
    end

    private

    def to_uri(request)
      request = "/#{request}" if request[0,1] != "/"
      "http://#{@host}:#{@port}#{request}"
    end

    def handle_error(uri)
      raise "Failed request on uri: #{uri}"
    end
  end
end
