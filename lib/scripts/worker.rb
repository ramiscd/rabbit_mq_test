# Criando script para receber mensagem (Consumer)

# Import bunny
require 'bunny'

#criando a conexão
connection = Bunny.new
connection.start

# criando canal
channel = connection.create_channel

# Declarando a mesma fila para escutar as mensagens
queue = channel.queue('hello')

# Recebendo a mensagem da fila
# puts '[*] Esperando por mensagens. para sair aperte control+C'
# queue.subscribe(block: true) do | _delivery_info, _properties, body |
#     puts " [x] Recived #{body}"
# end

queue.subscribe(block: true) do | delivery_info , _properties, body |
    puts "[x] Received #{body}"
    #imitate some work

    sleep body.count('.').to_i
    puts ' [x] done'
end
