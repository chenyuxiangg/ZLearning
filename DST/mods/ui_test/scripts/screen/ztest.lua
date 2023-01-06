ZTest = Class(function(self, inst)
    self.inst = inst
end)

local function fn()
    print("cyx_test event.")
end

function ZTest:RegisterEvent()
    self.inst:ListenForEvent("cyx_test", fn)
end

return ZTest