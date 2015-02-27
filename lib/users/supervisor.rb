class Supervisor < User

  def initialize(a_username,a_password)
    super(a_username,a_password)
  end

  def crud_users
    @priviliges['crud_users'] = false
  end

  def view_states_log
    @priviliges['view_states_log'] = true
  end

end
