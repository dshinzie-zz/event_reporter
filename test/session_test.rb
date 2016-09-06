require './lib/csv_manager'
require './lib/session'
require './lib/queue'
require './lib/help'

require 'minitest/autorun'
require 'minitest/pride'

class SessionTest < Minitest::Test

  def test_session_holds_other_instance_variables
    s = Session.new
    assert_equal [:@manager, :@queue, :@help], s.instance_variables
  end

  def test_find_stores_results_in_queue
    s = Session.new
    s.load('./test_file.csv')
    s.execute_find(["first_name", "John"])

    refute s.queue.data.nil?
  end

  def test_session_can_find_based_on_one_criteria
    s = Session.new
    s.load('./test_file.csv')
    s.execute_find(["first_name", "John"])

    assert_equal s.queue.data[0].first_name, "john"

    s.execute_find(["first_name", "Allison"])

    assert_equal s.queue.data[0].first_name, "allison"
  end

  def test_session_can_count_after_finding
    s = Session.new
    s.load('./test_file.csv')
    s.execute_find(["first_name", "John"])

    assert_equal 63, s.queue_count

  end

end
