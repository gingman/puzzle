require File.join(File.dirname(__FILE__), 'exception')
require File.join(File.dirname(__FILE__), 'error')
require File.join(File.dirname(__FILE__), 'const')
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
        handle_error(response.body, format)
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

    def self.handle_error(error_body, format = "json")
      error = parse_error(error_body, format)
      case error.http_status_code
      when 400
        raise Puzzle::Exception::ParamError, error.message
      when 403
        case error.code
        when Puzzle::ErrorCode::LOGIN_FAIL
          raise Puzzle::Exception::LoginFail, error.message
        when Puzzle::ErrorCode::TOKEN_FAIL
          raise Puzzle::Exception::TokenFail, error.message
        end
      when 404
        raise Puzzle::Exception::ContactNotExist, error.message
      when 405
        case error.code
        when Puzzle::ErrorCode::CONTACT_NOT_OWNED
          raise Puzzle::Exception::ContactNotOwned, error.message
        when Puzzle::ErrorCode::PURCHASE_LOW_POINTS
          raise Puzzle::Exception::PurchaseLowPoints, error.message
        end
      when 500
        case error.code
        when Puzzle::ErrorCode::SEARCH_ERROR
          raise Puzzle::Exception::SearchError, error.message
        when Puzzle::ErrorCode::SYS_ERROR
          raise Puzzle::Exception::SysError, error.message
        end
      when 501
        raise Puzzle::Exception::NotImplemented, error.message
      when 503
        raise Puzzle::Exception::NotAvailable, error.message
      else
        raise StandardError, "Unknown Error"
      end
    end

    def self.parse_error(error_data, format = "json")
      error = nil
      case format
      when "json"
        parsed_error = JSON.parse(error_data)
        if parsed_error && parsed_error.length > 0
          error = Error.new(parsed_error[0])
        end
      when "xml"
        # TODO: Add xml support
      end
      error
    end
  end
end

