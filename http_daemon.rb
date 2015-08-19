require 'daemons'

pwd  = File.dirname(File.expand_path(__FILE__))
file = pwd + '/bin/init_http_services.rb'

Daemons.run_proc('service_daemon',
	:dir_mode => :normal,
	:dir => File.join(pwd, 'tmp/pids'),
  :backtrace => true,
  :monitor => true,
  :log_output => true) do

	exec("ruby #{file}")
end
