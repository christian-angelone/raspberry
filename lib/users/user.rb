class User

  attr_accessor :username, :password
  attr_reader :priviliges

  def initialize(a_username,a_password)
    @username = a_username
    @password = a_password

    @priviliges = Hash.new
    set_priviliges
  end

  private
  def set_priviliges
    crud_users
    view_states_log
  end

  protected

  def crud_users
    @priviliges['crud_users'] = false
  end

  def view_states_log
    @priviliges['view_states_log'] = false 
  end
end
