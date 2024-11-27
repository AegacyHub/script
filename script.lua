local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()

local gamename = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name

local Window = Fluent:CreateWindow({
    Title = "Aegacy Hub Premium Script Game :",
    SubTitle = gamename,
    TabWidth = 130,
    Size = UDim2.fromOffset(490, 400),
    Acrylic = true,
    Theme = "Aqua",
    MinimizeKey = Enum.KeyCode.F1
})

local Tabs = {
    Updates = Window:AddTab({ Title = "Settings", Icon = "settings-2" }),
    Main = Window:AddTab({ Title = "General", Icon = "house" }),
}

local Side = nil

local Toggle = Tabs.Main:AddToggle("Toggle", {
    Title = "Auto Play",
    Description = "Auto Hit",
    Default = false
})

Toggle:OnChanged(function()
    if Toggle.Value then
        local VirtualInputManager = game:GetService("VirtualInputManager")

        _G.auto = true

        while _G.auto do
            pcall(function()
                local player = game:GetService("Players").LocalPlayer
                local ap = player.PlayerGui.GameUI.Screen.Arrows[Side].Arrows

                local column0 = ap.Arrow0.InnerFrame.Column:GetChildren()
                local column1 = ap.Arrow1.InnerFrame.Column:GetChildren()
                local column2 = ap.Arrow2.InnerFrame.Column:GetChildren()
                local column3 = ap.Arrow3.InnerFrame.Column:GetChildren()
                pcall(function ()
                    column4 = ap.Arrow4.InnerFrame.Column:GetChildren()
                end)

                pcall(function ()
                    column5 = ap.Arrow5.InnerFrame.Column:GetChildren()
                end)

                pcall(function ()
                    column6 = ap.Arrow6.InnerFrame.Column:GetChildren()
                end)

                pcall(function ()
                    column7 = ap.Arrow7.InnerFrame.Column:GetChildren()
                end)

                pcall(function ()
                    column8 = ap.Arrow8.InnerFrame.Column:GetChildren()
                end)

                local function autoplay(children, keyCode)
                    local frameDetected = false

                    for _, child in pairs(children) do
                        if child.Position.Y.Scale < (0 + 1e-9) + _G.Delay and child.Name == "Frame" then
                            frameDetected = true
                            coroutine.wrap(function()
                                VirtualInputManager:SendKeyEvent(true, keyCode, false, game)
                                
                                while child.Parent do
                                    task.wait()
                                end
                                VirtualInputManager:SendKeyEvent(false, keyCode, false, game)
                            end)()
                            break
                        end
                    end

                    if not frameDetected then
                        for _, child in pairs(children) do
                            if child.Position.Y.Scale < 0 + _G.Delay and child.Name == "Note" then
                                coroutine.wrap(function()
                                    VirtualInputManager:SendKeyEvent(true, keyCode, false, game)
                                    
                                    while child.Parent do
                                        task.wait()
                                    end
                                    VirtualInputManager:SendKeyEvent(false, keyCode, false, game)
                                end)()
                                break
                            end
                        end
                    end
                end

                autoplay(column0, key1)
                autoplay(column1, key2)
                autoplay(column2, key3)
                autoplay(column3, key4)
                autoplay(column4, key5)
                autoplay(column5, key6)
                autoplay(column6, key7)
                autoplay(column7, key8)
                autoplay(column8, key9)
            end)
            task.wait()
        end
    else
        _G.auto = false
    end
end)

Toggle:SetValue(false)


game.GuiService.MenuOpened:Connect(function()
    if Toggle.Value then
        _G.Toggled = true
        Toggle:SetValue(false)
    end
end)

game.GuiService.MenuClosed:Connect(function()
    if not Toggle.Value and _G.Toggled then
        _G.Toggled = false
        Toggle:SetValue(true)
    end
end)

local Keybind = Tabs.Main:AddKeybind("Keybind", {
    Title = "Auto Player Keybind",
    Mode = "Toggle",
    Default = "Insert",

    Callback = function(Value)
        if Toggle.Value then
            Toggle:SetValue(false)
        else
            Toggle:SetValue(true)
        end
    end,
})


Tabs.Main:AddSection("Adjustments")

local Dropdown = Tabs.Main:AddDropdown("Dropdown", {
    Title = "Delay Mode",
    Values = {"Static", "Random"},
    Multi = false,
    Default = 1,
    Callback = function(Value)
        _G.Mode = Value
    end
})

_G.Mode = "Static"

local Slider = Tabs.Main:AddSlider("Slider", {
    Title = "Note ms Delay",
    Description = "More = Earlier",
    Default = 0,
    Min = 0,
    Max = 0.03,
    Rounding = 3,
    Callback = function(Value)
        pcall(function()
            if _G.Mode == "Static" then
                _G.Delay = Value
                local player = game.Players.LocalPlayer
                if player.PlayerGui.GameUI.Windows.Settings.Frame.Body.Settings.Settings.ScrollingFrame.DownScroll.Toggle.Outer.Inner.ImageColor3 == {118, 255, 105} then
                    _G.Delay = _G.Delay - _G.Delay - _G.Delay
                else
                    _G.Delay = Value
                end
            else
                task.spawn(function()
                    while true do
                        _G.Delay = math.floor(math.random() * Value * 1000) / 1000
                        task.wait()
                    end
                end)
                
                local player = game:GetService("Players").LocalPlayer
                if player.PlayerGui.GameUI.Windows.Settings.Frame.Body.Settings.Settings.ScrollingFrame.DownScroll.Toggle.Outer.Inner.ImageColor3 == {118, 255, 105} then
                    _G.Delay = _G.Delay - _G.Delay - _G.Delay
                else
                    _G.Delay = math.floor(math.random() * Value * 1000) / 1000
                end
            end
        end)
    end
})

loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/InterfaceManager.lua"))()

Window:SelectTab(1)

local Timer = Tabs.Updates:AddParagraph({
    Title = "Time : 00:00:00",
})

local st = os.time()

local function updateTimer()
    while true do
        local et = os.difftime(os.time(), st)
        local h = math.floor(et / 3600)
        local m = math.floor((et % 3600) / 60)
        local s = et % 60
        local ft = string.format("Time : %02d:%02d:%02d", h, m, s)

        Timer:SetTitle(ft)
        task.wait(1)
    end
end

coroutine.wrap(updateTimer)()


local player = game:GetService("Players").LocalPlayer
local backpack = player:WaitForChild("Backpack")
if backpack:FindFirstChild("Ui") then
    backpack:FindFirstChild("Ui"):Destroy()
end

local tool = Instance.new("Tool")
tool.Name = "Ui"
tool.RequiresHandle = false
tool.TextureId = "rbxassetid://85390612734393"
tool.Parent = backpack

Open = true
tool.Activated:Connect(function()
    if Open then
        Window:Minimize()
    else
        Window:Minimize()
    end
end)

local VirtualUser = game:GetService('VirtualUser')
game:GetService('Players').LocalPlayer.Idled:connect(function()
    VirtualUser:CaptureController()
    VirtualUser:ClickButton2(Vector2.new())
end)

local player = game:GetService("Players").LocalPlayer

function CheckSide()
    pcall(function ()
        local player = game.Players.LocalPlayer
        local character = player.Character
        local rootPart = character and character:FindFirstChild("HumanoidRootPart")

        local minDistTo11 = math.huge
        local minDistTo21 = math.huge

        for _, stage in pairs(workspace.Map.Stages:GetChildren()) do
            if stage:FindFirstChild("Pads") then
                local pads = stage.Pads
                local part11 = pads:FindFirstChild("11")
                local part21 = pads:FindFirstChild("21")
                
                if part11 and (rootPart.Position - part11.Position).magnitude <= 5 then
                    local distTo11 = (rootPart.Position - part11.Position).magnitude
                    if distTo11 < minDistTo11 then
                        minDistTo11 = distTo11
                    end
                end

                if part21 and (rootPart.Position - part21.Position).magnitude <= 5 then
                    local distTo21 = (rootPart.Position - part21.Position).magnitude
                    if distTo21 < minDistTo21 then
                        minDistTo21 = distTo21
                    end
                end
            end
        end

        if minDistTo11 < minDistTo21 then
            Side = "Left"
        else
            Side = "Right"
        end
    end)
end

while true do
    local player = game:GetService("Players").LocalPlayer
    if player.PlayerGui.GameUI.Windows.SongSelector.Visible == true then
        CheckSide()
    end
    pcall(function()
        keymap = player.PlayerGui.GameUI.Screen.Arrows[Side].Arrows
        key1 = Enum.KeyCode[keymap["Arrow0"].InnerFrame["0"].Keybind.Text]
        key2 = Enum.KeyCode[keymap["Arrow1"].InnerFrame["1"].Keybind.Text]
        key3 = Enum.KeyCode[keymap["Arrow2"].InnerFrame["2"].Keybind.Text]
        key4 = Enum.KeyCode[keymap["Arrow3"].InnerFrame["3"].Keybind.Text]
        key5 = Enum.KeyCode[keymap["Arrow4"].InnerFrame["4"].Keybind.Text]
        key6 = Enum.KeyCode[keymap["Arrow5"].InnerFrame["5"].Keybind.Text]
        key7 = Enum.KeyCode[keymap["Arrow6"].InnerFrame["6"].Keybind.Text]
        key8 = Enum.KeyCode[keymap["Arrow7"].InnerFrame["7"].Keybind.Text]
        key9 = Enum.KeyCode[keymap["Arrow8"].InnerFrame["8"].Keybind.Text]
    end)
    task.wait()
end
