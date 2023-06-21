sub main(obj)
    ? obj 
    ' Print information from Roku manifest
    app_info = createObject("roAppInfo")
    ? "App Title: ", app_info.getTitle()
    ? "App Version: ", app_info.getVersion()
    ? "Channel ID: ", app_info.getID()
    ? "isDev: ", app_info.isDev()
    ? "Custom Field: ", app_info.getValue("custom_field")
    ? "Funny Message lol: ", app_info.getValue("funny_message")
    ' Print information from device
    ? "- - - - - - - - - - - - - - - - "
    device_info = createObject("roDeviceInfo")
    ? "Model: ", device_info.getModel()
    ? "Display Name: ", device_info.getModelDisplayName()
    ? "Firmware: ", device_info.getVersion()
    ? "Device ID: ", device_info.GetChannelClientId()
    ? "Friendly Name: ", device_info.getFriendlyName()
    display_size = device_info.getDisplaySize()
    ? "Display Size: ", display_size.w;"x";display_size.h
    ? "UI Resolution: ", device_info.getUIResolution()
    ? "Video Mode: ", device_info.getVideoMode()
    ? "IP Address: ",device_info.getExternalIp()

    screen = createObject("roSGScreen")
	scene = screen.createScene("home_scene")
	screen.Show()
    port = createObject("roMessagePort")
	screen.setMessagePort(m.port)
	' this loop is necessary to keep the application open
	' otherwise the channel will exit when it reaches the end of main()
	while(true)
		' nothing happens in here, yet
		' the HOME and BACK buttons on the remote will nuke the app
    end while
end sub