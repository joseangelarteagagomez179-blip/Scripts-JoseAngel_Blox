for _, obj in ipairs(workspace:GetDescendants()) do
    local cd = obj:FindFirstChildOfClass("ClickDetector")
    local pp = obj:FindFirstChildOfClass("ProximityPrompt")
    if cd or pp then
        print(obj.Name, obj.ClassName)
    end
end
