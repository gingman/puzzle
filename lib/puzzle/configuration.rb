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

    # Instantiated from {Puzzle.configuration}. Sets defaults.
    def initialize
      self.host = "www.jigsaw.com"
      self.port = 443
      self.format = "json"
    end
  end
end


