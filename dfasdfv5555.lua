---@diagnostic disable: undefined-global, lowercase-global, deprecated, undefined-field, ambiguity-1, unbalanced-assignments, redundant-parameter, cast-local-type
task.wait(2)
repeat task.wait() until game:IsLoaded()
if game.PlaceId == 8304191830 then
	repeat task.wait() until game.Workspace:FindFirstChild(game.Players.LocalPlayer.Name)
	repeat task.wait() until game.Players.LocalPlayer.PlayerGui:FindFirstChild("collection"):FindFirstChild("grid"):FindFirstChild("List"):FindFirstChild("Outer"):FindFirstChild("UnitFrames")
else
	repeat task.wait() until game.Workspace:FindFirstChild(game.Players.LocalPlayer.Name)
	game:GetService("ReplicatedStorage").endpoints.client_to_server.vote_start:InvokeServer()
	getgenv().start_time = os.time()
	repeat task.wait() until game:GetService("Workspace")["_waves_started"].Value == true
end

task.wait(5)

--#region Setting in Game PlayerID And WorkSpace

local versionx = " - auto 4x"
local map_dun1 = "_lobbytemplate_event227"
local key_dun1 = "key_jjk_finger"
local map_dun2 = "_lobbytemplate_event428"
local key_dun2 = "key_yamamoto"
local map_dun3 = "_lobbytemplate_event21"
local key_dun3 = "key_jjk_map"
-----------------------------------------------------------------
local plr = game:GetService("Players").LocalPlayer
local players = game:GetService("Players")
local HttpService = game:GetService("HttpService")
local Workspace = game:GetService("Workspace")
local LocalPlayer = game:GetService("Players").LocalPlayer
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local Mouse = LocalPlayer:GetMouse()
local ReplicatedFirst = game:GetService("ReplicatedFirst")
local playerGui = LocalPlayer:WaitForChild("PlayerGui")

-----------------------------------------------------------------

--#endregion

--#region Setting Script
local a = 'IprojectX' -- Paste Name
if not isfolder(a) then
	makefolder(a)
end
getgenv().savefilename = "IprojectX/autoProjectX." .. game.Players.LocalPlayer.Name .. ".json"
getgenv().door = "_lobbytemplategreen1"
-----------------------------------------------------------------
--#endregion

--#region List Friends

function listFriends()
	friendsWith = {} --array of player instances the local player is friends with
	for _, player in ipairs(players:GetPlayers()) do
		if player ~= plr then
			local success, result = pcall(function()
				return plr:IsFriendsWith(player.UserId)
			end)
			if success then
				if result then
					table.insert(friendsWith, player.Name)
				end
			else
				warn(result)
			end
		end
	end
	return friendsWith
end
--#endregion

--#region [Function] Auto Select Units

function handle_select_units()
  getgenv().profile_data = { equipped_units = {} }
  repeat
    do
      for i, v in pairs(getgc(true)) do
        if type(v) == "table" and rawget(v, "xp") then wait()
          table.insert(getgenv().profile_data.equipped_units, v)
        end
      end
    end
  until #getgenv().profile_data.equipped_units > 0

  getgenv().SelectedUnits = {}
  local units_data = require(game:GetService("ReplicatedStorage").src.Data.Units)
  for i, v in pairs(getgenv().profile_data.equipped_units) do
    if units_data[v.unit_id] and v.equipped_slot then
      local selected_unit_data = tostring(units_data[v.unit_id].id) .. " #" .. tostring(v.uuid)
      getgenv().SelectedUnits[tonumber(v.equipped_slot)] = selected_unit_data
      updatejson()
    end
  end
end
--#endregion

--#region Main UI

local ui_options = {
	main_color = Color3.fromRGB(41, 74, 122),
	min_size = Vector2.new(400, 300),
	toggle_key = Enum.KeyCode.RightShift,
	can_resize = true,
}

do
	local imgui = game:GetService("CoreGui"):FindFirstChild("imgui")
	if imgui then imgui:Destroy() end
end

local imgui = Instance.new("ScreenGui")
local Prefabs = Instance.new("Frame")
local Label = Instance.new("TextLabel")
local Window = Instance.new("ImageLabel")
local Resizer = Instance.new("Frame")
local Bar = Instance.new("Frame")
local Toggle = Instance.new("ImageButton")
local Base = Instance.new("ImageLabel")
local Top = Instance.new("ImageLabel")
local Tabs = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local TabSelection = Instance.new("ImageLabel")
local TabButtons = Instance.new("Frame")
local UIListLayout = Instance.new("UIListLayout")
local Frame = Instance.new("Frame")
local Tab = Instance.new("Frame")
local UIListLayout_2 = Instance.new("UIListLayout")
local TextBox = Instance.new("TextBox")
local TextBox_Roundify_4px = Instance.new("ImageLabel")
local Slider = Instance.new("ImageLabel")
local Title_2 = Instance.new("TextLabel")
local Indicator = Instance.new("ImageLabel")
local Value = Instance.new("TextLabel")
local TextLabel = Instance.new("TextLabel")
local TextLabel_2 = Instance.new("TextLabel")
local Circle = Instance.new("ImageLabel")
local UIListLayout_3 = Instance.new("UIListLayout")
local Dropdown = Instance.new("TextButton")
local Indicator_2 = Instance.new("ImageLabel")
local Box = Instance.new("ImageButton")
local Objects = Instance.new("ScrollingFrame")
local UIListLayout_4 = Instance.new("UIListLayout")
local TextButton_Roundify_4px = Instance.new("ImageLabel")
local TabButton = Instance.new("TextButton")
local TextButton_Roundify_4px_2 = Instance.new("ImageLabel")
local Folder = Instance.new("ImageLabel")
local Button = Instance.new("TextButton")
local TextButton_Roundify_4px_3 = Instance.new("ImageLabel")
local Toggle_2 = Instance.new("ImageLabel")
local Objects_2 = Instance.new("Frame")
local UIListLayout_5 = Instance.new("UIListLayout")
local HorizontalAlignment = Instance.new("Frame")
local UIListLayout_6 = Instance.new("UIListLayout")
local Console = Instance.new("ImageLabel")
local ScrollingFrame = Instance.new("ScrollingFrame")
local Source = Instance.new("TextBox")
local Comments = Instance.new("TextLabel")
local Globals = Instance.new("TextLabel")
local Keywords = Instance.new("TextLabel")
local RemoteHighlight = Instance.new("TextLabel")
local Strings = Instance.new("TextLabel")
local Tokens = Instance.new("TextLabel")
local Numbers = Instance.new("TextLabel")
local Info = Instance.new("TextLabel")
local Lines = Instance.new("TextLabel")
local ColorPicker = Instance.new("ImageLabel")
local Palette = Instance.new("ImageLabel")
local Indicator_3 = Instance.new("ImageLabel")
local Sample = Instance.new("ImageLabel")
local Saturation = Instance.new("ImageLabel")
local Indicator_4 = Instance.new("Frame")
local Switch = Instance.new("TextButton")
local TextButton_Roundify_4px_4 = Instance.new("ImageLabel")
local Title_3 = Instance.new("TextLabel")
local Button_2 = Instance.new("TextButton")
local TextButton_Roundify_4px_5 = Instance.new("ImageLabel")
local DropdownButton = Instance.new("TextButton")
local Keybind = Instance.new("ImageLabel")
local Title_4 = Instance.new("TextLabel")
local Input = Instance.new("TextButton")
local Input_Roundify_4px = Instance.new("ImageLabel")
local Windows = Instance.new("Frame")

imgui.Name = "imgui"
imgui.Parent = game:GetService("CoreGui")

Prefabs.Name = "Prefabs"
Prefabs.Parent = imgui
Prefabs.BackgroundColor3 = Color3.new(1, 1, 1)
Prefabs.Size = UDim2.new(0, 100, 0, 100)
Prefabs.Visible = false

Label.Name = "Label"
Label.Parent = Prefabs
Label.BackgroundColor3 = Color3.new(1, 1, 1)
Label.BackgroundTransparency = 1
Label.Size = UDim2.new(0, 200, 0, 20)
Label.Font = Enum.Font.GothamSemibold
Label.Text = "Hello, world 123"
Label.TextColor3 = Color3.new(1, 1, 1)
Label.TextSize = 14
Label.TextXAlignment = Enum.TextXAlignment.Left

Window.Name = "Window"
Window.Parent = Prefabs
Window.Active = true
Window.BackgroundColor3 = Color3.new(1, 1, 1)
Window.BackgroundTransparency = 1
Window.ClipsDescendants = true
Window.Position = UDim2.new(0, 20, 0, 20)
Window.Selectable = true
Window.Size = UDim2.new(0, 200, 0, 200)
Window.Image = "rbxassetid://2851926732"
Window.ImageColor3 = Color3.new(0.0823529, 0.0862745, 0.0901961)
Window.ScaleType = Enum.ScaleType.Slice
Window.SliceCenter = Rect.new(12, 12, 12, 12)

Resizer.Name = "Resizer"
Resizer.Parent = Window
Resizer.Active = true
Resizer.BackgroundColor3 = Color3.new(1, 1, 1)
Resizer.BackgroundTransparency = 1
Resizer.BorderSizePixel = 0
Resizer.Position = UDim2.new(1, -20, 1, -20)
Resizer.Size = UDim2.new(0, 20, 0, 20)

Bar.Name = "Bar"
Bar.Parent = Window
Bar.BackgroundColor3 = Color3.new(0.160784, 0.290196, 0.478431)
Bar.BorderSizePixel = 0
Bar.Position = UDim2.new(0, 0, 0, 5)
Bar.Size = UDim2.new(1, 0, 0, 15)

Toggle.Name = "Toggle"
Toggle.Parent = Bar
Toggle.BackgroundColor3 = Color3.new(1, 1, 1)
Toggle.BackgroundTransparency = 1
Toggle.Position = UDim2.new(0, 5, 0, -2)
Toggle.Rotation = 90
Toggle.Size = UDim2.new(0, 20, 0, 20)
Toggle.ZIndex = 2
Toggle.Image = "https://www.roblox.com/Thumbs/Asset.ashx?width=420&height=420&assetId=4731371541"

Base.Name = "Base"
Base.Parent = Bar
Base.BackgroundColor3 = Color3.new(0.160784, 0.290196, 0.478431)
Base.BorderSizePixel = 0
Base.Position = UDim2.new(0, 0, 0.800000012, 0)
Base.Size = UDim2.new(1, 0, 0, 10)
Base.Image = "rbxassetid://2851926732"
Base.ImageColor3 = Color3.new(0.160784, 0.290196, 0.478431)
Base.ScaleType = Enum.ScaleType.Slice
Base.SliceCenter = Rect.new(12, 12, 12, 12)

Top.Name = "Top"
Top.Parent = Bar
Top.BackgroundColor3 = Color3.new(1, 1, 1)
Top.BackgroundTransparency = 1
Top.Position = UDim2.new(0, 0, 0, -5)
Top.Size = UDim2.new(1, 0, 0, 10)
Top.Image = "rbxassetid://2851926732"
Top.ImageColor3 = Color3.new(0.160784, 0.290196, 0.478431)
Top.ScaleType = Enum.ScaleType.Slice
Top.SliceCenter = Rect.new(12, 12, 12, 12)

Tabs.Name = "Tabs"
Tabs.Parent = Window
Tabs.BackgroundColor3 = Color3.new(1, 1, 1)
Tabs.BackgroundTransparency = 1
Tabs.Position = UDim2.new(0, 15, 0, 60)
Tabs.Size = UDim2.new(1, -30, 1, -60)

Title.Name = "Title"
Title.Parent = Window
Title.BackgroundColor3 = Color3.new(1, 1, 1)
Title.BackgroundTransparency = 1
Title.Position = UDim2.new(0, 30, 0, 3)
Title.Size = UDim2.new(0, 200, 0, 20)
Title.Font = Enum.Font.GothamBold
Title.Text = "Gamer Time"
Title.TextColor3 = Color3.new(1, 1, 1)
Title.TextSize = 14
Title.TextXAlignment = Enum.TextXAlignment.Left

TabSelection.Name = "TabSelection"
TabSelection.Parent = Window
TabSelection.BackgroundColor3 = Color3.new(1, 1, 1)
TabSelection.BackgroundTransparency = 1
TabSelection.Position = UDim2.new(0, 15, 0, 30)
TabSelection.Size = UDim2.new(1, -30, 0, 25)
TabSelection.Visible = false
TabSelection.Image = "rbxassetid://2851929490"
TabSelection.ImageColor3 = Color3.new(0.145098, 0.14902, 0.156863)
TabSelection.ScaleType = Enum.ScaleType.Slice
TabSelection.SliceCenter = Rect.new(4, 4, 4, 4)

TabButtons.Name = "TabButtons"
TabButtons.Parent = TabSelection
TabButtons.BackgroundColor3 = Color3.new(1, 1, 1)
TabButtons.BackgroundTransparency = 1
TabButtons.Size = UDim2.new(1, 0, 1, 0)

UIListLayout.Parent = TabButtons
UIListLayout.FillDirection = Enum.FillDirection.Horizontal
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Padding = UDim.new(0, 2)

Frame.Parent = TabSelection
Frame.BackgroundColor3 = Color3.new(0.12549, 0.227451, 0.372549)
Frame.BorderColor3 = Color3.new(0.105882, 0.164706, 0.207843)
Frame.BorderSizePixel = 0
Frame.Position = UDim2.new(0, 0, 1, 0)
Frame.Size = UDim2.new(1, 0, 0, 2)

Tab.Name = "Tab"
Tab.Parent = Prefabs
Tab.BackgroundColor3 = Color3.new(1, 1, 1)
Tab.BackgroundTransparency = 1
Tab.Size = UDim2.new(1, 0, 1, 0)
Tab.Visible = false

UIListLayout_2.Parent = Tab
UIListLayout_2.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout_2.Padding = UDim.new(0, 5)

TextBox.Parent = Prefabs
TextBox.BackgroundColor3 = Color3.new(1, 1, 1)
TextBox.BackgroundTransparency = 1
TextBox.BorderSizePixel = 0
TextBox.Size = UDim2.new(1, 0, 0, 20)
TextBox.ZIndex = 2
TextBox.Font = Enum.Font.GothamSemibold
TextBox.PlaceholderColor3 = Color3.new(0.698039, 0.698039, 0.698039)
TextBox.PlaceholderText = "Input Text"
TextBox.Text = ""
TextBox.TextColor3 = Color3.new(0.784314, 0.784314, 0.784314)
TextBox.TextSize = 14

TextBox_Roundify_4px.Name = "TextBox_Roundify_4px"
TextBox_Roundify_4px.Parent = TextBox
TextBox_Roundify_4px.BackgroundColor3 = Color3.new(1, 1, 1)
TextBox_Roundify_4px.BackgroundTransparency = 1
TextBox_Roundify_4px.Size = UDim2.new(1, 0, 1, 0)
TextBox_Roundify_4px.Image = "rbxassetid://2851929490"
TextBox_Roundify_4px.ImageColor3 = Color3.new(0.203922, 0.207843, 0.219608)
TextBox_Roundify_4px.ScaleType = Enum.ScaleType.Slice
TextBox_Roundify_4px.SliceCenter = Rect.new(4, 4, 4, 4)

Slider.Name = "Slider"
Slider.Parent = Prefabs
Slider.BackgroundColor3 = Color3.new(1, 1, 1)
Slider.BackgroundTransparency = 1
Slider.Position = UDim2.new(0, 0, 0.178571433, 0)
Slider.Size = UDim2.new(1, 0, 0, 20)
Slider.Image = "rbxassetid://2851929490"
Slider.ImageColor3 = Color3.new(0.145098, 0.14902, 0.156863)
Slider.ScaleType = Enum.ScaleType.Slice
Slider.SliceCenter = Rect.new(4, 4, 4, 4)

Title_2.Name = "Title"
Title_2.Parent = Slider
Title_2.BackgroundColor3 = Color3.new(1, 1, 1)
Title_2.BackgroundTransparency = 1
Title_2.Position = UDim2.new(0.5, 0, 0.5, -10)
Title_2.Size = UDim2.new(0, 0, 0, 20)
Title_2.ZIndex = 2
Title_2.Font = Enum.Font.GothamBold
Title_2.Text = "Slider"
Title_2.TextColor3 = Color3.new(0.784314, 0.784314, 0.784314)
Title_2.TextSize = 14

Indicator.Name = "Indicator"
Indicator.Parent = Slider
Indicator.BackgroundColor3 = Color3.new(1, 1, 1)
Indicator.BackgroundTransparency = 1
Indicator.Size = UDim2.new(0, 0, 0, 20)
Indicator.Image = "rbxassetid://2851929490"
Indicator.ImageColor3 = Color3.new(0.254902, 0.262745, 0.278431)
Indicator.ScaleType = Enum.ScaleType.Slice
Indicator.SliceCenter = Rect.new(4, 4, 4, 4)

Value.Name = "Value"
Value.Parent = Slider
Value.BackgroundColor3 = Color3.new(1, 1, 1)
Value.BackgroundTransparency = 1
Value.Position = UDim2.new(1, -55, 0.5, -10)
Value.Size = UDim2.new(0, 50, 0, 20)
Value.Font = Enum.Font.GothamBold
Value.Text = "0%"
Value.TextColor3 = Color3.new(0.784314, 0.784314, 0.784314)
Value.TextSize = 14

TextLabel.Parent = Slider
TextLabel.BackgroundColor3 = Color3.new(1, 1, 1)
TextLabel.BackgroundTransparency = 1
TextLabel.Position = UDim2.new(1, -20, -0.75, 0)
TextLabel.Size = UDim2.new(0, 26, 0, 50)
TextLabel.Font = Enum.Font.GothamBold
TextLabel.Text = "]"
TextLabel.TextColor3 = Color3.new(0.627451, 0.627451, 0.627451)
TextLabel.TextSize = 14

TextLabel_2.Parent = Slider
TextLabel_2.BackgroundColor3 = Color3.new(1, 1, 1)
TextLabel_2.BackgroundTransparency = 1
TextLabel_2.Position = UDim2.new(1, -65, -0.75, 0)
TextLabel_2.Size = UDim2.new(0, 26, 0, 50)
TextLabel_2.Font = Enum.Font.GothamBold
TextLabel_2.Text = "["
TextLabel_2.TextColor3 = Color3.new(0.627451, 0.627451, 0.627451)
TextLabel_2.TextSize = 14

Circle.Name = "Circle"
Circle.Parent = Prefabs
Circle.BackgroundColor3 = Color3.new(1, 1, 1)
Circle.BackgroundTransparency = 1
Circle.Image = "rbxassetid://266543268"
Circle.ImageTransparency = 0.5

UIListLayout_3.Parent = Prefabs
UIListLayout_3.FillDirection = Enum.FillDirection.Horizontal
UIListLayout_3.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout_3.Padding = UDim.new(0, 20)

Dropdown.Name = "Dropdown"
Dropdown.Parent = Prefabs
Dropdown.BackgroundColor3 = Color3.new(1, 1, 1)
Dropdown.BackgroundTransparency = 1
Dropdown.BorderSizePixel = 0
Dropdown.Position = UDim2.new(-0.055555556, 0, 0.0833333284, 0)
Dropdown.Size = UDim2.new(0, 200, 0, 20)
Dropdown.ZIndex = 2
Dropdown.Font = Enum.Font.GothamBold
Dropdown.Text = "      Dropdown"
Dropdown.TextColor3 = Color3.new(0.784314, 0.784314, 0.784314)
Dropdown.TextSize = 14
Dropdown.TextXAlignment = Enum.TextXAlignment.Left

Indicator_2.Name = "Indicator"
Indicator_2.Parent = Dropdown
Indicator_2.BackgroundColor3 = Color3.new(1, 1, 1)
Indicator_2.BackgroundTransparency = 1
Indicator_2.Position = UDim2.new(0.899999976, -10, 0.100000001, 0)
Indicator_2.Rotation = -90
Indicator_2.Size = UDim2.new(0, 15, 0, 15)
Indicator_2.ZIndex = 2
Indicator_2.Image = "https://www.roblox.com/Thumbs/Asset.ashx?width=420&height=420&assetId=4744658743"

Box.Name = "Box"
Box.Parent = Dropdown
Box.BackgroundColor3 = Color3.new(1, 1, 1)
Box.BackgroundTransparency = 1
Box.Position = UDim2.new(0, 0, 0, 25)
Box.Size = UDim2.new(1, 0, 0, 150)
Box.ZIndex = 3
Box.Image = "rbxassetid://2851929490"
Box.ImageColor3 = Color3.new(0.129412, 0.133333, 0.141176)
Box.ScaleType = Enum.ScaleType.Slice
Box.SliceCenter = Rect.new(4, 4, 4, 4)

Objects.Name = "Objects"
Objects.Parent = Box
Objects.BackgroundColor3 = Color3.new(1, 1, 1)
Objects.BackgroundTransparency = 1
Objects.BorderSizePixel = 0
Objects.Size = UDim2.new(1, 0, 1, 0)
Objects.ZIndex = 3
Objects.CanvasSize = UDim2.new(0, 0, 0, 0)
Objects.ScrollBarThickness = 8

UIListLayout_4.Parent = Objects
UIListLayout_4.SortOrder = Enum.SortOrder.LayoutOrder

TextButton_Roundify_4px.Name = "TextButton_Roundify_4px"
TextButton_Roundify_4px.Parent = Dropdown
TextButton_Roundify_4px.BackgroundColor3 = Color3.new(1, 1, 1)
TextButton_Roundify_4px.BackgroundTransparency = 1
TextButton_Roundify_4px.Size = UDim2.new(1, 0, 1, 0)
TextButton_Roundify_4px.Image = "rbxassetid://2851929490"
TextButton_Roundify_4px.ImageColor3 = Color3.new(0.203922, 0.207843, 0.219608)
TextButton_Roundify_4px.ScaleType = Enum.ScaleType.Slice
TextButton_Roundify_4px.SliceCenter = Rect.new(4, 4, 4, 4)

TabButton.Name = "TabButton"
TabButton.Parent = Prefabs
TabButton.BackgroundColor3 = Color3.new(0.160784, 0.290196, 0.478431)
TabButton.BackgroundTransparency = 1
TabButton.BorderSizePixel = 0
TabButton.Position = UDim2.new(0.185185179, 0, 0, 0)
TabButton.Size = UDim2.new(0, 71, 0, 20)
TabButton.ZIndex = 2
TabButton.Font = Enum.Font.GothamSemibold
TabButton.Text = "Test tab"
TabButton.TextColor3 = Color3.new(0.784314, 0.784314, 0.784314)
TabButton.TextSize = 14

TextButton_Roundify_4px_2.Name = "TextButton_Roundify_4px"
TextButton_Roundify_4px_2.Parent = TabButton
TextButton_Roundify_4px_2.BackgroundColor3 = Color3.new(1, 1, 1)
TextButton_Roundify_4px_2.BackgroundTransparency = 1
TextButton_Roundify_4px_2.Size = UDim2.new(1, 0, 1, 0)
TextButton_Roundify_4px_2.Image = "rbxassetid://2851929490"
TextButton_Roundify_4px_2.ImageColor3 = Color3.new(0.203922, 0.207843, 0.219608)
TextButton_Roundify_4px_2.ScaleType = Enum.ScaleType.Slice
TextButton_Roundify_4px_2.SliceCenter = Rect.new(4, 4, 4, 4)

Folder.Name = "Folder"
Folder.Parent = Prefabs
Folder.BackgroundColor3 = Color3.new(1, 1, 1)
Folder.BackgroundTransparency = 1
Folder.Position = UDim2.new(0, 0, 0, 50)
Folder.Size = UDim2.new(1, 0, 0, 20)
Folder.Image = "rbxassetid://2851929490"
Folder.ImageColor3 = Color3.new(0.0823529, 0.0862745, 0.0901961)
Folder.ScaleType = Enum.ScaleType.Slice
Folder.SliceCenter = Rect.new(4, 4, 4, 4)

Button.Name = "Button"
Button.Parent = Folder
Button.BackgroundColor3 = Color3.new(0.160784, 0.290196, 0.478431)
Button.BackgroundTransparency = 1
Button.BorderSizePixel = 0
Button.Size = UDim2.new(1, 0, 0, 20)
Button.ZIndex = 2
Button.Font = Enum.Font.GothamSemibold
Button.Text = "      Folder"
Button.TextColor3 = Color3.new(1, 1, 1)
Button.TextSize = 14
Button.TextXAlignment = Enum.TextXAlignment.Left

TextButton_Roundify_4px_3.Name = "TextButton_Roundify_4px"
TextButton_Roundify_4px_3.Parent = Button
TextButton_Roundify_4px_3.BackgroundColor3 = Color3.new(1, 1, 1)
TextButton_Roundify_4px_3.BackgroundTransparency = 1
TextButton_Roundify_4px_3.Size = UDim2.new(1, 0, 1, 0)
TextButton_Roundify_4px_3.Image = "rbxassetid://2851929490"
TextButton_Roundify_4px_3.ImageColor3 = Color3.new(0.160784, 0.290196, 0.478431)
TextButton_Roundify_4px_3.ScaleType = Enum.ScaleType.Slice
TextButton_Roundify_4px_3.SliceCenter = Rect.new(4, 4, 4, 4)

Toggle_2.Name = "Toggle"
Toggle_2.Parent = Button
Toggle_2.BackgroundColor3 = Color3.new(1, 1, 1)
Toggle_2.BackgroundTransparency = 1
Toggle_2.Position = UDim2.new(0, 5, 0, 0)
Toggle_2.Size = UDim2.new(0, 20, 0, 20)
Toggle_2.Image = "https://www.roblox.com/Thumbs/Asset.ashx?width=420&height=420&assetId=4731371541"

Objects_2.Name = "Objects"
Objects_2.Parent = Folder
Objects_2.BackgroundColor3 = Color3.new(1, 1, 1)
Objects_2.BackgroundTransparency = 1
Objects_2.Position = UDim2.new(0, 10, 0, 25)
Objects_2.Size = UDim2.new(1, -10, 1, -25)
Objects_2.Visible = false

UIListLayout_5.Parent = Objects_2
UIListLayout_5.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout_5.Padding = UDim.new(0, 5)

HorizontalAlignment.Name = "HorizontalAlignment"
HorizontalAlignment.Parent = Prefabs
HorizontalAlignment.BackgroundColor3 = Color3.new(1, 1, 1)
HorizontalAlignment.BackgroundTransparency = 1
HorizontalAlignment.Size = UDim2.new(1, 0, 0, 20)

UIListLayout_6.Parent = HorizontalAlignment
UIListLayout_6.FillDirection = Enum.FillDirection.Horizontal
UIListLayout_6.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout_6.Padding = UDim.new(0, 5)

Console.Name = "Console"
Console.Parent = Prefabs
Console.BackgroundColor3 = Color3.new(1, 1, 1)
Console.BackgroundTransparency = 1
Console.Size = UDim2.new(1, 0, 0, 200)
Console.Image = "rbxassetid://2851928141"
Console.ImageColor3 = Color3.new(0.129412, 0.133333, 0.141176)
Console.ScaleType = Enum.ScaleType.Slice
Console.SliceCenter = Rect.new(8, 8, 8, 8)

ScrollingFrame.Parent = Console
ScrollingFrame.BackgroundColor3 = Color3.new(1, 1, 1)
ScrollingFrame.BackgroundTransparency = 1
ScrollingFrame.BorderSizePixel = 0
ScrollingFrame.Size = UDim2.new(1, 0, 1, 1)
ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
ScrollingFrame.ScrollBarThickness = 4

Source.Name = "Source"
Source.Parent = ScrollingFrame
Source.BackgroundColor3 = Color3.new(1, 1, 1)
Source.BackgroundTransparency = 1
Source.Position = UDim2.new(0, 40, 0, 0)
Source.Size = UDim2.new(1, -40, 0, 10000)
Source.ZIndex = 3
Source.ClearTextOnFocus = false
Source.Font = Enum.Font.Code
Source.MultiLine = true
Source.PlaceholderColor3 = Color3.new(0.8, 0.8, 0.8)
Source.Text = ""
Source.TextColor3 = Color3.new(1, 1, 1)
Source.TextSize = 15
Source.TextStrokeColor3 = Color3.new(1, 1, 1)
Source.TextWrapped = true
Source.TextXAlignment = Enum.TextXAlignment.Left
Source.TextYAlignment = Enum.TextYAlignment.Top

Comments.Name = "Comments"
Comments.Parent = Source
Comments.BackgroundColor3 = Color3.new(1, 1, 1)
Comments.BackgroundTransparency = 1
Comments.Size = UDim2.new(1, 0, 1, 0)
Comments.ZIndex = 5
Comments.Font = Enum.Font.Code
Comments.Text = ""
Comments.TextColor3 = Color3.new(0.231373, 0.784314, 0.231373)
Comments.TextSize = 15
Comments.TextXAlignment = Enum.TextXAlignment.Left
Comments.TextYAlignment = Enum.TextYAlignment.Top

Globals.Name = "Globals"
Globals.Parent = Source
Globals.BackgroundColor3 = Color3.new(1, 1, 1)
Globals.BackgroundTransparency = 1
Globals.Size = UDim2.new(1, 0, 1, 0)
Globals.ZIndex = 5
Globals.Font = Enum.Font.Code
Globals.Text = ""
Globals.TextColor3 = Color3.new(0.517647, 0.839216, 0.968628)
Globals.TextSize = 15
Globals.TextXAlignment = Enum.TextXAlignment.Left
Globals.TextYAlignment = Enum.TextYAlignment.Top

Keywords.Name = "Keywords"
Keywords.Parent = Source
Keywords.BackgroundColor3 = Color3.new(1, 1, 1)
Keywords.BackgroundTransparency = 1
Keywords.Size = UDim2.new(1, 0, 1, 0)
Keywords.ZIndex = 5
Keywords.Font = Enum.Font.Code
Keywords.Text = ""
Keywords.TextColor3 = Color3.new(0.972549, 0.427451, 0.486275)
Keywords.TextSize = 15
Keywords.TextXAlignment = Enum.TextXAlignment.Left
Keywords.TextYAlignment = Enum.TextYAlignment.Top

RemoteHighlight.Name = "RemoteHighlight"
RemoteHighlight.Parent = Source
RemoteHighlight.BackgroundColor3 = Color3.new(1, 1, 1)
RemoteHighlight.BackgroundTransparency = 1
RemoteHighlight.Size = UDim2.new(1, 0, 1, 0)
RemoteHighlight.ZIndex = 5
RemoteHighlight.Font = Enum.Font.Code
RemoteHighlight.Text = ""
RemoteHighlight.TextColor3 = Color3.new(0, 0.568627, 1)
RemoteHighlight.TextSize = 15
RemoteHighlight.TextXAlignment = Enum.TextXAlignment.Left
RemoteHighlight.TextYAlignment = Enum.TextYAlignment.Top

Strings.Name = "Strings"
Strings.Parent = Source
Strings.BackgroundColor3 = Color3.new(1, 1, 1)
Strings.BackgroundTransparency = 1
Strings.Size = UDim2.new(1, 0, 1, 0)
Strings.ZIndex = 5
Strings.Font = Enum.Font.Code
Strings.Text = ""
Strings.TextColor3 = Color3.new(0.678431, 0.945098, 0.584314)
Strings.TextSize = 15
Strings.TextXAlignment = Enum.TextXAlignment.Left
Strings.TextYAlignment = Enum.TextYAlignment.Top

Tokens.Name = "Tokens"
Tokens.Parent = Source
Tokens.BackgroundColor3 = Color3.new(1, 1, 1)
Tokens.BackgroundTransparency = 1
Tokens.Size = UDim2.new(1, 0, 1, 0)
Tokens.ZIndex = 5
Tokens.Font = Enum.Font.Code
Tokens.Text = ""
Tokens.TextColor3 = Color3.new(1, 1, 1)
Tokens.TextSize = 15
Tokens.TextXAlignment = Enum.TextXAlignment.Left
Tokens.TextYAlignment = Enum.TextYAlignment.Top

Numbers.Name = "Numbers"
Numbers.Parent = Source
Numbers.BackgroundColor3 = Color3.new(1, 1, 1)
Numbers.BackgroundTransparency = 1
Numbers.Size = UDim2.new(1, 0, 1, 0)
Numbers.ZIndex = 4
Numbers.Font = Enum.Font.Code
Numbers.Text = ""
Numbers.TextColor3 = Color3.new(1, 0.776471, 0)
Numbers.TextSize = 15
Numbers.TextXAlignment = Enum.TextXAlignment.Left
Numbers.TextYAlignment = Enum.TextYAlignment.Top

Info.Name = "Info"
Info.Parent = Source
Info.BackgroundColor3 = Color3.new(1, 1, 1)
Info.BackgroundTransparency = 1
Info.Size = UDim2.new(1, 0, 1, 0)
Info.ZIndex = 5
Info.Font = Enum.Font.Code
Info.Text = ""
Info.TextColor3 = Color3.new(0, 0.635294, 1)
Info.TextSize = 15
Info.TextXAlignment = Enum.TextXAlignment.Left
Info.TextYAlignment = Enum.TextYAlignment.Top

Lines.Name = "Lines"
Lines.Parent = ScrollingFrame
Lines.BackgroundColor3 = Color3.new(1, 1, 1)
Lines.BackgroundTransparency = 1
Lines.BorderSizePixel = 0
Lines.Size = UDim2.new(0, 40, 0, 10000)
Lines.ZIndex = 4
Lines.Font = Enum.Font.Code
Lines.Text = "1\n"
Lines.TextColor3 = Color3.new(1, 1, 1)
Lines.TextSize = 15
Lines.TextWrapped = true
Lines.TextYAlignment = Enum.TextYAlignment.Top

ColorPicker.Name = "ColorPicker"
ColorPicker.Parent = Prefabs
ColorPicker.BackgroundColor3 = Color3.new(1, 1, 1)
ColorPicker.BackgroundTransparency = 1
ColorPicker.Size = UDim2.new(0, 180, 0, 110)
ColorPicker.Image = "rbxassetid://2851929490"
ColorPicker.ImageColor3 = Color3.new(0.203922, 0.207843, 0.219608)
ColorPicker.ScaleType = Enum.ScaleType.Slice
ColorPicker.SliceCenter = Rect.new(4, 4, 4, 4)

Palette.Name = "Palette"
Palette.Parent = ColorPicker
Palette.BackgroundColor3 = Color3.new(1, 1, 1)
Palette.BackgroundTransparency = 1
Palette.Position = UDim2.new(0.0500000007, 0, 0.0500000007, 0)
Palette.Size = UDim2.new(0, 100, 0, 100)
Palette.Image = "rbxassetid://698052001"
Palette.ScaleType = Enum.ScaleType.Slice
Palette.SliceCenter = Rect.new(4, 4, 4, 4)

Indicator_3.Name = "Indicator"
Indicator_3.Parent = Palette
Indicator_3.BackgroundColor3 = Color3.new(1, 1, 1)
Indicator_3.BackgroundTransparency = 1
Indicator_3.Size = UDim2.new(0, 5, 0, 5)
Indicator_3.ZIndex = 2
Indicator_3.Image = "rbxassetid://2851926732"
Indicator_3.ImageColor3 = Color3.new(0, 0, 0)
Indicator_3.ScaleType = Enum.ScaleType.Slice
Indicator_3.SliceCenter = Rect.new(12, 12, 12, 12)

Sample.Name = "Sample"
Sample.Parent = ColorPicker
Sample.BackgroundColor3 = Color3.new(1, 1, 1)
Sample.BackgroundTransparency = 1
Sample.Position = UDim2.new(0.800000012, 0, 0.0500000007, 0)
Sample.Size = UDim2.new(0, 25, 0, 25)
Sample.Image = "rbxassetid://2851929490"
Sample.ScaleType = Enum.ScaleType.Slice
Sample.SliceCenter = Rect.new(4, 4, 4, 4)

Saturation.Name = "Saturation"
Saturation.Parent = ColorPicker
Saturation.BackgroundColor3 = Color3.new(1, 1, 1)
Saturation.Position = UDim2.new(0.649999976, 0, 0.0500000007, 0)
Saturation.Size = UDim2.new(0, 15, 0, 100)
Saturation.Image = "rbxassetid://3641079629"

Indicator_4.Name = "Indicator"
Indicator_4.Parent = Saturation
Indicator_4.BackgroundColor3 = Color3.new(1, 1, 1)
Indicator_4.BorderSizePixel = 0
Indicator_4.Size = UDim2.new(0, 20, 0, 2)
Indicator_4.ZIndex = 2

Switch.Name = "Switch"
Switch.Parent = Prefabs
Switch.BackgroundColor3 = Color3.new(1, 1, 1)
Switch.BackgroundTransparency = 1
Switch.BorderSizePixel = 0
Switch.Position = UDim2.new(0.229411766, 0, 0.20714286, 0)
Switch.Size = UDim2.new(0, 20, 0, 20)
Switch.ZIndex = 2
Switch.Font = Enum.Font.SourceSans
Switch.Text = ""
Switch.TextColor3 = Color3.new(1, 1, 1)
Switch.TextSize = 18

TextButton_Roundify_4px_4.Name = "TextButton_Roundify_4px"
TextButton_Roundify_4px_4.Parent = Switch
TextButton_Roundify_4px_4.BackgroundColor3 = Color3.new(1, 1, 1)
TextButton_Roundify_4px_4.BackgroundTransparency = 1
TextButton_Roundify_4px_4.Size = UDim2.new(1, 0, 1, 0)
TextButton_Roundify_4px_4.Image = "rbxassetid://2851929490"
TextButton_Roundify_4px_4.ImageColor3 = Color3.new(0.160784, 0.290196, 0.478431)
TextButton_Roundify_4px_4.ImageTransparency = 0.5
TextButton_Roundify_4px_4.ScaleType = Enum.ScaleType.Slice
TextButton_Roundify_4px_4.SliceCenter = Rect.new(4, 4, 4, 4)

Title_3.Name = "Title"
Title_3.Parent = Switch
Title_3.BackgroundColor3 = Color3.new(1, 1, 1)
Title_3.BackgroundTransparency = 1
Title_3.Position = UDim2.new(1.20000005, 0, 0, 0)
Title_3.Size = UDim2.new(0, 20, 0, 20)
Title_3.Font = Enum.Font.GothamSemibold
Title_3.Text = "Switch"
Title_3.TextColor3 = Color3.new(0.784314, 0.784314, 0.784314)
Title_3.TextSize = 14
Title_3.TextXAlignment = Enum.TextXAlignment.Left

Button_2.Name = "Button"
Button_2.Parent = Prefabs
Button_2.BackgroundColor3 = Color3.new(0.160784, 0.290196, 0.478431)
Button_2.BackgroundTransparency = 1
Button_2.BorderSizePixel = 0
Button_2.Size = UDim2.new(0, 91, 0, 20)
Button_2.ZIndex = 2
Button_2.Font = Enum.Font.GothamSemibold
Button_2.TextColor3 = Color3.new(1, 1, 1)
Button_2.TextSize = 14

TextButton_Roundify_4px_5.Name = "TextButton_Roundify_4px"
TextButton_Roundify_4px_5.Parent = Button_2
TextButton_Roundify_4px_5.BackgroundColor3 = Color3.new(1, 1, 1)
TextButton_Roundify_4px_5.BackgroundTransparency = 1
TextButton_Roundify_4px_5.Size = UDim2.new(1, 0, 1, 0)
TextButton_Roundify_4px_5.Image = "rbxassetid://2851929490"
TextButton_Roundify_4px_5.ImageColor3 = Color3.new(0.160784, 0.290196, 0.478431)
TextButton_Roundify_4px_5.ScaleType = Enum.ScaleType.Slice
TextButton_Roundify_4px_5.SliceCenter = Rect.new(4, 4, 4, 4)

DropdownButton.Name = "DropdownButton"
DropdownButton.Parent = Prefabs
DropdownButton.BackgroundColor3 = Color3.new(0.129412, 0.133333, 0.141176)
DropdownButton.BorderSizePixel = 0
DropdownButton.Size = UDim2.new(1, 0, 0, 20)
DropdownButton.ZIndex = 3
DropdownButton.Font = Enum.Font.GothamBold
DropdownButton.Text = "      Button"
DropdownButton.TextColor3 = Color3.new(0.784314, 0.784314, 0.784314)
DropdownButton.TextSize = 14
DropdownButton.TextXAlignment = Enum.TextXAlignment.Left

Keybind.Name = "Keybind"
Keybind.Parent = Prefabs
Keybind.BackgroundColor3 = Color3.new(1, 1, 1)
Keybind.BackgroundTransparency = 1
Keybind.Size = UDim2.new(0, 200, 0, 20)
Keybind.Image = "rbxassetid://2851929490"
Keybind.ImageColor3 = Color3.new(0.203922, 0.207843, 0.219608)
Keybind.ScaleType = Enum.ScaleType.Slice
Keybind.SliceCenter = Rect.new(4, 4, 4, 4)

Title_4.Name = "Title"
Title_4.Parent = Keybind
Title_4.BackgroundColor3 = Color3.new(1, 1, 1)
Title_4.BackgroundTransparency = 1
Title_4.Size = UDim2.new(0, 0, 1, 0)
Title_4.Font = Enum.Font.GothamBold
Title_4.Text = "Keybind"
Title_4.TextColor3 = Color3.new(0.784314, 0.784314, 0.784314)
Title_4.TextSize = 14
Title_4.TextXAlignment = Enum.TextXAlignment.Left

Input.Name = "Input"
Input.Parent = Keybind
Input.BackgroundColor3 = Color3.new(1, 1, 1)
Input.BackgroundTransparency = 1
Input.BorderSizePixel = 0
Input.Position = UDim2.new(1, -85, 0, 2)
Input.Size = UDim2.new(0, 80, 1, -4)
Input.ZIndex = 2
Input.Font = Enum.Font.GothamSemibold
Input.Text = "RShift"
Input.TextColor3 = Color3.new(0.784314, 0.784314, 0.784314)
Input.TextSize = 12
Input.TextWrapped = true

Input_Roundify_4px.Name = "Input_Roundify_4px"
Input_Roundify_4px.Parent = Input
Input_Roundify_4px.BackgroundColor3 = Color3.new(1, 1, 1)
Input_Roundify_4px.BackgroundTransparency = 1
Input_Roundify_4px.Size = UDim2.new(1, 0, 1, 0)
Input_Roundify_4px.Image = "rbxassetid://2851929490"
Input_Roundify_4px.ImageColor3 = Color3.new(0.290196, 0.294118, 0.313726)
Input_Roundify_4px.ScaleType = Enum.ScaleType.Slice
Input_Roundify_4px.SliceCenter = Rect.new(4, 4, 4, 4)

Windows.Name = "Windows"
Windows.Parent = imgui
Windows.BackgroundColor3 = Color3.new(1, 1, 1)
Windows.BackgroundTransparency = 1
Windows.Position = UDim2.new(0, 20, 0, 20)
Windows.Size = UDim2.new(1, 20, 1, -20)

--[[ Script ]]--
script.Parent = imgui

local UIS = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RS = game:GetService("RunService")
local ps = game:GetService("Players")

local p = ps.LocalPlayer
local mouse = p:GetMouse()

local Prefabs = script.Parent:WaitForChild("Prefabs")
local Windows = script.Parent:FindFirstChild("Windows")

local checks = {
	["binding"] = false,
}

UIS.InputBegan:Connect(function(input, gameProcessed)
	if input.KeyCode == ((typeof(ui_options.toggle_key) == "EnumItem") and ui_options.toggle_key or Enum.KeyCode.RightShift) then
		if script.Parent then
			if not checks.binding then
				script.Parent.Enabled = not script.Parent.Enabled
			end
		end
	end
end)

local function Resize(part, new, _delay)
	_delay = _delay or 0.5
	local tweenInfo = TweenInfo.new(_delay, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
	local tween = TweenService:Create(part, tweenInfo, new)
	tween:Play()
end

local function rgbtohsv(r, g, b) -- idk who made this function, but thanks
	r, g, b = r / 255, g / 255, b / 255
	local max, min = math.max(r, g, b), math.min(r, g, b)
	local h, s, v
	v = max

	local d = max - min
	if max == 0 then
		s = 0
	else
		s = d / max
	end

	if max == min then
		h = 0
	else
		if max == r then
			h = (g - b) / d
			if g < b then
				h = h + 6
			end
		elseif max == g then
			h = (b - r) / d + 2
		elseif max == b then
			h = (r - g) / d + 4
		end
		h = h / 6
	end

	return h, s, v
end

local function hasprop(object, prop)
	local a, b = pcall(function()
		return object[tostring(prop)]
	end)
	if a then
		return b
	end
end

local function gNameLen(obj)
	return obj.TextBounds.X + 15
end

local function gMouse()
	return Vector2.new(UIS:GetMouseLocation().X + 1, UIS:GetMouseLocation().Y - 35)
end

local function ripple(button, x, y)
	spawn(function()
		button.ClipsDescendants = true

		local circle = Prefabs:FindFirstChild("Circle"):Clone()

		circle.Parent = button
		circle.ZIndex = 1000

		local new_x = x - circle.AbsolutePosition.X
		local new_y = y - circle.AbsolutePosition.Y
		circle.Position = UDim2.new(0, new_x, 0, new_y)

		local size = 0
		if button.AbsoluteSize.X > button.AbsoluteSize.Y then
			 size = button.AbsoluteSize.X * 1.5
		elseif button.AbsoluteSize.X < button.AbsoluteSize.Y then
			 size = button.AbsoluteSize.Y * 1.5
		elseif button.AbsoluteSize.X == button.AbsoluteSize.Y then
			size = button.AbsoluteSize.X * 1.5
		end

		circle:TweenSizeAndPosition(UDim2.new(0, size, 0, size), UDim2.new(0.5, -size / 2, 0.5, -size / 2), "Out", "Quad", 0.5, false, nil)
		Resize(circle, {ImageTransparency = 1}, 0.5)

		wait(0.5)
		circle:Destroy()
	end)
end

local windows = 0
local library = {}

local function format_windows()
	local ull = Prefabs:FindFirstChild("UIListLayout"):Clone()
	ull.Parent = Windows
	local data = {}

	for i,v in next, Windows:GetChildren() do
		if not (v:IsA("UIListLayout")) then
			data[v] = v.AbsolutePosition
		end
	end

	ull:Destroy()

	for i,v in next, data do
		i.Position = UDim2.new(0, v.X, 0, v.Y)
	end
end

function library:FormatWindows()
	format_windows()
end

function library:AddWindow(title, options)
	windows = windows + 1
	local dropdown_open = false
	title = tostring(title or "New Window")
	options = (typeof(options) == "table") and options or ui_options
	options.tween_time = 0.1

	local Window = Prefabs:FindFirstChild("Window"):Clone()
	Window.Parent = Windows
	Window:FindFirstChild("Title").Text = title
	Window.Size = UDim2.new(0, options.min_size.X, 0, options.min_size.Y)
	Window.ZIndex = Window.ZIndex + (windows * 10)

	do -- Altering Window Color
		local Title = Window:FindFirstChild("Title")
		local Bar = Window:FindFirstChild("Bar")
		local Base = Bar:FindFirstChild("Base")
		local Top = Bar:FindFirstChild("Top")
		local SplitFrame = Window:FindFirstChild("TabSelection"):FindFirstChild("Frame")
		local Toggle = Bar:FindFirstChild("Toggle")

		spawn(function()
			while true do
				Bar.BackgroundColor3 = options.main_color
				Base.BackgroundColor3 = options.main_color
				Base.ImageColor3 = options.main_color
				Top.ImageColor3 = options.main_color
				SplitFrame.BackgroundColor3 = options.main_color

				RS.Heartbeat:Wait()
			end
		end)

	end

	local Resizer = Window:WaitForChild("Resizer")

	local window_data = {}
	Window.Draggable = true

	do -- Resize Window
		local oldIcon = mouse.Icon
		local Entered = false
		Resizer.MouseEnter:Connect(function()
			Window.Draggable = false
			if options.can_resize then
				oldIcon = mouse.Icon
				-- mouse.Icon = "http://www.roblox.com/asset?id=4745131330"
			end
			Entered = true
		end)

		Resizer.MouseLeave:Connect(function()
			Entered = false
			if options.can_resize then
				mouse.Icon = oldIcon
			end
			Window.Draggable = true
		end)

		local Held = false
		UIS.InputBegan:Connect(function(inputObject)
			if inputObject.UserInputType == Enum.UserInputType.MouseButton1 then
				Held = true

				spawn(function() -- Loop check
					if Entered and Resizer.Active and options.can_resize then
						while Held and Resizer.Active do

							local mouse_location = gMouse()
							local x = mouse_location.X - Window.AbsolutePosition.X
							local y = mouse_location.Y - Window.AbsolutePosition.Y

							--
							if x >= options.min_size.X and y >= options.min_size.Y then
								Resize(Window, {Size = UDim2.new(0, x, 0, y)}, options.tween_time)
							elseif x >= options.min_size.X then
								Resize(Window, {Size = UDim2.new(0, x, 0, options.min_size.Y)}, options.tween_time)
							elseif y >= options.min_size.Y then
								Resize(Window, {Size = UDim2.new(0, options.min_size.X, 0, y)}, options.tween_time)
							else
								Resize(Window, {Size = UDim2.new(0, options.min_size.X, 0, options.min_size.Y)}, options.tween_time)
							end

							RS.Heartbeat:Wait()
						end
					end
				end)
			end
		end)
		UIS.InputEnded:Connect(function(inputObject)
			if inputObject.UserInputType == Enum.UserInputType.MouseButton1 then
				Held = false
			end
		end)
	end

	do -- [Open / Close] Window
		local open_close = Window:FindFirstChild("Bar"):FindFirstChild("Toggle")
		local open = true
		local canopen = true

		local oldwindowdata = {}
		local oldy = Window.AbsoluteSize.Y
		open_close.MouseButton1Click:Connect(function()
			if canopen then
				canopen = false

				if open then
					-- Close

					oldwindowdata = {}
					for i,v in next, Window:FindFirstChild("Tabs"):GetChildren() do
						oldwindowdata[v] = v.Visible
						v.Visible = false
					end

					Resizer.Active = false

					oldy = Window.AbsoluteSize.Y
					Resize(open_close, {Rotation = 0}, options.tween_time)
					Resize(Window, {Size = UDim2.new(0, Window.AbsoluteSize.X, 0, 26)}, options.tween_time)
					open_close.Parent:FindFirstChild("Base").Transparency = 1

				else
					-- Open

					for i,v in next, oldwindowdata do
						i.Visible = v
					end

					Resizer.Active = true

					Resize(open_close, {Rotation = 90}, options.tween_time)
					Resize(Window, {Size = UDim2.new(0, Window.AbsoluteSize.X, 0, oldy)}, options.tween_time)
					open_close.Parent:FindFirstChild("Base").Transparency = 0

				end

				open = not open
				wait(options.tween_time)
				canopen = true

			end
		end)
	end

	do -- UI Elements
		local tabs = Window:FindFirstChild("Tabs")
		local tab_selection = Window:FindFirstChild("TabSelection")
		local tab_buttons = tab_selection:FindFirstChild("TabButtons")

		do -- Add Tab
			function window_data:AddTab(tab_name)
				local tab_data = {}
				tab_name = tostring(tab_name or "New Tab")
				tab_selection.Visible = true

				local new_button = Prefabs:FindFirstChild("TabButton"):Clone()
				new_button.Parent = tab_buttons
				new_button.Text = tab_name
				new_button.Size = UDim2.new(0, gNameLen(new_button), 0, 20)
				new_button.ZIndex = new_button.ZIndex + (windows * 10)
				new_button:GetChildren()[1].ZIndex = new_button:GetChildren()[1].ZIndex + (windows * 10)

				local new_tab = Prefabs:FindFirstChild("Tab"):Clone()
				new_tab.Parent = tabs
				new_tab.ZIndex = new_tab.ZIndex + (windows * 10)

				local function show()
					if dropdown_open then return end
					for i, v in next, tab_buttons:GetChildren() do
						if not (v:IsA("UIListLayout")) then
							v:GetChildren()[1].ImageColor3 = Color3.fromRGB(52, 53, 56)
							Resize(v, {Size = UDim2.new(0, v.AbsoluteSize.X, 0, 20)}, options.tween_time)
						end
					end
					for i, v in next, tabs:GetChildren() do
						v.Visible = false
					end

					Resize(new_button, {Size = UDim2.new(0, new_button.AbsoluteSize.X, 0, 25)}, options.tween_time)
					new_button:GetChildren()[1].ImageColor3 = Color3.fromRGB(73, 75, 79)
					new_tab.Visible = true
				end

				new_button.MouseButton1Click:Connect(function()
					show()
				end)

				function tab_data:Show()
					show()
				end

				do -- Tab Elements

					function tab_data:AddLabel(label_text) -- [Label]
						label_text = tostring(label_text or "New Label")

						local label = Prefabs:FindFirstChild("Label"):Clone()

						label.Parent = new_tab
						label.Text = label_text
						label.Size = UDim2.new(0, gNameLen(label), 0, 20)
						label.ZIndex = label.ZIndex + (windows * 10)

						return label
					end

					function tab_data:AddButton(button_text, callback) -- [Button]
						button_text = tostring(button_text or "New Button")
						callback = typeof(callback) == "function" and callback or function()end

						local button = Prefabs:FindFirstChild("Button"):Clone()

						button.Parent = new_tab
						button.Text = button_text
						button.Size = UDim2.new(0, gNameLen(button), 0, 20)
						button.ZIndex = button.ZIndex + (windows * 10)
						button:GetChildren()[1].ZIndex = button:GetChildren()[1].ZIndex + (windows * 10)

						spawn(function()
							while true do
								if button and button:GetChildren()[1] then
									button:GetChildren()[1].ImageColor3 = options.main_color
								end
								RS.Heartbeat:Wait()
							end
						end)

						button.MouseButton1Click:Connect(function()
							ripple(button, mouse.X, mouse.Y)
							pcall(callback)
						end)

						return button
					end

					function tab_data:AddSwitch(switch_text, callback) -- [Switch]
						local switch_data = {}

						switch_text = tostring(switch_text or "New Switch")
						callback = typeof(callback) == "function" and callback or function()end

						local switch = Prefabs:FindFirstChild("Switch"):Clone()

						switch.Parent = new_tab
						switch:FindFirstChild("Title").Text = switch_text

						switch:FindFirstChild("Title").ZIndex = switch:FindFirstChild("Title").ZIndex + (windows * 10)
						switch.ZIndex = switch.ZIndex + (windows * 10)
						switch:GetChildren()[1].ZIndex = switch:GetChildren()[1].ZIndex + (windows * 10)

						spawn(function()
							while true do
								if switch and switch:GetChildren()[1] then
									switch:GetChildren()[1].ImageColor3 = options.main_color
								end
								RS.Heartbeat:Wait()
							end
						end)

						local toggled = false
						switch.MouseButton1Click:Connect(function()
							toggled = not toggled
							switch.Text = toggled and utf8.char(10003) or ""
							pcall(callback, toggled)
						end)

						function switch_data:Set(bool)
							toggled = (typeof(bool) == "boolean") and bool or false
							switch.Text = toggled and utf8.char(10003) or ""
							pcall(callback,toggled)
						end

						return switch_data, switch
					end

					function tab_data:AddTextBox(textbox_text, callback, textbox_options)
						textbox_text = tostring(textbox_text or "New TextBox")
						callback = typeof(callback) == "function" and callback or function()end
						textbox_options = typeof(textbox_options) == "table" and textbox_options or {["clear"] = true}
						textbox_options = {
							["clear"] = ((textbox_options.clear) == true)
						}

						local textbox = Prefabs:FindFirstChild("TextBox"):Clone()

						textbox.Parent = new_tab
						textbox.PlaceholderText = textbox_text
						textbox.ZIndex = textbox.ZIndex + (windows * 10)
						textbox:GetChildren()[1].ZIndex = textbox:GetChildren()[1].ZIndex + (windows * 10)

						textbox.FocusLost:Connect(function(ep)
							if ep then
								if #textbox.Text > 0 then
									pcall(callback, textbox.Text)
									if textbox_options.clear then
										textbox.Text = ""
									end
								end
							end
						end)

						return textbox
					end

					function tab_data:AddSlider(slider_text, callback, slider_options)
						local slider_data = {}

						slider_text = tostring(slider_text or "New Slider")
						callback = typeof(callback) == "function" and callback or function()end
						slider_options = typeof(slider_options) == "table" and slider_options or {}
						slider_options = {
							["min"] = slider_options.min or 0,
							["max"] = slider_options.max or 100,
							["readonly"] = slider_options.readonly or false,
						}

						local slider = Prefabs:FindFirstChild("Slider"):Clone()

						slider.Parent = new_tab
						slider.ZIndex = slider.ZIndex + (windows * 10)

						local title = slider:FindFirstChild("Title")
						local indicator = slider:FindFirstChild("Indicator")
						local value = slider:FindFirstChild("Value")
						title.ZIndex = title.ZIndex + (windows * 10)
						indicator.ZIndex = indicator.ZIndex + (windows * 10)
						value.ZIndex = value.ZIndex + (windows * 10)

						title.Text = slider_text

						do -- Slider Math
							local Entered = false
							slider.MouseEnter:Connect(function()
								Entered = true
								Window.Draggable = false
							end)
							slider.MouseLeave:Connect(function()
								Entered = false
								Window.Draggable = true
							end)

							local Held = false
							UIS.InputBegan:Connect(function(inputObject)
								if inputObject.UserInputType == Enum.UserInputType.MouseButton1 then
									Held = true

									spawn(function() -- Loop check
										if Entered and not slider_options.readonly then
											while Held and (not dropdown_open) do
												local mouse_location = gMouse()
												local x = (slider.AbsoluteSize.X - (slider.AbsoluteSize.X - ((mouse_location.X - slider.AbsolutePosition.X)) + 1)) / slider.AbsoluteSize.X

												local min = 0
												local max = 1

												local size = min
												if x >= min and x <= max then
													size = x
												elseif x < min then
													size = min
												elseif x > max then
													size = max
												end

												Resize(indicator, {Size = UDim2.new(size or min, 0, 0, 20)}, options.tween_time)
												local p = math.floor((size or min) * 100)

												local maxv = slider_options.max
												local minv = slider_options.min
												local diff = maxv - minv

												local sel_value = math.floor(((diff / 100) * p) + minv)

												value.Text = tostring(sel_value)
												pcall(callback, sel_value)

												RS.Heartbeat:Wait()
											end
										end
									end)
								end
							end)
							UIS.InputEnded:Connect(function(inputObject)
								if inputObject.UserInputType == Enum.UserInputType.MouseButton1 then
									Held = false
								end
							end)

							function slider_data:Set(new_value)
								new_value = tonumber(new_value) or 0
								new_value = (((new_value >= 0 and new_value <= 100) and new_value) / 100)

								Resize(indicator, {Size = UDim2.new(new_value or 0, 0, 0, 20)}, options.tween_time)
								local p = math.floor((new_value or 0) * 100)

								local maxv = slider_options.max
								local minv = slider_options.min
								local diff = maxv - minv

								local sel_value = math.floor(((diff / 100) * p) + minv)

								value.Text = tostring(sel_value)
								pcall(callback, sel_value)
							end

							slider_data:Set(slider_options["min"])
						end

						return slider_data, slider
					end

					function tab_data:AddKeybind(keybind_name, callback, keybind_options)
						local keybind_data = {}

						keybind_name = tostring(keybind_name or "New Keybind")
						callback = typeof(callback) == "function" and callback or function()end
						keybind_options = typeof(keybind_options) == "table" and keybind_options or {}
						keybind_options = {
							["standard"] = keybind_options.standard or Enum.KeyCode.RightShift,
						}

						local keybind = Prefabs:FindFirstChild("Keybind"):Clone()
						local input = keybind:FindFirstChild("Input")
						local title = keybind:FindFirstChild("Title")
						keybind.ZIndex = keybind.ZIndex + (windows * 10)
						input.ZIndex = input.ZIndex + (windows * 10)
						input:GetChildren()[1].ZIndex = input:GetChildren()[1].ZIndex + (windows * 10)
						title.ZIndex = title.ZIndex + (windows * 10)

						keybind.Parent = new_tab
						title.Text = "  " .. keybind_name
						keybind.Size = UDim2.new(0, gNameLen(title) + 80, 0, 20)

						local shortkeys = { -- thanks to stroketon for helping me out with this
				            RightControl = 'RightCtrl',
				            LeftControl = 'LeftCtrl',
				            LeftShift = 'LShift',
				            RightShift = 'RShift',
				            MouseButton1 = "Mouse1",
				            MouseButton2 = "Mouse2"
				        }

						local keybind = keybind_options.standard

						function keybind_data:SetKeybind(Keybind)
							local key = shortkeys[Keybind.Name] or Keybind.Name
							input.Text = key
							keybind = Keybind
						end

						UIS.InputBegan:Connect(function(a, b)
							if checks.binding then
								spawn(function()
									wait()
									checks.binding = false
								end)
								return
							end
							if a.KeyCode == keybind and not b then
								pcall(callback, keybind)
							end
						end)

						keybind_data:SetKeybind(keybind_options.standard)

						input.MouseButton1Click:Connect(function()
							if checks.binding then return end
							input.Text = "..."
							checks.binding = true
							local a, b = UIS.InputBegan:Wait()
							keybind_data:SetKeybind(a.KeyCode)
						end)

						return keybind_data, keybind
					end

					function tab_data:AddDropdown(dropdown_name, callback)
						local dropdown_data = {}
						dropdown_name = tostring(dropdown_name or "New Dropdown")
						callback = typeof(callback) == "function" and callback or function()end

						local dropdown = Prefabs:FindFirstChild("Dropdown"):Clone()
						local box = dropdown:FindFirstChild("Box")
						local objects = box:FindFirstChild("Objects")
						local indicator = dropdown:FindFirstChild("Indicator")
						dropdown.ZIndex = dropdown.ZIndex + (windows * 10)
						box.ZIndex = box.ZIndex + (windows * 10)
						objects.ZIndex = objects.ZIndex + (windows * 10)
						indicator.ZIndex = indicator.ZIndex + (windows * 10)
						dropdown:GetChildren()[3].ZIndex = dropdown:GetChildren()[3].ZIndex + (windows * 10)

						dropdown.Parent = new_tab
						dropdown.Text = "      " .. dropdown_name
						box.Size = UDim2.new(1, 0, 0, 0)

						local open = false
						dropdown.MouseButton1Click:Connect(function()
							open = not open

							local len = (#objects:GetChildren() - 1) * 20
							if #objects:GetChildren() - 1 >= 10 then
								len = 10 * 20
								objects.CanvasSize = UDim2.new(0, 0, (#objects:GetChildren() - 1) * 0.1, 0)
							end

							if open then -- Open
								if dropdown_open then return end
								dropdown_open = true
								Resize(box, {Size = UDim2.new(1, 0, 0, len)}, options.tween_time)
								Resize(indicator, {Rotation = 90}, options.tween_time)
							else -- Close
								dropdown_open = false
								Resize(box, {Size = UDim2.new(1, 0, 0, 0)}, options.tween_time)
								Resize(indicator, {Rotation = -90}, options.tween_time)
							end

						end)

						function dropdown_data:Add(n)
							local object_data = {}
							n = tostring(n or "New Object")

							local object = Prefabs:FindFirstChild("DropdownButton"):Clone()

							object.Parent = objects
							object.Text = n
							object.ZIndex = object.ZIndex + (windows * 10)

							object.MouseEnter:Connect(function()
								object.BackgroundColor3 = options.main_color
							end)
							object.MouseLeave:Connect(function()
								object.BackgroundColor3 = Color3.fromRGB(33, 34, 36)
							end)

							if open then
								local len = (#objects:GetChildren() - 1) * 20
								if #objects:GetChildren() - 1 >= 10 then
									len = 10 * 20
									objects.CanvasSize = UDim2.new(0, 0, (#objects:GetChildren() - 1) * 0.1, 0)
								end
								Resize(box, {Size = UDim2.new(1, 0, 0, len)}, options.tween_time)
							end

							object.MouseButton1Click:Connect(function()
								if dropdown_open then
									dropdown.Text = "      [ " .. n .. " ]"
									dropdown_open = false
									open = false
									Resize(box, {Size = UDim2.new(1, 0, 0, 0)}, options.tween_time)
									Resize(indicator, {Rotation = -90}, options.tween_time)
									pcall(callback, n)
								end
							end)
							function object_data:Remove()
								object:Destroy()
							end

							return object, object_data
						end

						return dropdown_data, dropdown
					end

					function tab_data:AddColorPicker(callback)
						local color_picker_data = {}
						callback = typeof(callback) == "function" and callback or function()end

						local color_picker = Prefabs:FindFirstChild("ColorPicker"):Clone()

						color_picker.Parent = new_tab
						color_picker.ZIndex = color_picker.ZIndex + (windows * 10)

						local palette = color_picker:FindFirstChild("Palette")
						local sample = color_picker:FindFirstChild("Sample")
						local saturation = color_picker:FindFirstChild("Saturation")
						palette.ZIndex = palette.ZIndex + (windows * 10)
						sample.ZIndex = sample.ZIndex + (windows * 10)
						saturation.ZIndex = saturation.ZIndex + (windows * 10)

						do -- Color Picker Math
							local h = 0
							local s = 1
							local v = 1

							local function update()
								local color = Color3.fromHSV(h, s, v)
								sample.ImageColor3 = color
								saturation.ImageColor3 = Color3.fromHSV(h, 1, 1)
								pcall(callback, color)
							end

							do
								local color = Color3.fromHSV(h, s, v)
								sample.ImageColor3 = color
								saturation.ImageColor3 = Color3.fromHSV(h, 1, 1)
							end

							local Entered1, Entered2 = false, false
							palette.MouseEnter:Connect(function()
								Window.Draggable = false
								Entered1 = true
							end)
							palette.MouseLeave:Connect(function()
								Window.Draggable = true
								Entered1 = false
							end)
							saturation.MouseEnter:Connect(function()
								Window.Draggable = false
								Entered2 = true
							end)
							saturation.MouseLeave:Connect(function()
								Window.Draggable = true
								Entered2 = false
							end)

							local palette_indicator = palette:FindFirstChild("Indicator")
							local saturation_indicator = saturation:FindFirstChild("Indicator")
							palette_indicator.ZIndex = palette_indicator.ZIndex + (windows * 10)
							saturation_indicator.ZIndex = saturation_indicator.ZIndex + (windows * 10)

							local Held = false
							UIS.InputBegan:Connect(function(inputObject)
								if inputObject.UserInputType == Enum.UserInputType.MouseButton1 then
									Held = true

									spawn(function() -- Loop check
										while Held and Entered1 and (not dropdown_open) do -- Palette
											local mouse_location = gMouse()

											local x = ((palette.AbsoluteSize.X - (mouse_location.X - palette.AbsolutePosition.X)) + 1)
											local y = ((palette.AbsoluteSize.Y - (mouse_location.Y - palette.AbsolutePosition.Y)) + 1.5)

											local color = Color3.fromHSV(x / 100, y / 100, 0)
											h = x / 100
											s = y / 100

											Resize(palette_indicator, {Position = UDim2.new(0, math.abs(x - 100) - (palette_indicator.AbsoluteSize.X / 2), 0, math.abs(y - 100) - (palette_indicator.AbsoluteSize.Y / 2))}, options.tween_time)

											update()
											RS.Heartbeat:Wait()
										end

										while Held and Entered2 and (not dropdown_open) do -- Saturation
											local mouse_location = gMouse()
											local y = ((palette.AbsoluteSize.Y - (mouse_location.Y - palette.AbsolutePosition.Y)) + 1.5)
											v = y / 100

											Resize(saturation_indicator, {Position = UDim2.new(0, 0, 0, math.abs(y - 100))}, options.tween_time)

											update()
											RS.Heartbeat:Wait()
										end
									end)
								end
							end)
							UIS.InputEnded:Connect(function(inputObject)
								if inputObject.UserInputType == Enum.UserInputType.MouseButton1 then
									Held = false
								end
							end)

							function color_picker_data:Set(color)
								color = typeof(color) == "Color3" and color or Color3.new(1, 1, 1)
								local h2, s2, v2 = rgbtohsv(color.r * 255, color.g * 255, color.b * 255)
								sample.ImageColor3 = color
								saturation.ImageColor3 = Color3.fromHSV(h2, 1, 1)
								pcall(callback, color)
							end
						end

						return color_picker_data, color_picker
					end

					function tab_data:AddConsole(console_options)
						local console_data = {}

						console_options = typeof(console_options) == "table" and console_options or {["readonly"] = true,["full"] = false,}
						console_options = {
							["y"] = tonumber(console_options.y) or 200,
							["source"] = console_options.source or "Logs",
							["readonly"] = ((console_options.readonly) == true),
							["full"] = ((console_options.full) == true),
						}

						local console = Prefabs:FindFirstChild("Console"):Clone()

						console.Parent = new_tab
						console.ZIndex = console.ZIndex + (windows * 10)
						console.Size = UDim2.new(1, 0, console_options.full and 1 or 0, console_options.y)

						local sf = console:GetChildren()[1]
						local Source = sf:FindFirstChild("Source")
						local Lines = sf:FindFirstChild("Lines")
						Source.ZIndex = Source.ZIndex + (windows * 10)
						Lines.ZIndex = Lines.ZIndex + (windows * 10)

						Source.TextEditable = not console_options.readonly

						do -- Syntax Zindex
							for i,v in next, Source:GetChildren() do
								v.ZIndex = v.ZIndex + (windows * 10) + 1
							end
						end
						Source.Comments.ZIndex = Source.Comments.ZIndex + 1

						do -- Highlighting (thanks to whoever made this)
							local lua_keywords = {"and", "break", "do", "else", "elseif", "end", "false", "for", "function", "goto", "if", "in", "local", "nil", "not", "or", "repeat", "return", "then", "true", "until", "while"}
							local global_env = {"getrawmetatable", "newcclosure", "islclosure", "setclipboard", "game", "workspace", "script", "math", "string", "table", "print", "wait", "BrickColor", "Color3", "next", "pairs", "ipairs", "select", "unpack", "Instance", "Vector2", "Vector3", "CFrame", "Ray", "UDim2", "Enum", "assert", "error", "warn", "tick", "loadstring", "_G", "shared", "getfenv", "setfenv", "newproxy", "setmetatable", "getmetatable", "os", "debug", "pcall", "ypcall", "xpcall", "rawequal", "rawset", "rawget", "tonumber", "tostring", "type", "typeof", "_VERSION", "coroutine", "delay", "require", "spawn", "LoadLibrary", "settings", "stats", "time", "UserSettings", "version", "Axes", "ColorSequence", "Faces", "ColorSequenceKeypoint", "NumberRange", "NumberSequence", "NumberSequenceKeypoint", "gcinfo", "elapsedTime", "collectgarbage", "PhysicalProperties", "Rect", "Region3", "Region3int16", "UDim", "Vector2int16", "Vector3int16", "load", "fire", "Fire"}

							local Highlight = function(string, keywords)
							    local K = {}
							    local S = string
							    local Token =
							    {
							        ["="] = true,
							        ["."] = true,
							        [","] = true,
							        ["("] = true,
							        [")"] = true,
							        ["["] = true,
							        ["]"] = true,
							        ["{"] = true,
							        ["}"] = true,
							        [":"] = true,
							        ["*"] = true,
							        ["/"] = true,
							        ["+"] = true,
							        ["-"] = true,
							        ["%"] = true,
									[";"] = true,
									["~"] = true
							    }
							    for i, v in pairs(keywords) do
							        K[v] = true
							    end
							    S = S:gsub(".", function(c)
							        if Token[c] ~= nil then
							            return "\32"
							        else
							            return c
							        end
							    end)
							    S = S:gsub("%S+", function(c)
							        if K[c] ~= nil then
							            return c
							        else
							            return (" "):rep(#c)
							        end
							    end)

							    return S
							end

							local hTokens = function(string)
							    local Token =
							    {
							        ["="] = true,
							        ["."] = true,
							        [","] = true,
							        ["("] = true,
							        [")"] = true,
							        ["["] = true,
							        ["]"] = true,
							        ["{"] = true,
							        ["}"] = true,
							        [":"] = true,
							        ["*"] = true,
							        ["/"] = true,
							        ["+"] = true,
							        ["-"] = true,
							        ["%"] = true,
									[";"] = true,
									["~"] = true
							    }
							    local A = ""
							    string:gsub(".", function(c)
							        if Token[c] ~= nil then
							            A = A .. c
							        elseif c == "\n" then
							            A = A .. "\n"
									elseif c == "\t" then
										A = A .. "\t"
							        else
							            A = A .. "\32"
							        end
							    end)

							    return A
							end

							local strings = function(string)
							    local highlight = ""
							    local quote = false
							    string:gsub(".", function(c)
							        if quote == false and c == "\34" then
							            quote = true
							        elseif quote == true and c == "\34" then
							            quote = false
							        end
							        if quote == false and c == "\34" then
							            highlight = highlight .. "\34"
							        elseif c == "\n" then
							            highlight = highlight .. "\n"
									elseif c == "\t" then
									    highlight = highlight .. "\t"
							        elseif quote == true then
							            highlight = highlight .. c
							        elseif quote == false then
							            highlight = highlight .. "\32"
							        end
							    end)

							    return highlight
							end

							local info = function(string)
							    local highlight = ""
							    local quote = false
							    string:gsub(".", function(c)
							        if quote == false and c == "[" then
							            quote = true
							        elseif quote == true and c == "]" then
							            quote = false
							        end
							        if quote == false and c == "]" then
							            highlight = highlight .. "]"  -- fig bug
							        elseif c == "\n" then
							            highlight = highlight .. "\n"
									elseif c == "\t" then
									    highlight = highlight .. "\t"
							        elseif quote == true then
							            highlight = highlight .. c
							        elseif quote == false then
							            highlight = highlight .. "\32"
							        end
							    end)

							    return highlight
							end

							local comments = function(string)
							    local ret = ""
							    string:gsub("[^\r\n]+", function(c)
							        local comm = false
							        local i = 0
							        c:gsub(".", function(n)
							            i = i + 1
							            if c:sub(i, i + 1) == "--" then
							                comm = true
							            end
							            if comm == true then
							                ret = ret .. n
							            else
							                ret = ret .. "\32"
							            end
							        end)
							        ret = ret
							    end)

							    return ret
							end

							local numbers = function(string)
							    local A = ""
							    string:gsub(".", function(c)
							        if tonumber(c) ~= nil then
							            A = A .. c
							        elseif c == "\n" then
							            A = A .. "\n"
									elseif c == "\t" then
										A = A .. "\t"
							        else
							            A = A .. "\32"
							        end
							    end)

							    return A
							end

							local highlight_lua = function(type)
								if type == "Text" then
									Source.Text = Source.Text:gsub("\13", "")
									Source.Text = Source.Text:gsub("\t", "      ")
									local s = Source.Text

									Source.Keywords.Text = Highlight(s, lua_keywords)
									Source.Globals.Text = Highlight(s, global_env)
									Source.RemoteHighlight.Text = Highlight(s, {"FireServer", "fireServer", "InvokeServer", "invokeServer"})
									Source.Tokens.Text = hTokens(s)
									Source.Numbers.Text = numbers(s)
									Source.Strings.Text = strings(s)
									Source.Comments.Text = comments(s)

									local lin = 1
									s:gsub("\n", function()
										lin = lin + 1
									end)

									Lines.Text = ""
									for i = 1, lin do
										Lines.Text = Lines.Text .. i .. "\n"
									end

									sf.CanvasSize = UDim2.new(0, 0, lin * 0.153846154, 0)
								end

							local highlight_logs = function(type)
							end
								if type == "Text" then
									Source.Text = Source.Text:gsub("\13", "")
									Source.Text = Source.Text:gsub("\t", "      ")
									local s = Source.Text

									Source.Info.Text = info(s)

									local lin = 1
									s:gsub("\n", function()
										lin = lin + 1
									end)

									sf.CanvasSize = UDim2.new(0, 0, lin * 0.153846154, 0)
								end
							end

							if console_options.source == "Lua" then
								highlight_lua("Text")
								Source.Changed:Connect(highlight_lua)
							elseif console_options.source == "Logs" then
								Lines.Visible = false

								highlight_logs("Text")
								Source.Changed:Connect(highlight_logs)
							end

							function console_data:Set(code)
								Source.Text = tostring(code)
							end

							function console_data:Get()
								return Source.Text
							end

							function console_data:Log(msg)
								Source.Text = Source.Text .. "[*] " .. tostring(msg) .. "\n"
							end

						end

						return console_data, console
					end

					function tab_data:AddHorizontalAlignment()
						local ha_data = {}

						local ha = Prefabs:FindFirstChild("HorizontalAlignment"):Clone()
						ha.Parent = new_tab

						function ha_data:AddButton(...)
							local data, object
							local ret = {tab_data:AddButton(...)}
							if typeof(ret[1]) == "table" then
								data = ret[1]
								object = ret[2]
								object.Parent = ha
								return data, object
							else
								object = ret[1]
								object.Parent = ha
								return object
							end
						end

						return ha_data, ha
					end

					function tab_data:AddFolder(folder_name) -- [Folder]
						local folder_data = {}

						folder_name = tostring(folder_name or "New Folder")

						local folder = Prefabs:FindFirstChild("Folder"):Clone()
						local button = folder:FindFirstChild("Button")
						local objects = folder:FindFirstChild("Objects")
						local toggle = button:FindFirstChild("Toggle")
						folder.ZIndex = folder.ZIndex + (windows * 10)
						button.ZIndex = button.ZIndex + (windows * 10)
						objects.ZIndex = objects.ZIndex + (windows * 10)
						toggle.ZIndex = toggle.ZIndex + (windows * 10)
						button:GetChildren()[1].ZIndex = button:GetChildren()[1].ZIndex + (windows * 10)

						folder.Parent = new_tab
						button.Text = "      " .. folder_name

						spawn(function()
							while true do
								if button and button:GetChildren()[1] then
									button:GetChildren()[1].ImageColor3 = options.main_color
								end
								RS.Heartbeat:Wait()
							end
						end)

						local function gFolderLen()
							local n = 25
							for i,v in next, objects:GetChildren() do
								if not (v:IsA("UIListLayout")) then
									n = n + v.AbsoluteSize.Y + 5
								end
							end
							return n
						end

						local open = false
						button.MouseButton1Click:Connect(function()
							if open then -- Close
								Resize(toggle, {Rotation = 0}, options.tween_time)
								objects.Visible = false
							else -- Open
								Resize(toggle, {Rotation = 90}, options.tween_time)
								objects.Visible = true
							end

							open = not open
						end)

						spawn(function()
							while true do
								Resize(folder, {Size = UDim2.new(1, 0, 0, (open and gFolderLen() or 20))}, options.tween_time)
								wait()
							end
						end)

						for i,v in next, tab_data do
							folder_data[i] = function(...)
								local data, object
								local ret = {v(...)}
								if typeof(ret[1]) == "table" then
									data = ret[1]
									object = ret[2]
									object.Parent = objects
									return data, object
								else
									object = ret[1]
									object.Parent = objects
									return object
								end
							end
						end

						return folder_data, folder
					end

				end

				return tab_data, new_tab
			end
		end
	end

	do
		for i, v in next, Window:GetDescendants() do
			if hasprop(v, "ZIndex") then
				v.ZIndex = v.ZIndex + (windows * 10)
			end
		end
	end

	return window_data, Window
end

--#endregion

--#region GetCurrentLevelName

local function GetCurrentLevelName()
	if game.Workspace._MAP_CONFIG then
		return game:GetService("Workspace")._MAP_CONFIG.GetLevelData:InvokeServer()["name"]
	end
end

--#endregion

--#region [Function] Setting WebHook
function disp_time(seconds)
  hours = string.format("%02.f", math.floor(seconds/3600))
  mins = string.format("%02.f", math.floor(seconds/60 - (hours*60)))
  secs = string.format("%02.f", math.floor(seconds - hours*3600 - mins*60))
  return mins..":"..secs
end

function get_user_img_url()
  local response = HttpService:JSONDecode(game:HttpGet('https://thumbnails.roblox.com/v1/users/avatar-bust?userIds=' .. LocalPlayer.UserId .. '&size=420x420&format=Png&isCircular=false'))
  for i, v in pairs(response.data) do
    return tostring(v.imageUrl)
  end
end


------------item drop result
local Table_All_Items_New_data = {}

function getCSMPortals()
	local reg = getreg() --> returns Roblox's registry in a table
	for i, v in next, reg do
		if type(v) == "function" then --> Checks if the current iteration is a function
			if getfenv(v).script then --> Checks if the function's environment is in a script
				--if getfenv(v).script:GetFullName() == "ReplicatedStorage.src.client.Services.DropService" or getfenv(v).script:GetFullName() == "ReplicatedStorage.src.client.Services.NPCServiceClient" then
				for _, v in pairs(debug.getupvalues(v)) do --> Basically a for loop that prints everything, but in one line
					if type(v) == "table" then
						if v["session"] then
							local portals = {}
							for _, item in pairs(v["session"]["inventory"]["inventory_profile_data"]["unique_items"]) do
									table.insert(portals, item)
							end
							return portals
						end
					end
				end
			end
		end
	end
end

for _, v3 in pairs(game:GetService("ReplicatedStorage").src.Data.Items:GetDescendants()) do
	if v3:IsA("ModuleScript") then
		for v4, v5 in pairs(require(v3)) do
			Table_All_Items_New_data[v4] = {}
			Table_All_Items_New_data[v4]['Name'] = v5['name']
			Table_All_Items_New_data[v4]['Count'] = 0
		end
	end
end

function getNormalItems()
	local reg = getreg() --> returns Roblox's registry in a table
	for i, v in next, reg do
		if type(v) == "function" then --> Checks if the current iteration is a function
			if getfenv(v).script then --> Checks if the function's environment is in a script
				--if getfenv(v).script:GetFullName() == "ReplicatedStorage.src.client.Services.DropService" or getfenv(v).script:GetFullName() == "ReplicatedStorage.src.client.Services.NPCServiceClient" then
				for _, v in pairs(debug.getupvalues(v)) do --> Basically a for loop that prints everything, but in one line
					if type(v) == "table" then
						if v["session"] then
							return v["session"]["inventory"]["inventory_profile_data"]["normal_items"]
						end
					end
				end
				--end
			end
		end
	end
end

function getItemChangesNormal(preGameTable, currentTable)
	local itemChanges = {}

	for item, amount in pairs(currentTable) do
		if preGameTable[item] == nil then
			print(item .. ": +" .. amount)
			itemChanges[item] = "+" .. amount
		else
			if preGameTable[item] > amount then
				print(item .. ": -" .. preGameTable[item] - amount)
				itemChanges[item] = "-" .. preGameTable[item] - amount
			elseif preGameTable[item] < amount then
				print(item .. "+" .. amount - preGameTable[item])
				itemChanges[item] = "+" .. amount - preGameTable[item]
			end
		end
	end
	return itemChanges
end

function getUniqueItems()
	local reg = getreg() --> returns Roblox's registry in a table

	for i, v in next, reg do
		if type(v) == "function" then --> Checks if the current iteration is a function
			if getfenv(v).script then --> Checks if the function's environment is in a script
				--if getfenv(v).script:GetFullName() == "ReplicatedStorage.src.client.Services.DropService" or getfenv(v).script:GetFullName() == "ReplicatedStorage.src.client.Services.NPCServiceClient" then
				for _, v in pairs(debug.getupvalues(v)) do --> Basically a for loop that prints everything, but in one line
					if type(v) == "table" then
						if v["session"] then
							return v["session"]["inventory"]["inventory_profile_data"]["unique_items"]
						end
					end
				end
				--end
			end
		end
	end
end

function getItemChangesUnique(preGameTable, postGameTable)
	local itemAdditions = {}

	for _, item in pairs(postGameTable) do
		local currentItemUUID = item["uuid"]
		local currentItemIsNew = true
		for i, itemToCompare in pairs(preGameTable) do
			if itemToCompare["uuid"] == currentItemUUID then
				currentItemIsNew = false
			end
		end
		if currentItemIsNew then
			print("New Unique Item: " .. item["item_id"])
			table.insert(itemAdditions, item["item_id"])
		end
	end

	return itemAdditions
end

function shallowCopy(original)
	local copy = {}
	for key, value in pairs(original) do
		copy[key] = value
	end
	return copy
end

repeat local testItemGet = getNormalItems() until testItemGet ~= nil

getgenv().startingInventoryNormalItems = shallowCopy(getNormalItems())
getgenv().startingInventoryUniqueItems = shallowCopy(getUniqueItems())


--#endregion

--#region [Function] Web Hook Deteal
function update_data()
	print('Start 1')
	getgenv().end_time = os.time()

	local itemDifference = getItemChangesNormal(getgenv().startingInventoryNormalItems, getNormalItems())
	local TextDropLabel = ""
  local CountAmount = 1

	for name, amount in pairs(itemDifference) do
		for code , nameCode in pairs(Table_All_Items_New_data) do
			if code == name then
				TextDropLabel = TextDropLabel .. tostring(CountAmount) .. ". " .. tostring(nameCode["Name"]) .. " : " .. tostring(amount) .. "\n"
				CountAmount = CountAmount + 1
				break
			end
		end
	end

  if TextDropLabel == "" then
    TextDropLabel = "ไม่มีไอเท็มที่ได้รับ"
  end

	print('Log 1')
  user_level = tostring(LocalPlayer.PlayerGui.spawn_units.Lives.Main.Desc.Level.Text)
	total_gems = tostring(LocalPlayer._stats.gem_amount.Value)
	gem_reward = tostring(LocalPlayer.PlayerGui.ResultsUI.Holder.LevelRewards.ScrollingFrame.GemReward.Main.Amount.Text)
	trophy_reward = tostring(LocalPlayer.PlayerGui.ResultsUI.Holder.LevelRewards.ScrollingFrame.TrophyReward.Main.Amount.Text)
	xp_reward = tostring(LocalPlayer.PlayerGui.ResultsUI.Holder.LevelRewards.ScrollingFrame.XPReward.Main.Amount.Text):split(" ")[1]
	total_wave = tostring(LocalPlayer.PlayerGui.ResultsUI.Holder.Middle.WavesCompleted.Text):split(": ")[2]
	total_time = tostring(LocalPlayer.PlayerGui.ResultsUI.Holder.Middle.Timer.Text):split(": ")[2]
	result = tostring(LocalPlayer.PlayerGui.ResultsUI.Holder.Title.Text)

	local itemInventory = getNormalItems()
	local portal_name = getCSMPortals()
	local demon_portal = 0
	local alien_portal = 0
	local devil_Academy = 0
	local alien_scouter = 0
	local tomoe = 0
	local relicShard = 0
	local starfruit = 0
	local starfruit_rainbow = 0
	local starfruit_green = 0
	local starfruit_red = 0
	local starfruit_blue = 0
	local starfruit_pink = 0
	local demonShard = 0
	local entertainShard = 0
	--//Egg
	local easter_egg_1 = 0
	local easter_egg_2 = 0
	local easter_egg_3 = 0
	local easter_egg_4 = 0
	local easter_egg_5 = 0
	local easter_egg_6 = 0
	--// end Egg
	local six_eye = 0
	for name, amount in pairs(itemInventory) do

		if name == "west_city_frieza_item" then
			alien_scouter = tostring(amount or 0)
		elseif name == "uchiha_item" then
			tomoe = tostring(amount or 0)
		elseif name == "relic_shard" then
			relicShard = tostring(amount or 0)
		elseif name == "StarFruit" then
			starfruit = tostring(amount or 0)
		elseif name == "StarFruitEpic" then
			starfruit_rainbow = tostring(amount or 0)
		elseif name == "StarFruitGreen" then
			starfruit_green = tostring(amount or 0)
		elseif name == "StarFruitRed" then
			starfruit_red = tostring(amount or 0)
		elseif name == "StarFruitBlue" then
			starfruit_blue = tostring(amount or 0)
		elseif name == "StarFruitPink" then
			starfruit_pink = tostring(amount or 0)
		elseif name == "april_symbol" then
			demonShard = tostring(amount or 0)
		elseif name == "easter_egg_1" then
			easter_egg_1 = tostring(amount or 0)
		elseif name == "easter_egg_2" then
			easter_egg_2 = tostring(amount or 0)
		elseif name == "easter_egg_3" then
			easter_egg_3 = tostring(amount or 0)
		elseif name == "easter_egg_4" then
			easter_egg_4 = tostring(amount or 0)
		elseif name == "easter_egg_5" then
			easter_egg_5 = tostring(amount or 0)
		elseif name == "easter_egg_6" then
			easter_egg_6 = tostring(amount or 0)
		elseif name == "entertainment_district_item" then
			entertainShard = tostring(amount or 0)
		elseif name == "six_eyes" then
			six_eye = tostring(amount or 0)
		end
	end

	

	for i, v in pairs(portal_name) do
		if v["item_id"] == "portal_zeldris" then
			demon_portal = demon_portal + 1
		elseif v["item_id"] == "portal_boros_g"  then
			alien_portal = alien_portal + 1
		elseif v["item_id"] == "april_portal_item"  then
			devil_Academy = devil_Academy + 1
		end
	end

	print('Log 2')

	if gem_reward == "+99999" then gem_reward = "+0" end
	if xp_reward == "+99999" then xp_reward = "+0" end
	if trophy_reward == "+99999" then trophy_reward = "+0" end
	if result == "VICTORY" then
    result = "ชัยชนะ"
  else
    result = "พ่ายแพ้"
  end
	print('Log 3')
  if getgenv().autoSelectMode == "ฟาร์มเพชร" then
    gem_reward = tostring(LocalPlayer.PlayerGui.Waves.HealthBar.IngameRewards.GemRewardTotal.Holder.Main.Amount.Text)
    total_wave = tostring(Workspace["_wave_num"].Value)
    total_time = disp_time(os.difftime(getgenv().end_time, getgenv().start_time))
  end
	print('Log 4')

	myGems = getgenv().resultGems + gem_reward
	if getgenv().autoSelectMode == "ฟาร์มเพชร" then
		getgenv().textGem = getgenv().textGem - gem_reward
	else
		getgenv().textGem = getgenv().textGem - 0
	end
	permeNategems = myGems + getgenv().textGem
	getgenv().resultGems = myGems
	updatejson()

	print('Log 5')
	--print(Table_All_Items_New_data["entertainment_district_item"]['Count'])
	-- // Raid // --


	--
	--tostring(Table_All_Items_New_data["six_eyes"]['Name']) .. ": x" .. tostring(Table_All_Items_New_data["six_eyes"]['Count'] or 0)
	--Table_All_Items_New_data["six_eyes"]['Count'] or 0

	for name, amount in pairs(itemDifference) do
		if getgenv().autoSelectMode == "ฟาร์มไอเท็มเรด" and getgenv().autoSelectItem == "Alien Scouter" and name == "west_city_frieza_item" then
			getgenv().textGem = tonumber(getgenv().textGem) - amount
			if tonumber(getgenv().textGem) <= 1 then
				pcall(function () webhook_finish() end)
				updatejson()
				return
			end
			updatejson()
			task.wait(1)
			break
		elseif getgenv().autoSelectMode == "ฟาร์มไอเท็มเรด" and getgenv().autoSelectItem == "Tomoe" and name == "uchiha_item" then
			getgenv().textGem = tonumber(getgenv().textGem) - amount
			if tonumber(getgenv().textGem) <= 1 then
				pcall(function () webhook_finish() end)
				updatejson()
				return
			end
			updatejson()
			task.wait(1)
			break
		elseif getgenv().autoSelectMode == "ฟาร์มไอเท็มเรด" and getgenv().autoSelectItem == "Entertain Shard" and name == "entertainment_district_item" then
			getgenv().textGem = tonumber(getgenv().textGem) - amount
			if tonumber(getgenv().textGem) <= 1 then
				pcall(function () webhook_finish() end)
				updatejson()
				return
			end
			updatejson()
			task.wait(1)
			break
		elseif getgenv().autoSelectMode == "ฟาร์มไอเท็มเรด" and getgenv().autoSelectItem == "Demon Shard" and name == "april_symbol" then
			getgenv().textGem = tonumber(getgenv().textGem) - amount
			if tonumber(getgenv().textGem) <= 1 then
				pcall(function () webhook_finish() end)
				updatejson()
				return
			end
			updatejson()
			task.wait(1)
			break
		elseif getgenv().autoSelectMode == "ฟาร์มไอเท็มเรด" and getgenv().autoSelectItem == "Relic Shard" and name == "relic_shard" then
			getgenv().textGem = tonumber(getgenv().textGem) - amount
			if tonumber(getgenv().textGem) <= 0 then
				pcall(function () webhook_finish() end)
				updatejson()
				return
			end
			updatejson()
			task.wait(1)
			break
		elseif getgenv().autoSelectMode == "ฟาร์มตาโกโจ" and getgenv().autoSelectItem == "SIX EYE" and name == "six_eyes" then
			getgenv().textGem = tonumber(getgenv().textGem) - amount
			if tonumber(getgenv().textGem) <= 0 then
				pcall(function () webhook_finish() end)
				updatejson()
				return
			end
			updatejson()
			task.wait(1)
			break
		end
		
	end

	

	print('Log 6')

  return {
    ["content"] = "",
    ["username"] = "GGx Shop",
    ["avatar_url"] = "https://cdn.discordapp.com/attachments/1044102091804774430/1079198787693711532/GGxShop_2.png",
    ["embeds"] = {
      {
        ["author"] = {
			["name"] = "  "
		  },
		  ["title"] =" <a:jj:1101312850292637848>".."════┇ GGx Shop ┇════".." <a:jj:1101312850292637848>",
		  ["color"] = 0xFF00FF,
		  ["thumbnail"] = {
			["url"] = get_user_img_url(),
        },
        ["fields"] = {
			{
			["name"] ="<a:scribbleheartcut:1101245449156968528>ไอดีลูกกระจ๊อก<a:scribbleheartcut:1101245449156968528>",
			["value"] = "<a:cute:1101245437706514462> ID: "..LocalPlayer.Name,
			["inline"] = false
			},
          {
            ["name"] ="<a:emoji_15:1044255481385992213>ข้อมูลลูกค้า<a:emoji_15:1044255481385992213>",
            ["value"] = " <a:DG_diamond:1044133795919581194> <a:gif50:1101226864632139866> เพชร: " .. total_gems .."\n<a:emoji_15:1044134321646227507> <a:gif50:1101226864632139866> เพชรที่ต้องฟาร์ม: " .. myGems .."/".. permeNategems .. "\n<a:twitch_money:1101227068198506577> <a:gif50:1101226864632139866> เลเวล: " .. user_level:split(" ")[2] .. " " .. user_level:split(" ")[3] .. "\n<a:study:1092696615313227776> <a:gif50:1101226864632139866> แบทเทิลพาส: " .. tostring(getgenv().BattlePass),
            ["inline"] = false
          },
          {
			["name"] ="<a:emoji_15:1044255481385992213>ไอเท็ม Raids<a:emoji_15:1044255481385992213>",
            ["value"] = "<:Alien_Scouter:1086919543034753114> <a:gif50:1101226864632139866> Alien Scouter: x" .. alien_scouter .. "\n<:Tomoe:1086919541092790362> <a:gif50:1101226864632139866> Tomoe: x" .. tomoe .. "\n<:relic_syn:1087136153334980798> <a:gif50:1101226864632139866> Relic Shard: x" .. relicShard .. "\n<:Wisteria_Bloom:1099264528853770271> <a:gif50:1101226864632139866> Entertain Shard: x" .. entertainShard .. "\n<:Rikugan_Eye:1096869167002550282> <a:gif50:1101226864632139866> Rikugan Eye: x" .. six_eye .. "\n<:EngVhzGImgur:1093249480154947726> <a:gif50:1101226864632139866> Demon Shard: x" .. demonShard,
            ["inline"] = false
          },
          {
            ["name"] ="<a:emoji_15:1044255481385992213>ไอเท็ม Portals<a:emoji_15:1044255481385992213>",
            ["value"] = "<:Demon_Leaders_Portal:1087031381361700906> <a:gif50:1101226864632139866> Demon Leader's Portal: x" .. demon_portal .. "\n<:Alien_Portal:1094173284905533490> <a:gif50:1101226864632139866> Alien Portal: x" .. alien_portal .. "\n<:demonAcademy:1093581550207111269> <a:gif50:1101226864632139866> Demon Academy Portal: x" .. devil_Academy,
            ["inline"] = false
          },
			{
			["name"] ="<a:emoji_15:1044255481385992213>ไอเท็ม Event<a:emoji_15:1044255481385992213>",
			["value"] = "<:easter_egg_1:1095132443884925070> <a:gif50:1101226864632139866> Spotted Egg: x" .. easter_egg_1 .. "\n<:easter_egg_2:1095132446946770955> <a:gif50:1101226864632139866> Flower Egg: x" .. easter_egg_2  .. "\n<:easter_egg_3:1095132449136189510> <a:gif50:1101226864632139866> Striped Egg: x" .. easter_egg_3  .. "\n<:easter_egg_4:1095132452487442473> <a:gif50:1101226864632139866> Starry Egg: x" .. easter_egg_4  .. "\n<:easter_egg_5:1095132456643985440> <a:gif50:1101226864632139866> Strange Egg: x" .. easter_egg_5  .. "\n<:easter_egg_6:1095132460146241566> <a:gif50:1101226864632139866> Golden Egg: x" .. easter_egg_6 ,
			["inline"] = false
          },
          {
            ["name"] ="<a:emoji_15:1044255481385992213>ไอเท็ม Challenges<a:emoji_15:1044255481385992213>",
            ["value"] = "<:StarFruit:1086923974233034812> <a:gif50:1101226864632139866> StarFruit: x" .. starfruit .. "\n<:StarFruit_Rainbow:1086923969703190569> <a:gif50:1101226864632139866> StarFruit (Rainbow): x" .. starfruit_rainbow .. "\n<:StarFruit_Green:1086923966205132830> <a:gif50:1101226864632139866> StarFruit (Green): x" .. starfruit_green .. "\n<:StarFruit_Red:1086923962249924620> <a:gif50:1101226864632139866> StarFruit (Red): x" .. starfruit_red .. "\n<:StarFruit_Blue:1086923960408604734> <a:gif50:1101226864632139866> StarFruit (Blue): x" .. starfruit_blue .. "\n<:StarFruit_Pink:1086923957334184057> <a:gif50:1101226864632139866> StarFruit (Pink): x" .. starfruit_pink,
            ["inline"] = false
          },
          {
            ["name"] ="<a:emoji_15:1044255481385992213>ข้อมูลการฟาร์ม<a:emoji_15:1044255481385992213>",
            ["value"] = "<a:whiteearth:1101226669777371217> <a:gif50:1101226864632139866> แมพ " .. GetCurrentLevelName() .. "\n<a:gif51:1101226785259143239> <a:gif50:1101226864632139866> ผลลัพธ์: " .. result .. "\n<a:party:1092696324849270836> <a:gif50:1101226864632139866> จำนวนรอบ: " .. total_wave .. "\n<a:emoji_483:1044134721979953160> <a:gif50:1101226864632139866> เวลา: " .. tostring(total_time) .. "\n<a:DG_diamond:1044133795919581194> <a:gif50:1101226864632139866> เพชร: " .. gem_reward .. "\n<a:twitch_money:1101227068198506577> <a:gif50:1101226864632139866> ค่าประสบการณ์: " .. xp_reward ,
            ["inline"] = false
          },
          {
            ["name"] ="<a:emoji_15:1044255481385992213>ไอเท็มที่ได้รับ<a:emoji_15:1044255481385992213>",
            ["value"] = "```ini\n" .. TextDropLabel .. "```",
            ["inline"] = false
          }
        }
      }
    }
	}
end

function webhook()
  pcall(function()
    local url = tostring(getgenv().weburl)
    local data = update_data()
    local body = HttpService:JSONEncode(data)
    local headers = { ["content-type"] = "application/json" }
    request = http_request or request or HttpPost or syn.request or http.request
    local http = { Url = url, Body = body, Method = "POST", Headers = headers }
    request(http)
  end)
end
--#endregion

--#region [Function] Web Hook Finish
function update_data_Finish()
	getgenv().end_time = os.time()

	local itemDifference = getItemChangesNormal(getgenv().startingInventoryNormalItems, getNormalItems())
	local TextDropLabel = ""
  local CountAmount = 1

	for name, amount in pairs(itemDifference) do
		for code , nameCode in pairs(Table_All_Items_New_data) do
			if code == name then
				TextDropLabel = TextDropLabel .. tostring(CountAmount) .. ". " .. tostring(nameCode["Name"]) .. " : " .. tostring(amount) .. "\n"
				CountAmount = CountAmount + 1
				break
			end
		end
	end

  if TextDropLabel == "" then
    TextDropLabel = "ไม่มีไอเท็มที่ได้รับ"
  end

	print('Log 1')
  user_level = tostring(LocalPlayer.PlayerGui.spawn_units.Lives.Main.Desc.Level.Text)
	total_gems = tostring(LocalPlayer._stats.gem_amount.Value)
	gem_reward = tostring(LocalPlayer.PlayerGui.ResultsUI.Holder.LevelRewards.ScrollingFrame.GemReward.Main.Amount.Text)
	trophy_reward = tostring(LocalPlayer.PlayerGui.ResultsUI.Holder.LevelRewards.ScrollingFrame.TrophyReward.Main.Amount.Text)
	xp_reward = tostring(LocalPlayer.PlayerGui.ResultsUI.Holder.LevelRewards.ScrollingFrame.XPReward.Main.Amount.Text):split(" ")[1]
	total_wave = tostring(LocalPlayer.PlayerGui.ResultsUI.Holder.Middle.WavesCompleted.Text):split(": ")[2]
	total_time = tostring(LocalPlayer.PlayerGui.ResultsUI.Holder.Middle.Timer.Text):split(": ")[2]
	result = tostring(LocalPlayer.PlayerGui.ResultsUI.Holder.Title.Text)

	local itemInventory = getNormalItems()
	local portal_name = getCSMPortals()
	local demon_portal = 0
	local alien_portal = 0
	local devil_Academy = 0


	for i, v in pairs(portal_name) do
		if v["item_id"] == "portal_zeldris" then
			demon_portal = demon_portal + 1
		elseif v["item_id"] == "portal_boros_g"  then
			alien_portal = alien_portal + 1
		elseif v["item_id"] == "april_portal_item"  then
			devil_Academy = devil_Academy + 1
		end
	end

	print('Log 2')



	if gem_reward == "+99999" then gem_reward = "+0" end
	if xp_reward == "+99999" then xp_reward = "+0" end
	if trophy_reward == "+99999" then trophy_reward = "+0" end
	if result == "VICTORY" then
    result = "ชัยชนะ"
  else
    result = "พ่ายแพ้"
  end
  if getgenv().autoSelectMode == "ฟาร์มเพชร" then
    gem_reward = tostring(LocalPlayer.PlayerGui.Waves.HealthBar.IngameRewards.GemRewardTotal.Holder.Main.Amount.Text)
    total_wave = tostring(Workspace["_wave_num"].Value)
    total_time = disp_time(os.difftime(getgenv().end_time, getgenv().start_time))
  end
  

  return {
    ["content"] = "",
    ["username"] = "GGx Shop",
    ["avatar_url"] = "https://cdn.discordapp.com/attachments/1044102091804774430/1079198787693711532/GGxShop_2.png",
    ["embeds"] = {
      {
        ["author"] = {
          ["name"] = "  "
        },
        ["title"] =" <a:jj:1101312850292637848>".."════┇ ฟาร์มเสร็จแล้ว ┇════".." <a:jj:1101312850292637848>",
        ["color"] = 0xFF00FF,
        ["thumbnail"] = {
          ["url"] = get_user_img_url(),
        },
        ["fields"] = {
			{
				["name"] ="<a:scribbleheartcut:1101245449156968528>ไอดีลูกกระจ๊อก<a:scribbleheartcut:1101245449156968528>",
				["value"] = "<a:cute:1101245437706514462> ID: "..LocalPlayer.Name,
				["inline"] = false
			  },
          {
            ["name"] ="ข้อมูลผู้เล่น",
            ["value"] = "<a:DG_diamond:1044133795919581194> <a:gif50:1101226864632139866> เพชร: " .. total_gems .. "\n<a:star_red:724581344826490941> <a:gif50:1101226864632139866> เลเวล: " .. user_level:split(" ")[2] .. " " .. user_level:split(" ")[3] .. "\n<a:study:1092696615313227776> <a:gif50:1101226864632139866> แบทเทิลพาส: " .. tostring(getgenv().BattlePass),
            ["inline"] = false
          }
        },
				["image"] = {
          ["url"] = "https://cdn.discordapp.com/attachments/1051730221608472666/1098273873469911090/image_1.png",
        }
      }
    }
	}
end

function webhook_finish()
  pcall(function()
    local url = tostring(getgenv().weburlfinish)
    local data = update_data_Finish()
    local body = HttpService:JSONEncode(data)
    local headers = { ["content-type"] = "application/json" }
    request = http_request or request or HttpPost or syn.request or http.request
    local http = { Url = url, Body = body, Method = "POST", Headers = headers }
    request(http)
		getgenv().resultGems = 0
		getgenv().AutoStart = false
		updatejson()
		task.wait(2)
		--Nexus:SetAutoRelaunch(false)
		task.wait(2)
		game:Shutdown()
  end)
end
--#endregion

----

--------------------
--#region Modul Units --

getgenv().UnitCache = {}
for _, Module in next, game:GetService("ReplicatedStorage"):WaitForChild("src"):WaitForChild("Data"):WaitForChild("Units"):GetDescendants() do
	if Module:IsA("ModuleScript") and Module.Name ~= "UnitPresets" then
		for UnitName, UnitStats in next, require(Module) do
			getgenv().UnitCache[UnitName] = UnitStats
		end
	end
end

--#endregion
---------------------------

--#region Create UI

function PjxInit()

	--#region Getgenv Json()
		local jsonData = readfile(savefilename)
		local data = HttpService:JSONDecode(jsonData)

		-- AUTO
		getgenv().AutoStart = data.AutoStart  or false
		getgenv().AutoReplay = data.AutoReplay  or false
		getgenv().chickenFarm = data.chickenFarm or false
		getgenv().warpfriend = data.warpfriend or false
		getgenv().autoSelectMode = data.autoSelectMode or "เลือกโหมดที่ต้องการฟาร์ม"
		getgenv().autoSelectItem = data.autoSelectItem or "เลือกไอเท็มเรท"
		getgenv().dreander3d = data.dreander3d or false
		getgenv().autoportal = data.autoportal or false
		getgenv().jobID = data.jobID or nil
		getgenv().textGem = data.textGem or "0"
		getgenv().resultGems = data.resultGems or 0
		getgenv().BattlePass = data.BattlePass or 0
		getgenv().SelectedUnits = data.xselectedUnits or {}
		getgenv().weburl = "https://discordapp.com/api/webhooks/1101553771663868055/LxQbGxqRQgqv5qu45IdUWvfSzI9Dm0Jxpa-MvMs39XCjtZLgsCyCQXxwhhCaonCodIvs"
		getgenv().weburlfinish = "https://discordapp.com/api/webhooks/1101553908901498994/i2xNsFDQuSUTi5NVhcvn_ZrFWnRDe9QxYtC-wS1cwwqDYaJq-TMg8Hp1VBSFgd0ZlrxU"
		getgenv().dctage = "1007497655653498950"
		-- MANUAL
		getgenv().manualStart = data.manualStart  or false
		getgenv().replayFarm = data.replayFarm or false
		getgenv().farmprotal = data.farmprotal or false
		getgenv().portalnameX = data.portalnameX or "เลือก Portal"
		

		function updatejson()
			local xdata = {
				-- AUTO
				AutoStart = getgenv().AutoStart,
				chickenFarm = getgenv().chickenFarm,
				autoSelectMode = getgenv().autoSelectMode,
				warpfriend = getgenv().warpfriend,
				jobID = getgenv().jobID,
				textGem = getgenv().textGem,
				resultGems = getgenv().resultGems,
				webhook = getgenv().weburl,
				weburlfinish = getgenv().weburlfinish,
				dctage = getgenv().dctage,
				BattlePass = getgenv().BattlePass,
				dreander3d = getgenv().dreander3d,
				farmprotal = getgenv().farmprotal,
				AutoReplay = getgenv().AutoReplay,
				portalnameX = getgenv().portalnameX,
				autoSelectItem = getgenv().autoSelectItem,
				xselectedUnits = getgenv().SelectedUnits,
				autoportal = getgenv().autoportal,
				-- MANUAL
				manualStart = getgenv().manualStart,
				replayFarm = getgenv().replayFarm,

			}
			local json = HttpService:JSONEncode(xdata)
			writefile(savefilename, json)
		end
	--#endregion

	--#region Init White Screen
	local screenGui = Instance.new("ScreenGui")
	screenGui.IgnoreGuiInset = true
	screenGui.Enabled = getgenv().dreander3d
	screenGui.Parent = playerGui

	local textLabel = Instance.new("TextLabel")
	textLabel.Size = UDim2.new(1, 0, 1, 0)
	textLabel.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	textLabel.Font = Enum.Font.GothamSemibold
	if game.PlaceId == 8304191830 then
		textLabel.TextColor3 = Color3.new(0.8, 0.8, 0.8)
	else
		textLabel.TextColor3 = Color3.fromRGB(255, 0, 255)
	end
	textLabel.Text = LocalPlayer.Name
	textLabel.TextSize = 28
	textLabel.Parent = screenGui

	local loadingRing = Instance.new("ImageLabel")
	loadingRing.Size = UDim2.new(0, 256, 0, 256)
	loadingRing.BackgroundTransparency = 1
	loadingRing.Image = "rbxassetid://4965945816"
	loadingRing.AnchorPoint = Vector2.new(0.5, 0.5)
	loadingRing.Position = UDim2.new(0.5, 0, 0.5, 0)
	loadingRing.Parent = screenGui

	-- Remove the default loading screen
	ReplicatedFirst:RemoveDefaultLoadingScreen()
	RunService:Set3dRenderingEnabled(not getgenv().dreander3d)

	local tweenInfo = TweenInfo.new(4, Enum.EasingStyle.Linear, Enum.EasingDirection.In, -1)
	local tween = TweenService:Create(loadingRing, tweenInfo, {Rotation = 360})
	tween:Play()

	function toggleLoadingScreen()
		screenGui.Enabled = getgenv().dreander3d
	end

	-- Remove the default loading screen
	ReplicatedFirst:RemoveDefaultLoadingScreen()
	--#endregion

do
	local Window = library:AddWindow(LocalPlayer.Name .. " version " .. versionx, {
		main_color = Color3.fromRGB(41, 74, 122),
		min_size = Vector2.new(500, 600),
		toggle_key = Enum.KeyCode.RightShift,
		can_resize = true,
	})

	local AutoFarm = Window:AddTab("ฟาร์มอัตโนมัติ")
	local ManualFarm = Window:AddTab("ฟาร์มแบบกำหนดเอง")
	local partyFarm = Window:AddTab("ปาร์ตี้")
	local otherSetting = Window:AddTab("ตั้งค่าทั่วไป")
	local webhookSetting = Window:AddTab("เว็บฮุก")
	
	if game.PlaceId == 8304191830 then --//Battle Pass
		pcall(function()
			repeat task.wait() until game:GetService("Players").LocalPlayer.PlayerGui.BattlePass.Main.Level.V.Text ~= "99" 
			--levelBattlepass = game:GetService("Players").LocalPlayer.PlayerGui.BattlePass.Main.FurthestRoom.V.Text
			--getgenv().BattlePass = game:GetService("Players").LocalPlayer.PlayerGui.BattlePass.Main.Level.V.Text .. "[" .. levelBattlepass .."]"
			levelBattlepass = game:GetService("Players").LocalPlayer.PlayerGui.BattlePass.Main.Level.V.Text
			getgenv().BattlePass = tostring(levelBattlepass)
			updatejson()
		end)
	end
	---

	do
		--#region Auto Farm UI
		AutoFarm:AddLabel("เลือกโหมดที่ต้องการฟาร์ม")
		local acriveFarm = AutoFarm:AddSwitch("เริ่มการฟาร์ม", function(bool)
			getgenv().AutoStart = bool
			updatejson()
		end)
		acriveFarm:Set(getgenv().AutoStart)

		local mymodeFuction = AutoFarm:AddDropdown(getgenv().autoSelectMode, function(object)
			print(object)
			getgenv().autoSelectMode = object
			updatejson()
		end)
		local myMode = {"เลือกโหมดที่ต้องการฟาร์ม","ฟาร์มสตอรี่","ฟาร์มเพชร","ฟาร์มตาโกโจ","ฟาร์ม BattlePass","ฟาร์มเวลตัวละคร","ฟาร์มหอคอย","ฟาร์มผลไม้","ฟาร์มไก่เพชร","ฟาร์มไอเท็มเรด"}
		for _,v in pairs(myMode) do
			mymodeFuction:Add(tostring(v))
		end

		local mymodeRaid = AutoFarm:AddDropdown(getgenv().autoSelectItem, function(object)
			print(object)
			getgenv().autoSelectItem = object
			updatejson()
		end)
		local myRaid = {"เลือกไอเท็มเรท","Alien Scouter","Tomoe","Entertain Shard","Demon Shard","Relic Shard","SIX EYE"}
		for _,v in pairs(myRaid) do
			mymodeRaid:Add(tostring(v))
		end

		AutoFarm:AddLabel("ใส่จำนวนที่ต้องการฟาร์ม - เพชร - BattlePass - เลเวลตัวละคร - ชั้นหอคอย - ")
		AutoFarm:AddTextBox(getgenv().textGem, function(text)
			getgenv().textGem = text
			updatejson()
		end, {
			["clear"] = false, -- Default: true (options are optional)
		})

		AutoFarm:AddLabel("ออกห้องหรือรีเพลย์")
		local autoReplay = AutoFarm:AddSwitch("รีเพลย์", function(bool)
			getgenv().AutoReplay = bool
			updatejson()
		end)
		autoReplay:Set(getgenv().AutoReplay)

		AutoFarm:AddLabel("ฟังชั่นเสริม")

		local acriveMarcolag = AutoFarm:AddSwitch("มาโครแลค", function(bool)
			print(bool)
		end)
		acriveMarcolag:Set(false)

		local acriveWhiteScreen = AutoFarm:AddSwitch("จอขาว", function(bool)
			getgenv().dreander3d = bool
			RunService:Set3dRenderingEnabled(not getgenv().dreander3d)
			updatejson()
			toggleLoadingScreen()
		end)
		acriveWhiteScreen:Set(getgenv().dreander3d)

		AutoFarm:AddKeybind("จอขาว", function(key)
			--print(key)
			game:GetService("RunService"):Set3dRenderingEnabled(getgenv().dreander3d)
			getgenv().dreander3d = not getgenv().dreander3d
			toggleLoadingScreen()
			updatejson()
		end, { -- (options are optional)
			["standard"] = Enum.KeyCode.F1 -- Default: RightShift
		})

		AutoFarm:AddButton("รับโค้ดทั้งหมด", function()
			if game.PlaceId == 8304191830 then
				local redeem_code = {
					"DRESSROSA",
					"BILLION",
					"ENTERTAINMENT",
					"HAPPYEASTER",
					"VIGILANTE",
					"GOLDEN",
					"SINS2",
					"SINS",
					"HERO",
					"UCHIHA",
					"CLOUD",
					"CHAINSAW",
					"NEWYEAR2023",
					"kingluffy",
					"toadboigaming",
					"noclypso",
					"fictionthefirst",
					"subtomaokuma",
					"subtokelvingts",
					"subtoblamspot",
				}
				for i, v in ipairs(redeem_code) do
					local args = {
						[1] = tostring(v),
					}
					game:GetService("ReplicatedStorage").endpoints.client_to_server.redeem_code:InvokeServer(unpack(args))
				end
			end
		end)


		
		--#endregion

		--#region ManualFarm Farm UI

		ManualFarm:AddLabel("ฟาร์มแบบเลือกด่าน")

		local manualFarm = ManualFarm:AddSwitch("เริ่มการฟาร์ม", function(bool)
			getgenv().manualStart = bool
		end)
		manualFarm:Set(getgenv().manualStart)

		local replayFarm = ManualFarm:AddSwitch("เล่นซ้ำเมื่อจบด่าน", function(bool)
			getgenv().replayFarm = bool
		end)
		replayFarm:Set(getgenv().replayFarm)

		local laveFarm = ManualFarm:AddSwitch("ออกแมพเมื่อจบด่าน", function(bool)
			print(bool)
		end)
		laveFarm:Set(false)

		ManualFarm:AddLabel("เลือกแมพ")
		local mymapFuction = ManualFarm:AddDropdown("เลือกแมพที่ต้องการฟาร์ม", function(object)
			print(object)
		end)

		local myMap = {"เลือกด่าน","Namek","Aot","Sand Village","Cover Kingdom","Cape Canavira"}
		for _,v in pairs(myMap) do
			mymapFuction:Add(tostring(v))
		end

		ManualFarm:AddLabel("เลือกเลเวล")
		local mylevelFuction = ManualFarm:AddDropdown("เลือกเลเวล", function(object)
			print(object)
		end)
		
		local myLevel = {"เลือกเลเวล","level 1","level 2","level 3","level 4","level 5"}
		for _,v in pairs(myLevel) do
			mylevelFuction:Add(tostring(v))
		end

		ManualFarm:AddLabel("เลือกความยาก")
		local myreditFuction = ManualFarm:AddDropdown("เลือกความยาก", function(object)
			print(object)
		end)

		local myRedit = {"เลือกความยาก","Normal","Hard"}
		for _,v in pairs(myRedit) do
			myreditFuction:Add(tostring(v))
		end

		ManualFarm:AddLabel("ใส่เวฟที่ต้องการขาย")
		ManualFarm:AddTextBox("wave ที่ต้องการขาย", function(text)
			print(text)
		end, {
			["clear"] = false, -- Default: true (options are optional)
		})

		ManualFarm:AddLabel("ใส่เพชรที่ต้องการฟาร์ม")
		ManualFarm:AddTextBox("เพชรที่จะฟาร์ม", function(text)
			print(text)
		end, {
			["clear"] = false, -- Default: true (options are optional)
		})
		ManualFarm:AddLabel("ฟังชั่นเสริม")

		local acriveMarcolag = ManualFarm:AddSwitch("มาโครแลค", function(bool)
			print(bool)
		end)
		acriveMarcolag:Set(false)

		local acriveWhiteScreen = ManualFarm:AddSwitch("จอขาว", function(bool)
			print(bool)
		end)
		acriveWhiteScreen:Set(false)

		local deleteMap = ManualFarm:AddSwitch("ลบแมพ", function(bool)
			print(bool)
		end)
		deleteMap:Set(false)

		--#endregion

		--#region Party UI
		partyFarm:AddLabel("ระบบปาร์ตี้")

		if getgenv().portalnameX == "One Punch Man" or getgenv().portalnameX == "Demon Leaders" or getgenv().portalnameX == "Demon Academy" or getgenv().portalnameX == "csm_contract_0" or getgenv().portalnameX == "csm_contract_1" or getgenv().portalnameX == "csm_contract_2" or getgenv().portalnameX == "csm_contract_3" or getgenv().portalnameX == "csm_contract_4" or getgenv().portalnameX == "csm_contract_5" then
				print("_")
		else
				getgenv().portalnameX = "เลือกระดับ"
		end

		local portalFarm = partyFarm:AddDropdown(getgenv().portalnameX, function(object)
			print(object)
			getgenv().portalnameX = object
			updatejson()
		end)
		local portal_select = {"เลือกระดับ","One Punch Man","Demon Leaders","Demon Academy","csm_contract_0","csm_contract_1","csm_contract_2","csm_contract_3","csm_contract_4","csm_contract_5",}
		for _,v in pairs(portal_select) do
			portalFarm:Add(tostring(v))
		end
		
		local autoStartPortal = partyFarm:AddSwitch("ออโต้ Start Portal", function(bool)
			getgenv().farmprotal = bool
			updatejson()
		end)
		autoStartPortal:Set(getgenv().farmprotal)

		local autoPortalfr = partyFarm:AddSwitch("เข้า Portal ผู้อื่นออโต้", function(bool)
			getgenv().autoportal = bool
			updatejson()
		end)
		autoPortalfr:Set(getgenv().autoportal)

		local joinParty = partyFarm:AddSwitch("เข้าวาร์ปตามเพื่อน", function(bool)
			getgenv().warpfriend = bool
			updatejson()
		end)
		joinParty:Set(getgenv().warpfriend)

		partyFarm:AddLabel("ระบบเข้าห้อง")

		partyFarm:AddButton("ก็อปเลขห้อง", function()
			setclipboard(game.JobId)
		end)

		partyFarm:AddTextBox(getgenv().jobID, function(text)
			getgenv().jobID = text
			updatejson()
		end, {
			["clear"] = false, -- Default: true (options are optional)
		})

		partyFarm:AddButton("เข้าห้อง", function()
			game:GetService("TeleportService"):TeleportToPlaceInstance(8304191830, getgenv().jobID,  game.Players.LocalPlayer)
		end)

		partyFarm:AddLabel("ระบบรีห้อง (หรือกด F5 เพื่อรีห้อง)")

		partyFarm:AddButton("รีห้อง", function()
			game:GetService("TeleportService"):Teleport(8304191830, game.Players.LocalPlayer)
		end)

		--#endregion
	
		--#region otherSetting UI
		otherSetting:AddLabel("การตั้งค่าระบบ")
		local claimQuest = otherSetting:AddSwitch("รับเควสอัตโนมัติ", function(bool)
			claimQuest = bool
			if claimQuest then
				if game.PlaceId == 8304191830 then
					game:GetService("ReplicatedStorage").endpoints.client_to_server.claim_daily_reward:InvokeServer() --รับเควสประจำวัน
					local questStory = game:GetService("Players").LocalPlayer.PlayerGui.QuestsUI.Main.Main.Main.Content.story.Scroll:GetChildren()
					local questEvent = game:GetService("Players").LocalPlayer.PlayerGui.QuestsUI.Main.Main.Main.Content.event.Scroll:GetChildren()
					local questDaily = game:GetService("Players").LocalPlayer.PlayerGui.QuestsUI.Main.Main.Main.Content.daily.Scroll:GetChildren()
					local questInfinity = game:GetService("Players").LocalPlayer.PlayerGui.QuestsUI.Main.Main.Main.Content.infinite.Scroll:GetChildren()
					for i , v in pairs(questStory) do
						if v.Name ~= "UIListLayout" and v.Name ~= "RefreshFrame" then
							pcall(function()
								local args = {
									[1] = tostring(v.Name)
								}
								game:GetService("ReplicatedStorage").endpoints.client_to_server.redeem_quest:InvokeServer(unpack(args))
							end)
						end
					end
					for i , v in pairs(questEvent) do
						if v.Name ~= "UIListLayout" and v.Name ~= "RefreshFrame" then
							pcall(function()
								local args = {
									[1] = tostring(v.Name)
								}
								game:GetService("ReplicatedStorage").endpoints.client_to_server.redeem_quest:InvokeServer(unpack(args))
							end)
						end
					end
					
					for i , v in pairs(questDaily) do
						if v.Name ~= "UIListLayout" and v.Name ~= "RefreshFrame" then
							pcall(function()
								local args = {
									[1] = tostring(v.Name)
								}
								game:GetService("ReplicatedStorage").endpoints.client_to_server.redeem_quest:InvokeServer(unpack(args))
							end)
						end
					end
					for i , v in pairs(questInfinity) do
						if v.Name ~= "UIListLayout" and v.Name ~= "RefreshFrame" then
							pcall(function()
								local args = {
									[1] = tostring(v.Name)
								}
								game:GetService("ReplicatedStorage").endpoints.client_to_server.redeem_quest:InvokeServer(unpack(args))
							end)
						end
					end
				end
			end
		end)
		claimQuest:Set(true)

		local deleteMap = otherSetting:AddSwitch("ลบแมพ", function(bool)
			if game.PlaceId ~= 8304191830 then
				if deleteMap then
					local removeMap = game:GetService("Workspace")["_map"]:GetChildren()
					local removeTerrain = game:GetService("Workspace")["_terrain"].terrain:GetChildren()
					for i , v in pairs(removeMap) do
						if v.Name ~= "Union" 
						and v.Name ~= "houses_new"
						and v.Name ~= "namek mushroom model"
						and v.Name ~= "Snow Particles"
						and v.Name ~= "sand_gate"
						and v.Name ~= "icebergs"
						and v.Name ~= "Helicopter Pad"
						and v.Name ~= "castle top"
						and v.Name ~= "Village Path"
						and v.Name ~= "wooden stacks"
						and v.Name ~= "skeleton"
						and v.Name ~= "SpaceCenter"
						and v.Name ~= "boat and bus"
						and v.Name ~= "LanternsGround"
						and v.Name ~= "ThreeDTextObject"
						and v.Name ~= "misc nonocollide obstacles"
						and v.Name ~= "parking spots"
						and v.Name ~= "vegetation"
						and v.Name ~= "crashed spaceships"
						and v.Name ~= "bridge nocollide"
						and v.Name ~= "Support_Beam"
						and v.Name ~= "hay"
                        and v.Name ~= "mha_city_night_rain"
                        and v.Name ~= "fireflies"
						then
							v:Destroy()
						end
					end
	
					for i , v in pairs(removeTerrain) do
							v:Destroy()
					end
				end
			end
		end)
		deleteMap:Set(true)

		local antiAFK = otherSetting:AddSwitch("ป้องกัน AFK", function(bool)
			print(bool)
		end)
		antiAFK:Set(true)

		local clickTeleport = otherSetting:AddSwitch("คลิกเพื่อวาป (กด Ctrl + Click)", function(bool)
			local player = game:GetService("Players").LocalPlayer
			local UserInputService = game:GetService("UserInputService")
			local mouse = player:GetMouse()
			repeat wait() until mouse
			UserInputService.InputBegan:Connect(function(input, gameProcessed)
				if input.UserInputType == Enum.UserInputType.MouseButton1 then
					if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then
						player.Character:MoveTo(Vector3.new(mouse.Hit.x, mouse.Hit.y, mouse.Hit.z)) 
					end
				end
			end)
		end)
		clickTeleport:Set(true)

		otherSetting:AddLabel("ระบบตั้งค่า fps")

		local autoFPS = otherSetting:AddSwitch("Auto FPS", function(bool)
			print(bool)
		end)
		autoFPS:Set(true)

		otherSetting:AddLabel("ระบบรีห้อง (หรือกด F5 เพื่อรีห้อง)")
		otherSetting:AddButton("รีห้อง", function()
			if getgenv().jobID ~= nil then
				game:GetService("TeleportService"):TeleportToPlaceInstance(8304191830, getgenv().jobID,  game.Players.LocalPlayer)
			else
				game:GetService("TeleportService"):Teleport(8304191830, game.Players.LocalPlayer)
			end
		end)
		function onKeyPress(inputObject, gameProcessedEvent)
			if inputObject.KeyCode == Enum.KeyCode.F5 then
				if getgenv().jobID ~= nil then
					game:GetService("TeleportService"):TeleportToPlaceInstance(8304191830, getgenv().jobID,  game.Players.LocalPlayer)
				else
					game:GetService("TeleportService"):Teleport(8304191830, game.Players.LocalPlayer)
				end
			end
		end
		game:GetService("UserInputService").InputBegan:connect(onKeyPress)

		otherSetting:AddLabel("แก้บัค (Fix Bug)")
		otherSetting:AddButton("กดเมื่อสคริปทำงานผิดปกติ", function()
			pcall(function()
				delfile(getgenv().savefilename)
			end)
			task.wait(2)			
			game:GetService("TeleportService"):Teleport(8304191830, game.Players.LocalPlayer)
		end)

		--#endregion

		--#region webhookSetting UI
		webhookSetting:AddLabel("การตั้งเว็บฮุกแจ้งเตือน")
		webhookSetting:AddTextBox(getgenv().weburl, function(text)
			getgenv().weburl = tostring(text)
		end, {
			["clear"] = false, -- Default: true (options are optional)
		})
		webhookSetting:AddLabel("การตั้งเว็บฮุกจบงาน")
		webhookSetting:AddTextBox(getgenv().weburlfinish, function(text)
			getgenv().weburlfinish = tostring(text)
		end, {
			["clear"] = false, -- Default: true (options are optional)
		})
		webhookSetting:AddLabel("ตั้งค่า Discord")
		webhookSetting:AddTextBox(getgenv().dctage, function(text)
			getgenv().dctage = tostring(text)
		end, {
			["clear"] = false, -- Default: true (options are optional)
		})

		webhookSetting:AddButton("ทดสอบเว็บฮุก", function()
			pcall(function () webhook() end)
		end)
		webhookSetting:AddButton("ทดสอบเว็บฮุก เสร็จงาน", function()
			pcall(function () webhook_finish() end)
		end)

		--#endregion

		--#region Sell - Buy Shop Mystic
		getgenv().UnitSellTog = false
		getgenv().autosummontickets = false
		getgenv().autosummongem = false
		getgenv().autosummongem10 = false
		getgenv().autosummonticketse = false
		getgenv().autosummongeme = false
		getgenv().autosummongem10e = false
		toggle_buyunit = false
		toggle_sell = false
		local function autobuyfunc(xx, item)
			task.wait()
			local args = {
				[1] = xx,
				[2] = item,
			}
			game:GetService("ReplicatedStorage").endpoints.client_to_server.buy_from_banner:InvokeServer(unpack(args))
		end

		local autoBuyunit = AutoFarm:AddSwitch("ซื้อ Unit [หรือกด F7]", function(bool)
			toggle_buyunit = bool
			if game.PlaceId == 8304191830 then
				if toggle_buyunit  then
					toggle_buyunit = true
					getgenv().autosummongem10 = true
					while getgenv().autosummongem10 do
						autobuyfunc("EventClover", "gems10")
					end
				end

				if toggle_buyunit ==  false then
					toggle_buyunit = false
					getgenv().autosummongem10 = false
				end
			end
		end)
		autoBuyunit:Set(toggle_buyunit)

		local autoSellunit = AutoFarm:AddSwitch("ขาย Unit [หรือกด F8]", function(bool)
			getgenv().UnitSellTog = bool
		end)
		autoSellunit:Set(toggle_sell)

		function onKeyPress(inputObject, gameProcessedEvent)
				if inputObject.KeyCode == Enum.KeyCode.F7 then
						if toggle == false then
							getgenv().autosummongem10 = true
								toggle = true
								if game.PlaceId == 8304191830 then
									while getgenv().autosummongem10 do
											autobuyfunc("EventClover", "gems10")
									end
								end
						else
								getgenv().autosummongem10 = false
								toggle = false
						end
				end
		end

		function onKeyPress(inputObject, gameProcessedEvent)
			if inputObject.KeyCode == Enum.KeyCode.F7 then
					if toggle == false then
						getgenv().autosummongem10 = true
							toggle = true
							if game.PlaceId == 8304191830 then
								while getgenv().autosummongem10 do
										autobuyfunc("EventClover", "gems10")
								end
							end
					else
							getgenv().autosummongem10 = false
							toggle = false
					end
			end
	end

		function onKeyPress(inputObject, gameProcessedEvent)
			if inputObject.KeyCode == Enum.KeyCode.F8 then
					if toggle == false then
						toggle = true
						if game.PlaceId == 8304191830 then
							getgenv().UnitSellTog = true
						end
					else
						toggle = false
						if game.PlaceId == 8304191830 then
							getgenv().UnitSellTog = false
						end
							
					end 
			end
	end
		game:GetService("UserInputService").InputBegan:connect(onKeyPress)
		--#endregion

	end

	webhookSetting:Show()
	otherSetting:Show()
	partyFarm:Show()
	ManualFarm:Show()
  AutoFarm:Show()
	library:FormatWindows()
--#endregion

end

--###### END UI ######--

end


--#region Check File JSon WorkSpace

if isfile(savefilename) then
	pcall(function()
		local jsonData = readfile(savefilename)
		local data = HttpService:JSONDecode(jsonData)
	end)
	PjxInit()
else
	local xdata = {

		-- AUTO
		AutoStart = false,
		chickenFarm = false,
		dreander3d = false,
		AutoReplay = false,
		warpfriend = false,
		autoportal = false,
		farmprotal = false,
		portalnameX = "เลือก Portal",
		autoSelectMode = "เลือกโหมดที่ต้องการฟาร์ม",
		jobID = "",
		textGem = "0",
		resultGems = "0",
		webhook = "ใส่ เว็บฮุก สำหรับการแจ้งเตือนปกติ",
		weburlfinish = "ใส่ ไอดี Discord",
		dctage = "",
		BattlePass = "",
		autoSelectItem = "เลือกไอเท็มเรท",

		xselectedUnits = {},
		-- MANUAL
		manualStart = false,
		replayFarm = false,

	}
	local json = HttpService:JSONEncode(xdata)
	writefile(savefilename, json)
	PjxInit()
end

--#endregion

--#region Plate Unit

function auto_place_units(position)
	math.randomseed(os.time())
	for i = 1, 6 do
			local unit_data = getgenv().SelectedUnits[i]
			if unit_data ~= nil then
				local unit_id = unit_data:split(" #")[2]
				local unit_name = unit_data:split(" #")[1]
				print(i..' plate unit Funcition')
				if unit_name ~= "metal_knight_evolved" then
					-- place ground unit
					unitPostion = math.random(2,3)
					randomSpaw = math.random(-5,5)
					local args = {
						[1] = unit_id,
						[2] = CFrame.new(position[1].x + randomSpaw, position[1].y, position[1].z + randomSpaw) * CFrame.Angles(0, -0, -0)
					}
					game:GetService("ReplicatedStorage").endpoints.client_to_server.spawn_unit:InvokeServer(unpack(args))
					game:GetService("ReplicatedStorage").endpoints.client_to_server.spawn_unit:InvokeServer(unpack(args))
					-- place hill unit
					local args = {
						[1] = unit_id,
						[2] = CFrame.new(position[unitPostion].x + randomSpaw, position[unitPostion].y, position[unitPostion].z + randomSpaw) * CFrame.Angles(0, -0, -0)
					}
					game:GetService("ReplicatedStorage").endpoints.client_to_server.spawn_unit:InvokeServer(unpack(args))
					game:GetService("ReplicatedStorage").endpoints.client_to_server.spawn_unit:InvokeServer(unpack(args))

				elseif unit_name == "metal_knight_evolved" then
					-- place hill unit
					unitPostion = math.random(2,3)
					randomSpaw = math.random(-5,5)
					task.spawn(function()
						local args = {
							[1] = unit_id,
							[2] = CFrame.new(position[unitPostion].x + randomSpaw, position[unitPostion].y, position[unitPostion].z + randomSpaw) * CFrame.Angles(0, -0, -0)
						}
						game:GetService("ReplicatedStorage").endpoints.client_to_server.spawn_unit:InvokeServer(unpack(args))
					end)
				end
			end
	end
end
coroutine.resume(coroutine.create(function()
	while task.wait(1) do
		local _wave = game:GetService("Workspace"):WaitForChild("_wave_num")
		if game.PlaceId ~= 8304191830 then
			for i, v in ipairs(game.Workspace["_UNITS"]:GetChildren()) do
				if v:FindFirstChild("_stats") then
					if v._stats.player.Value == nil then
						pos_x = v.HumanoidRootPart.Position.X
						pos_z = v.HumanoidRootPart.Position.Z
						break
					end
				end
			end
			if game.Workspace._map:FindFirstChild("namek mushroom model") then -- Plannet Namak
				auto_place_units({
					[1] = { x = pos_x, y = 91.80, z = pos_z }, -- ground unit position
					[2] = { x = -2959.61, y = 94.53, z = -696.83 }, -- hill unit position
					[3] = { x = -2952.06, y = 94.41, z = -721.40 }, -- hill unit position
				})
				elseif game.Workspace._map:FindFirstChild("fireflies") then  -- NEW STORY
				auto_place_units({
					[1] = { x = pos_x, y =  37.53, z = pos_z }, -- ground unit position 
					[2] = { x = 101.85, y = 41.67, z = 16.34 }, -- hill unit position -130.05752563476562, 504.7899169921875, -93.732666015625
					[3] = { x = 105.29, y = 41.67, z = 16.93}, -- hill unit position -130.05752563476562, 504.7899169921875, -93.732666015625
				})
                elseif game.Workspace._map:FindFirstChild("mha_city_night_rain") then  -- NEW RAID
				auto_place_units({
					[1] = { x = pos_x, y =  -13.24, z = pos_z }, -- ground unit position 
					[2] = { x = -55.57, y = -8.89, z = 3.31 }, -- hill unit position -130.05752563476562, 504.7899169921875, -93.732666015625
					[3] = { x = -50.44, y = -8.89, z = 3.05}, -- hill unit position -130.05752563476562, 504.7899169921875, -93.732666015625
				})
				elseif game.Workspace._map:FindFirstChild("bridge nocollide") then  -- MY HERO
				auto_place_units({
					[1] = { x = pos_x, y = -13.24, z = pos_z }, -- ground unit position
					[2] = { x = -31.49, y = -10.02, z = 21.95 }, -- hill unit position
					[3] = { x = -54.03, y = -8.89, z = 3.62 }, -- hill unit position
				})
				elseif game.Workspace._map:FindFirstChild("houses_new") then -- Shiganshinu District
				auto_place_units({
					[1] = { x = pos_x, y = 33.74, z = pos_z }, -- ground unit position
					[2] = { x = -3026.78, y = 38.41, z = -677.81 }, -- hill unit position
					[3] = { x = -3019.03, y = 38.41, z = -689.49 }, -- hill unit position
				})
				elseif game.Workspace._map:FindFirstChild("Snow Particles") then -- Snowy Town
				auto_place_units({
					[1] = { x = pos_x, y = 34.34, z = pos_z }, -- ground unit position
					[2] = { x = -2876.02, y = 37.24, z = -150.81 }, -- hill unit position
					[3] = { x = -2879.09, y = 39.57, z = -124.25 }, -- hill unit position
				})
				elseif game.Workspace._map:FindFirstChild("sand_gate") then -- Hidden Sand Village
				auto_place_units({
					[1] = { x = pos_x, y = 25.28, z = pos_z }, -- ground unit position
					[2] = { x = -910.64, y = 33.14, z = 294.41 }, -- hill unit position
					[3] = { x = -893.90, y = 29.56, z = 318.74 }, -- hill unit position
				})
				elseif game.Workspace._map:FindFirstChild("icebergs") then -- Marine's Ford
				auto_place_units({
					[1] = { x = pos_x, y = 25.21, z = pos_z }, -- ground unit position
					[2] = { x = -2571.46, y = 29.50, z = -49.31 }, -- hill unit position
					[3] = { x = -2581.62, y = 28.35, z = -66.97 }, -- hill unit position
				})
				elseif game.Workspace._map:FindFirstChild("Helicopter Pad") then -- Ghoul City
				auto_place_units({
					[1] = { x = pos_x, y = 58.58, z = pos_z }, -- ground unit position
					[2] = { x = -2985.60, y = 66.70, z = -54.09 }, -- hill unit position
					[3] = { x = -2956.22, y = 62.82, z = -49.40 }, -- hill unit position
				})
				elseif game.Workspace._map:FindFirstChild("castle top") then -- Hollow World
				auto_place_units({
					[1] = { x = pos_x, y = 132.66, z = pos_z }, -- ground unit position
					[2] = { x = -184.33, y = 136.34, z = -757.71 }, -- hill unit position
					[3] = { x = -174.58, y = 136.34, z = -710.48 }, -- hill unit position
				})
				elseif game.Workspace._map:FindFirstChild("Village Path") then -- Ant Kingdom
				auto_place_units({
					[1] = { x = pos_x, y = 23.01, z = pos_z }, -- ground unit position
					[2] = { x = -145.86, y = 26.72, z = 2965.56 }, -- hill unit position
					[3] = { x = -191.47, y = 27.20, z = 2952.01 }, -- hill unit position
				})
				elseif game.Workspace._map:FindFirstChild("wooden stacks") then -- Magic Town
				auto_place_units({
					[1] = { x = pos_x, y = 6.74, z = pos_z }, -- ground unit position
					[2] = { x = -596.36, y = 13.99, z = -824.33 }, -- hill unit position
					[3] = { x = -586.75, y = 13.88, z = -824.23 }, -- hill unit position
				})
				elseif game.Workspace._map:FindFirstChild("skeleton") then -- Cursed Academy
				auto_place_units({
					[1] = { x = pos_x, y = 1.23, z = pos_z }, -- ground unit position
					[2] = { x = -167.89, y = 5.03, z = -41.00 }, -- hill unit position
					[3] = { x = -124.5, y = 4.86, z = -44.06 }, -- hill unit position
				})
				elseif game.Workspace._map:FindFirstChild("SpaceCenter") then -- Clover Kingdom
				auto_place_units({
					[1] = { x = pos_x, y = 15.25, z = pos_z }, -- ground unit position
					[2] = { x = -107.81, y = 19.62, z = -526.78 }, -- hill unit position
					[3] = { x = -111.71, y = 19.62, z = -502.85 }, -- hill unit position
				})
				elseif game.Workspace._map:FindFirstChild("boat and bus") then  -- Devil Portal
				auto_place_units({
					[1] = { x = pos_x, y = 1, z = pos_z }, -- ground unit position
					[2] = { x = -361.46, y = 3.91, z = -544.41 }, -- hill unit position
					[3] = { x = -385.43, y = 5.86, z = -559.16 }, -- hill unit position
				})
				elseif game.Workspace._map:FindFirstChild("LanternsGround") then 
				auto_place_units({
					[1] = { x = pos_x, y = 122.06, z = pos_z }, -- ground unit position
					[2] = { x = 394.85, y = 124.44, z = -74.23 }, -- hill unit position
					[3] = { x = 365.35, y = 125.39, z = -95.78 }, -- hill unit position
				})
				elseif game.Workspace:FindFirstChild("opm_1") then -- Alien Spaceship
				auto_place_units({
					[1] = { x = pos_x, y = 361.21, z = pos_z }, -- ground unit position
					[2] = { x = -336.19, y = 365.26, z = 1389.11 }, -- hill unit position
					[3] = { x = -336.18, y = 365.26, z = 1391.78 }, -- hill unit position
				})
				elseif game.Workspace._map:FindFirstChild("ThreeDTextObject") then -- RAID UCHIHA
				auto_place_units({
					[1] = { x = pos_x, y = 536.89, z = pos_z }, -- ground unit position
					[2] = { x = 304.59, y = 539.89, z = -588.45 }, -- hill unit position
					[3] = { x = 267.66, y = 539.89, z = -560.54 }, -- hill unit position
				})
				elseif game.Workspace._map:FindFirstChild("misc nonocollide obstacles") then -- 7DPS
				auto_place_units({
					[1] = { x = pos_x, y = 212.96, z = pos_z }, -- ground unit position
					[2] = { x = -87.39, y = 216.99, z = -214.06 }, -- hill unit position
					[3] = { x = -102.37, y = 219.20, z = -204.66 }, -- hill unit position
				})
				elseif game.Workspace._map:FindFirstChild("parking spots") then
				auto_place_units({
					[1] = { x = pos_x, y = 36.04, z = pos_z }, -- ground unit position
					[2] = { x = -188.33, y = 46.76, z = 552.44 }, -- hill unit position
					[3] = { x = -179.47, y = 46.63, z = 552.69 }, -- hill unit position
				})
				elseif game.Workspace._map:FindFirstChild("vegetation") then  -- RAID WESTCITY
				auto_place_units({
					[1] = { x = pos_x, y = 19.76, z = pos_z }, -- ground unit position
					[2] = { x = -2334.15, y = 31.41, z = -79.33 }, -- hill unit position
					[3] = { x = -2339.57, y = 32.03, z = -90.32 }, -- hill unit position
				})
				elseif game.Workspace._map:FindFirstChild("crashed spaceships") then  -- RAID Freeze
				auto_place_units({
					[1] = { x = pos_x, y = 19.76, z = pos_z }, -- ground unit position
					[2] = { x = -2334.15, y = 31.41, z = -79.33 }, -- hill unit position
					[3] = { x = -2339.57, y = 32.03, z = -90.32 }, -- hill unit position
				})
				elseif game.Workspace._map:FindFirstChild("Support_Beam") then  -- RAID Gyegoro
				auto_place_units({
					[1] = { x = pos_x, y = 495.600, z = pos_z }, -- ground unit position 
					[2] = { x = -130.05, y = 504.78, z = -93.73 }, -- hill unit position -130.05752563476562, 504.7899169921875, -93.732666015625
					[3] = { x = -97.27, y = -97.27, z = -92.03 }, -- hill unit position -97.27552032470703, 500.6242980957031, -92.03937530517578
				})
				elseif game.Workspace._map:FindFirstChild("hay") then  -- ONE PICE
				auto_place_units({
					[1] = { x = pos_x, y = 2.60, z = pos_z }, -- ground unit position 
					[2] = { x = -35.40, y = 5.98, z = -201.43 }, -- hill unit position -130.05752563476562, 504.7899169921875, -93.732666015625
					[3] = { x = -35.40, y = 5.98, z = -201.43 }, -- hill unit position -130.05752563476562, 504.7899169921875, -93.732666015625
				})

			end
		end
	end
end))
--Puppet Island
--#endregion 

--#region SelectUnit

coroutine.resume(coroutine.create(function()
  if game.PlaceId == 8304191830 then
    handle_select_units()
    local collection = plr.PlayerGui:WaitForChild("collection")
    collection:GetPropertyChangedSignal("Enabled"):Connect(function()
      if collection.Enabled == false then
        handle_select_units()
      end
    end)
  end
end))
--#endregion

--#region Auto Upgrade

coroutine.resume(coroutine.create(function()
	while task.wait(0) do
		if game.PlaceId ~= 8304191830 then
			local _wave = game:GetService("Workspace"):WaitForChild("_wave_num")
			if _wave.Value >= 4 then
				pcall(function() --///
					repeat task.wait() until game:GetService("Workspace"):WaitForChild("_UNITS")
					for _, v in ipairs(game:GetService("Workspace")["_UNITS"]:GetChildren()) do
						if v:FindFirstChild("_stats") then
							if tostring(v["_stats"].player.Value) == game.Players.LocalPlayer.Name and v["_stats"].xp.Value >= 0 then
								if v.Name == "wendy" or v.Name == "wendy:shiny" or v.Name == "sakura" then
									-- print(v.Name)
								else
									game:GetService("ReplicatedStorage").endpoints.client_to_server.upgrade_unit_ingame:InvokeServer(v)
								end
							end
						end
					end
				end)
			end
		end
	end
end))

--#endregion 

--#region fram Story
tp_check = true
local function startfarming_Story()
	if getgenv().AutoStart and getgenv().autoSelectMode == "ฟาร์มสตอรี่" or getgenv().AutoStart and getgenv().autoSelectMode == "ฟาร์มไก่เพชร"  then
		if game.PlaceId == 8304191830 then
			task.wait(5)
			local cpos = plr.Character.HumanoidRootPart.CFrame
			if tp_check then
				for _, v in pairs(game:GetService("Workspace")["_LOBBIES"].Story:GetChildren()) do
					check_door = tostring(game:GetService("Workspace")["_LOBBIES"].Story[v.Name].Owner.Value)
					if check_door == "nil"  then
						game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Workspace")["_LOBBIES"].Story[v.Name].Door.CFrame * CFrame.new(0, 0, 1)
						wait(1)
						--// Check ShickenFram
						local checkNaamek = game:GetService("Players").LocalPlayer.PlayerGui.LevelSelectGui.MapSelect.Main.Wrapper.Container.namek.Main.Container.LevelsCleared.V.Text
						if checkNaamek == "6/6" and getgenv().autoSelectMode == "ฟาร์มไก่เพชร" then
							getgenv().autoSelectMode = "ฟาร์มเพชร"
							updatejson()
							wait(2)
							game:GetService("TeleportService"):Teleport(8304191830, game.Players.LocalPlayer)
						end
						--//---------------------
						broke = false
						for g, j in ipairs(game:GetService("Players").LocalPlayer.PlayerGui.LevelSelectGui.MapSelect.Main.Wrapper.Container :GetChildren()) do
							if j:IsA("ImageButton") then
								if j.Name == "ComingSoon" then
								else
									local ClearStory = j.Main.Container.LevelsCleared:GetChildren()
									for l, s in pairs(ClearStory) do
										if s.Name == "V" then
											chLevel = s.Text
											waves = chLevel:split("/")
											if waves[1] == "6" then
												wait(1)
											else
												
												st_farm = j.Name .. "_level_" .. waves[1] + 1
												broke = true
												wait(1)
												local args = {
													[1] = tostring(v.Name), -- Lobby
													[2] = tostring(st_farm), -- World
													[3] = false, -- Friends Only or not
													[4] = "Normal",
												}
												game:GetService("ReplicatedStorage").endpoints.client_to_server.request_lock_level:InvokeServer(unpack(args))
												task.wait(5)
												local args = {
													[1] = tostring(v.Name),
												}
												game:GetService("ReplicatedStorage").endpoints.client_to_server.request_start_game:InvokeServer(unpack(args))
												break
											end
										end
									end
								end
							end
							if broke then
								break
							end
						end
						tp_check = false
						break
					end
				end
			end
			wait(2)
		end
	end
end
--#endregion

--#region Select Mode
coroutine.resume(coroutine.create(function()
	while task.wait() do
		-- Not Lobbies
		if game.PlaceId ~= 8304191830 then
			break
		end

		--#region Farm Story
		if getgenv().AutoStart and getgenv().autoSelectMode == "ฟาร์มสตอรี่" or getgenv().AutoStart and getgenv().autoSelectMode == "ฟาร์มไก่เพชร" then
			startfarming_Story()
		end
		--#endregion

		--#region Farm Gem
		if getgenv().AutoStart and getgenv().autoSelectMode == "ฟาร์มเพชร" then
			if game.PlaceId == 8304191830 then
				local cpos = plr.Character.HumanoidRootPart.CFrame
				if tostring(Workspace._LOBBIES.Story[getgenv().door].Owner.Value) ~= plr.Name then
					for _, v in pairs(game:GetService("Workspace")["_LOBBIES"].Story:GetDescendants()) do
						if v.Name == "Owner" and v.Value == nil then
							local args = {
								[1] = tostring(v.Parent.Name),
							}
							game:GetService("ReplicatedStorage").endpoints.client_to_server.request_join_lobby:InvokeServer(unpack(args))
							task.wait(4)
							if getgenv().autoSelectMode == "ฟาร์มเพชร" then
								local args = {
									[1] = tostring(v.Parent.Name), -- Lobby
									[2] = "namek_infinite", -- World
									[3] = false, -- Friends Only or not
									[4] = "Hard",
								}
								game:GetService("ReplicatedStorage").endpoints.client_to_server.request_lock_level:InvokeServer(unpack(args))
							end
							task.wait(2)
							local args = {
								[1] = tostring(v.Parent.Name),
							}
							game:GetService("ReplicatedStorage").endpoints.client_to_server.request_start_game:InvokeServer(unpack(args))
							game:GetService("ReplicatedStorage").endpoints.client_to_server.request_start_game:InvokeServer(unpack(args))
							getgenv().door = v.Parent.Name
							plr.Character.HumanoidRootPart.CFrame = v.Parent.Door.CFrame
							break
						end
					end
				end
				task.wait()
				plr.Character.HumanoidRootPart.CFrame = cpos
			end
		end
		--#endregion

		--#region Farm Gojo
		if getgenv().AutoStart and getgenv().autoSelectMode == "ฟาร์มตาโกโจ" then
			if game.PlaceId == 8304191830 then
				local cpos = plr.Character.HumanoidRootPart.CFrame
				if tostring(Workspace._LOBBIES.Story[getgenv().door].Owner.Value) ~= plr.Name then
					for _, v in pairs(game:GetService("Workspace")["_LOBBIES"].Story:GetDescendants()) do
						if v.Name == "Owner" and v.Value == nil then
							local args = {
								[1] = tostring(v.Parent.Name),
							}
							game:GetService("ReplicatedStorage").endpoints.client_to_server.request_join_lobby:InvokeServer(unpack(args))
							task.wait(4)
							if getgenv().autoSelectMode == "ฟาร์มตาโกโจ" then
								local args = {
									[1] = tostring(v.Parent.Name), -- Lobby
									[2] = "jjk_infinite", -- World
									[3] = false, -- Friends Only or not
									[4] = "Hard",
								}
								game:GetService("ReplicatedStorage").endpoints.client_to_server.request_lock_level:InvokeServer(unpack(args))
							end
							task.wait(2)
							local args = {
								[1] = tostring(v.Parent.Name),
							}
							game:GetService("ReplicatedStorage").endpoints.client_to_server.request_start_game:InvokeServer(unpack(args))
							game:GetService("ReplicatedStorage").endpoints.client_to_server.request_start_game:InvokeServer(unpack(args))
							getgenv().door = v.Parent.Name
							plr.Character.HumanoidRootPart.CFrame = v.Parent.Door.CFrame
							break
						end
					end
				end
				task.wait()
				plr.Character.HumanoidRootPart.CFrame = cpos
			end
		end
		--#endregion

		--#region Farm BattlePass
		if getgenv().AutoStart and getgenv().autoSelectMode == "ฟาร์ม BattlePass" then
			if game.PlaceId == 8304191830 then
				local cpos = plr.Character.HumanoidRootPart.CFrame
				if tostring(Workspace._LOBBIES.Story[getgenv().door].Owner.Value) ~= plr.Name then
					for _, v in pairs(game:GetService("Workspace")["_LOBBIES"].Story:GetDescendants()) do
						if v.Name == "Owner" and v.Value == nil then
							local args = {
								[1] = tostring(v.Parent.Name),
							}
							game:GetService("ReplicatedStorage").endpoints.client_to_server.request_join_lobby:InvokeServer(unpack(args))
							task.wait(4)
							
								local args = {
									[1] = tostring(v.Parent.Name), -- Lobby
									[2] = "namek_infinite", -- World
									[3] = false, -- Friends Only or not
									[4] = "Hard",
								}
								game:GetService("ReplicatedStorage").endpoints.client_to_server.request_lock_level:InvokeServer(unpack(args))
							
							task.wait(2)
							local args = {
								[1] = tostring(v.Parent.Name),
							}
							game:GetService("ReplicatedStorage").endpoints.client_to_server.request_start_game:InvokeServer(unpack(args))
							game:GetService("ReplicatedStorage").endpoints.client_to_server.request_start_game:InvokeServer(unpack(args))
							getgenv().door = v.Parent.Name
							plr.Character.HumanoidRootPart.CFrame = v.Parent.Door.CFrame
							break
						end
					end
				end
				task.wait()
				plr.Character.HumanoidRootPart.CFrame = cpos
			end
		end
		--#endregion
	
		--#region Farm Level Players
		if getgenv().AutoStart and getgenv().autoSelectMode == "ฟาร์มเวลตัวละคร" then
			if game.PlaceId == 8304191830 then
				local cpos = plr.Character.HumanoidRootPart.CFrame
				if tostring(Workspace._LOBBIES.Story[getgenv().door].Owner.Value) ~= plr.Name then
					for _, v in pairs(game:GetService("Workspace")["_LOBBIES"].Story:GetDescendants()) do
						if v.Name == "Owner" and v.Value == nil then
							local args = {
								[1] = tostring(v.Parent.Name),
							}
							game:GetService("ReplicatedStorage").endpoints.client_to_server.request_join_lobby:InvokeServer(unpack(args))
							task.wait(4)
							local args = {
								[1] = tostring(v.Parent.Name), -- Lobby
								[2] = "namek_level_1", -- World
								[3] = false, -- Friends Only or not
								[4] = "Normal",
							}
							game:GetService("ReplicatedStorage").endpoints.client_to_server.request_lock_level:InvokeServer(unpack(args))
							task.wait(2)
							local args = {
								[1] = tostring(v.Parent.Name),
							}
							game:GetService("ReplicatedStorage").endpoints.client_to_server.request_start_game:InvokeServer(unpack(args))
							game:GetService("ReplicatedStorage").endpoints.client_to_server.request_start_game:InvokeServer(unpack(args))
							getgenv().door = v.Parent.Name
							plr.Character.HumanoidRootPart.CFrame = v.Parent.Door.CFrame
							break
						end
					end
				end
				task.wait()
				plr.Character.HumanoidRootPart.CFrame = cpos
			end
		end
		--#endregion
	
		--#region Farm Clstel

		if getgenv().AutoStart and getgenv().autoSelectMode == "ฟาร์มหอคอย" then
			if game.PlaceId == 8304191830 then
				game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new( 12423.1855, 155.24025, 3198.07593, -1.34111269e-06, -2.02512282e-08, 1, 3.91705386e-13, 1, 2.02512282e-08, -1, 4.18864542e-13, -1.34111269e-06 )
				getgenv().infinityroom = 0
				for i, v in pairs( game:GetService("Players")[game.Players.LocalPlayer.Name].PlayerGui.InfiniteTowerUI.LevelSelect.InfoFrame.LevelButtons :GetChildren() ) do
					if v.Name == "FloorButton" then
						if v.clear.Visible == false and v.Locked.Visible == false then
							local room = string.split(v.Main.text.Text, " ")
	
							local args = {
								[1] = tonumber(room[2]),
							}
	
							game:GetService("ReplicatedStorage").endpoints.client_to_server.request_start_infinite_tower :InvokeServer(unpack(args))
							getgenv().infinityroom = tonumber(room[2])
							break
						end
					end
				end
				task.wait(6)
			end
		elseif getgenv().AutoStart and getgenv().autoSelectMode == "ฟาร์มหอคอย" then
			if game.PlaceId == 8304191830 then
				local args = {
					[1] = "_lobbytemplate_event330",
				}
				game:GetService("ReplicatedStorage").endpoints.client_to_server.request_join_lobby :InvokeServer(unpack(args))
				task.wait(5)
			end
		end
		--#endregion
		
		--#region Farm Frust
		if getgenv().AutoStart and getgenv().autoSelectMode == "ฟาร์มผลไม้" then
			if game.PlaceId == 8304191830 then
				local cpos = plr.Character.HumanoidRootPart.CFrame
				for i, v in pairs(game:GetService("Workspace")["_CHALLENGES"].Challenges:GetDescendants()) do
					if v.Name == "Owner" and v.Value == nil then
						local args = {
							[1] = tostring(v.Parent.Name),
						}
						game:GetService("ReplicatedStorage").endpoints.client_to_server.request_join_lobby:InvokeServer(unpack(args))
						getgenv().chdoor = v.Parent.Name
						break
					end
				end
				task.wait()
				plr.Character.HumanoidRootPart.CFrame = cpos
			end
		end
		--#endregion
	end
end))
--#endregion

--#region Teleport in Wave
local function amReplay()
	while task.wait() do
		if game.PlaceId ~= 8304191830 then
			if getgenv().AutoReplay then
				-- sell unit
				repeat task.wait() until game:GetService("Workspace"):WaitForChild("_UNITS")
				for i, v in ipairs(game:GetService("Workspace")["_UNITS"]:GetChildren()) do
					repeat task.wait() until v:WaitForChild("_stats")
					if tostring(v["_stats"].player.Value) == game.Players.LocalPlayer.Name then
						repeat task.wait() until v:WaitForChild("_stats"):WaitForChild("upgrade")
						game:GetService("ReplicatedStorage").endpoints.client_to_server.sell_unit_ingame:InvokeServer(v)
					end
				end
				--
			end
		end
	end
end
coroutine.resume(coroutine.create(function()
	while task.wait() do
		local _wave = game:GetService("Workspace"):WaitForChild("_wave_num")
		if game.PlaceId ~= 8304191830 then
			--#region Teleport Gem
			levePlayers = LocalPlayer.PlayerGui.spawn_units.Lives.Main.Desc.Level.Text
			levelCheck = levePlayers:split(" ")
			if getgenv().AutoStart and getgenv().autoSelectMode == "ฟาร์มเพชร" and tonumber(levelCheck[2]) <= tonumber(50) and tonumber(_wave.Value) >= tonumber(15) then
				if tonumber(getgenv().textGem) <= 1 then
					pcall(function () webhook_finish()  end)
					task.wait(3)
					game:GetService("TeleportService"):Teleport(8304191830, game.Players.LocalPlayer)
					break
				else
					if getgenv().AutoReplay then
						amReplay()
						break
					else
						pcall(function () webhook()  end)
						task.wait(3)
						game:GetService("TeleportService"):Teleport(8304191830, game.Players.LocalPlayer)
						break
					end
				end
			end
			if getgenv().AutoStart and getgenv().autoSelectMode == "ฟาร์มตาโกโจ" and tonumber(_wave.Value) >= tonumber(32)  then
				if tonumber(getgenv().textGem) <= 0 then
					pcall(function () webhook_finish()  end)
					task.wait(3)
					game:GetService("TeleportService"):Teleport(8304191830, game.Players.LocalPlayer)
					break
				else
					if getgenv().AutoReplay then
						amReplay()
						break
					else
						pcall(function () webhook()  end)
						task.wait(3)
						game:GetService("TeleportService"):Teleport(8304191830, game.Players.LocalPlayer)
						break
					end
				end
			end
			--#endregion
		end
	end
end))
--#endregion

--#region Farm BattlePass

coroutine.resume(coroutine.create(function()
	while task.wait() do
		local _wave = game:GetService("Workspace"):WaitForChild("_wave_num")
		if getgenv().AutoStart and getgenv().autoSelectMode == "ฟาร์ม BattlePass" and tonumber(_wave.Value) >= tonumber(55)  then
			if tonumber(getgenv().textGem) <= tonumber(getgenv().BattlePass) then
				pcall(function () webhook_finish()  end)
			else
				pcall(function () webhook()  end)
			end
			task.wait(3)
			game:GetService("TeleportService"):Teleport(8304191830, game.Players.LocalPlayer)
		end
	end
end))

--#endregion


--#region GameFinished Auto

local function gameisFinishAuto()
	--// Next Story --//
	task.wait(4)

	-- // Replay // --
	if getgenv().AutoReplay and  getgenv().autoSelectMode == "เลือกโหมดที่ต้องการฟาร์ม"  then
		task.wait()
		pcall(function() webhook() end)
		local a = { [1] = "replay" }
		game:GetService("ReplicatedStorage").endpoints.client_to_server.set_game_finished_vote:InvokeServer(unpack(a))
		game:GetService("ReplicatedStorage").endpoints.client_to_server.set_game_finished_vote:InvokeServer(unpack(a))
	end
	-- // Exit Room //--
	if getgenv().autoSelectMode == "เลือกโหมดที่ต้องการฟาร์ม"  then
		task.wait()
		pcall(function() webhook() end)
		game:GetService("TeleportService"):Teleport(8304191830, game.Players.LocalPlayer)
		for i = 1, 180 do
			warn("Game restart in : " .. i)
			task.wait(1)
		end
		game:GetService("TeleportService"):Teleport(8304191830, game.Players.LocalPlayer)
	end
	
	-- // Raid // --
	if getgenv().autoSelectMode == "ฟาร์มไอเท็มเรด" then
		task.wait(3)
		pcall(function() webhook() end)
		if getgenv().AutoReplay then
			local a = { [1] = "replay" }
			game:GetService("ReplicatedStorage").endpoints.client_to_server.set_game_finished_vote:InvokeServer(unpack(a))
			game:GetService("ReplicatedStorage").endpoints.client_to_server.set_game_finished_vote:InvokeServer(unpack(a))
			for i = 1, 180 do
				warn("Game restart in : " .. i)
				task.wait(1)
			end
			game:GetService("TeleportService"):Teleport(8304191830, game.Players.LocalPlayer)
			game:GetService("TeleportService"):Teleport(8304191830, game.Players.LocalPlayer)
			for i = 1, 60 do
				warn("game Shutdown in : " .. i)
				task.wait(1)
			end
			game:Shutdown()
		end
		game:GetService("TeleportService"):Teleport(8304191830, game.Players.LocalPlayer)
	end

	if getgenv().AutoStart and getgenv().autoSelectMode == "ฟาร์มสตอรี่" then
		pcall(function() webhook() end)
		while task.wait(5) do
			local args = {
				[1] = "next_story"
			}
			game:GetService("ReplicatedStorage").endpoints.client_to_server.set_game_finished_vote:InvokeServer(unpack(args))
		end
		wait(99)
	end

	if getgenv().AutoStart and getgenv().autoSelectMode == "ฟาร์มไก่เพชร" then
		pcall(function() webhook() end)
		while task.wait(5) do
			local checkMAp = game:GetService("Workspace")._map:FindFirstChild("namek mushroom model")
			local aceCheck = game:GetService("Players").LocalPlayer.PlayerGui.ResultsUI.Holder.LevelName
			local resultx = tostring(LocalPlayer.PlayerGui.ResultsUI.Holder.Title.Text)
			
			if checkMAp then

				if aceCheck == "Act 6 - The Purple Tyrant" then
					if resultx == "VICTORY" then
						getgenv().autoSelectMode = "ฟาร์มเพชร" 
						updatejson()
						game:GetService("TeleportService"):Teleport(8304191830, game.Players.LocalPlayer)
					else
						local a = { [1] = "replay" }
						game:GetService("ReplicatedStorage").endpoints.client_to_server.set_game_finished_vote:InvokeServer(unpack(a))
						game:GetService("ReplicatedStorage").endpoints.client_to_server.set_game_finished_vote:InvokeServer(unpack(a))
						wait(99)
					end
				else

					if resultx == "VICTORY" then
						local args = {
							[1] = "next_story"
						}
						game:GetService("ReplicatedStorage").endpoints.client_to_server.set_game_finished_vote:InvokeServer(unpack(args))
						game:GetService("ReplicatedStorage").endpoints.client_to_server.set_game_finished_vote:InvokeServer(unpack(args))
					else
						local a = { [1] = "replay" }
						game:GetService("ReplicatedStorage").endpoints.client_to_server.set_game_finished_vote:InvokeServer(unpack(a))
						game:GetService("ReplicatedStorage").endpoints.client_to_server.set_game_finished_vote:InvokeServer(unpack(a))
						wait(99)
					end
				end
			else
				getgenv().autoSelectMode = "ฟาร์มเพชร" 
				updatejson()
				game:GetService("TeleportService"):Teleport(8304191830, game.Players.LocalPlayer)
			end
		end
		wait(99)
	end
	-- // Gems // --
	if getgenv().AutoStart and getgenv().autoSelectMode == "ฟาร์มเพชร" then
		task.wait()
		pcall(function() webhook() end)
		if getgenv().AutoReplay then
			local a = { [1] = "replay" }
			game:GetService("ReplicatedStorage").endpoints.client_to_server.set_game_finished_vote:InvokeServer(unpack(a))
			game:GetService("ReplicatedStorage").endpoints.client_to_server.set_game_finished_vote:InvokeServer(unpack(a))
		end
		game:GetService("TeleportService"):Teleport(8304191830, game.Players.LocalPlayer)
		for i = 1, 180 do
			warn("Game restart in : " .. i)
			task.wait(1)
		end
		game:GetService("TeleportService"):Teleport(8304191830, game.Players.LocalPlayer)
		game:GetService("TeleportService"):Teleport(8304191830, game.Players.LocalPlayer)
		for i = 1, 60 do
			warn("game Shutdown in : " .. i)
			task.wait(1)
		end
		game:Shutdown()
	end

	--// Level Players --//
	if getgenv().AutoStart and getgenv().autoSelectMode == "ฟาร์มเวลตัวละคร" then
		levePlayers = LocalPlayer.PlayerGui.spawn_units.Lives.Main.Desc.Level.Text
		levelCheck = levePlayers:split(" ")
		if tonumber(levelCheck[2]) >= tonumber(getgenv().textGem) then
			pcall(function() webhook_finish() end)
			task.wait(3)
			game:GetService("TeleportService"):Teleport(8304191830, game.Players.LocalPlayer)
		else
			pcall(function() webhook() end)
			local a = { [1] = "replay" }
			game:GetService("ReplicatedStorage").endpoints.client_to_server.set_game_finished_vote:InvokeServer(unpack(a))
			game:GetService("ReplicatedStorage").endpoints.client_to_server.set_game_finished_vote:InvokeServer(unpack(a))
			wait(99)
		end
	end
	-- Castle

	-- if getgenv().AutoStart and getgenv().autoSelectMode == "ฟาร์มหอคอย" then
	-- 	task.wait(5)
	-- 	pcall(function() webhook() end)
	-- 	game:GetService("ReplicatedStorage").endpoints.client_to_server.request_start_infinite_tower_from_game:InvokeServer()
	-- 	game:GetService("ReplicatedStorage").endpoints.client_to_server.request_start_infinite_tower_from_game:InvokeServer()
	-- 	wait(99)
	-- end

	if getgenv().AutoStart and getgenv().autoSelectMode == "ฟาร์มหอคอย" then
		task.wait(5)
		local resultx = tostring(LocalPlayer.PlayerGui.ResultsUI.Holder.Title.Text)
		infTower_check = game:GetService("Players").LocalPlayer.PlayerGui.ResultsUI.Holder.LevelName.Text
		infinityTower = infTower_check:split(" ")
		
		if resultx == "VICTORY" then
			if tonumber(infinityTower[4]) >= tonumber(getgenv().textGem) then
				pcall(function() webhook_finish() end)
			else
				pcall(function() webhook() end)
				game:GetService("ReplicatedStorage").endpoints.client_to_server.request_start_infinite_tower_from_game:InvokeServer()
				game:GetService("ReplicatedStorage").endpoints.client_to_server.request_start_infinite_tower_from_game:InvokeServer()
				wait(99)
			end
		else
			game:GetService("ReplicatedStorage").endpoints.client_to_server.request_start_infinite_tower_from_game:InvokeServer()
			game:GetService("ReplicatedStorage").endpoints.client_to_server.request_start_infinite_tower_from_game:InvokeServer()
			wait(99)
		end
	end

	-- Fruit
	if getgenv().AutoStart and getgenv().autoSelectMode == "ฟาร์มผลไม้" then
		pcall(function() webhook() end)
		task.wait(3)
		game:GetService("TeleportService"):Teleport(8304191830, game.Players.LocalPlayer)
	end

end

coroutine.resume(coroutine.create(function()
	local GameFinished = game:GetService("Workspace"):WaitForChild("_DATA"):WaitForChild("GameFinished")
	GameFinished:GetPropertyChangedSignal("Value"):Connect(function()
		if GameFinished.Value == true then
			wait(2)
			if getgenv().AutoStart then -- Mode Auto
				gameisFinishAuto()
			end
		end
	end)
end))

--#endregion

--#region Auto Sell Units Shop Mystick

coroutine.resume(coroutine.create(function()
	while task.wait() do
		if getgenv().UnitSellTog then
			for i, v in ipairs(game:GetService("ReplicatedStorage")["_FX_CACHE"]:GetChildren()) do
				if v.Name == "CollectionUnitFrame" then
					repeat task.wait() until v:FindFirstChild("name")
					for _, Info in next, getgenv().UnitCache do
						if Info.name == v.name.Text and Info.rarity == "Rare" or Info.name == v.name.Text and Info.rarity == "Epic" then
							if getgenv().UnitSellTog then
								local args = {
									[1] = {
										[1] = tostring(v._uuid.Value),
									},
								}
								game:GetService("ReplicatedStorage").endpoints.client_to_server.sell_units:InvokeServer(unpack(args))
							end
						end
						if getgenv().UnitSellTog == false then
							break
						end
					end
				end
				if getgenv().UnitSellTog == false then
					break
				end
			end
		end
	end
end))

--#endregion

--#region Teleport to Friends

coroutine.resume(coroutine.create(function()
	while task.wait(5) do
		if game.PlaceId == 8304191830 then
			if getgenv().warpfriend then
				local nameList = listFriends()
				for _, f_name in pairs(nameList) do
					for _, v in pairs(game:GetService("Workspace")["_LOBBIES"].Story:GetChildren()) do
							checkOwner = tostring(game:GetService("Workspace")["_LOBBIES"].Story[v.Name].Owner.Value)
							if checkOwner == tostring(f_name) then
								game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Workspace")["_LOBBIES"].Story[v.Name].Door.CFrame * CFrame.new(0, 0, 1)
								task.wait(3)
							end
					end
					for _, v in pairs(game:GetService("Workspace")["_RAID"].Raid:GetChildren()) do
						checkOwner = tostring(game:GetService("Workspace")["_RAID"].Raid[v.Name].Owner.Value)
						if checkOwner == tostring(f_name) then
							task.wait(3)
							game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Workspace")["_RAID"].Raid[v.Name].Door.CFrame * CFrame.new(0, 0, 1)
						end
					end
				end
			end
		end
	end
end))

--#endregion

--#region Anti AFK

coroutine.resume(coroutine.create(function()
	while task.wait(300) do
			pcall(function()
				local vu = game:GetService("VirtualUser")
				game:GetService("Players").LocalPlayer.Idled:connect(function()
					vu:Button2Down(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
					wait(1)
					vu:Button2Up(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
				end)
			end)
	end
end))

--#endregion

--#region Farm Portal

coroutine.resume(coroutine.create(function()
	while task.wait(15) do
		if getgenv().farmprotal then
			--ipairs(game:GetService("ReplicatedStorage")["_FX_CACHE"]:GetChildren())
			print('Find Portal')
			for i, v in ipairs(game:GetService("ReplicatedStorage")["_FX_CACHE"]:GetChildren()) do
				if getgenv().portalnameX == "One Punch Man" then
					if v.Name == "portal_boros_g" then
						getgenv().PortalID = v._uuid_or_id.value
						break
					end
				elseif getgenv().portalnameX == "Demon Leaders" then
					if v.Name == "portal_zeldris" then
						getgenv().PortalID = v._uuid_or_id.value
						break
					end
				elseif getgenv().portalnameX == "Demon Academy" then
					if v.Name == "april_portal_item" then
						getgenv().PortalID = v._uuid_or_id.value
						break
					end
				elseif getgenv().portalnameX ~= "One Punch Man" and v.Name == "portal_csm" or v.Name == "portal_csm1" or v.Name == "portal_csm2" or v.Name == "portal_csm3" or v.Name == "portal_csm4" or v.Name == "portal_csm5" then
					getgenv().PortalID = v._uuid_or_id.value
					break
				end
			end
			task.wait(5)

			local args = {
				[1] = tostring(getgenv().PortalID),
				[2] = {
					["friends_only"] = false,
				},
			}

			game:GetService("ReplicatedStorage").endpoints.client_to_server.use_portal:InvokeServer(unpack(args))

			task.wait(45)

			for i, v in pairs(game:GetService("Workspace")["_PORTALS"].Lobbies:GetDescendants()) do
				if v.Name == "Owner" then
					if tostring(v.value) == game.Players.LocalPlayer.Name then
						local args = {
							[1] = tostring(v.Parent.Name),
						}
						game:GetService("ReplicatedStorage").endpoints.client_to_server.request_start_game:InvokeServer(unpack(args))
						break
					end
				end
			end
			task.wait(7)
		end
	end
end))

--#endregion

--#region Lock FPS

function low_cpu()
  UserInputService.WindowFocusReleased:Connect(function()
    setfpscap(10)
  end)
  UserInputService.WindowFocused:Connect(function()
    setfpscap(30)
  end)
end

low_cpu()

--#endregion

--#region Aoto JoinPortal

coroutine.resume(coroutine.create(function()
	while task.wait() do
    if game.PlaceId == 8304191830 then
      if getgenv().autoportal then 
        for i, v in pairs(game:GetService("Workspace")["_PORTALS"].Lobbies:GetChildren()) do
          local args = {
            [1] = tostring(v.Name),
          }
          game:GetService("ReplicatedStorage").endpoints.client_to_server.request_join_lobby:InvokeServer(unpack(args))
          task.wait(3) 
        end
        task.wait(5) --// Wait New Loop 
      end
    end
	end
end))

--#endregion

--#region setting Hidden Error

coroutine.resume(coroutine.create(function()
	while task.wait() do
		if game.PlaceId ~= 8304191830 then
			--// Disble Error in game
			game.Players.LocalPlayer.PlayerGui.MessageGui.Enabled = false
			game:GetService("ReplicatedStorage").packages.assets["ui_sfx"].error.Volume = 0
			game:GetService("ReplicatedStorage").packages.assets["ui_sfx"].error_old.Volume = 0
			--// AUTO SETTING LOW POLYGON
			local args = {
					[1] = "low_quality",
					[2] = true
			}
			game:GetService("ReplicatedStorage").endpoints.client_to_server.toggle_setting:InvokeServer(unpack(args))
			local args = {
					[1] = "disable_kill_fx",
					[2] = true
			}
			game:GetService("ReplicatedStorage").endpoints.client_to_server.toggle_setting:InvokeServer(unpack(args))
			local args = {
					[1] = "disable_other_fx",
					[2] = true
			}
			game:GetService("ReplicatedStorage").endpoints.client_to_server.toggle_setting:InvokeServer(unpack(args))
			local args = {
					[1] = "disable_effects",
					[2] = true
			}
			game:GetService("ReplicatedStorage").endpoints.client_to_server.toggle_setting:InvokeServer(unpack(args))
			local args = {
					[1] = "low_quality_shadows",
					[2] = true
			}
			game:GetService("ReplicatedStorage").endpoints.client_to_server.toggle_setting:InvokeServer(unpack(args))
			local args = {
					[1] = "low_quality_textures",
					[2] = true
			}
			game:GetService("ReplicatedStorage").endpoints.client_to_server.toggle_setting:InvokeServer(unpack(args))
			local args = {
					[1] = "autoskip_waves",
					[2] = true
			}
			game:GetService("ReplicatedStorage").endpoints.client_to_server.toggle_setting:InvokeServer(unpack(args))
			local args = {
					[1] = "disable_auto_open_overhead",
					[2] = true
			}
			game:GetService("ReplicatedStorage").endpoints.client_to_server.toggle_setting:InvokeServer(unpack(args))
			--///////////////////////////////////////////////////////////////////////////////////////////////////--
		end
		break
	end
end))

-- function autoload()
-- 		pcall(function()
-- 				if exec == "Synapse X" then
-- 						syn.queue_on_teleport("loadstring(game:HttpGet('https://raw.githubusercontent.com/iwhiteiwhite/iwhiteiwhite/main/ldScr.lua'))()")
-- 					else
-- 						queue_on_teleport("loadstring(game:HttpGet('https://raw.githubusercontent.com/iwhiteiwhite/iwhiteiwhite/main/ldScr.lua'))()")
-- 				end
-- 		end)
-- end
-- autoload()


--#endregion 

--#region Auto Reconnect
function auto_reconnect()
  repeat task.wait() until game.CoreGui:FindFirstChild('RobloxPromptGui')
  game.CoreGui.RobloxPromptGui.promptOverlay.ChildAdded:Connect(function(e)
    if e.Name == 'ErrorPrompt' then
      warn("Trying to Reconnect")
      repeat
        game:GetService("TeleportService"):Teleport(8304191830, game.Players.LocalPlayer)
        task.wait(3)
      until false
    end
  end)
end
auto_reconnect()
--#endregion

--#region Check Status
coroutine.resume(coroutine.create(function()
	while task.wait(4) do
		game:GetService("StarterGui"):SetCore("SendNotification",{
			Title = "check status", -- Required
			Text = "ระบบกำลังทำงาน..", -- Required
			Icon = "rbxthumb://type=AvatarHeadShot&id=" .. plr.UserId .. "&w=180&h=180 true";
			Duration = 2
		})
	end
end))
--#endregion

wait(30)
setfpscap(5)
print('Loader Suscuess!!')
