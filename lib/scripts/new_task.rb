require 'bunny'

# Conectando ao servidor RabbitMQ
connection = Bunny.new(automatically_recover: false)
connection.start

# Criando um canal
channel = connection.create_channel

# Declarando uma fila
queue = channel.queue('task_queue', durable: true)

# Enviando mensagem para fila
message = ARGV.empty? ? 'Hello World!' : ARGV.join(' ')

queue.publish(message, persistent: true)
puts "[x] Send #{message}"

# Fechando a conexão
connection.close
