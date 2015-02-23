class State

  @@violada = false
  @@timeout = 0

  protected
  
  def violada?
    @@violada
  end

  def timeout?
    @@timeout > 10
  end

  def violada bool
    @@violada = bool
  end

  def add_to_timeout
    @@timeout += 1
  end

  def reset_timeout
    @@timeout = 0
  end

end
