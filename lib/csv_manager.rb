require 'csv'
require_relative 'staging'
require 'pry'


class CSVManager
  attr_accessor :data

  def initialize
    @data = []
  end

  def load_file(filename)
    #store data in accessor method to be used in queue
    #using @data will have previous loads stored in
    self.data = []
    CSV.foreach(filename, headers: true, header_converters: :symbol) do |row|
      self.data << Staging.new(row) #initialize each row
    end
  end

  def save_file(filename, data)
    File.open(filename, "w") do |csv|
      csv.puts get_headers_for_save_file
    end

    File.open(filename, "a") do |csv|
      csv.puts get_data_by_column_header(data)
    end
  end

  def get_data_by_column_header(data)
    results = data.map do |e|
      "#{e.instance_variable_get("@last_name")},"\
      "#{e.instance_variable_get("@first_name")},"\
      "#{e.instance_variable_get("@email_address")},"\
      "#{e.instance_variable_get("@zipcode")},"\
      "#{e.instance_variable_get("@city")},"\
      "#{e.instance_variable_get("@state")},"\
      "#{e.instance_variable_get("@street")},"\
      "#{e.instance_variable_get("@homephone")}"
    end
    results.flatten.join(",")
    #binding.pry
  end

  def get_headers_for_save_file
    "last_name,first_name,email_address,zipcode,city,state,street,homephone"
  end


  # def column_data_verifier(column, row)
  #   case column
  #   when "last_name"
  #     data[row].last_name == @results[row].split(", ")[0] ? true : false
  #   when "first_name"
  #     data[row].first_name == @results[row].split(", ")[1] ? true : false
  #   when "email_address"
  #     data[row].email_address == @results[row].split(", ")[2] ? true : false
  #   when "zipcode"
  #     data[row].zipcode == @results[row].split(", ")[3] ? true : false
  #   when "city"
  #     data[row].city == @results[row].split(", ")[4] ? true : false
  #   when "state"
  #     data[row].state == @results[row].split(", ")[5] ? true : false
  #   when "street"
  #     data[row].street == @results[row].split(", ")[6] ? true : false
  #   when "homephone"
  #     data[row].homephone == @results[row].split(", ")[7] ? true : false
  #   end
  # end

end

#last name, first name, email, zipcode, city, state, address, and phone number.
