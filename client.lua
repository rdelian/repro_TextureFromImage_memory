RegisterNetEvent(RESOURCE_NAME..':ReceiveImages')
AddEventHandler(RESOURCE_NAME..':ReceiveImages', function(data)
	print("Data Received: " .. tostring(data) .. ' #' .. #data)

	LoadCustomImages(data)

	-- Test textures
	Notify("Text, yay", GetGameTimer(), "002-youtube")
	Notify("Text, yay", GetGameTimer(), "055-lastfm")
end)

