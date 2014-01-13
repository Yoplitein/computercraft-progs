--[[ Downloads files from github, much like the pastebin command. ]]--

local args = {...}
local urlTemplate = "https://raw.github.com/%s/%s/master/%s"

if #args < 3 then
    print("github <user> <repo> <path> [output filename]")
    
    return
end

local function remove_extension(name)
    name, _, _ = name:gsub(".lua$", "")
    
    return name
end

local function guess_name(path)
    local index = path:find("/")
    local last = 0
    
    while index do
        last = index
        index = path:find("/", index+1)
    end
    
    return remove_extension(path:sub(last+1))
end

local function main()
    local out = args[4] or guess_name(args[3])
    local response = http.get(urlTemplate:format(args[1], args[2], args[3]))
    
    if response then
        print("Saving into ", out)
        
        local file = fs.open(out, "w")
        
        file.write(response.readAll())
        file.close()
    else
        print("Failed to retrieve file.")
    end
end

main()
