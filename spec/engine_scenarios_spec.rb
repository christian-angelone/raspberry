require 'spec_helper'
require 'engine'
require 'states/state_off_off'
require 'states/state_off_on'
require 'states/state_on_off'
require 'states/state_on_on'

describe 'Engine Scenario' do

  describe 'puerta olvidada' do
    it 'it should notify> Cerradura Bloqueada,Puerta Olvidada' do
      init_state = StateOffOn.new
      engine = Engine.new(init_state,keep: true)
      20.times do
        @response = engine.change_to(init_state)
      end
      expect(@response.message).to eq('Cerradura Bloqueada,Puerta Olvidada')
    end
  end
end
