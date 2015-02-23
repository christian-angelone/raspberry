class StateOffOn < State
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
    if violada? 
      return CerraduraBloqueadaPuertaViolada.new
    else
      if timeout?
        return CerraduraBloqueadaPuertaOlvidada.new
      else
        add_to_timeout
        return CerraduraBloqueadaPuertaAbierta.new
      end
    end
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
