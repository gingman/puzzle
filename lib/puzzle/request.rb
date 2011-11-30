require "json"
require "cgi"
require "net/http"

module Puzzle
  class Request
    def self.delete(path, options = {})
      options[:token] ||= Puzzle.configuration.token

      response = request.delete(uri(path, options))
      response.code.to_i == 200
    end

    def self.get(path, options = {})
      token = Puzzle.configuration.token
      format = Puzzle.configuration.format

      unless token.nil?
        options[:token] ||= token
      end

      response = request.get(uri(path, options))

      case response.code.to_i
      when 200
        case format
        when "json"
          JSON.parse(response.body)
        when "xml"
          # TODO: Support XML format  
        end
      else
        # TODO: Handle Errors
        false
      end
    end

    def self.request
      http = Net::HTTP.new(Puzzle.configuration.host, Puzzle.configuration.port)
      http.use_ssl = true
      http
    end

    def self.uri(path, options = {})
      format = Puzzle.configuration.format
      "/rest/#{path}.#{format}?#{hash_to_query_string(options)}"
    end

    def self.hash_to_query_string(hash)
      hash.sort_by { |key, value|
        key.to_s
      }.delete_if { |key, value|
        value.to_s.empty?
      }.collect { |key, value|
        "#{CGI.escape(key.to_s).gsub(/%(5B|5D)/n) { [$1].pack("H*") }}=#{CGI.escape(value.to_s)}"
      }.join("&")
    end
  end
end

