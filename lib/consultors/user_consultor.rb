class UserConsultor

  def self.all
    IO.readlines("/next_key_data/users.csv")
  end

  def self.authenticate(username,password)
    
    user_type = {'USER' => User.new(username,password),
                 'SUPERVISOR' => Supervisor.new(username,password),
                 'ADMIN' => Admin.new(username,password)}

    result = nil
    File.open("/next_key_data/users.csv", 'r') do |file| 
      file.each_line do |line|
        user_data = line.split(',')
        if (user_data[0].eql? username and user_data[1].eql? password)
          result = user_type[user_data[2].delete("\n")]         
        end
      end
    end
    p result
    result
  end
  
end
