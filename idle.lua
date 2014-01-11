--[[ dancing turtles are best turtles ]]--

function random_bool()
    return math.random() > 0.5
end

function main()
    while true do
        if random_bool() then
            turtle.turnLeft()
        else
            turtle.turnRight()
        end
        
        sleep(0.1)
    end
end

main()
