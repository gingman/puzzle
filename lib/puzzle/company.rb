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

    def self.find(options)
      companies = []
      result = Puzzle::Request.get("/searchCompany", options)
      result["companies"].each do |company|
        companies << new(company)
      end
      companies
    end
  end
end
