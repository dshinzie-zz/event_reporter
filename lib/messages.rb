module Messages

  # Display messages
  def self.display_welcome
    puts "Welcome to Event Reporter."
  end

  def self.display_instructions
    puts "Enter load <filename>, help <command>, queue <command> or find <attribute><criteria>."
  end

  def self.display_intro
    display_welcome
    display_instructions
  end

  def self.display_exit
    puts "Goodbye."
  end

  def self.request_command
    print " > "
  end

  def self.file_loaded(filename)
    puts "Loaded #{filename}."
  end

  def self.file_missing
    puts "File #{filename} does not exist."
  end

  def self.queue_empty
    puts "Records in queue: 0. Please use Find."
  end

  def self.queue_count(input)
    puts "Records in queue: #{input}."
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


  # Help Messages
end
