require './lib/district'
require 'minitest/autorun'
require 'minitest/pride'

class DistrictTest < Minitest::Test

  def test_district_initialized_with_empty_hash
    d = District.new

    assert d.districts.empty?
  end

  def test_url_exists
    d = District.new

    refute d.url.nil?
  end

  def test_api_key_exists
    d = District.new

    refute d.key.nil?
  end

  def test_url_is_built_with_paramters
    d = District.new
    params = "districts/locate/?zip="
    d.get_api_response(d.url, params, '80113', d.key)

    assert d.new_url.include?(params)
    assert d.new_url.include?('80113')
    assert d.new_url.include?(d.key)
  end

  def test_api_gets_response
    d = District.new
    params = 'districts/locate/?zip='

    refute d.get_api_response(d.url, params, '80113', d.key).nil?
  end

  def test_api_response_contains_district
    d = District.new
    params = "districts/locate/?zip="
    results = d.get_api_response(d.url, params, '80113', d.key)
    flat = d.flattened_response(results)

    refute flat.first["district"].nil?
  end

  def test_all_api_responses_contains_district
    d = District.new
    params = "districts/locate/?zip="
    results = d.get_api_response(d.url, params, '80113', d.key)
    flat = d.flattened_response(results)

    flat.each { |e| refute e["district"].nil? }
  end

  def test_hash_is_populated
    d = District.new
    params = "districts/locate/?zip="
    results = d.get_api_response(d.url, params, '80113', d.key)
    flat = d.flattened_response(results)
    d.add_district_to_hash(flat, d.districts, '80113')

    refute d.districts.empty?

  end

  def test_hash_contains_zipcodes
    d = District.new
    params = "districts/locate/?zip="
    results = d.get_api_response(d.url, params, '80113', d.key)
    flat = d.flattened_response(results)
    d.add_district_to_hash(flat, d.districts, '80113')

    assert d.districts.keys.include?('80113')
  end

  def test_hash_contains_values_for_zipcode_keys
    d = District.new
    params = "districts/locate/?zip="
    results = d.get_api_response(d.url, params, '80113', d.key)
    flat = d.flattened_response(results)
    d.add_district_to_hash(flat, d.districts,'80113')

    refute d.districts['80113'].nil?
  end

end
