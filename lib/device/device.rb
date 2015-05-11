class Device

  def initialize(an_ip,a_port: 161)

      @protocol = SNMP_Protocol.new(an_ip) #.3.3.0
      @nodes = [ '1.3.6.1.4.1.38783.3.3.0',
                 '1.3.6.1.4.1.38783.3.5.0',
                 '1.3.6.1.4.1.38783.3.1.0',
                 '1.3.6.1.4.1.38783.3.2.0',
                 '1.3.6.1.4.1.38783.3.7.0',
                 '1.3.6.1.4.1.38783.3.8.0',
                 '1.3.6.1.4.1.38783.3.9.0',
                 '1.3.6.1.4.1.38783.3.10.0',
                 '1.3.6.1.4.1.38783.3.11.0',
                 '1.3.6.1.4.1.38783.3.12.0'
               ]
  end 

  def state

   data = @protocol.fetch_all(@nodes)
   { :relay1 =>       data[0],
     :relay2 =>       data[1],
     :input1 =>       data[2],
     :input2 =>       data[3],
     :voltage1 =>     data[4],
     :voltage2 =>     data[5],
     :temperature1 => data[6],
     :temperature2 => data[7],
     :humidity1 =>    data[8],
     :humidity2 =>    data[9]
    }
    
  end

  def pulse
   # @protocol.set_to(@nodes[0],@protocol.class.to_integer32(1)) #3.4.0
    @protocol.set_to(@nodes[0],@protocol.class.to_integer32(1))
    sleep 8
    @protocol.set_to(@nodes[0],@protocol.class.to_integer32(0))
  end  

end
