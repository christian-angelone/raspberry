class StateOffOn
  def eval(state)
    method = "eval_#{state.class}"
    send method
  end

  def eval_StateOffOff
    'Cerradura Bloqueada,Puerta Cerrada'
  end

  def eval_StateOffOn
    'No esta Definido'
  end

  def eval_StateOnOff
    'Cerradura Activada,Puerta Cerrada'
  end

  def eval_StateOnOn
    'Cerradura Activada,Puerta Abierta'
  end
end
