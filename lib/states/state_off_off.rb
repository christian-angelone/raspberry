class StateOffOff < State

  def eval(state)
    method = "eval_#{state.class}"
    send method
  end

  def == (state)
    state.instance_of?(self.class)
  end

  def eval_StateOffOff
    CerraduraBloqueadaPuertaCerrada.new
  end

  def eval_StateOffOn
    violada true
    CerraduraBloqueadaPuertaViolada.new  
  end

  def eval_StateOnOff
    violada false
    reset_timeout
    CerraduraActivadaPuertaCerrada.new
  end

  def eval_StateOnOn
    violada false
    reset_timeout
    CerraduraActivadaPuertaAbierta.new
  end

end
