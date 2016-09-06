require_relative 'messages'
require 'pry'

class Queue

  HEADERS = [:regdate, :last_name, :first_name, :email_address,
        :homephone, :street, :city, :state, :zipcode]

  attr_reader :queue

  def self.initialize ##? i dont get this
    @queue = []
  end

  def queue_add(results)
    results.class == Array ? @queue = results : @queue = [results]
    Messages.queue_added
  end

  def queue_count
    @queue.size
  end

  def queue_clear
    @queue = []
    Messages.queue_cleared
  end

  def queue_print
    if @queue.nil?
      Messages.queue_empty
    else
      print_headers(get_padding)
      print_data(get_padding)
    end
  end

  def get_padding
    paddings = {}
    get_queue_columns(@queue).each do |column|
      @queue.sort_by do |attendee|
        attendee.send(column).length
        paddings[column] = @queue.last.send(column).length
        end
      end
      paddings
  end

  def print_headers(paddings)
    header = get_queue_columns(@queue)
    header.each do |header|
      printf(header.ljust(paddings[header] + 13))
    end
    puts ""
  end

  def print_data(paddings)
    @queue.each do |attendee|
      get_queue_columns(attendee).each do |column|
        printf(attendee.send(column).ljust(paddings[column] + 13))
      end
      puts "\n"
    end
  end

  def get_queue_columns(data)
    if data.class == Array
      data = data.first.instance_variables
    else
      data = data.instance_variables
    end

    results = data.map do |element|
      element.to_s.sub("@", "")
    end
  end


end
