#!/usr/bin/env ruby
# encoding: UTF-8

$VERBOSE = true

%w(lib ext test).each do |dir|
  $LOAD_PATH.unshift File.expand_path("../../#{dir}", __FILE__)
end

require 'rubygems' if RUBY_VERSION.start_with?('1.8.')
require 'oj'

Oj.mimic_JSON

#puts Oj.default_options

range = ("01".."12")

puts Oj.dump(range)
