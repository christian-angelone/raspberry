require 'socket'
require 'snmp'
require 'require_all'
require_all 'lib'

include SNMP

ip = '192.168.0.55'
init_data = Array.new
main_node = '1.3.6.1.4.1.38783.'

nodes = [main_node + '3.1.0',
         main_node + '3.2.0',
         main_node + '3.3.0',
         main_node + '3.5.0',
         main_node + '3.7.0',
         main_node + '3.8.0',
         main_node + '3.9.0',
         main_node + '3.10.0',
         main_node + '3.11.0',
         main_node + '3.12.0']

SNMP::Manager.open(:host => ip) do |manager|

  response = manager.get(nodes)

  response.each_varbind do |vb|

     init_data << vb.value.to_s

   end
end

states = {
           ['0','0'] => StateOffOff.new,
           ['0','1'] => StateOffOn.new,
           ['1','0'] => StateOnOff.new,
           ['1','1'] => StateOnOn.new
         }

engine = Engine.new(states[[init_data[2],init_data[0]]],keep: true)
result = nil

host_ip = Socket.ip_address_list.detect{|intf| intf.ipv4_private?}.ip_address

while(true)
data = Array.new
SNMP::Manager.open(:host => ip) do |manager|

  response = manager.get(nodes)

  response.each_varbind do |vb|

     data << vb.value.to_s

   end
end

result_given = engine.change_to(states[[data[2],data[0]]])
p result_given.message

unless result_given == result

  result = result_given

  final_message = host_ip + ',' + Time.now.strftime("%d/%m/%Y %H:%M") + ',' +  result.message + ',' +
            data[0] + ',' +
            data[1] + ',' +
            data[2] + ',' +
            data[3] + ',' +
            data[4] + ',' +
            data[5] + ',' +
            data[6] + ',' + data[7] + ',' + data[8] + ',' + data[9]   

  File.open('/next_key_data/state_log.csv', 'a') { |file| file.puts(final_message) }

  socket = TCPSocket.new '192.168.0.14', 7070
  socket.puts(final_message)
  socket.close
end
sleep 1
end
