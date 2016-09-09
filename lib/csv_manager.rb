require './lib/attendee'
require './lib/messages'
require 'csv'

class CSVManager
  attr_accessor :data

  def initialize
    @data = []
  end

  def load_file(filename)
    self.data = []
    CSV.foreach(filename, headers: true, header_converters: :symbol) do |row|
      self.data << Attendee.new(row)
    end
  end

  def save_file(filename, data)
    CSV.open(filename, "w", {:headers => true, :header_converters => :symbol}) do |output|
      output << get_headers_for_save_file
      data.each do |attendee|
        output << get_headers_for_save_file.map {|column| attendee.send(column)}
      end
    end
    Messages.file_saved(filename)
  end

  def get_headers_for_save_file
    ["last_name","first_name","email_address","zipcode","city","state","street","homephone"]
  end
end
