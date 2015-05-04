class DeviceInfoConsultor
   def self.all
    IO.readlines("/next_key_data/device_info.json")
  end
end
