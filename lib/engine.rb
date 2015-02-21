class Engine

  def initialize(state,keep: false)
    @actual_state = state
    @keep = keep
  end

  def change_to(state)
    @response = @actual_state.eval(state)
    @actual_state = state if @keep
    @response
  end
end
