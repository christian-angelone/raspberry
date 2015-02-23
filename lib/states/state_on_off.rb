class StateOnOff < State
  def eval(state)
    method = "eval_#{state.class}"
    send method
  end

  def == (state)
    state.instance_of?(self.class)
  end

  def eval_StateOffOff
    violada false
    reset_timeout
    CerraduraBloqueadaPuertaCerrada.new
  end

  def eval_StateOffOn
    violada false
    reset_timeout
    CerraduraBloqueadaPuertaAbierta.new
  end

  def eval_StateOnOff 
   CerraduraActivadaPuertaCerrada.new
  end

  def eval_StateOnOn
    violada false
    reset_timeout
    CerraduraActivadaPuertaAbierta.new
  end
end
