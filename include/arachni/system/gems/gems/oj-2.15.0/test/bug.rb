#!/usr/bin/env ruby
# encoding: UTF-8

$: << File.dirname(__FILE__)

require 'helper'

require 'oj'
require 'securerandom'

class Handler
  def hash_start()      {} end
  def hash_set(h,k,v)   h.store(k,v) end
  def array_start()     [] end
  def array_append(a,v) a << v end
  def error(message, line, column)
    raise Exception.new(message, line, column)
  end
end

json = Oj.dump({"this"=>"object"})

if true
  name = "/tmp/#{SecureRandom.uuid}"
  `mkfifo #{name}`
  if fork
    open(name, 'r+') do |read_io|
      p "start reading #{read_io.stat.ftype}"
      Oj.sc_parse(Handler.new, read_io) {|v| p v}
      p "stop reading"
    end
  else
    open(name, 'w+') do |write_io|
      p "start writing #{write_io.stat.ftype}  autoclose: #{write_io.autoclose?}"
      write_io.write json
      write_io.write json
      p "stop writing"
    end
    sleep(1) # make it obvious that there are two threads
    open(name, 'w+') do |write_io|
      p "start writing #{write_io.stat.ftype}"
      write_io.write json
      write_io.write json
      p "stop writing"
    end
  end
else
  IO.pipe do |read_io, write_io|
    if fork
      write_io.close
      p "start reading #{read_io.stat.ftype}"
      Oj.sc_parse(Handler.new, read_io) {|v| p v}
      p "stop reading"
      read_io.close
    else
      read_io.close
      p "start writing #{write_io.stat.ftype}"
      write_io.write json
      write_io.write json
      p "stop writing"
      write_io.close
    end
  end
end
