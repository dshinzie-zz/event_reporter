require './lib/queue'
require 'minitest/autorun'
require 'minitest/pride'

class QueueTest < Minitest::Test
  def test_queue_stores_values_in_array
    skip  ##need explanations
    assert_equal Array, Queue.new.queue.class
  end

  def test_can_add_data_to_queue
    q = Queue.new
    q.add_queue("test")

    refute q.queue.nil?
  end

  def test_can_count_values_in_queue
    q = Queue.new
    q.add_queue("test")

    assert_equal 1, q.queue_count
  end

  def test_can_count_records_in_array_in_queue
    q = Queue.new
    q.add_queue([1, 2, 3, 4, 5, 6, 7, 8, 9, 10])

    assert_equal 10, q.queue_count

    q.add_queue([[1,2,3], [1,2,3], [1,2,3]])

    assert_equal 3, q.queue_count

    q.add_queue([1111,2222,[3],[4]])

    assert_equal 4, q.queue_count
  end

  def test_can_clear_queue
    q = Queue.new
    q.add_queue([1, 2, 3, 4, 5, 6, 7, 8, 9, 10])
    q.queue_clear

    assert q.queue.empty?
  end


end
