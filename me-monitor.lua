--[[ Monitors an ME controller, emitting a redstone signal when it is off. ]]--

local args = {...}

if args[1] == "help" or #args < 2 then
    print("me-monitor <monitor side> <redstone output side>")
    
    return
end

local controller = peripheral.wrap(args[1])

function check()
    return pcall(controller.getFreeBytes) --there's probably a better way to do this
end

function main()
    while true do
        if check() then
            os.sleep(1)
        else
            redstone.setOutput(args[2], true)
            
            while not check() do
                os.sleep(1)
            end
            
            redstone.setOutput(args[2], false)
        end
    end
end

main()
