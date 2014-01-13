--[[ Basic program for sorting Mystcraft pages. (or any other items with unique names, for that matter)
     Duplicates are put into a chest on top, and new pages are put in the front.
     Known pages are saved in pages.txt, so it will continue to work across reboots. ]]--

local args = {...}
local known = {}

if #args < 2 then
    print("pagesort <side of input chest> <direction of turtle relative to chest (north/east/etc.)>")
    
    return
end

local function get_all_stacks(inventory)
    local data = {}
    
    for iii=1, inventory.getInventorySize() do
        data[iii] = inventory.getStackInSlot(iii)
    end
    
    return data
end

local function load_data()
    file = fs.open("pages.txt", "r")
    
    if file then
        known = textutils.unserialize(file.readAll())
        
        file.close()
    end
end

local function save_data()
    file = fs.open("pages.txt", "w")
    
    file.write(textutils.serialize(known))
    file.close()
end

local function main()
    local inChest = peripheral.wrap(args[1])
    local new = false
    
    load_data()
    
    while true do
        for k,v in pairs(get_all_stacks(inChest)) do
            local name = v["name"]
            
            if known[name] == nil then
                print("Found new page (", name, ")")
                
                new = true
                known[name] = true
                
                inChest.pushItemIntoSlot(args[2], k, 1, 1)
                turtle.drop()
            else
                print("Found duplicate page (", name, ")")
                
                inChest.pushItemIntoSlot(args[2], k, 1, 1)
                turtle.dropUp()
            end
        end
        
        if new then
            save_data()
            
            new = false
        end
        
        os.sleep(1)
    end
end

main()
