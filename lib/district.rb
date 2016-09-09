require 'net/http'
require 'json'

class District

  attr_reader :districts, :url, :new_url, :key, :zipcode, :flat

  def initialize
    @districts = Hash.new{ |hsh,key| hsh[key] = [] }
    @url = "https://congress.api.sunlightfoundation.com/"
    @key = "e179a6973728c4dd3fb1204283aaccb5"
  end

  def get_district(data)
      params = "districts/locate/?zip="

      data.each do |attendee|
        response = get_api_response(@url, params, attendee.zipcode, @key)
        flat = flattened_response(response)
        add_district_to_hash(flat, @districts, attendee.zipcode)
      end
  end

  def get_api_response(url, params, zipcode, key)
    @new_url = url + params + zipcode + "&apikey=#{key}"
    uri = URI(new_url)
    response = Net::HTTP.get(uri)
    JSON.parse(response)
  end

  def flattened_response(input)
    flatten = input.values.flatten
    flatten.pop(1)
    @flat = flatten
  end

  def add_district_to_hash(input, hash, zipcode)
    input.each do |e|
      if hash[zipcode.to_s].empty?
        hash[zipcode.to_s] = [e["district"]]
      else
        hash[zipcode.to_s] << e["district"]
      end
      hash[zipcode.to_s].uniq!
    end
  end
end
