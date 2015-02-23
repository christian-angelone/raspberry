class CerraduraActivadaPuertaAbierta
  def message
    'Cerradura Activada,Puerta Abierta'
  end

  def == (msg)
    msg.instance_of?(self.class)
  end
end
