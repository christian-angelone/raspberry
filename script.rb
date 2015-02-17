require 'snmp'
include SNMP

ip = '192.168.0.55'

SNMP::Manager.open(:host => ip) do |manager|

  response = manager.get(["1.3.6.1.4.1.38783.3.3.0", "1.3.6.1.4.1.38783.3.1.0"])
  response.each_varbind do |vb|

    puts "#{vb.name.to_s}  #{vb.value.to_s}  #{vb.value.asn1_type}"

  end
end

manager = Manager.new(:host => ip)
varbind = VarBind.new("1.3.6.1.4.1.38783.3.3.0", Integer32.new(ARGV[0]))
manager.set(varbind)
manager.close
