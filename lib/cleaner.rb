require 'pry'
module Cleaner

  #clean names
  def self.clean_case(data)
    data.nil? || data == "" ? data = "none" : data.downcase
  end

  #zip codes
  def self.clean_zipcode(data)
    data.nil? || data == "" ? data = "00000" : data.to_s.rjust(5,"0")[0..4]
  end

  #phone
  def self.clean_phone(data)
    unless bad_number?(data)
      number_cleaner(data)
    else
      "Bad number"
    end
  end

  def self.number_cleaner(data)
    #skips an optional leading one (^1?), then extracts the first remaining 10 digits in chunks ((\d{3})(\d{3})(\d{4})) and formats.
    if data.gsub(/\D/, "").match(/^1?(\d{3})(\d{3})(\d{4})/)
      [$1, $2, $3].join("-")
    end
  end

  def self.bad_number?(data)
    data.nil? || data == "0" || data == "" || !data.match(/[[:alpha:]]/).nil? || data.gsub("-", "").length < 10
  end

  def self.clean_state(data)
    data.nil? || data == "" ? data = "none" : data.downcase
  end

end
