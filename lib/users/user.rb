class User

  attr_accessor :empresa, :area, :state
  attr_reader :priviliges

  def initialize(a_username,a_password)
    @username = a_username
    @password = a_password

    @priviliges = Hash.new
    set_priviliges
  end

  def to_json
    data = {"username":@username,"password":@password,"empresa":@empresa,"area":@area}
    data.to_json
  end

  def are_you?(a_username,a_password)
  
     @username.eql?(a_username) and @password.eql?(a_password)
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
