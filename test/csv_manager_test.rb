require './lib/csv_manager'
require 'minitest/autorun'
require 'minitest/pride'

class CSVManagerTest < Minitest::Test
  # unit tests
  def test_manager_loads_into_array
    csv = CSVManager.new
    csv.load_file('./test_file.csv')

    assert_equal Array, csv.data.class
  end

  def test_manager_loads_a_file
    csv = CSVManager.new
    csv.load_file('./event_attendees.csv')

    assert_equal 5175, csv.data.count
  end

  def test_manager_resets_load_count
    csv = CSVManager.new
    csv.load_file('./test_file.csv')

    assert_equal 110, csv.data.count

    csv.load_file('./event_attendees.csv')

    assert_equal 5175, csv.data.count
  end

  def test_manager_saves_file
    csv = CSVManager.new
    new_filename = './test_file_save.csv'
    csv.load_file('./test_file.csv')
    csv.save_file(new_filename, csv.data)

    assert File.exist?(new_filename)
  end


  # def test_manager_grabs_correct_data
  #   csv = CSVManager.new
  #   csv.load_file('./test_file.csv')
  #   csv.get_data_by_column_header(csv.data)
  #
  #   assert csv.column_data_verifier("last_name", 0)
  #   assert csv.column_data_verifier("last_name", 50)
  #
  #   assert csv.column_data_verifier("first_name", 0)
  #   assert csv.column_data_verifier("first_name", 50)
  #
  #   assert csv.column_data_verifier("email_address", 0)
  #   assert csv.column_data_verifier("email_address", 50)
  #
  #   assert csv.column_data_verifier("zipcode", 0)
  #   assert csv.column_data_verifier("zipcode", 50)
  #
  #   assert csv.column_data_verifier("city", 0)
  #   assert csv.column_data_verifier("city", 50)
  #
  #   assert csv.column_data_verifier("state", 0)
  #   assert csv.column_data_verifier("state", 50)
  #
  #   assert csv.column_data_verifier("street", 0)
  #   assert csv.column_data_verifier("street", 50)
  #
  #   assert csv.column_data_verifier("homephone", 0)
  #   assert csv.column_data_verifier("homephone", 50)
  # end
end
