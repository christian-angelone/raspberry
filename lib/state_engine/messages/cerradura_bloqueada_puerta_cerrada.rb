class CerraduraBloqueadaPuertaCerrada
  def message
    'Cerradura Bloqueada,Puerta Cerrada'
  end

  def == (msg)
    msg.instance_of?(self.class)
  end
end
