function isfull()
    local total = 0
    
    for iii=1,16 do
        if turtle.getItemCount(iii) ~= 0 then
            total = total + 1
        end
    end
    
    return total == 16
end

function main()
    while not isfull() do
        while turtle.detect() do
            turtle.dig()
            turtle.digUp()
        end
        turtle.forward()
        os.sleep(0.1)
    end
end

main()
