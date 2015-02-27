require 'spec_helper'
require 'users/supervisor'

describe Supervisor do

  supervisor = Supervisor.new('supervisor_test','87654321')

  it 'should only have priviliges for view states log' do
    
    expect(supervisor.priviliges['crud_users']).to be false
    expect(supervisor.priviliges['view_states_log']).to be true

  end
end
