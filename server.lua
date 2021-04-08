local function printFiles(data)
    for i = 1, #data do
        print(data[i])
    end
end

Citizen.CreateThread(function()
    local files = scandir(RESOURCE_PATH .. '/images')
    
    -- printFiles(files)

    TriggerClientEvent(RESOURCE_NAME..':ReceiveImages', -1, files)
end)