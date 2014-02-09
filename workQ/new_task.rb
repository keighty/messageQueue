#!/usr/bin/env ruby
# encoding: utf-8

require "bunny"

conn = Bunny.new
conn.start
channel = conn.create_channel
q = channel.queue("hello")

msg  = ARGV.empty? ? "Hello World!" : ARGV.join(" ")
q.publish(msg, :persistent => true)
puts " [x] Published #{msg}"

conn.close