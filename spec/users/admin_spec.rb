require 'spec_helper'
require 'users/admin'

describe Admin do

  admin = Admin.new('admin_test','qwertyui')

  it 'should have priviliges to view states log' do
   expect(admin.priviliges['view_states_log']).to be true
  end

  it 'should have priviliges to crud users' do
    expect(admin.priviliges['crud_users']).to be true
  end

end
