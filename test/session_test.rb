require './lib/csv_manager'
require './lib/session'
require './lib/queue_manager'
require './lib/help'
require 'minitest/autorun'
require 'minitest/pride'

class SessionTest < Minitest::Test

  def test_session_isolates_command_from_input
    s = Session.new
    s.execute_command ("load")
    assert_equal "load", s.com

    s.execute_command("find first_name danny")
    assert_equal "find", s.com

    s.execute_command("queue print")
    assert_equal "queue", s.com

    s.execute_command("help load")
    assert_equal "help", s.com

    s.execute_command("load test.csv")
    assert_equal "load", s.com
  end

  def test_session_isolates_parameters_from_input
    s = Session.new

    s.execute_command("load test_file.csv")
    assert_equal ["test_file.csv"], s.para

    s.execute_command("find first_name Allison")
    assert_equal ["first_name", "Allison"], s.para

    s.execute_command("queue print")
    assert_equal ["print"], s.para

    s.execute_command("queue print by last_name")
    assert_equal ["print by", "last_name"], s.para

    s.execute_command("help")
    assert_equal nil, s.para

    s.execute_command("help print by")
    assert_equal "print by", s.para

    s.execute_command("queue export html test.html")
    assert_equal ["export html", "test.html"], s.para
  end

  def test_session_validates_valid_commands
    s = Session.new

    refute s.validate_commands("give", "money")
    refute s.validate_commands("test", "johnson")
    refute s.validate_commands("loadd", "me")
    assert s.validate_commands("load", "me")
  end

  def test_session_validates_valid_queue_commands
    s = Session.new

    refute s.validate_commands("queue", "cry")
    refute s.validate_commands("queue", "print to")
    refute s.validate_commands("queue", "export tnt")
    assert s.validate_commands("queue", "print by")
  end

  def test_session_can_execute_load
    s = Session.new
    s.execute_command("load")

    refute s.manager.data.nil?
  end

  def test_session_can_execute_find
    s = Session.new
    s.execute_command("load")
    s.execute_command("find first_name john")

    refute s.qm.queue.nil?
  end

  def test_session_can_execute_queue_count
    s = Session.new
    s.execute_command("load")
    s.execute_command("find first_name john")
    s.execute_command("queue count")

    assert_equal 63, s.qm.queue.size
  end

  def test_session_can_execute_queue_clear
    s = Session.new
    s.execute_command("load")
    s.execute_command("find first_name john")
    s.execute_command("queue count")

    assert_equal 63, s.qm.queue.size

    s.execute_command("queue clear")

    assert_equal 0, s.qm.queue.size
  end

  def test_session_can_execute_queue_district_
    s = Session.new
    s.execute_command("load")
    s.execute_command("find first_name danny")
    s.execute_command("queue district")

    refute s.qm.api.districts.nil?
  end

  def test_session_can_execute_print
    s = Session.new
    s.execute_command("load")
    s.execute_command("find first_name danny")
    s.execute_command("queue print")

    assert s.qm.printer.printed
  end

  def test_session_can_execute_print_by
    s = Session.new
    s.execute_command("load")
    s.execute_command("find first_name danny")
    s.execute_command("queue print by last_name")

    assert s.qm.printer.printed
  end

  def test_session_can_execute_save_to
    s = Session.new
    s.execute_command("load")
    s.execute_command("find first_name danny")
    s.execute_command("queue save to test.csv")

    assert File.exists?('./test.csv')
  end


  def test_session_can_execute_export_html
    s = Session.new
    s.execute_command("load")
    s.execute_command("find first_name danny")
    s.execute_command("queue export to test.html")

    assert File.exists?('./output/test.html')
  end






end
