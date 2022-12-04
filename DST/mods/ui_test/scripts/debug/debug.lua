local ZDebugFunc = {}

function ZDebugFunc:zprint(obj)
    if type(obj) == "table" then
        for k,v in obj do
            print("key: ", k, " value: ", v)
        end
    else
        print(obj)
    end
end

return ZDebugFunc