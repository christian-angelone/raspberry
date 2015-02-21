require 'snmp'
include SNMP

ip = '192.168.0.55'
data = Array.new
main_node = '1.3.6.1.4.1.38783.'
SNMP::Manager.open(:host => ip) do |manager|

  response = manager.get([main_node + '3.1.0',
                          main_node + '3.2.0',
                          main_node + '3.3.0',
                          main_node + '3.5.0',
                          main_node + '3.7.0',
                          main_node + '3.8.0',
                          main_node + '3.9.0',
                          main_node + '3.10.0',
                          main_node + '3.11.0',
                          main_node + '3.12.0' ])
 
  response.each_varbind do |vb|

     data << vb.value.to_s

   end
end

p "input1: #{data[0]}"
p "input2: #{data[1]}"
p "relay1: #{data[2]}"
p "relay2: #{data[3]}"
p "voltage1: #{data[4]}"
p "voltage2: #{data[5]}"
p "temp1: #{data[6]}"
p "temp2: #{data[7]}"
p "humidity1: #{data[8]}"
p "humidity2: #{data[9]}"
