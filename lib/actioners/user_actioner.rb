class UserActioner

  def write(state)
    File.open('/next_key_data/users.csv', 'a') { |file| file.puts(state) }
  end

end
