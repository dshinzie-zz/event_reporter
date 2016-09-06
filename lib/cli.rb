require_relative 'messages'
require_relative 'session'
require 'pry'


class CLI
  attr_reader :session, :command

  EXIT_COMMANDS = ["q", "quit", "exit", "e"]

  def initialize
    @session = Session.new
    @command = ""
  end

  def prompt_user
    Messages.request_command
    @input = gets.strip.downcase
  end

  def execute
    Messages.display_intro
    until EXIT_COMMANDS.include?(command)
      @command = prompt_user
      session.execute_command(command)
    end
    Messages.display_exit
  end
end

c = CLI.new
c.execute
