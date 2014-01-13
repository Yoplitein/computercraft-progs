--[[ Useful functions when working in the interpreter.
     Simply load with os.loadAPI. ]]

--pretty prints a table and any subtables, waiting for a keypress after each line
_G.print_table = function(table, level)
    level = level or 0
    
    for k,v in pairs(table) do
        for _=0, level do io.write(" ") end
        
        if type(v) == "table" then
            print(k, " = ")
            print_table(v, level+1)
        else
            print(k, " = ", v)
        end
        
        os.pullEvent("key")
    end
end
