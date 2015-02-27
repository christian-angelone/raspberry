require 'spec_helper'
require 'require_all'
require_all 'lib/users'

describe User do 

  user = User.new('test_user','12345678')

  it 'should have no priviliges' do

    expect(user.priviliges['crud_users']).to be false
    expect(user.priviliges['view_states_log']).to be false
  end
  
end
