gem 'minitest'
require './lib/csv_manager'
require 'minitest/autorun'
require 'minitest/pride'

class CSVManagerTest < Minitest::Test
  # unit tests
  def test_manager_loads_into_array
    csv = CSVManager.new
    filename = './test_file.csv'
    csv.load_file(filename)

    assert_equal Array, csv.data.class
  end

  def test_manager_loads_a_file
    csv = CSVManager.new
    filename = './test_file.csv'
    csv.load_file(filename)

    assert_equal 110, csv.data.count
  end

  def test_manager_loads_full_event_attendees_file
    csv = CSVManager.new
    filename = './event_attendees.csv'
    csv.load_file(filename)

    assert_equal 5175, csv.data.count
  end
end
