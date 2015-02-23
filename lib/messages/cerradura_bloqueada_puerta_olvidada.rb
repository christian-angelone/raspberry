class CerraduraBloqueadaPuertaOlvidada
  def message
    'Cerradura Bloqueada,Puerta Olvidada'
  end

  def == (msg)
    msg.instance_of?(self.class)
  end
end
