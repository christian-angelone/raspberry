class CerraduraBloqueadaPuertaViolada
  def message
    'Cerradura Bloqueada,Puerta Violada'
  end

  def == (msg)
    msg.instance_of?(self.class)
  end
end
