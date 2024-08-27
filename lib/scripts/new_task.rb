#criando script para enviar mensagem (producer)

#import do banny
require 'bunny'

# Conectando ao servidor RabbitMQ
connection = Bunny.new
connection.start

# Criando um canal
channel = connection.create_channel

# Declarando uma fila
queue = channel.queue("hello")

# Enviando mensagem para fila
message = ARGV.empty? ? 'Hello World!' : ARGV.join(' ')

queue.publish(message, persistent: true)
puts "[x] Send #{message}"
# channel.default_exchange.publish("Hello World!", routing_key: queue.name)
# puts "[x] Sent 'Hello World!'"

# Fechando a conexão
connection.close
