require_relative 'cleaner'

class Staging
  #used as a staging between input csv data and output cleaned up data
  attr_reader :regdate,
              :first_name,
              :last_name,
              :email_address,
              :homephone,
              :street,
              :city,
              :state,
              :zipcode
              
  attr_accessor :district

  def initialize(data)
    @regdate = data[:regdate]
    @first_name = Cleaner.clean_case(data[:first_name])
    @last_name = Cleaner.clean_case(data[:last_name])
    @email_address = Cleaner.clean_case(data[:email_address])
    @homephone = Cleaner.clean_phone(data[:homephone])
    @street = Cleaner.clean_address(data[:street])
    @city = Cleaner.clean_address(data[:city])
    @state = Cleaner.clean_state(data[:state])
    @zipcode = Cleaner.clean_zipcode(data[:zipcode]).strip
    @district = ""
  end

end
