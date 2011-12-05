module Puzzle
  class Company
    attr_accessor :id, :name, :address, :city, :state, :zip, :country, :active_contacts

    def initialize(company_info)
      @id = company_info["companyId"]
      @name = company_info["name"]
      @address = company_info["address"]
      @city = company_info["city"]
      @state = company_info["state"]
      @zip = company_info["zip"]
      @country = company_info["country"]
      @active_contacts = company_info["activeContacts"]
    end

    # Return a list of companies
    # => pageSize: The attribute specifies the maximum number of records to be returned in a request. The default value is 50 and the system limit is 100.
    # => name: Name of the desired company (indexed to include Company Name, URL, and ticker symbol)
    # => View http://developer.jigsaw.com/documentation/search_and_get_api_guide/6_Data_Keys_and_Values for available search parameter
    def self.find(options)
      companies = []
      results = {}
      result = Puzzle::Request.get("/searchCompany", options)
      result["companies"].each do |company|
        companies << new(company)
      end
      results = {
        :total => result["totalHits"],
        :companies => companies
      }
    end
  end
end
