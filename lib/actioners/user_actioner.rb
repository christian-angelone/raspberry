class UserActioner

  def self.register(user)
    File.open('/next_key_data/users.json', 'a') { |file| file.puts(user) }
  end

	def self.update_state(user_dni,state)
    File.open('/next_key_data/users.json', 'r+') do |file|
      file.each_line do |line|
        if line.include?(user_dni)
          line_to_update = JSON.parse(line)
          line_to_update["state"] = state
          file.seek(-line.length, IO::SEEK_CUR)
          file.write(line_to_update.to_json)
        end
      end
    end
  end
end
