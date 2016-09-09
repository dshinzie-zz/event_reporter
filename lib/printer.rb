class Printer

  attr_reader :max_last,
              :max_first,
              :max_email,
              :max_zip,
              :max_city,
              :max_state,
              :max_street,
              :max_phone,
              :max_district,
              :printed

  def initialize(queue)
    @max_last = (queue.max_by { |attendee| attendee.last_name.length + 1 }).last_name.length
    @max_first = (queue.max_by { |attendee| attendee.first_name.length + 1 }).first_name.length
    @max_email = (queue.max_by { |attendee| attendee.email_address.length + 1 }).email_address.length
    @max_zip = (queue.max_by { |attendee| attendee.zipcode.length + 1 }).zipcode.length
    @max_city = (queue.max_by { |attendee| attendee.city.length + 1 }).city.length
    @max_state = (queue.max_by { |attendee| attendee.state.length + 1 }).state.length
    @max_street = (queue.max_by { |attendee| attendee.street.length + 1 }).street.length
    @max_phone = (queue.max_by { |attendee| attendee.homephone.length + 1 }).homephone.length
    @max_district = (queue.max_by { |attendee| attendee.district.length + 1 }).district.length
    @printed = false
  end

  def min_max_adjustment
    @max_last < "last name".length + 3 ? @max_last = "last name".length + 3 : @max_last += 3
    @max_first < "first name".length + 3 ? @max_first = "first name".length + 3 : @max_first += 3
    @max_email < "email address".length + 3 ? @max_email = "email address".length + 3 : @max_email += 3
    @max_zip < "zipcode".length + 3 ? @max_zip = "zip_name".length + 3 : @max_zip += 3
    @max_city < "city".length + 3 ? @max_city = "city".length + 3 : @max_city += 3
    @max_state < "state".length + 3 ? @max_state = "state".length + 3 : @max_state += 3
    @max_street < "street".length + 3 ? @max_street = "street".length + 3 : @max_street += 3
    @max_phone < "phone".length + 3 ? @max_phone = "phone".length + 3 : @max_phone += 3
    @max_district < "district".length + 3 ? @max_district = "district".length + 3 : @max_district += 3
  end

  def print_headers
    puts sprintf("%-#{@max_last}s %-#{@max_first}s %-#{@max_email}s %-#{@max_zip}s %-#{@max_city}s %-#{@max_state}s %-#{@max_street}s %-#{@max_phone}s %-#{@max_district}s", "last name", "first name", "email address", "zipcode", "city", "state", "street", "homephone", "district")
    puts ""

  end

  def print(queue, attribute = nil)
    if attribute.nil?
      print_continue_loop(queue)
      @printed = true
    else
      queue = queue.sort_by { |attendee| attendee.send(attribute) }
      print_continue_loop(queue)
      @printed = true
    end
  end

  def print_continue_loop(queue)
    queue.each_with_index do |attendee, index|
      print_data(attendee)
      if (index + 1) % 10 == 0
        puts "showing records #{index - 8} - #{index + 1} of #{queue.size}. Press enter to continue."
        gets
      end
    end
  end

  def print_data(attendee)
    puts sprintf("%-#{@max_last}s %-#{@max_first}s %-#{@max_email}s %-#{@max_zip}s %-#{@max_city}s %-#{@max_state}s %-#{@max_street}s %-#{@max_phone}s %-#{@max_district}s", attendee.last_name, attendee.first_name, attendee.email_address, attendee.zipcode, attendee.city, attendee.state, attendee.street, attendee.homephone, attendee.district)
  end
end
