# Criando script para receber mensagem (Consumer)

# Import bunny
require 'bunny'

#criando a conexão
connection = Bunny.new(automatically_recover: false)
connection.start

# criando canal
channel = connection.create_channel

# Declarando a mesma fila para escutar as mensagens
queue = channel.queue('task_queue', durable: true)

channel.prefetch(1)
puts " [*] Weating for messages. press control+C to exit"

begin
    queue.subscribe(manual_ack: true, block: true) do | delivery_info , _properties, body |
        puts "[x] Received #{body}"
        #imitate some work
        sleep body.count('.').to_i
        puts ' [x] done'
        channel.ack(delivery_info.delivery_tag)
    end
rescue Interrupt =>_
    connection.close
end