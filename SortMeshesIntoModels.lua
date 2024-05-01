function getStringBetweenWords(inputString, startWord, endKeyword)
	local startIndex = string.find(inputString, startWord)
	if startIndex then
		startIndex = startIndex + #startWord -- Move start index to the end of the startWord
		local endIndex = string.find(inputString, endKeyword, startIndex)
		if endIndex then
			return string.sub(inputString, startIndex, endIndex - 1)
		end
	end
	return nil
end

for i,v in pairs(game.Workspace:GetChildren()) do
	if v:IsA("MeshPart") then
		local ItemName = getStringBetweenWords(v.Name, "Meshes/", "_0")
		if not ItemName then
			ItemName = getStringBetweenWords(v.Name, "Meshes/", " C")
		end
		local NewModel = game.Workspace:FindFirstChild(ItemName)
		if not NewModel then
			local Model = Instance.new("Model")
			Model.Parent = game.Workspace
			Model.Name = ItemName
			v.Parent = Model
		else
			v.Parent = NewModel
		end
	end
end
