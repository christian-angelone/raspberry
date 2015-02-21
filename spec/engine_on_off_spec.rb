describe Engine do

  context 'StateOnOff being the actual state' do

    init_state = StateOnOff.new
    engine = Engine.new(init_state)
    p engine

    describe 'changes to StateOffOff' do

      it 'should notify> Cerradura Bloqueada,Puerta Cerrada' do
        off_off = StateOffOff.new
        response = engine.change_to(off_off)
        expected_response = 'Cerradura Bloqueada,Puerta Cerrada'
        expect(response).to eq expected_response
      end
    end

    describe 'changes to StateOffOn' do

      it 'should notify> Cerradura Bloqueada,Puerta Abierta' do
        off_on = StateOffOn.new
        response = engine.change_to(off_on)
        expected_response = 'Cerradura Bloqueada,Puerta Abierta'
        expect(response).to eq expected_response
      end
    end

    describe 'changes to StateOnOff' do

      it 'should notify> Cerradura Activada,Puerta Cerrada' do
        on_off = StateOnOff.new
        response = engine.change_to(on_off)
        expected_response = 'Cerradura Activada,Puerta Cerrada'
        expect(response).to eq expected_response
      end
    end

    describe 'changes to StateOnOn' do

      it 'should notify> Cerradura Activada,Puerta Abierta' do
        on_on = StateOnOn.new
        response = engine.change_to(on_on)
        expected_response = 'Cerradura Activada,Puerta Abierta'
        expect(response).to eq expected_response
      end
    end
  end
end
