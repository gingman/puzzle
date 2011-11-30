module Puzzle
  module Exception
    class ParamError < StandardError; end
    class LoginFail < StandardError; end
    class TokenFail < StandardError; end
    class PurchaseLowPoints < StandardError; end
    class ContactNotExist < StandardError; end
    class ContactNotOwned < StandardError; end
    class SearchError < StandardError; end
    class SysError < StandardError; end
    class NotImplemented < StandardError; end
    class NotAvailable < StandardError; end
  end
end
