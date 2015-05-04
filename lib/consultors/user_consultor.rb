require 'json'

class UserConsultor

  @@FILE = '/next_key_data/users.json'

  def self.all
    result='['
    unless(File.zero?(@@FILE))
      File.open(@@FILE, 'r') do |file|
        file.each_line do |line|
          result += "#{line},"
        end
        result = result[0...-1]
      end
    end
    result += ']'
  end

  def self.online_users
    users_status_file = '/next_key_data/online_users.json'
    result='['
    unless(File.zero?(users_status_file))
      File.open(users_status_file, 'r') do |file|
        file.each_line do |line|
          result += "#{line},"
        end
        result = result[0...-1]
      end
    end
    result += ']'
  end

  def self.authenticate(username,password)
    
    user_type = {'USER' => User.new(username,password),
                 'SUPERVISOR' => Supervisor.new(username,password),
                 'ADMIN' => Admin.new(username,password)}

    user = nil
    File.open(@@FILE, 'r') do |file| 
      file.each_line do |line|
        user_data = JSON.parse(line)
        if ("#{user_data["dni"]}@#{user_data["empresa"]}" == username and user_data["password"] == password)
          user = user_type[user_data["priviliges"]]
          user.empresa = user_data["empresa"]   
          user.area = user_data["area"]   
          return user
        end
      end
    end
    user
  end
end
