for _, obj in ipairs(workspace:GetDescendants()) do
    if obj:IsA("BasePart") or obj:IsA("MeshPart") or obj:IsA("Model") then
        local nameL = obj.Name:lower()
        if nameL:find("mail") or nameL:find("buzon") or nameL:find("box") 
           or nameL:find("collect") or nameL:find("drop") then
            print(obj.Name, obj.ClassName)
        end
    end
end
