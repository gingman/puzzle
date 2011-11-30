# Load required files
%w(configuration request company).each do |file|
  require File.join(File.dirname(__FILE__), 'puzzle', file)
end

module Puzzle
  # Call this method to modify defaults in your initializers.
  #
  # Puzzle.configure do |configuration|
  #   configuration.host = "www.jigsaw.com"
  #   configuration.token = "mytoken"
  #   configuration.format = "xml"
  # end
  #
  # @yield [Configuration] The current configuration.
  def self.configure
    yield(configuration)
  end

  # @return [Configuration] Current configuration.
  def self.configuration
    @@configuration ||= Configuration.new
  end
end
