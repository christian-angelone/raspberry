require 'spec_helper'
require 'engine'
require 'states/state_off_off'
require 'states/state_off_on'
require 'states/state_on_off'
require 'states/state_on_on'

describe 'Engine Scenarios' do

  describe 'off_off to off_on to off_on' do
    it 'it should notify> Cerradura Bloqueda,Puerta Violada' do
      init_state = StateOffOff.new
      engine = Engine.new(init_state)
    end
  end
end
