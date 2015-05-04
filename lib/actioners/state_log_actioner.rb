class StateLogActioner

  def write(state)
    File.open('/next_key_data/state_log.json', 'a') { |file| file.puts(state) }
  end
end
