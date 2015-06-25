require 'rubygems'
require 'daemons'
require 'require_all'
require_all 'lib'

pwd = File.dirname(File.expand_path(__FILE__)) # the current directory
file = pwd + '/bin/init_http_services.rb'
Daemons.run_proc(file) do
	exec "ruby #{file}"
end
#Daemons.run(file)
