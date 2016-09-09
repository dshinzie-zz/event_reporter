require './lib/messages'
require 'minitest/autorun'
require 'minitest/pride'

class MessagesTest < Minitest::Test

  def test_display_welcome_puts_message_and_returns_nil
    assert Messages.display_welcome.nil?
  end

  def test_display_instructions_puts_message_and_returns_nil
    assert Messages.display_instructions.nil?
  end

  def test_display_intro_puts_message_and_returns_nil
    assert Messages.display_intro.nil?
  end

  def test_display_exit_puts_message_and_returns_nil
    assert Messages.display_exit.nil?
  end

  def test_request_command_puts_message_and_returns_nil
    assert Messages.request_command.nil?
  end

  def test_file_loaded_puts_message_and_returns_nil
    assert Messages.file_loaded("testfile.csv").nil?
  end

  def test_file_missing_puts_message_and_returns_nil
    assert Messages.file_missing("testfile.csv").nil?
  end

  def test_queue_empty_puts_message_and_returns_nil
    assert Messages.queue_empty.nil?
  end

  def test_queue_count_puts_message_and_returns_nil
    assert Messages.queue_count("10").nil?
  end

  def test_queue_cleared_puts_message_and_returns_nil
    assert Messages.queue_cleared.nil?
  end

  def test_queue_added_puts_message_and_returns_nil
    assert Messages.queue_added.nil?
  end

  def test_invalid_command_puts_message_and_returns_nil
    assert Messages.invalid_command.nil?
  end

  def test_invalid_queue_puts_message_and_returns_nil
    assert Messages.invalid_queue.nil?
  end

  def test_queue_count_over_ten_puts_message_and_returns_nil
    assert Messages.queue_count_over_ten.nil?
  end

  def test_queue_district_ran_puts_message_and_returns_nil
    assert Messages.queue_district_ran.nil?
  end

  def test_queue_html_created_puts_message_and_returns_nil
    assert Messages.queue_html_created("testfile.html").nil?
  end

  def test_find_wrong_attribute_puts_message_and_returns_nil
    assert Messages.find_wrong_attribute("wrong_attribute").nil?
  end
end
