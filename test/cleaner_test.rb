require './lib/cleaner'
require 'minitest/autorun'
require 'minitest/pride'

class CleanerTest < Minitest::Test

  def test_cleaner_downcases_all_letters
    assert_equal "test", Cleaner.clean_case("TEST")
    assert_equal "onetwothree", Cleaner.clean_case("OneTwoThree")
    assert_equal "unittest", Cleaner.clean_case("Unittest")
  end

  def test_cleaner_pads_zip_codes_to_five_digits
    assert_equal "00924", Cleaner.clean_zipcode("924")
    assert_equal "77004", Cleaner.clean_zipcode("77004")
    assert_equal "00001", Cleaner.clean_zipcode("1")
    refute_equal "924", Cleaner.clean_zipcode("924")
  end

  def test_cleaner_zip_defaults_to_00000_if_nil_or_empty
    assert_equal "00000", Cleaner.clean_zipcode(nil)
    assert_equal "00000", Cleaner.clean_zipcode("")
    refute_equal "00000", Cleaner.clean_zipcode("1")
  end

  def test_cleaner_reformats_numbers_with_no_spaces_no_characaters
    assert_equal "615-438-5000", Cleaner.clean_phone("6154385000")
    assert_equal "360-904-6000", Cleaner.clean_phone("3609046000")
  end

  def test_cleaner_reformats_numbers_with_spaces
    assert_equal "615-438-5000", Cleaner.clean_phone("615 438 5000")
    assert_equal "360-904-6000", Cleaner.clean_phone("360 904 6000")
    assert_equal "221-143-5134", Cleaner.clean_phone("22 11435 134")

  end

  def test_cleaner_reformats_numbers_with_special_characters
    assert_equal "360-904-6000", Cleaner.clean_phone("360-904-6000")
    assert_equal "360-904-6000", Cleaner.clean_phone("(360) 904 6000")
    assert_equal "360-904-6000", Cleaner.clean_phone("(360)-904 6000")
    assert_equal "360-904-6000", Cleaner.clean_phone("(360) 904-6000")
    assert_equal "360-904-6000", Cleaner.clean_phone("(360)-9046000")
    assert_equal "360-904-6000", Cleaner.clean_phone("(360)904-6000")

    assert_equal "360-904-6000", Cleaner.clean_phone("360.904.6000")
    assert_equal "360-904-6000", Cleaner.clean_phone("(360).904 6000")
    assert_equal "360-904-6000", Cleaner.clean_phone("(360) 904.6000")
    assert_equal "360-904-6000", Cleaner.clean_phone("(360).9046000")
    assert_equal "360-904-6000", Cleaner.clean_phone("(360)904.6000")

    assert_equal "360-904-6000", Cleaner.clean_phone("360-904.6000")
    assert_equal "360-904-6000", Cleaner.clean_phone("360.904-6000")
    assert_equal "360-904-6000", Cleaner.clean_phone("(360).904-6000")
    assert_equal "360-904-6000", Cleaner.clean_phone("(360)-904.6000")
  end

  def test_cleaner_excludes_first_optional_1
    assert_equal "508-237-5000", Cleaner.clean_phone("1-508-237-5000")
    assert_equal "857-498-1000", Cleaner.clean_phone("1(857)498-1000")
    assert_equal "614-236-7000", Cleaner.clean_phone("1-(614) 236-7000")
    assert_equal "111-111-1000", Cleaner.clean_phone("111-111-1000")
  end

  def test_cleaner_returns_message_for_empty_or_nil_numbers
    expected = "000-000-0000"
    assert_equal expected, Cleaner.clean_phone("")
    assert_equal expected, Cleaner.clean_phone("0")
    assert_equal expected, Cleaner.clean_phone(nil)
  end

  def test_cleaner_returns_message_for_numbers_containing_letters
    expected = "000-000-0000"
    assert_equal expected, Cleaner.clean_phone("n000")
    assert_equal expected, Cleaner.clean_phone("xxxx000")
    assert_equal expected, Cleaner.clean_phone("ajgabrie@unca.000")
    assert_equal expected, Cleaner.clean_phone("9.82E+00")
  end

  def test_cleaner_returns_message_for_number_less_than_10_digits
    expected = "000-000-0000"
    assert_equal expected, Cleaner.clean_phone("999 23 9343")
    assert_equal expected, Cleaner.clean_phone("324 300 333")
    assert_equal expected, Cleaner.clean_phone("114 454 121")
    assert_equal "993-343-1234", Cleaner.clean_phone("993 343 1234")

  end



end
