--[[ simple turtle powered tree farming ]]--

function safe_move(func)
    while not func() do
        sleep(1)
    end
end

function chop_leaves()
    for iii=1,4 do
        turtle.dig()
        turtle.turnLeft()
    end
end

function chop_wood()
    local count = 0

    while turtle.detectUp() do
        turtle.digUp()
        safe_move(turtle.up)
        chop_leaves()

        count = count + 1
    end

    return count
end

function go_down(count)
    for iii=0,count do
        safe_move(turtle.down)
        sleep(0.1)
    end
end

function main()
    while true do
        safe_move(turtle.forward)

        if turtle.detect() then
            turtle.dig()
            safe_move(turtle.forward)
            turtle.digDown()
            go_down(chop_wood())
            safe_move(turtle.back)
            turtle.place()
            safe_move(turtle.up)
        end

        safe_move(turtle.back)
        sleep(5)
    end
end

main()
