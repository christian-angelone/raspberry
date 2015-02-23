require 'sinatra'

get '/' do
 "Details: #{`uname -a`}"
end

get '/state_log' do
data = ""
File.open('/next_key_data/state_log.csv', 'r') do |f|
  f.each_line do |line|
    data += line
  end
end
data
end
