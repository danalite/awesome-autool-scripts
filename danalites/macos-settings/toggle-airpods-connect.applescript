use framework "IOBluetooth"
use scripting additions

set AirPodsName to "AirPods Pro"

on getFirstMatchingDevice(deviceName)
	repeat with device in (current application's IOBluetoothDevice's pairedDevices() as list)
		if (device's nameOrAddress as string) contains deviceName then return device
	end repeat
end getFirstMatchingDevice

on toggleDevice(device)
	set quotedDeviceName to quoted form of (device's nameOrAddress as string)
	
	if not (device's isConnected as boolean) then
		device's openConnection()
	end if
	
	with timeout of 30 seconds
		set deviceValueInAudioSource to ""
		repeat while deviceValueInAudioSource = ""
			set deviceValueInAudioSource to do shell script "/usr/local/bin/SwitchAudioSource -a | grep -m1 " & quotedDeviceName
		end repeat
		
		do shell script "/usr/local/bin/SwitchAudioSource -s " & quotedDeviceName
		return "Connecting " & (device's nameOrAddress as string)
	end timeout
end toggleDevice

return toggleDevice(getFirstMatchingDevice(AirPodsName))