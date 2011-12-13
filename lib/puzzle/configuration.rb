module Puzzle
  # Class used to store configuration information
  class Configuration
    # @return [String] The host to connect to (defaults to +api.openbeerdatabase.com+).
    attr_accessor :host

    # @return [Integer] The port used to communicate
    attr_accessor :port
    
    # @return [String] The return format (XML/JSON)
    attr_accessor :format
    
    # @return [String] The API token for your user.
    attr_accessor :token

    # @return [String] The path to the certificate
    attr_accessor :ca_path

    # @return [String] The path to the certificate
    attr_accessor :ca_file

    # @return [String] The verification method used by ssl
    attr_accessor :verify_mode
    
    # Instantiated from {Puzzle.configuration}. Sets defaults.
    def initialize
      self.host = "www.jigsaw.com"
      self.port = 443
      self.format = "json"
      self.verify_mode = OpenSSL::SSL::VERIFY_PEER
      self.ca_path = '/etc/ssl/certs' if File.exists?('/etc/ssl/certs') # Ubuntu
      self.ca_file = '/opt/local/share/curl/curl-ca-bundle.crt' if File.exists?('/opt/local/share/curl/curl-ca-bundle.crt') # Mac OS X
    end
  end
end


