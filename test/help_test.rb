require './lib/help'
require 'minitest/autorun'
require 'minitest/pride'

class HelpTest < Minitest::Test

  def test_help_load_puts_message_and_returns_nil
    h = Help.new

    assert h.help_display("load").nil?
  end

  def test_help_find_puts_message_and_returns_nil
    h = Help.new

    assert h.help_display("find").nil?
  end

  def test_help_count_puts_message_and_returns_nil
    h = Help.new

    assert h.help_display("count").nil?
  end

  def test_help_queue_puts_message_and_returns_nil
    h = Help.new

    assert h.help_display("queue").nil?
  end

  def test_help_queue_count_puts_message_and_returns_nil
    h = Help.new

    assert h.help_display("queue count").nil?
  end

  def test_help_queue_clear_puts_message_and_returns_nil
    h = Help.new

    assert h.help_display("queue clear").nil?
  end

  def test_help_queue_print_puts_message_and_returns_nil
    h = Help.new

    assert h.help_display("queue print").nil?
  end
  
  def test_help_queue_print_by_puts_message_and_returns_nil
    h = Help.new

    assert h.help_display("queue print by").nil?
  end

  def test_help_queue_district_puts_message_and_returns_nil
    h = Help.new

    assert h.help_display("queue district").nil?
  end

  def test_help_queue_save_to_puts_message_and_returns_nil
    h = Help.new

    assert h.help_display("queue save to").nil?
  end

  def test_help_queue_export_html_puts_message_and_returns_nil
    h = Help.new

    assert h.help_display("queue export html").nil?
  end
end
