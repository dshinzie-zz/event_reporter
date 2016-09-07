require_relative 'messages'
require 'net/http'
require 'json'
require 'pry'

class Queue

  attr_reader :queue, :district

  def initialize ##? i dont get this
    @queue = []
    @districts = Hash.new{|hsh,key| hsh[key] = [] }
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
    print_headers
    print_data
  end

  def queue_print_by(attribute)
    print_headers
    print_by_data(attribute)
  end

  def print_headers
    puts sprintf('%-15s %-15s %-45s %-10s %-15s %-10s %-35s %-15s %-10s', "last name", "first name", "email address", "zipcode", "city", "state", "street", "homephone", "district")
    puts ""
  end

  def print_data
    @queue.each do |a|
      puts sprintf('%-15s %-15s %-45s %-10s %-15s %-10s %-35s %-15s %-10s', a.last_name, a.first_name, a.email_address, a.zipcode, a.city, a.state, a.street, a.homephone, a.district)
    end
  end


  def print_by_data(attribute)
    @queue = @queue.sort_by { |attendee| attendee.send(attribute) }

    @queue.each do |a|
      puts sprintf('%-15s %-15s %-45s %-10s %-15s %-10s %-35s %-15s', a.last_name, a.first_name, a.email_address, a.zipcode, a.city, a.state, a.street, a.homephone)
    end
  end

  def queue_district
    if queue.count < 10
      @queue.each do |attendee|
        get_district_by_zip(attendee.zipcode.to_i)
      end

      add_district_to_queue
      Messages.queue_district_ran
    else
      Messages.queue_count_over_ten
    end
  end

  def add_district_to_queue
    @queue.each do |attendee|
      attendee.district = @districts[attendee.zipcode.to_i].join(", ") if @districts.has_key?(attendee.zipcode.to_i)
    end
  end

  def get_district_by_zip(zipcode)
    key = "e179a6973728c4dd3fb1204283aaccb5"
    url = "https://congress.api.sunlightfoundation.com/districts/locate/?zip=#{zipcode}&apikey=#{key}"
    uri = URI(url)
    response = Net::HTTP.get(uri)
    results = JSON.parse(response)
    flatten = results.values.flatten
    flatten.pop(1)

    flatten.each do |e|
      if @districts[zipcode].empty?
        @districts[zipcode] = [e["district"]]
      else
        @districts[zipcode] << e["district"]
      end
      @districts[zipcode].uniq!
    end
  end

  def get_legislators_by_zip(zipcode)
    key = "e179a6973728c4dd3fb1204283aaccb5"
    url = "https://congress.api.sunlightfoundation.com/legislators/locate/?zip=#{zipcode}&apikey=#{key}"
    uri = URI(url)
    response = Net::HTTP.get(uri)
    results = JSON.parse(response)
    @districts[zipcode] << results.values.flatten.first["first_name"]
    @districts[zipcode] << results.values.flatten.first["last_name"]
  end


  # def get_queue_columns(data)
  #   if data.class == Array
  #     data = data.first.instance_variables
  #   else
  #     data = data.instance_variables
  #   end
  #
  #   results = data.map do |element|
  #     element.to_s.sub("@", "")
  #   end
  # end

end
