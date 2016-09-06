require_relative 'csv_manager'
require_relative 'help'
require_relative 'queue'
require_relative 'messages'
require 'pry'

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
      execute_queue(params[0])
    when "help"
      "come back"
    end
  end

  def split_parameters(input)
    if input.split.length == 1
      [input.split[0].downcase, nil]
    else
      [input.split[0].downcase, input.split[1..-1]]
    end
  end

  def validate_commands(command, params)
    valid_commands = ["load", "help", "queue", "find", "exit", "e", "quit", "q"]
    valid_queue = ["count", "clear", "print", "print by", "save to"]

    if !valid_commands.include?(command)
      Messages.invalid_command
    elsif command == "queue" && !valid_queue.include?(params[0])
      Messages.invalid_queue
    else
      return command, params
    end
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
    case params
    when "count"
      queue.queue.nil? ? Messages.queue_empty : Messages.queue_count(queue.queue_count)
    when "clear"
      queue.queue_clear
    when "distict"
      ""
    when "print"
      queue.queue_print
    when "print by"
      ""
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

end
