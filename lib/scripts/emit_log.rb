require 'bunny'

connection = Bunny.new
connection.start

channel = connection.create_channel
exchange = channel.fanout('logs')

message = ARGV.empty? ? 'Hello World' : ARGV.join('  ')

exchange.publish(message)
puts " [X] Sent #{message}"

connection.close