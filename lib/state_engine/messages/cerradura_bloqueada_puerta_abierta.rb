class CerraduraBloqueadaPuertaAbierta
  def message
    'Cerradura Bloqueada,Puerta Abierta'
  end

  def == (msg)
    msg.instance_of?(self.class)
  end
end
