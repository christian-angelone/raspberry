class DeviceActioner
  
  def initialize(a_protocol)
    @protocol = a_protocol
  end

  def pulse_to(node)
    @protocol.set_to(node,@protocol.class.to_integer32(1))
    sleep 5
    @protocol.set_to(node,@protocol.class.to_integer32(0))
  end
end
