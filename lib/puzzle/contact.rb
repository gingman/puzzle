module Puzzle
  class Contact
    attr_accessor :company_id
    attr_accessor :id
    attr_accessor :title
    attr_accessor :company_name
    attr_accessor :updated_at
    attr_accessor :graveyard_status
    attr_accessor :firstname
    attr_accessor :lastname
    attr_accessor :city
    attr_accessor :state
    attr_accessor :country
    attr_accessor :zip
    attr_accessor :url
    attr_accessor :area_code
    attr_accessor :phone
    attr_accessor :email
    attr_accessor :address
    attr_accessor :owned
    attr_accessor :owned_type


    def initialize(contact_info)
      @company_id = contact_info["companyId"]
      @id = contact_info["contactId"]
      @title = contact_info["title"]
      @company_name = contact_info["companyName"]
      @updated_at = contact_info["updatedDate"]
      @graveyard_status = contact_info["graveyardStatus"]
      @firstname = contact_info["firstname"]
      @lastname = contact_info["lastname"]
      @city = contact_info["city"]
      @state = contact_info["state"]
      @country = contact_info["country"]
      @zip = contact_info["zip"]
      @url = contact_info["contactURL"]
      @area_code = contact_info["areaCode"]
      @phone = contact_info["phone"]
      @email = contact_info["email"]
      @address = contact_info["address"]
      @owned = contact_info["owned"]
      @owned_type = contact_info["ownedType"]
    end

    # Return a list of contacts
    # => pageSize: The attribute specifies the maximum number of records to be returned in a request. The system limit and default value is 500.
    # => firstname: firstname of the contact to be searched
    # => lastname: last (or family) name of the contact to be searched
    # => levels: employee rank (e.g. VP, Staff)
    # => companyName: company for whom contact works (indexed to include Company Name, URL, and ticker symbol)
    # => email: full email address of the contact to be searched
    # => View http://developer.jigsaw.com/documentation/search_and_get_api_guide/6_Data_Keys_and_Values for available search parameter
    def self.find(options)
      contacts = []
      results = {}
      result = Puzzle::Request.get("/searchContact", options)
      result["contacts"].each do |contact|
        contacts << new(contact)
      end
      results = {
        :total => result["totalHits"],
        :contacts => contacts
      }
    end
  end
end
