require 'json'
require 'require_all'
require_all 'lib'

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

states = {
           ['0','0'] => StateOffOff.new,
           ['0','1'] => StateOffOn.new,
           ['1','0'] => StateOnOff.new,
           ['1','1'] => StateOnOn.new
         }

log_actioner = StateLogActioner.new
notifier = NotifyActioner.new(ip:'192.168.0.22',port:'7070')
snmp_protocol = SNMP_Protocol.new('192.168.0.55')

init_data = snmp_protocol.fetch_all(nodes)

engine = StateEngine.new(states[[init_data[2],init_data[0]]],keep: true)
result = nil

host_ip = Socket.ip_address_list.detect{|intf| intf.ipv4_private?}.ip_address

while(true)
data = snmp_protocol.fetch_all(nodes)

result_given = engine.change_to(states[[data[2],data[0]]])
p result_given.message

unless result_given == result

  result = result_given

  final_message = { host: host_ip,
                    date: Time.now.strftime("%d/%m/%Y %H:%M"),
                    status:  result.message,
                    digital_input1: data[0],
                    digital_input2: data[1],
                    relay1: data[2],
                    relay2: data[3],
                    voltage1: data[4],
                    voltage2: data[5],
                    temperature1: data[6],
                    temperature2: data[7],
                    humidity1: data[8],
                    humidity2: data[9]
                 }
  
  log_actioner.write(final_message.to_json)
  notifier.send(final_message.to_json)
end
sleep 1
end
