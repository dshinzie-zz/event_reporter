require './lib/csv_manager'
require 'minitest/autorun'
require 'minitest/pride'

class CSVManagerTest < Minitest::Test

  def test_manager_intializes_with_empty_array
    csv = CSVManager.new

    assert_equal Array, csv.data.class
  end

  def test_manager_loads_into_array
    csv = CSVManager.new
    csv.load_file('./event_attendees.csv')

    refute csv.data.nil?
  end

  def test_manager_loads_a_file
    csv = CSVManager.new
    csv.load_file('./event_attendees.csv')

    assert_equal 5175, csv.data.count
  end

  def test_manager_resets_load_count
    csv = CSVManager.new
    csv.load_file('./test_file.csv')

    assert_equal 9, csv.data.count

    csv.load_file('./event_attendees.csv')

    assert_equal 5175, csv.data.count
  end

  def test_manager_saves_file
    csv = CSVManager.new
    new_filename = './event_attendees_save.csv'
    csv.load_file('./event_attendees.csv')
    csv.save_file(new_filename, csv.data)

    assert File.exist?(new_filename)
  end
end
