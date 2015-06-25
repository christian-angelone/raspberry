require 'json'
#require 'require_all'
#require_all 'lib'

states = {
           ['0','0'] => StateOffOff.new,
           ['0','1'] => StateOffOn.new,
           ['1','0'] => StateOnOff.new,
           ['1','1'] => StateOnOn.new
         }

log_actioner = StateLogActioner.new
notifier = NotifyActioner.new(ip:'192.168.0.247',port:'7070')

device = Device.new('192.168.1.181')

begin
	@initial_state = device.state
rescue
	retry
end

engine = StateEngine.new(states[[@initial_state[:relay1],@initial_state[:input1]]],keep: true)
result = nil

host_ip = Socket.ip_address_list.detect{|intf| intf.ipv4_private?}.ip_address

iterations = 0
while(true)
iterations += 1
begin
	@actual_state = device.state
rescue
	retry
end
result_given = engine.change_to(states[[@actual_state[:relay1],@actual_state[:input1]]])
p result_given.message + "(#{iterations})"

unless result_given == result

  result = result_given

  final_message = { host: host_ip,
                    date: Time.now.strftime("%d/%m/%Y %H:%M"),
                    status:  result.message,
                  }.merge(@actual_state)
  
  log_actioner.write(final_message.to_json)
 # notifier.send(final_message.to_json)
  notifier.broadcast(final_message.to_json)  
end
sleep 0.5
end
