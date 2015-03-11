class DeviceActioner
  
  def initialize(a_protocol,node)
    @protocol = a_protocol
    @node = node
  end

  def pulse
    @protocol.set_to(@node,@protocol.class.to_integer32(1))
    sleep 5
    @protocol.set_to(@node,@protocol.class.to_integer32(0))
  end
end
