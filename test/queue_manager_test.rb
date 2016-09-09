require './lib/queue_manager'
require './lib/csv_manager'
require './lib/session'
require 'minitest/autorun'
require 'minitest/pride'

class QueueManagerTest < Minitest::Test

  attr_reader :s, :qm

  def setup
    @s = Session.new
    @s.execute_command("load")
    @s.execute_command("find first_name danny")
    @qm = @s.qm.queue
  end

  def test_queue_stores_values_in_array
    assert_equal Array, QueueManager.new.queue.class
  end

  def test_queue_count_is_initially_empty
    q = QueueManager.new

    assert q.queue.empty?
  end

  def test_queue_can_add_data_to_queue
    q = QueueManager.new
    q.queue_add("test")

    refute q.queue.nil?
  end

  def test_queue_can_count_values_in_queue
    q = QueueManager.new
    q.queue_add("test")

    assert_equal 1, q.queue_count
  end

  def test_queue_can_count_records_in_array
    q = QueueManager.new
    q.queue_add([1, 2, 3, 4, 5, 6, 7, 8, 9, 10])
    assert_equal 10, q.queue_count

    q.queue_add([[1,2,3], [1,2,3], [1,2,3]])
    assert_equal 3, q.queue_count

    q.queue_add([1111,2222,[3],[4]])
    assert_equal 4, q.queue_count
  end

  def test_queue_can_clear_queue
    q = QueueManager.new
    q.queue_add([1, 2, 3, 4, 5, 6, 7, 8, 9, 10])
    q.queue_clear

    assert q.queue.empty?
  end

  def test_queue_stores_only_most_recent_find
    q = QueueManager.new
    q.queue_add("testtestestest")
    q.queue_add(["Hello", "darkness", "my", "old", "friend"])
    q.queue_add("Sup, bro.")

    assert_equal 1, q.queue_count
  end

  def test_queue_exporter_creates_new_file
    q = QueueManager.new
    q.queue = qm

    q.queue_export("test.html", q.queue)

    assert File.exists?('./output/test.html')
  end

  def test_queue_prints_without_attributes
    q = QueueManager.new
    q.queue = qm
    q.queue_print

    assert q.printer.printed
  end

  def test_queue_prints_with_attributes
    q = QueueManager.new
    q.queue = qm
    q.queue_print("last_name")

    assert q.printer.printed
  end

  def test_queue_adds_districts_to_hash
    q = QueueManager.new
    q.queue = qm
    q.queue_district(q.queue)

    refute q.api.districts.nil?
  end

  def test_queue_district_builds_new_url
    q = QueueManager.new
    q.queue = qm
    q.queue_district(q.queue)

    refute q.api.new_url.nil?
  end

  def test_queue_district_adds_district_to_queue
    q = QueueManager.new
    q.queue = qm
    q.queue_district(q.queue)

    refute q.queue.first.district.nil?
    refute q.queue.last.district.nil?
  end

  def test_queue_district_only_adds_if_under_10_entries
    s2 = Session.new
    s2.execute_command("load")
    s2.execute_command("find first_name john")
    qm2 = s2.qm.queue
    q = QueueManager.new
    q.queue = qm2
    q.queue_district(q.queue)

    assert_equal "", q.queue.first.district
    assert_equal "", q.queue.last.district
  end

  def test_queue_creates_list_of_valid_attributes
    q = QueueManager.new
    q.queue = qm
    q.get_queue_columns(q.queue)

    assert q.get_queue_columns(q.queue).include?("first_name")
    assert q.get_queue_columns(q.queue).include?("homephone")
    assert q.get_queue_columns(q.queue).include?("street")

    refute q.get_queue_columns(q.queue).include?("not_real")
    refute q.get_queue_columns(q.queue).include?("test_of_test")
  end

  def test_queue_validates_against_wrong_attributes
    q = QueueManager.new
    q.queue = qm
    q.get_queue_columns(q.queue)


    assert q.attribute_exists?(q.queue, "last_name")
    assert q.attribute_exists?(q.queue, "zipcode")
    assert q.attribute_exists?(q.queue, "email_address")

    refute q.attribute_exists?(q.queue, "tester")
    refute q.attribute_exists?(q.queue, "antizipcode")
    refute q.attribute_exists?(q.queue, "middle_name")
  end


end
