local function zprint(obj)
    if type(obj) == "table" then
        for k,v in obj do
            print("key: ", k, " value: ", v)
        end
    else
        print(obj)
    end
end

local ZDebugFunc = {
    ["zprint"] = zprint,
}

return ZDebugFunc