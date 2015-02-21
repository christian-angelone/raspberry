class State

  @@violada = false

  protected
  
  def violada?
    @@violada
  end

  def violada bool
    @@violada = bool
  end

end
