local Logger = {}

function Logger.printR(t)
    local printRCache = {}
    local function subPrintR(t, indent)
        if (printRCache[tostring(t)]) then
            print(indent .. "*" .. tostring(t))
        else
            printRCache[tostring(t)] = true
            if (type(t) == "table") then
                for pos, val in pairs(t) do
                    if (type(val) == "table") then
                        print(indent .. "[" .. pos .. "] => " .. tostring(t) .. " {")
                        subPrintR(val, indent .. string.rep(" ", string.len(pos) + 8))
                        print(indent .. string.rep(" ", string.len(pos) + 6) .. "}")
                    elseif (type(val) == "string") then
                        print(indent .. "[" .. pos .. '] => "' .. val .. '"')
                    else
                        print(indent .. "[" .. pos .. "] => " .. tostring(val))
                    end
                end
            else
                print(indent .. tostring(t))
            end
        end
    end

    if (type(t) == "table") then
        print(tostring(t) .. " {")
        subPrintR(t, "  ")
        print("}")
    else
        subPrintR(t, "  ")
    end
    print()
end

return Logger