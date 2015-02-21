require 'states/state'
require 'messages/cerradura_bloqueada_puerta_violada'
require 'messages/cerradura_bloqueada_puerta_abierta'
require 'messages/cerradura_bloqueada_puerta_cerrada'
require 'messages/cerradura_activada_puerta_cerrada'
require 'messages/cerradura_activada_puerta_abierta'

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
    CerraduraBloquedaPuertaViolada.new  
  end

  def eval_StateOnOff
    violada false
    CerraduraActivadaPuertaCerrada.new
  end

  def eval_StateOnOn
    violada false
    CerraduraActivadaPuertaAbierta.new
  end

end
