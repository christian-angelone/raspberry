class UserActioner

  def self.register(user)
    File.open('/next_key_data/users.json', 'a') { |file| file.puts(user) }
  end

  def self.set_online(user,ip)
    File.open('/next_key_data/online_users.json', 'w') { |file| file.puts("{\"user\":\"#{user}\",\"ip\":\"#{ip}\"}") }
  end

end
