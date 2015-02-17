class Engine

  def initialize(state,testing: false)
    @actual_state = state
    @testing = testing
  end

  def change_to(state)
    response =  @actual_state.eval(state)
    @actual_state = state unless @testing
    response
  end

end
