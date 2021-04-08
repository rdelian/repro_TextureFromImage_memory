-- Global variables
RESOURCE_NAME = GetCurrentResourceName()

if IsDuplicityVersion() then
    -- Global Server variables
    RESOURCE_PATH = GetResourcePath(RESOURCE_NAME)
    
    -- Get all files in a directory works on both Windows & UNIX
    function scandir(dirname)
        local function scandir_win(directory)
            local i, t, popen = 0, {}, io.popen
            for filename in popen('dir "'..directory..'" /b'):lines() do
                i = i + 1
                t[i] = filename
            end
            return t
        end
        local callit = os.tmpname()
        os.execute("ls "..dirname .. " >"..callit)
        local f = io.open(callit,"r")
        local rv = f:read("*all")
        f:close()
        os.remove(callit)

        local tabby = {}
        local from  = 1
        local delim_from, delim_to = string.find( rv, "\n", from  )
        while delim_from do
            table.insert( tabby, string.sub( rv, from , delim_from-1 ) )
            from  = delim_to + 1
            delim_from, delim_to = string.find( rv, "\n", from  )
        end
        -- table.insert( tabby, string.sub( rv, from  ) ) -- Comment out eliminates blank line on end!
        if not tabby[1] then
            -- dprint('w', 'Scandir failded, switching to scandir_win instead')
            return scandir_win(dirname)
        end
        return tabby
    end
else
    -- Test Textures
    function Notify(text, title, photo, title_substring)
        AddTextEntry(RESOURCE_NAME.."NotifyText", text)
        BeginTextCommandThefeedPost(RESOURCE_NAME.."NotifyText")
    
        if photo then
            EndTextCommandThefeedPostMessagetextTu(photo, photo, false, 0, title, title_substring, 0.5)
        end
    
        EndTextCommandThefeedPostTicker(true, false)
    end
    
    -- Load Textures
    function LoadCustomImages(images)
        local ext = 'png'

        for i = 1, #images do
            local image = images[i]
            local dict_name = image:sub(0, image:find('.' .. ext) - 1)

            local entry = CreateRuntimeTxd(dict_name)
            local ret = CreateRuntimeTextureFromImage(entry, dict_name, "/images/" .. image)

            local format_string = "^3[LoadCustomImages]^7 Runtime Txd: %s | Texture Handle: %s"

            print( (format_string):format(tostring(entry), tostring(ret)) )
        end
    end    
end

