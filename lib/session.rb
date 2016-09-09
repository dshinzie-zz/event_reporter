require './lib/csv_manager'
require './lib/help'
require './lib/queue_manager'
require './lib/messages'

class Session

  attr_reader :manager, :qm, :help, :export, :com, :para

  def initialize
    @manager = CSVManager.new
    @qm = QueueManager.new
    @help = Help.new
  end

  def execute_command(command)

    command, params = split_parameters(command)
    @com, @para = command, params
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
      [output[0].downcase, output[1..-1].join(" ")]
    when output.length == 2
      [output[0].downcase, [output[1].downcase]]
    when output[0] == "queue" && output.length > 2
      [output[0].downcase, [output[1..2].join(" "), output[3]]]
    when output[0] == "find"
      [output[0].downcase, [output[1], output[2..-1].join(" ")]]
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

  def execute_queue(params)
    case params[0]
    when "count"
      qm.queue.empty? ? Messages.queue_empty : Messages.queue_count(qm.queue_count)
    when "clear"
      qm.queue_clear
    when "district"
      qm.queue_district(qm.queue)
    when "print", "print by"
      qm.queue.empty? ? Messages.queue_empty : qm.queue_print(params[1])
    when "save to"
      manager.save_file(params[1], qm.queue)
    when "export html"
      qm.queue_export(params[1], qm.queue)
    end
  end

  def execute_find(params)
    attributes = params[0]
    criteria = params[1..-1].join.downcase

    if qm.attribute_exists?(manager.data, attributes)
      find(manager.data, attributes, criteria)
    else
      Messages.find_wrong_attribute(attributes)
    end
  end

  def find(data, attribute, criteria)
    results = data.select { |data| data.send(attribute) == criteria }
    qm.queue_add(results)
  end

  def execute_load(input_filename)
    filename = get_filename(input_filename)

    if File.exists?(filename)
      @manager.load_file(filename)
      Messages.file_loaded(filename)
    else
      Messages.file_missing(filename)
    end
  end

  def get_filename(filename)
    if filename.nil?
      filename = "./event_attendees.csv"
    else
      filename = "./" + filename.join
    end
    filename
  end

  def execute_help(params)
    if params.nil?
      Messages.help_full
    else
      help.help_display(params)
    end
  end

end
