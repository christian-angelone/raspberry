require 'socket'

class NotifyActioner

  def initialize(a_destiny)
    @destiny = a_destiny
  end 

  def send(message)
    socket = TCPSocket.new @destiny[:ip], @destiny[:port]
    socket.puts(message)
    socket.close
  end

  def broadcast(message)
    address = "192.168.1.255"
    port = 3000
    socket = UDPSocket.open
    socket.setsockopt(Socket::SOL_SOCKET,Socket::SO_BROADCAST, true)
    socket.send(message,0,address,port)
    socket.close
  end
end   
