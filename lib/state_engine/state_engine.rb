class StateEngine

  def initialize(state,keep)
    @actual_state = state
    @keep = keep
  end

  def change_to(state)
    @response = @actual_state.eval(state)
    @actual_state = state if @keep
    @response
  end
end
