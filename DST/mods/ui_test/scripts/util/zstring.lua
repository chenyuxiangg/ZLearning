local Zstring = Class(function(self, str)
    self.str = str
    self.curPos = 1
    self.curStep = 1
end)

function Zstring:getNextStepByPos(startPos)
    if self.str == nil or #self.str == 0 then
        return self.curStep
    end
    local byteVal = string.byte(self.str, startPos)
    if byteVal == nil then
        return self.curStep
    end
    if byteVal > 239 then
        self.curStep = 4
    elseif byteVal > 223 then
        self.curStep = 3
    elseif byteVal > 191 then
        self.curStep = 2
    else
        self.curStep = 1
    end
    return self.curStep
end

function Zstring:getCharacterLength()
    local realByteCount = #self.str
    local curBytePos = 1
    local length = 0

    while (curBytePos < realByteCount) do
        self:getNextStepByPos(curBytePos)
        curBytePos = curBytePos + self.curStep
        length = length + 1
    end
    return length
end

function Zstring:substrByCharacterCount(startPos, characterCount)
    local sp = startPos ~= nil and startPos or self.curPos
    local ep = sp
    for i = 1, characterCount do
        self:getNextStepByPos(ep)
        ep = ep + self.curStep
        if ep >= #self.str then
            break
        end
    end
    self.curPos = ep
    return string.sub(self.str, sp, ep)
end

function Zstring:substrByByteCount(startPos, byteCount)
    local sp = startPos ~= nil and startPos or self.curPos
    local ep = sp
    local curByteCount = 0
    byteCount = sp + byteCount <= #self.str and byteCount or #self.str-sp
    while true do
        self.getNextStepByPos(ep)
        curByteCount = curByteCount + self.curStep
        if curByteCount > byteCount then
            break
        end
        ep = ep + self.curStep
    end
    return string.sub(self.str, sp, ep)
end

return Zstring