require 'rubygems'
require 'terminal-table/import'

module Messages
  def self.display_welcome
    puts "\n" + "Welcome to Event Reporter!" + "\n"
  end

  def self.display_instructions
    puts "\n" + "Enter load <filename>, help <command>, queue <command> or find <attribute><criteria>." + "\n"
  end

  def self.display_intro
    display_welcome
    display_instructions
  end

  def self.display_exit
    puts "\n" + "Goodbye! :)" + "\n"
  end

  def self.request_command
    print " > "
  end

  def self.file_loaded(filename)
    puts "File #{filename} loaded."
  end

  def self.file_missing(filename)
    puts "File #{filename} does not exist."
  end

  def self.file_saved(filename)
    puts "File #{filename} saved."
  end

  def self.queue_empty
    puts "Records in queue: 0. Please use Load / Find."
  end

  def self.queue_count(input)
    puts "Records in queue: #{input}"
  end

  def self.queue_cleared
    puts "Queue has been cleared."
  end

  def self.queue_added
    puts "Queue updated."
  end

  def self.invalid_command
    puts "Invalid command."
  end

  def self.invalid_queue
    puts "Invalid queue command."
  end

  def self.queue_count_over_ten
    puts "Queue count must be under 10 for Sunlight API districts."
  end

  def self.queue_district_ran
    puts "Queue updated with Sunlight API districts."
  end

  def self.queue_html_created(input)
    puts "HTML file created: #{input}"
  end

  def self.find_wrong_attribute(attribute)
    puts "Wrong or missing attribute: #{attribute}"
  end

  def self.help_full
    table = Terminal::Table.new do |t|
      t.title = 'Event Reporter Commands'
      t.headings = 'Command', 'Description'
      t.style = {:width => 150}
      t << ['load <filename.csv>', 'Load .csv file to system']
      t << ['find <attribute> <criteria>', 'Populate queue matching criteria']
      t << ['qeueu count', 'Populate queue matching criteria']
      t << ['qeueu clear', 'Empty current queue']
      t << ['qeueu district', 'Something']
      t << ['qeueu print', 'Display queue data']
      t << ['qeueu print by', 'Display qeueu data by criteria']
      t << ['qeueu save to <filename.csv>', 'Save queue to .csv file']
      t << ['qeueu export html <filename.csv>', 'Export queue to .html file']
    end

    puts table
  end

  def self.help_load
    table = Terminal::Table.new do |t|
      t.headings = 'Item', 'Description'
      t.style = {:width => 150}
      t << ['load <filename.csv>', "Load data from a csv file into the system.\nIf no file is given, filename is defaulted to './event_attendees.csv'"]
      t << ['Example', 'Load example_file.csv']
    end

    puts table
  end

  def self.help_find
    table = Terminal::Table.new do |t|
      t.headings = 'Item', 'Description'
      t.style = {:width => 150}
      t << ['find <attribute> <criteria>', "Search within the recent load data that matches specific criteria.\n<attribute> is the column name, <criteria> is the desired matching data."]
      t << ['Example', 'find first_name john']
    end

    puts table
  end

  def self.help_queue
    table = Terminal::Table.new do |t|
      t.headings = 'Item', 'Description'
      t.style = {:width => 150}
      t << ['queue', "Use Queue to find information about the most recent Find results.\nRequires an additional queue command."]
      t << ['queue commands', 'count, clear, print, print by <attribute>, save to <filename.csv>, district, export html <filename.csv>']
      t << ['Example', 'queue count']
      t << ['Example', 'queue print by first_name']
    end

    puts table
  end

  def self.help_queue_count
    table = Terminal::Table.new do |t|
      t.headings = 'Item', 'Description'
      t.style = {:width => 150}
      t << ['queue count', "Returns the number of records in the current queue."]
      t << ['Example', 'queue count']
    end

    puts table
  end

  def self.help_queue_clear
    table = Terminal::Table.new do |t|
      t.headings = 'Item', 'Description'
      t.style = {:width => 150}
      t << ['queue clear', "Empties the current queue.\nMust use Find command to repopulate queueu."]
      t << ['Example', 'queue clear']
    end

    puts table
  end

  def self.help_queue_district
    table = Terminal::Table.new do |t|
      t.headings = 'Item', 'Description'
      t.style = {:width => 150}
      t << ['queue district', "Returns info if less than 10 records."]
      t << ['Example', 'queue district']
    end

    puts table
  end

  def self.help_queue_print
    table = Terminal::Table.new do |t|
      t.headings = 'Item', 'Description'
      t.style = {:width => 150}
      t << ['queue print', "Prints all the data in the queue."]
      t << ['Example', 'queue print']
    end

    puts table
  end

  def self.help_queue_print_by
    table = Terminal::Table.new do |t|
      t.headings = 'Item', 'Description'
      t.style = {:width => 150}
      t << ['queue print by <attribute>', "Prints all the data in the queue by a specific attribute."]
      t << ['Example', 'queue print by first_name']
    end

    puts table
  end

  def self.help_queue_save_to
    table = Terminal::Table.new do |t|
      t.headings = 'Item', 'Description'
      t.style = {:width => 150}
      t << ['queue save to <filename.csv>', "Saves the data in the current queue to a .csv file"]
      t << ['Example', "queue save to './example.csv'"]
    end

    puts table
  end

  def self.help_queue_export_html
    table = Terminal::Table.new do |t|
      t.headings = 'Item', 'Description'
      t.style = {:width => 150}
      t << ['export html <filename.csv>', "Exports the data in the current queue to an .html file"]
      t << ['Example', "queue export html './example.csv'"]
    end

    puts table
  end
end
