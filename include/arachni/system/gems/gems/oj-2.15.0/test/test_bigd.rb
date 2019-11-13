#!/usr/bin/env ruby
# encoding: UTF-8

$VERBOSE = true

%w(lib ext test).each do |dir|
  $LOAD_PATH.unshift File.expand_path("../../#{dir}", __FILE__)
end

require 'rubygems' if RUBY_VERSION.start_with?('1.8.')

#require "minitest/spec"
require "minitest/autorun"
 
require "oj"
 
# Uncomment this line and test_big_decimal will fail
require "active_support/json"
 
# With ActiveSupport 4.0, neither of these settings affect BigDecimal#to_json,
# only BigDecimal#as_json
#
# ActiveSupport.encode_big_decimal_as_string = false
# ActiveSupport::JSON::Encoding.encode_big_decimal_as_string = false
 
describe Oj do
 
  # Options set by default in Rails 4.0 / Rabl
  def options
    {
      :bigdecimal_as_decimal=>true, # default = true
      :use_to_json=>true, # default = false
      :mode=>:compat, # default = object
      :time_format=>:ruby, # default = unix
    }
  end
 
  def test_big_decimal
    orig = BigDecimal.new("3.14159265359")
    puts "*** to_s: #{orig.to_s}"
    puts "*** to_json: #{orig.to_json}"
    puts "*** JSON.dump: #{JSON.dump(orig)}"
    json = Oj.dump(orig, options)
    puts "*** json: #{json}"
 
    value = Oj.load(json)
    puts "*** value: #{value.class}"
    assert_equal(value, orig)
 
    # by default, without active support
    # assert_equal("0.314159265359E1", json)
    # in Rails 4.1, with active support
    # assert_equal("3.14159265359", json)
  end
 
  # Floats are unaffected
  def test_float
    orig = 3.14159265359
    json = Oj.dump(orig, options)
    assert_equal("3.14159265359", json)
  end
 
end
