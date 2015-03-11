require 'snmp'

class SNMP_Protocol
  
  include SNMP

  def self.to_octect_string(string)
    OctetString.new(string)
  end

  def self.to_integer32(integer)
    Integer32.new(integer)
  end

  def initialize(an_ip,a_port: 161)
    @ip = an_ip
    @port = a_port
  end

  def set_to(this_node,this_value)
    manager = Manager.new(:host => @ip)
    varbind = VarBind.new(this_node,this_value)
    manager.set(varbind)
    manager.close
  end

  def fetch_all(these_nodes)
    result = []
    SNMP::Manager.open(:host => @ip) do |fetching|
    
      response = fetching.get(these_nodes)
      response.each_varbind do |vb|
        result << vb.value.to_s
      end
    end
    result
  end 
end
