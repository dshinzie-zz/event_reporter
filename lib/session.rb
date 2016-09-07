require_relative 'csv_manager'
require_relative 'help'
require_relative 'queue'
require_relative 'messages'
require 'sunlight/congress'
require 'erb'
require 'pry'

Sunlight::Congress.api_key = "e179a6973728c4dd3fb1204283aaccb5"

class Session

  attr_reader :manager, :queue, :help

  def initialize
    @manager = CSVManager.new
    @queue = Queue.new
    @help = Help.new
  end

  def execute_command(command)

    command, params = split_parameters(command)
    validate_commands(command, params)

    case command
    when "load"
      execute_load(params)
    when "find"
      execute_find(params)
    when "queue"
      execute_queue(params)
    when "help"
      execute_help(params)
    end
  end

  def split_parameters(input)
    output = input.split
    case
    when output.length == 1
      [output[0].downcase, nil]
    when output[0] == "help"
      [output[0], output[1..-1].join(" ")]
    when output.length == 2
      [output[0].downcase, [output[1].downcase]]
    when output[0] == "queue" && output.length > 2
      [output[0], [output[1..2].join(" "), output[3]]]
    when output[0] == "find"
      [output[0], [output[1], output[2..-1].join(" ")]]
    end
  end

  def validate_commands(command, params)
    valid_commands = ["load", "help", "queue", "find", "exit", "e", "quit", "q"]
    valid_queue = ["count", "clear", "print", "print by", "save to", "export html", "district"]

    if invalid_command?(command, valid_commands)
      Messages.invalid_command
    elsif command == "queue" && params.class == Array && invalid_command?(params.first, valid_queue)
      Messages.invalid_queue
    elsif command == "queue" && params.class == String && invalid_command?(params, valid_queue)
      Messages.invalid_queue
    else
      return command, params
    end
  end

  def invalid_command?(input, list)
    list.include?(input) ? false : true
  end

  def execute_find(params)
    attributes = params[0]
    criteria = params[1..-1].join.downcase
    find(manager.data, attributes, criteria)
  end

  def find(data, attribute, criteria)
    results = data.select { |data| data.send(attribute) == criteria }
    queue.queue_add(results)
  end

  def execute_queue(params)
    case params[0]
    when "count"
      queue.queue.nil? ? Messages.queue_empty : Messages.queue_count(queue.queue_count)
    when "clear"
      queue.queue_clear
    when "district"
      queue.queue_district
    when "print"
      queue.queue_print
    when "print by"
      queue.queue_print_by(params[1])
    when "save to"
      ""
    when "export html"
      ""
    end
  end

  def execute_load(filename)
    if filename.nil?
      filename = "./event_attendees.csv"
    end

    if File.exists?(filename)
      @manager.load_file(filename)
      Messages.file_loaded(filename)
    else
      Messages.file_missing
    end
  end

  def execute_help(params)
    if params.nil?
      Messages.help_full
    else
      help.help_display(params)
    end
  end

end
