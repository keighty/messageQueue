#!/usr/bin/env ruby
# encoding: utf-8

require "bunny"

conn = Bunny.new(:automatically_recover => false)
conn.start
channel = conn.create_channel
q = channel.queue("hello")

q.subscribe(:ack => true, :block => true) do |delivery_info, properties, body|
  puts " [x] Received #{body}"
  # imitate some work
  sleep body.count(".").to_i
  puts " [x] Done"

  channel.ack(delivery_info.delivery_tag)
end