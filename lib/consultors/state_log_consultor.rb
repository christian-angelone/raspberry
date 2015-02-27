class StateLogConsultor

  @@FILE = '/next_key_data/state_log.csv'  

  def self.all
    IO.readlines(@@FILE)
  end

  def self.last
    state_log = IO.readlines(@@FILE)
    state_log.last
  end
end
