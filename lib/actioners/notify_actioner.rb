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
end   
