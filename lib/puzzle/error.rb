module Puzzle
  class Error
    attr_accessor :stack_trace, :code, :message, :http_status_code
    def initialize(error)
      @code = error["errorCode"]
      @message = error["errorMsg"]
      @stack_trace = error["stackTrace"]
      @http_status_code = error["httpStatusCode"] 
    end
  end
end
