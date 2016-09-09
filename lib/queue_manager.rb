require './lib/messages'
require './lib/district'
require './lib/printer'
require 'erb'

class QueueManager

  attr_accessor :queue, :api, :printer

  def initialize
    @queue = []
    @api = District.new
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

  def queue_print(attribute = nil)
    @printer = Printer.new(@queue)
    
    if attribute.nil? || attribute_exists?(@queue, attribute)
      @printer.min_max_adjustment
      @printer.print_headers
      @printer.print(@queue, attribute)
    else
      Messages.find_wrong_attribute(attribute)
    end
  end

  def queue_district(data)
    if data.count > 10
      Messages.queue_count_over_ten
    elsif data.count == 0
      Messages.queue_empty
    else
      @api.get_district(data)
      add_district_to_queue(data)
    end
  end

  def add_district_to_queue(data)
    data.each do |attendee|
      attendee.district = @api.districts[attendee.zipcode].sort.join(", ") if @api.districts.has_key?(attendee.zipcode)
    end
    Messages.queue_district_ran
  end

  def queue_export(filename, data)
    Dir.mkdir("output") unless Dir.exists? "output"
    filename = "output/#{filename}"
    File.open(filename, 'w') { |file| file.puts queue_table_format(data) }
    Messages.queue_html_created(filename)
  end

  def queue_table_format(data)
    template = File.read("form_export.erb")
    erb_template = ERB.new(template)
    table = erb_template.result(binding)
  end

  def attribute_exists?(data, attribute)
    get_queue_columns(data).include?(attribute) ? true : false
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
