module Cleaner

  def self.clean_case(data)
    data.nil? || data == "" ? data = "NONE" : data.downcase.strip
  end

  def self.clean_zipcode(data)
    data.nil? || data == "" ? data = "00000" : data.to_s.rjust(5,"0")[0..4]
  end

  def self.clean_phone(data)
    return "000-000-0000" if data.nil?
    data.gsub!(/[^0-9]/, "")
    data.slice!(0) if data.length == 11
    return "000-000-0000" unless data.length == 10
    return data.insert(3,'-').insert(7,'-') if data.length == 10
  end

  def self.clean_state(data)
    data.nil? || data == "" ? data = "none" : data.downcase
  end
end
