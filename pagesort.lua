--[[ Sorts Mystcraft biome and block pages.
     Biomes are sent to the left, blocks to the right, everything else in front. ]]--

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

local function drop(side)
    if     side == "left" then
        turtle.turnLeft()
        turtle.drop()
        turtle.turnRight()
    elseif side == "right" then
        turtle.turnRight()
        turtle.drop()
        turtle.turnLeft()
    elseif side == "front" then
        turtle.drop()
    end
end

local function main()
    local inChest = peripheral.wrap(args[1])
    
    while true do
        for k,v in pairs(get_all_stacks(inChest)) do
            local name = v["name"]
            
            inChest.pushItemIntoSlot(args[2], k, 1, 1)
            
            if     name:find("Biome)") then
                print(name, " is biome")
                drop("left")
            elseif name:find("Block)") then
                print(name, " is block")
                drop("right")
            else
                print("I don't know what ", name, " is")
                drop("front")
            end
        end
        
        os.sleep(1)
    end
end

main()
