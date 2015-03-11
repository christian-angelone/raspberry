class StateLogActioner

  def write(state)
    File.open('/next_key_data/state_log.csv', 'a') { |file| file.puts(state) }
  end
end
