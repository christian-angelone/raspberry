class Device

  def initialize(an_ip,a_port: 161)

      @protocol = SNMP_Protocol.new(an_ip, a_port)
      @nodes = { :relay1 =>       {:id => '1.3.6.1.4.1.38783.3.3.0',  :value => nil},
                 :relay2 =>       {:id => '1.3.6.1.4.1.38783.3.5.0',  :value => nil},
                 :input1 =>       {:id => '1.3.6.1.4.1.38783.3.1.0',  :value => nil},
                 :input2 =>       {:id => '1.3.6.1.4.1.38783.3.2.0',  :value => nil},
                 :voltage1 =>     {:id => '1.3.6.1.4.1.38783.3.7.0',  :value => nil},
                 :voltage2 =>     {:id => '1.3.6.1.4.1.38783.3.8.0',  :value => nil},
                 :temperature1 => {:id => '1.3.6.1.4.1.38783.3.9.0',  :value => nil},
                 :temperature2 => {:id => '1.3.6.1.4.1.38783.3.10.0', :value => nil},
                 :humidity1 =>    {:id => '1.3.6.1.4.1.38783.3.11.0', :value => nil},
                 :humidity2 =>    {:id => '1.3.6.1.4.1.38783.3.12.0', :value => nil}
               }
      
  end  


  private
  def init_values

    #@nodes.each    

  end

end
