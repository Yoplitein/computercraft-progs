--[[ Evenly distributes inventory contents in a crystallizer. ]]--

local validSlots = {1, 2, 3, 5, 6}

local function insert(crystallizer, slot)
    for turtleSlot=1,16 do
        if crystallizer.pullItemIntoSlot("up", turtleSlot, 1, slot) > 0 then
            return true
        end
    end
    
    
    return false
end

local function main()
    local crystallizer = peripheral.wrap("bottom")
    local currentSlot = 1
    
    while true do
        local success = false
        
        for _,slot in pairs(validSlots) do
            success = insert(crystallizer, slot)
        end
        
        if success then
            os.sleep(0.1)
        else
            os.sleep(5)
        end
    end
end

main()
