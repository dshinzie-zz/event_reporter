require './lib/printer'
require './lib/session'
require 'minitest/autorun'
require 'minitest/pride'

class PrinterTest < Minitest::Test

  attr_reader :s, :q

  def setup
    @s = Session.new
    @s.execute_command("load")
    @s.execute_command("find first_name danny")
    @q = @s.qm.queue
  end

  def test_max_last_name_calculated
    p = Printer.new(q)

    assert_equal 8, p.max_last
  end

  def test_max_first_name_calculated
    p = Printer.new(q)

    assert_equal 5, p.max_first
  end

  def test_max_email_calculated
    p = Printer.new(q)

    assert_equal 25, p.max_email
  end

  def test_max_zip_calculated
    p = Printer.new(q)

    assert_equal 5, p.max_zip
  end

  def test_max_city_calculated
    p = Printer.new(q)

    assert_equal 11, p.max_city
  end

  def test_max_state_calculated
    p = Printer.new(q)

    assert_equal 2, p.max_state
  end

  def test_max_street_calculated
    p = Printer.new(q)

    assert_equal 35, p.max_street
  end

  def test_max_phone_calculated
    p = Printer.new(q)

    assert_equal 12, p.max_phone
  end

  def test_max_district_calculated
    p = Printer.new(q)

    assert_equal 0, p.max_district
  end

  def test_min_max_adjustment_takes_header_length_over_short_attribute
    s2 = Session.new
    s2.execute_command("load")
    s2.execute_command("find first_name john")
    q2 = s2.qm.queue
    p = Printer.new(q2)
    p.min_max_adjustment

    assert_equal 13, p.max_first
  end

  def test_printer_prints_without_attributes
    s2 = Session.new
    s2.execute_command("load")
    s2.execute_command("find first_name danny")
    q2 = s2.qm.queue
    p = Printer.new(q2)
    p.print(q2)

    assert p.printed
  end

  def test_printer_prints_with_attributes
    s2 = Session.new
    s2.execute_command("load")
    s2.execute_command("find first_name danny")
    q2 = s2.qm.queue
    p = Printer.new(q2)
    p.print(q2, "last_name")

    assert p.printed
  end

end
