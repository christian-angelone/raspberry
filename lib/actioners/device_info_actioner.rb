class DeviceInfoActioner
  
  def write(info)
    File.open('/next_key_data/device_info.json', 'w') { |file| file.puts(info) }
  end

end
