class CerraduraActivadaPuertaCerrada
  def message
    'Cerradura Activada,Puerta Cerrada'
  end

  def == (msg)
    msg.instance_of?(self.class)
  end
end
