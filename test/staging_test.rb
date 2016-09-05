gem 'minitest'
require './lib/staging'
require './lib/csv_manager'
require 'minitest/autorun'
require 'minitest/pride'

class StagingTest < Minitest::Test
  def test_staging_holds_data
    csv = CSVManager.new
    csv.load_file('./test_file.csv')

    refute csv.data.nil?
  end

  def test_staging_holds_regdate
    csv = CSVManager.new
    csv.load_file('./test_file.csv')

    refute csv.data[0].regdate.nil?
    refute csv.data[50].regdate.nil?
    refute csv.data[100].regdate.nil?
  end

  def test_staging_holds_first_name
    csv = CSVManager.new
    csv.load_file('./test_file.csv')

    refute csv.data[0].first_name.nil?
    refute csv.data[50].first_name.nil?
    refute csv.data[100].first_name.nil?
  end

  def test_staging_holds_last_name
    csv = CSVManager.new
    csv.load_file('./test_file.csv')

    refute csv.data[0].last_name.nil?
    refute csv.data[50].last_name.nil?
    refute csv.data[100].last_name.nil?
  end

  def test_staging_holds_email_address
    csv = CSVManager.new
    csv.load_file('./test_file.csv')

    refute csv.data[0].email_address.nil?
    refute csv.data[50].email_address.nil?
    refute csv.data[100].email_address.nil?
  end

  def test_staging_holds_homephone
    csv = CSVManager.new
    csv.load_file('./test_file.csv')

    refute csv.data[0].homephone.nil?
    refute csv.data[50].homephone.nil?
    refute csv.data[100].homephone.nil?
  end

  def test_staging_holds_street
    csv = CSVManager.new
    csv.load_file('./test_file.csv')

    refute csv.data[0].street.nil?
    refute csv.data[50].street.nil?
    refute csv.data[100].street.nil?
  end

  def test_staging_holds_city
    csv = CSVManager.new
    csv.load_file('./test_file.csv')

    refute csv.data[0].city.nil?
    refute csv.data[50].city.nil?
    refute csv.data[100].city.nil?
  end

  def test_staging_holds_state
    csv = CSVManager.new
    csv.load_file('./test_file.csv')

    refute csv.data[0].state.nil?
    refute csv.data[50].state.nil?
    refute csv.data[100].state.nil?
  end

  def test_staging_holds_zipcode
    csv = CSVManager.new
    csv.load_file('./test_file.csv')

    refute csv.data[0].zipcode.nil?
    refute csv.data[50].zipcode.nil?
    refute csv.data[100].zipcode.nil?
  end

end
