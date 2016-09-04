require 'csv'
require 'pry'

class CSVManager
  attr_accessor :data

  def initialize
    @data = []
  end

  def load_file(filename)
    #store data in accessor method to be used in queue
    self.data = []
    CSV.foreach(filename, headers: true, header_converters: :symbol) do |row|
      self.data << row
    end
  end
end
