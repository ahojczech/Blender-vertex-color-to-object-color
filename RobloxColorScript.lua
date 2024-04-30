function getStringAfterWord(inputString, word)
    local startIndex = string.find(inputString, word)
    if startIndex then
        local wordLength = string.len(word)
        return string.sub(inputString, startIndex + wordLength)
    else
        return nil
    end
end

function RGBStringToColor3(rgbString)
    local r, g, b = string.match(rgbString, "(%d+), (%d+), (%d+)")
    if r and g and b then
        local color3Value = Color3.new(tonumber(r) / 255, tonumber(g) / 255, tonumber(b) / 255)
        return color3Value
    else
        error("Invalid RGB string format")
    end
end

for i,v in pairs(game.Workspace:GetChildren()) do
    if v:IsA("MeshPart") then
        local RGBStringValue = getStringAfterWord(v.Name, "Color-")
        local matchedColor = RGBStringToColor3(RGBStringValue)
        v.Color = matchedColor
    end
end
