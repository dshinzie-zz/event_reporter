require_relative 'Messages'
require 'pry'

class Help

  def help_display(params)
    case params
    when "load"
      Messages.help_load
    when "find"
      Messages.help_find
    when "queue"
      Messages.help_queue
    when "queue count"
      Messages.help_queue_count
    when "queue clear"
      Messages.help_queue_clear
    when "queue print"
      Messages.help_queue_print
    when "queue print by"
      Messages.help_queue_print_by
    when "queue district"
      Messages.help_queue_district
    when "queue save to"
      Messages.help_queue_save_to
    when "queue export html"
      Messages.help_queue_export_html
    end
  end

end
