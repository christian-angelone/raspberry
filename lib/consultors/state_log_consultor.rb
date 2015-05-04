class StateLogConsultor

  @@FILE = '/next_key_data/state_log.json'  

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

  def self.last
    state_log = IO.readlines(@@FILE)
    state_log.last
  end
end
