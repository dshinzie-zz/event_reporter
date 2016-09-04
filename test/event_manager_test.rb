gem 'minitest'
require_relative '../lib/csv_manager'
require 'minitest/autorun'
require 'minitest/pride'

class CSVManagerTest < Minitest::Test
  def test_manager_loads_file
    csv = CSVManger.new
    filename = './file_test.csv'
    csv.load_file(file_name)
    p csv.data.count
  end
end
