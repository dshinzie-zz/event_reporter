require './lib/cli'
require 'minitest/autorun'
require 'minitest/pride'

class CLITest < Minitest::Test


  def test_command_is_downcased
    cli = CLI.new

    assert_equal ["load", ["test"]], cli.split_parameters(["LOAD", "test"])
    assert_equal ["wallowallo", ["test"]], cli.split_parameters(["WalloWallo", "test"])
  end

  def test_multiple_params_grouped
    cli = CLI.new

    assert_equal ["load", ["'./event_attendees.csv'"]], cli.split_parameters(["Load", "'./event_attendees.csv'"])
    assert_equal ["help", ['']], cli.split_parameters(["Help", ''])
    assert_equal ["help", ["Queue", "Clear"]], cli.split_parameters(["Help", "Queue", "Clear"])
  end

end
