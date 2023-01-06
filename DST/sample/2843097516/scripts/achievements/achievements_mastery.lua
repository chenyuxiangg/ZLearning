require("kaachievement_utils/utils")

local modName = "kaAchievement"
local categoryName = "Mastery"

-- RegisterXxxxAchievements(inst)
_G[string.format("Register%sAchievements", categoryName)] = function(inst)
    -- Nothing
end

-- RegisterXxxxAchievementEntries(root)
local registerEntriesFuncName = string.format("Register%sAchievementEntries", categoryName)
_G[registerEntriesFuncName] = function(root)
    local function GetNumFinishedTrophies(data)
        local numDone = 0
        local maxNum  = 0

        for _categoryName,vv in pairs(GetKaAchievementLoader().entries) do
            if _categoryName ~= categoryName then
                for i,v in pairs(vv) do
                    local varName = GetCompletedVarName(_categoryName, v.name)
                    maxNum = maxNum + 1
                    if data[varName] then
                        numDone = numDone + 1
                    end
                end
            end
        end

        return numDone, maxNum
    end

    local function GetNumEntriesInCategory(data, _categoryName)
        local numDone = 0
        local maxNum  = 0

        for i,v in pairs(GetKaAchievementLoader().entries[_categoryName] or {}) do
            if v.name ~= "alltrophy" then
                local varName = GetCompletedVarName(_categoryName, v.name)
                maxNum = maxNum + 1
                if data[varName] then
                    numDone = numDone + 1
                end
            end
        end

        return numDone, maxNum
    end

    local entries =
    {
        {
            name   = "alltrophy",
            Record =
                function(data)
                    local numDone, maxNum = GetNumFinishedTrophies(data)
                    return subfmt(STRINGS.ACCOMPLISHMENTS.UI.PROGRESS_FMT, {num=numDone, max=maxNum})
                end,
            Check  =
                function(data)
                    local numDone, maxNum = GetNumFinishedTrophies(data)
                    return maxNum ~= 0 and numDone == maxNum
                end,
        },
    }

    for _,v in pairs(KAACHIEVEMENT.CATEGORIES) do
        if v ~= categoryName then
            table.insert(entries,
            {
                name   = string.format("all%s", string.lower(v)),
                Record =
                    function(data)
                        local numDone, maxNum = GetNumEntriesInCategory(data, v)
                        return subfmt(STRINGS.ACCOMPLISHMENTS.UI.PROGRESS_FMT, {num=numDone, max=maxNum})
                    end,
                Check  =
                    function(data)
                        local numDone, maxNum = GetNumEntriesInCategory(data, v)
                        return maxNum ~= 0 and numDone == maxNum
                    end,
            })
        end
    end

    local category = {}
    for k,v in pairs(entries) do
        print(modName, registerEntriesFuncName, k, v)
        category[k] = v
    end

    print(modName, registerEntriesFuncName, categoryName)
    root[categoryName] = category
end
