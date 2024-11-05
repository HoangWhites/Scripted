local TweenService = game:service"TweenService"
local plr = game.Players.LocalPlayer
local uis = game:GetService("UserInputService")
local mouse = plr:GetMouse()
local ParentGui = game.Players.LocalPlayer.PlayerGui -- or ParentGui
local Library = {}

makedraggable = function (topbar, object)
	local Dragging = false
	local DragInput = nil
	local DragStart = nil
	local PositionStart = nil

	local function Update(input)
		local Delta = input.Position - DragStart
		local newPos = UDim2.new(
			PositionStart.X.Scale,
			PositionStart.X.Offset + Delta.X,
			PositionStart.Y.Scale,
			PositionStart.Y.Offset + Delta.Y
		)
		object.Position = newPos
	end

	topbar.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			Dragging = true
			DragStart = input.Position
			PositionStart = object.Position

			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					Dragging = false
				end
			end)
		end
	end)

	topbar.InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
			DragInput = input
		end
	end)

	uis.InputChanged:Connect(function(input)
		if input == DragInput and Dragging then
			Update(input)
		end
	end)
end

function Library:AddNotify(ConfigNotify)
    ConfigNotify = ConfigNotify or {}
    ConfigNotify.Title = ConfigNotify.Title or "Notification"
    ConfigNotify.Content = ConfigNotify.Content or "This Is Notification"
    ConfigNotify.Time = ConfigNotify.Time or 5

    spawn(function()
        if not game.Players.LocalPlayer.PlayerGui:FindFirstChild("NotifyGay") then
            local UniqueNotify = Instance.new("ScreenGui")
            UniqueNotify.Name = "NotifyGay"
            UniqueNotify.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
            UniqueNotify.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
        end
        if not game.Players.LocalPlayer.PlayerGui:WaitForChild("NotifyGay"):FindFirstChild("NotifyLayout") then
            local NotifyLayout = Instance.new("Frame")
            NotifyLayout.Name = "NotifyLayout"
            NotifyLayout.Parent = game.Players.LocalPlayer.PlayerGui:WaitForChild("NotifyGay")
            NotifyLayout.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            NotifyLayout.BackgroundTransparency = 1.000
            NotifyLayout.BorderColor3 = Color3.fromRGB(0, 0, 0)
            NotifyLayout.BorderSizePixel = 0
            NotifyLayout.Position = UDim2.new(1, 200, 1, -100)
            NotifyLayout.Size = UDim2.new(0, 200, 0, 63)
            local Count = 0
            game.Players.LocalPlayer.PlayerGui:WaitForChild("NotifyGay").NotifyLayout.ChildRemoved:Connect(function()
                for r, v in next, game.Players.LocalPlayer.PlayerGui:WaitForChild("NotifyGay").NotifyLayout:GetChildren() do
                    TweenService:Create(v, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {Position = UDim2.new(0, 0, 1, -((v.Size.Y.Offset + 12) * Count))}):Play()
                    Count = Count + 1
                end
            end)
        end
        local NotifyPosHeigh = 0
        for i, v in game.Players.LocalPlayer.PlayerGui:WaitForChild("NotifyGay").NotifyLayout:GetChildren() do
            NotifyPosHeigh = -(v.Position.Y.Offset) + v.Size.Y.Offset + 12
        end
        local NotifyReal = Instance.new("Frame")
        local UICorner = Instance.new("UICorner")
        local Title = Instance.new("TextLabel")
        local UIPadding = Instance.new("UIPadding")
        local Desc = Instance.new("TextLabel")
        local UIPadding_2 = Instance.new("UIPadding")
        local Time = Instance.new("Frame")
        local Close = Instance.new("Frame")
        local Logo = Instance.new("ImageLabel")
        local Click = Instance.new("TextButton")
        local DropShadowHolder = Instance.new("Frame")
        local DropShadow = Instance.new("ImageLabel")
        local NotifyFunc = {}

        NotifyReal.Name = "NotifyReal"
        NotifyReal.Parent = game.Players.LocalPlayer.PlayerGui:WaitForChild("NotifyGay"):FindFirstChild("NotifyLayout")
        NotifyReal.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
        NotifyReal.BorderColor3 = Color3.fromRGB(0, 0, 0)
        NotifyReal.BorderSizePixel = 0
        NotifyReal.Position = UDim2.new(0, 0, 0, -(NotifyPosHeigh))
        NotifyReal.Size = UDim2.new(0, 200, 0, 66)

        UICorner.CornerRadius = UDim.new(0, 4)
        UICorner.Parent = NotifyReal

        Title.Name = "Title"
        Title.Parent = NotifyReal
        Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        Title.BackgroundTransparency = 1.000
        Title.BorderColor3 = Color3.fromRGB(0, 0, 0)
        Title.BorderSizePixel = 0
        Title.Size = UDim2.new(1, 0, 0, 20)
        Title.Font = Enum.Font.GothamBold
        Title.Text = ConfigNotify.Title
        Title.TextColor3 = Color3.fromRGB(255, 255, 255)
        Title.TextSize = 14.000
        Title.TextXAlignment = Enum.TextXAlignment.Left

        UIPadding.Parent = Title
        UIPadding.PaddingLeft = UDim.new(0, 12)
        UIPadding.PaddingTop = UDim.new(0, 7)

        Desc.Name = "Desc"
        Desc.Parent = NotifyReal
        Desc.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        Desc.BackgroundTransparency = 1.000
        Desc.BorderColor3 = Color3.fromRGB(0, 0, 0)
        Desc.BorderSizePixel = 0
        Desc.Position = UDim2.new(0, 0, 0, 23)
        Desc.Size = UDim2.new(1, 0, 1, -23)
        Desc.Font = Enum.Font.GothamBold
        Desc.Text = ConfigNotify.Content
        Desc.TextColor3 = Color3.fromRGB(144, 144, 144)
        Desc.TextSize = 12.000
        Desc.TextWrapped = true
        Desc.TextXAlignment = Enum.TextXAlignment.Left
        Desc.TextYAlignment = Enum.TextYAlignment.Top

        UIPadding_2.Parent = Desc
        UIPadding_2.PaddingLeft = UDim.new(0, 12)
        UIPadding_2.PaddingTop = UDim.new(0, 2)

        Time.Name = "Time"
        Time.Parent = NotifyReal
        Time.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        Time.BorderColor3 = Color3.fromRGB(0, 0, 0)
        Time.BorderSizePixel = 0
        Time.Size = UDim2.new(1, 0, 0, 1)

        Close.Name = "Close"
        Close.Parent = NotifyReal
        Close.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        Close.BackgroundTransparency = 1.000
        Close.BorderColor3 = Color3.fromRGB(0, 0, 0)
        Close.BorderSizePixel = 0
        Close.Position = UDim2.new(1, -20, 0, 0)
        Close.Size = UDim2.new(0, 20, 0, 20)

        Logo.Name = "Logo"
        Logo.Parent = Close
        Logo.AnchorPoint = Vector2.new(0.5, 0.5)
        Logo.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        Logo.BackgroundTransparency = 1.000
        Logo.BorderColor3 = Color3.fromRGB(0, 0, 0)
        Logo.BorderSizePixel = 0
        Logo.Position = UDim2.new(0.5, 0, 0.5, 0)
        Logo.Size = UDim2.new(0, 10, 0, 10)
        Logo.Image = "http://www.roblox.com/asset/?id=77914344378314"

        Click.Name = "Click"
        Click.Parent = Close
        Click.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        Click.BackgroundTransparency = 1.000
        Click.BorderColor3 = Color3.fromRGB(0, 0, 0)
        Click.BorderSizePixel = 0
        Click.Size = UDim2.new(1, 0, 1, 0)
        Click.Font = Enum.Font.SourceSans
        Click.Text = ""
        Click.TextColor3 = Color3.fromRGB(0, 0, 0)
        Click.TextSize = 14.000

        DropShadowHolder.Name = "DropShadowHolder"
        DropShadowHolder.Parent = NotifyFrame
        DropShadowHolder.BackgroundTransparency = 1.000
        DropShadowHolder.BorderSizePixel = 0
        DropShadowHolder.Size = UDim2.new(1, 0, 1, 0)
        DropShadowHolder.ZIndex = 0

        DropShadow.Name = "DropShadow"
        DropShadow.Parent = DropShadowHolder
        DropShadow.AnchorPoint = Vector2.new(0.5, 0.5)
        DropShadow.BackgroundTransparency = 1.000
        DropShadow.BorderSizePixel = 0
        DropShadow.Position = UDim2.new(0.5, 0, 0.5, 0)
        DropShadow.Size = UDim2.new(1, 50, 1, 50)
        DropShadow.ZIndex = 0
        DropShadow.Image = "rbxassetid://6015897843"
        DropShadow.ImageColor3 = Color3.fromRGB(106, 117, 135)
        DropShadow.ImageTransparency = 0.500
        DropShadow.ScaleType = Enum.ScaleType.Slice
        DropShadow.SliceCenter = Rect.new(49, 49, 450, 450)

        local waitbruh = false
        function NotifyFunc:Close()
            if waitbruh then
                return false
            end
            waitbruh = true
            TweenService:Create(
                NotifyReal,
                TweenInfo.new(tonumber(.2), Enum.EasingStyle.Back, Enum.EasingDirection.InOut),
                {Position = UDim2.new(0, 400, 0, 0)}
            ):Play()
            task.wait(tonumber(ConfigNotify.Time) / 1.2)
            game.Players.LocalPlayer.PlayerGui.NotifyGay.NotifyLayout:Destroy()
        end
        Click.MouseButton1Click:Connect(
            function()
                NotifyFunc:Close()
            end
        )
        TweenService:Create(
            NotifyReal,
            TweenInfo.new(tonumber(.2), Enum.EasingStyle.Back, Enum.EasingDirection.InOut),
            {Position = UDim2.new(0, -444, 1, -(NotifyPosHeigh) - 20)}
        ):Play()
        Time:TweenSize(UDim2.new(0, 0, 0, 1),"Out","Quad",tonumber(ConfigNotify.Time),true)
        task.wait(tonumber(ConfigNotify.Time))
        TweenService:Create(
            NotifyReal,
            TweenInfo.new(tonumber(.2), Enum.EasingStyle.Back, Enum.EasingDirection.InOut),
            {Position = UDim2.new(1, -0, 1, -(NotifyPosHeigh) - 20)}
        ):Play()
        task.wait(tonumber(2))
        NotifyFunc:Close()
        return NotifyFunc
    end)
end

function Library:AddWindows()
	local Whites = Instance.new("ScreenGui")
	local Main = Instance.new("Frame")
	local UICorner = Instance.new("UICorner")
	local TabFrame = Instance.new("Frame")
	local UICorner_2 = Instance.new("UICorner")
	local TabHolder = Instance.new("ScrollingFrame")
	local UIPadding = Instance.new("UIPadding")
	local UIListLayout = Instance.new("UIListLayout")
	local LayoutChannel = Instance.new("Frame")
	local Synigga = Instance.new("Frame")
	local Nguu = Instance.new("Folder")
	local UIPageLayout = Instance.new("UIPageLayout")
	local Channel = Instance.new("Frame")
	local Logo = Instance.new("ImageLabel")
	local Version = Instance.new("TextLabel")
	local Friends = Instance.new("TextLabel")
	local Dev = Instance.new("TextLabel")
	local ANNOUNCEMENT = Instance.new("TextLabel")
	local ToggleInterface = Instance.new("Frame")
	local UICorner_3 = Instance.new("UICorner")
	local Cricle = Instance.new("Frame")
	local UICorner_4 = Instance.new("UICorner")
	local UIStroke = Instance.new("UIStroke")
	local Click_3 = Instance.new("TextButton")
	local Nichga = Instance.new("TextLabel")
	local Nigger = Instance.new("Frame")
	local UICorner_5 = Instance.new("UICorner")
	local TextLabel = Instance.new("TextLabel")
	local Top = Instance.new("Frame")
	local TabEnable = Instance.new("Frame")
	local Icon = Instance.new("ImageLabel")
	local Click = Instance.new("TextButton")
	local UserInterface = Instance.new("Frame")
	local UICorner_20 = Instance.new("UICorner")
	local UserFace = Instance.new("Frame")
	local UICorner_21 = Instance.new("UICorner")
	local UIStroke_2 = Instance.new("UIStroke")
	local UIGradient = Instance.new("UIGradient")
	local IconPlayer = Instance.new("ImageLabel")
	local UICorner_22 = Instance.new("UICorner")
	local USERNAME = Instance.new("TextLabel")
	local TimeElapsed = Instance.new("TextLabel")
	local Belis = Instance.new("TextLabel")
	local TimeElapsed_2 = Instance.new("TextLabel")
	local TimeElapsed_3 = Instance.new("TextLabel")
	local Features = Instance.new("ImageLabel")
	local DropShadowHolder_2 = Instance.new("Frame")
	local DropShadow_2 = Instance.new("ImageLabel")
	local CountTab = 1

	UserInterface.Name = "User Interface"
	UserInterface.Parent = Main
	UserInterface.AnchorPoint = Vector2.new(0.5, 0.5)
	UserInterface.BackgroundColor3 = Color3.fromRGB(24, 24, 24)
	UserInterface.BorderColor3 = Color3.fromRGB(0, 0, 0)
	UserInterface.BorderSizePixel = 0
	UserInterface.Position = UDim2.new(1.34000003, 0, 0.5, 0)
	UserInterface.Size = UDim2.new(0, 350, 0, 359)

	UICorner_20.CornerRadius = UDim.new(0, 12)
	UICorner_20.Parent = UserInterface

	UserFace.Name = "UserFace"
	UserFace.Parent = UserInterface
	UserFace.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	UserFace.BackgroundTransparency = 1.000
	UserFace.BorderColor3 = Color3.fromRGB(0, 0, 0)
	UserFace.BorderSizePixel = 0
	UserFace.Position = UDim2.new(0, 125, 0, 36)
	UserFace.Size = UDim2.new(0, 100, 0, 100)

	UICorner_21.CornerRadius = UDim.new(1, 0)
	UICorner_21.Parent = UserFace

	UIStroke_2.Parent = UserFace
	UIStroke_2.Color = Color3.fromRGB(255, 255, 255)
	UIStroke_2.Thickness = 2.000

	UIGradient.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(13, 13, 13)), ColorSequenceKeypoint.new(0.49, Color3.fromRGB(72, 72, 72)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(139, 139, 139))}
	UIGradient.Parent = UIStroke_2

	IconPlayer.Name = "IconPlayer"
	IconPlayer.Parent = UserFace
	IconPlayer.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	IconPlayer.BackgroundTransparency = 1.000
	IconPlayer.BorderColor3 = Color3.fromRGB(0, 0, 0)
	IconPlayer.BorderSizePixel = 0
	IconPlayer.Size = UDim2.new(0, 100, 0, 100)
	IconPlayer.Image = "https://www.roblox.com/headshot-thumbnail/image?userId="..game:GetService("Players").LocalPlayer.UserId .."&width=420&height=420&format=png"

	UICorner_22.CornerRadius = UDim.new(1, 0)
	UICorner_22.Parent = IconPlayer

	USERNAME.Name = "USERNAME"
	USERNAME.Parent = UserFace
	USERNAME.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	USERNAME.BackgroundTransparency = 1.000
	USERNAME.BorderColor3 = Color3.fromRGB(0, 0, 0)
	USERNAME.BorderSizePixel = 0
	USERNAME.Position = UDim2.new(-0.400000006, 0, 1.08000004, 0)
	USERNAME.Size = UDim2.new(0, 200, 0, 50)
	USERNAME.Font = Enum.Font.GothamBold
	USERNAME.Text = "USERNAME : " .. plr.Name
	USERNAME.TextColor3 = Color3.fromRGB(255, 255, 255)
	USERNAME.TextSize = 17.000
	USERNAME.TextXAlignment = Enum.TextXAlignment.Left

	TimeElapsed.Name = "Time Elapsed"
	TimeElapsed.Parent = UserFace
	TimeElapsed.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	TimeElapsed.BackgroundTransparency = 1.000
	TimeElapsed.BorderColor3 = Color3.fromRGB(0, 0, 0)
	TimeElapsed.BorderSizePixel = 0
	TimeElapsed.Position = UDim2.new(-0.400000006, 0, 1.39999998, 0)
	TimeElapsed.Size = UDim2.new(0, 200, 0, 50)
	TimeElapsed.Font = Enum.Font.GothamBold
	TimeElapsed.Text = "Time Elapsed : 0H 0M 0S"
	TimeElapsed.TextColor3 = Color3.fromRGB(255, 255, 255)
	TimeElapsed.TextSize = 17.000
	TimeElapsed.TextXAlignment = Enum.TextXAlignment.Left

	function getElapsedTime(startTime)
		local elapsedTime = tick() - startTime
		local hours = math.floor(elapsedTime / 3600)
		local minutes = math.floor((elapsedTime % 3600) / 60)
		local seconds = elapsedTime % 60
	
		return string.format("%dH %dM %dS", hours, minutes, seconds)
	end
	startTime = tick()
	game:GetService("RunService").Stepped:Connect(function()
		TimeElapsed.Text = "Time Elapsed : " ..getElapsedTime(startTime)
	end)

	Belis.Name = "Belis"
	Belis.Parent = UserFace
	Belis.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Belis.BackgroundTransparency = 1.000
	Belis.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Belis.BorderSizePixel = 0
	Belis.Position = UDim2.new(-0.400000006, 0, 1.74000001, 0)
	Belis.Size = UDim2.new(0, 200, 0, 50)
	Belis.Font = Enum.Font.GothamBold
	Belis.Text = "Player Belis : 100000000"
	Belis.TextColor3 = Color3.fromRGB(255, 255, 35)
	Belis.TextSize = 17.000
	Belis.TextXAlignment = Enum.TextXAlignment.Left

	function AutoSetBeli()
		while wait() do
			Belis.Text = "Player Beli : ".. plr.Data.Beli.Value  
		end
	end

	TimeElapsed_2.Name = "Time Elapsed"
	TimeElapsed_2.Parent = UserFace
	TimeElapsed_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	TimeElapsed_2.BackgroundTransparency = 1.000
	TimeElapsed_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
	TimeElapsed_2.BorderSizePixel = 0
	TimeElapsed_2.Position = UDim2.new(-0.400000006, 0, 2.3499999, 0)
	TimeElapsed_2.Size = UDim2.new(0, 200, 0, 50)
	TimeElapsed_2.Font = Enum.Font.GothamBold
	TimeElapsed_2.Text = "Bounty : 300000000"
	TimeElapsed_2.TextColor3 = Color3.fromRGB(255, 255, 255)
	TimeElapsed_2.TextSize = 17.000
	TimeElapsed_2.TextXAlignment = Enum.TextXAlignment.Left

	function AutoSetBounty()
		while wait() do
			TimeElapsed_2.Text = "Bounty : ".. plr.leaderstats["Bounty/Honor"].Value 
		end
	end

	TimeElapsed_3.Name = "Time Elapsed"
	TimeElapsed_3.Parent = UserFace
	TimeElapsed_3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	TimeElapsed_3.BackgroundTransparency = 1.000
	TimeElapsed_3.BorderColor3 = Color3.fromRGB(0, 0, 0)
	TimeElapsed_3.BorderSizePixel = 0
	TimeElapsed_3.Position = UDim2.new(-0.400000006, 0, 2.04999995, 0)
	TimeElapsed_3.Size = UDim2.new(0, 200, 0, 50)
	TimeElapsed_3.Font = Enum.Font.GothamBold
	TimeElapsed_3.Text = "Fragments : 100000000"
	TimeElapsed_3.TextColor3 = Color3.fromRGB(255, 56, 222)
	TimeElapsed_3.TextSize = 17.000
	TimeElapsed_3.TextXAlignment = Enum.TextXAlignment.Left

	function AutoSetFragments()
		while wait() do
			TimeElapsed_3.Text = "Fragments : ".. plr.Data.Fragments.Value
		end
	end

	Features.Name = "Features"
	Features.Parent = UserInterface
	Features.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Features.BackgroundTransparency = 1.000
	Features.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Features.BorderSizePixel = 0
	Features.Position = UDim2.new(-0.405714273, 0, -0.157381698, 0)
	Features.Size = UDim2.new(1.81357145, 0, 1.31337059, 0)
	Features.ZIndex = 0
	Features.Image = "rbxassetid://121551106919693"

	DropShadowHolder_2.Name = "DropShadowHolder"
	DropShadowHolder_2.Parent = UserInterface
	DropShadowHolder_2.BackgroundTransparency = 1.000
	DropShadowHolder_2.BorderSizePixel = 0
	DropShadowHolder_2.Size = UDim2.new(1, 0, 1, 0)
	DropShadowHolder_2.ZIndex = 0

	DropShadow_2.Name = "DropShadow"
	DropShadow_2.Parent = DropShadowHolder_2
	DropShadow_2.AnchorPoint = Vector2.new(0.5, 0.5)
	DropShadow_2.BackgroundTransparency = 1.000
	DropShadow_2.BorderSizePixel = 0
	DropShadow_2.Position = UDim2.new(0.5, 0, 0.5, 0)
	DropShadow_2.Size = UDim2.new(1, 47, 1, 47)
	DropShadow_2.ZIndex = 0
	DropShadow_2.Image = "rbxassetid://6015897843"
	DropShadow_2.ImageColor3 = Color3.fromRGB(0, 0, 0)
	DropShadow_2.ImageTransparency = 1.000
	DropShadow_2.ScaleType = Enum.ScaleType.Slice
	DropShadow_2.SliceCenter = Rect.new(49, 49, 450, 450)

	Whites.Name = "Whites"
	Whites.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
	Whites.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

	Main.Name = "Main"
	Main.Parent = Whites
	Main.AnchorPoint = Vector2.new(0.5, 0.5)
	Main.BackgroundColor3 = Color3.fromRGB(24, 24, 24)
	Main.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Main.BorderSizePixel = 0
	Main.Position = UDim2.new(0.5, 0, 0.5, 0)
	Main.Size = UDim2.new(0, 541, 0, 359)

	UICorner.CornerRadius = UDim.new(0, 12)
	UICorner.Parent = Main

	Top.Name = "Top"
	Top.Parent = Main
	Top.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Top.BackgroundTransparency = 1.000
	Top.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Top.BorderSizePixel = 0
	Top.Size = UDim2.new(1, 0, 0, 50)

	TabFrame.Name = "TabFrame"
	TabFrame.Parent = Main
	TabFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	TabFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
	TabFrame.BorderSizePixel = 0
	TabFrame.Position = UDim2.new(0, 6, 0, 6)
	TabFrame.Size = UDim2.new(0, 80, 1, -12)

	UICorner_2.CornerRadius = UDim.new(0, 12)
	UICorner_2.Parent = TabFrame

	TabHolder.Name = "Tab Holder"
	TabHolder.Parent = TabFrame
	TabHolder.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	TabHolder.BackgroundTransparency = 1.000
	TabHolder.BorderColor3 = Color3.fromRGB(0, 0, 0)
	TabHolder.BorderSizePixel = 0
	TabHolder.Size = UDim2.new(1, 0, 1, 0)
	TabHolder.ScrollBarThickness = 0
    game:GetService("RunService").Stepped:Connect(function()
        TabHolder.CanvasSize = UDim2.new(0, 0, 0, UIListLayout.AbsoluteContentSize.Y + 20)
    end)

	UIPadding.Parent = TabHolder
	UIPadding.PaddingBottom = UDim.new(0, 12)
	UIPadding.PaddingLeft = UDim.new(0, 12)
	UIPadding.PaddingRight = UDim.new(0, 12)
	UIPadding.PaddingTop = UDim.new(0, 12)

	UIListLayout.Parent = TabHolder
	UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
	UIListLayout.Padding = UDim.new(0, 14)

	LayoutChannel.Name = "LayoutChannel"
	LayoutChannel.Parent = Main
	LayoutChannel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	LayoutChannel.BackgroundTransparency = 1.000
	LayoutChannel.BorderColor3 = Color3.fromRGB(0, 0, 0)
	LayoutChannel.BorderSizePixel = 0
	LayoutChannel.Position = UDim2.new(0, 98, 0, 6)
	LayoutChannel.Size = UDim2.new(1, -110, 1, -12)

	Synigga.Name = "Synigga"
	Synigga.Parent = LayoutChannel
	Synigga.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Synigga.BackgroundTransparency = 1.000
	Synigga.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Synigga.BorderSizePixel = 0
	Synigga.ClipsDescendants = true
	Synigga.Size = UDim2.new(1, 0, 1, 0)

	Nguu.Name = "Nguu"
	Nguu.Parent = Synigga

	UIPageLayout.Parent = Nguu
	UIPageLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
	UIPageLayout.SortOrder = Enum.SortOrder.LayoutOrder
	UIPageLayout.EasingStyle = Enum.EasingStyle.Linear
	UIPageLayout.Padding = UDim.new(0, 12)
	UIPageLayout.TweenTime = 0.250

	Channel.Name = "Channel"
	Channel.Parent = Nguu
	Channel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Channel.BackgroundTransparency = 1.000
	Channel.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Channel.BorderSizePixel = 0
	Channel.Size = UDim2.new(1, 0, 1, 0)

	Logo.Name = "Logo"
	Logo.Parent = Channel
	Logo.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Logo.BackgroundTransparency = 1.000
	Logo.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Logo.BorderSizePixel = 0
	Logo.Position = UDim2.new(-0.0278422274, 0, -0.0172910672, 0)
	Logo.Size = UDim2.new(0, 200, 0, 200)
	Logo.Image = "http://www.roblox.com/asset/?id=109359250966429"

	Version.Name = "Version"
	Version.Parent = Channel
	Version.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Version.BackgroundTransparency = 1.000
	Version.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Version.BorderSizePixel = 0
	Version.Position = UDim2.new(0.436194897, 0, 0.0806916431, 0)
	Version.Size = UDim2.new(0, 200, 0, 50)
	Version.Font = Enum.Font.GothamBold
	Version.Text = "Owner : Hoang Nam"
	Version.TextColor3 = Color3.fromRGB(255, 255, 255)
	Version.TextSize = 17.000
	Version.TextXAlignment = Enum.TextXAlignment.Left

	Friends.Name = "Friends"
	Friends.Parent = Channel
	Friends.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Friends.BackgroundTransparency = 1.000
	Friends.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Friends.BorderSizePixel = 0
	Friends.Position = UDim2.new(0.436194897, 0, 0.219020173, 0)
	Friends.Size = UDim2.new(0, 255, 0, 50)
	Friends.Font = Enum.Font.GothamBold
	Friends.Text = "My Friends : ! Sync, Susano, Rise"
	Friends.TextColor3 = Color3.fromRGB(255, 255, 255)
	Friends.TextSize = 17.000
	Friends.TextWrapped = true
	Friends.TextXAlignment = Enum.TextXAlignment.Left

	Dev.Name = "Dev"
	Dev.Parent = Channel
	Dev.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Dev.BackgroundTransparency = 1.000
	Dev.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Dev.BorderSizePixel = 0
	Dev.Position = UDim2.new(0.436194897, 0, 0.36311239, 0)
	Dev.Size = UDim2.new(0, 255, 0, 50)
	Dev.Font = Enum.Font.GothamBold
	Dev.Text = "Dev: Khanh, Susano, Rise, Resuralツ\n"
	Dev.TextColor3 = Color3.fromRGB(255, 255, 255)
	Dev.TextSize = 17.000
	Dev.TextWrapped = true
	Dev.TextXAlignment = Enum.TextXAlignment.Left

	ANNOUNCEMENT.Name = "ANNOUNCEMENT"
	ANNOUNCEMENT.Parent = Channel
	ANNOUNCEMENT.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	ANNOUNCEMENT.BackgroundTransparency = 1.000
	ANNOUNCEMENT.BorderColor3 = Color3.fromRGB(0, 0, 0)
	ANNOUNCEMENT.BorderSizePixel = 0
	ANNOUNCEMENT.Position = UDim2.new(-0.0278422274, 0, 0.507204592, 0)
	ANNOUNCEMENT.Size = UDim2.new(0, 219, 0, 50)
	ANNOUNCEMENT.Font = Enum.Font.GothamBold
	ANNOUNCEMENT.Text = "[+] ANNOUNCEMENT"
	ANNOUNCEMENT.TextColor3 = Color3.fromRGB(255, 255, 255)
	ANNOUNCEMENT.TextSize = 20.000

	ToggleInterface.Name = "ToggleInterface"
	ToggleInterface.Parent = ANNOUNCEMENT
	ToggleInterface.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	ToggleInterface.BorderColor3 = Color3.fromRGB(0, 0, 0)
	ToggleInterface.BorderSizePixel = 0
	ToggleInterface.Position = UDim2.new(1.47000003, 30, 0.239999995, 0)
	ToggleInterface.Size = UDim2.new(0, 75, 0, 20)

	UICorner_3.Parent = ToggleInterface

	Cricle.Name = "Cricle"
	Cricle.Parent = ToggleInterface
	Cricle.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	Cricle.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Cricle.BorderSizePixel = 0
	Cricle.Position = UDim2.new(0, -2, 0, -2)
	Cricle.Size = UDim2.new(0, 25, 0, 25)

	UICorner_4.CornerRadius = UDim.new(1, 0)
	UICorner_4.Parent = Cricle

	UIStroke.Parent = Cricle
	UIStroke.Color = Color3.fromRGB(255, 255, 255)
	UIStroke.Thickness = 1.500

	Click_3.Name = "Click"
	Click_3.Parent = ToggleInterface
	Click_3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Click_3.BackgroundTransparency = 1.000
	Click_3.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Click_3.BorderSizePixel = 0
	Click_3.Size = UDim2.new(1, 0, 1, 0)
	Click_3.Font = Enum.Font.SourceSans
	Click_3.Text = ""
	Click_3.TextColor3 = Color3.fromRGB(0, 0, 0)
	Click_3.TextSize = 14.000
	local Bulon = false
	Click_3.Activated:Connect(function()
		if Bulon == false then
			TweenService:Create(
				Cricle,
				TweenInfo.new(tonumber(.2), Enum.EasingStyle.Back, Enum.EasingDirection.InOut),
				{Position = UDim2.new(0, 50, 0, -2)}
			):Play()
			TweenService:Create(
				Main,
				TweenInfo.new(tonumber(.2), Enum.EasingStyle.Back, Enum.EasingDirection.InOut),
				{Position = UDim2.new(0.360000014, 0, 0.5, 0)}
			):Play()
			TweenService:Create(
				UserInterface,
				TweenInfo.new(tonumber(.2), Enum.EasingStyle.Back, Enum.EasingDirection.InOut),
				{Position = UDim2.new(0.810000002, 0, 0.5, 0)}
			):Play()
			Bulon = true
		else
			Bulon = false
			TweenService:Create(
				Cricle,
				TweenInfo.new(tonumber(.2), Enum.EasingStyle.Back, Enum.EasingDirection.InOut),
				{Position = UDim2.new(0, -2, 0, -2)}
			):Play()
			TweenService:Create(
				Main,
				TweenInfo.new(tonumber(.2), Enum.EasingStyle.Back, Enum.EasingDirection.InOut),
				{Position = UDim2.new(0.5, 0, 0.5, 0)}
			):Play()
			TweenService:Create(
				UserInterface,
				TweenInfo.new(tonumber(.2), Enum.EasingStyle.Back, Enum.EasingDirection.InOut),
				{Position = UDim2.new(1.810000002, 0, 0.5, 0)}
			):Play()
		end
	end)

	Nichga.Name = "Nichga"
	Nichga.Parent = ToggleInterface
	Nichga.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Nichga.BackgroundTransparency = 1.000
	Nichga.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Nichga.BorderSizePixel = 0
	Nichga.Position = UDim2.new(0, -60, 0, -1)
	Nichga.Size = UDim2.new(0, 50, 0, 25)
	Nichga.Font = Enum.Font.GothamBold
	Nichga.Text = "User Interface"
	Nichga.TextColor3 = Color3.fromRGB(255, 255, 255)
	Nichga.TextSize = 17.000
	Nichga.TextXAlignment = Enum.TextXAlignment.Right

	Nigger.Name = "Nigger"
	Nigger.Parent = Channel
	Nigger.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Nigger.BackgroundTransparency = 0.960
	Nigger.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Nigger.BorderSizePixel = 0
	Nigger.Position = UDim2.new(0.00464037107, 0, 0.634005785, 0)
	Nigger.Size = UDim2.new(0, 431, 0, 121)

	UICorner_5.CornerRadius = UDim.new(0, 4)
	UICorner_5.Parent = Nigger

	TextLabel.Parent = Nigger
	TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	TextLabel.BackgroundTransparency = 1.000
	TextLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
	TextLabel.BorderSizePixel = 0
	TextLabel.Position = UDim2.new(0.0412148386, 0, -0.129408911, 0)
	TextLabel.Size = UDim2.new(0, 231, 0, 151)
	TextLabel.Font = Enum.Font.GothamBold
	TextLabel.Text = "- Update New GUI\n- Added Fast Attack SuperFast\n- Fixed Level Farm\n- Fixed Cake Prince\n- Fixed Auto Bones\n- Fixed Tween\n- Added Instance Tween To Mirror"
	TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
	TextLabel.TextSize = 16.000
	TextLabel.TextXAlignment = Enum.TextXAlignment.Left

	TabEnable.Name = "Tab Enable"
	TabEnable.Parent = TabHolder
	TabEnable.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	TabEnable.BorderColor3 = Color3.fromRGB(0, 0, 0)
	TabEnable.BorderSizePixel = 0
	TabEnable.Size = UDim2.new(0, 50, 0, 50)

	Icon.Name = "Icon"
	Icon.Parent = TabEnable
	Icon.AnchorPoint = Vector2.new(0.5, 0.5)
	Icon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Icon.BackgroundTransparency = 1.000
	Icon.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Icon.BorderSizePixel = 0
	Icon.Position = UDim2.new(0.5, 0, 0.5, 0)
	Icon.Size = UDim2.new(1, -4, 1, -4)
	Icon.Image = "rbxassetid://138237184742170"

	Click.Name = "Click"
	Click.Parent = TabEnable
	Click.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Click.BackgroundTransparency = 1.000
	Click.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Click.BorderSizePixel = 0
	Click.Size = UDim2.new(1, 0, 1, 0)
	Click.Font = Enum.Font.SourceSans
	Click.Text = ""
	Click.TextColor3 = Color3.fromRGB(0, 0, 0)
	Click.TextSize = 14.000
	Click.Activated:Connect(function()
		UIPageLayout:JumpToIndex(0)
	end)

	makedraggable(Top, Main)

	local TabNigga = {}

	function TabNigga:AddTab(Config)
		Config = Config or {}
		Config.Icon = Config.Icon or ""
		Config.Name = Config.Name or "Tab 1"

		local TabDisable = Instance.new("Frame")
		local Icon_2 = Instance.new("ImageLabel")
		local Click_2 = Instance.new("TextButton")
		local Channel_2 = Instance.new("ScrollingFrame")
		local UIListLayout_2 = Instance.new("UIListLayout")
		local UIPadding_2 = Instance.new("UIPadding")
		local ChannelName = Instance.new("TextLabel")

		Channel_2.Name = "Channel"
		Channel_2.Parent = Nguu
		Channel_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Channel_2.BackgroundTransparency = 1.000
		Channel_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Channel_2.BorderSizePixel = 0
		Channel_2.Size = UDim2.new(1, 0, 1, 0)
		Channel_2.ScrollBarThickness = 0
		Channel_2.LayoutOrder = CountTab
        game:GetService("RunService").Stepped:Connect(function()
            Channel_2.CanvasSize = UDim2.new(0, 0, 0, UIListLayout_2.AbsoluteContentSize.Y + 20)
        end)

		UIListLayout_2.Parent = Channel_2
		UIListLayout_2.SortOrder = Enum.SortOrder.LayoutOrder
		UIListLayout_2.Padding = UDim.new(0, 12)

		UIPadding_2.Parent = Channel_2
		UIPadding_2.PaddingBottom = UDim.new(0, 7)
		UIPadding_2.PaddingLeft = UDim.new(0, 7)
		UIPadding_2.PaddingRight = UDim.new(0, 7)
		UIPadding_2.PaddingTop = UDim.new(0, 12)

		ChannelName.Name = "Channel Name"
		ChannelName.Parent = Channel_2
		ChannelName.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		ChannelName.BackgroundTransparency = 1.000
		ChannelName.BorderColor3 = Color3.fromRGB(0, 0, 0)
		ChannelName.BorderSizePixel = 0
		ChannelName.Size = UDim2.new(0, 200, 0, 50)
		ChannelName.Font = Enum.Font.GothamBold
		ChannelName.Text = Config.Name
		ChannelName.TextColor3 = Color3.fromRGB(255, 255, 255)
		ChannelName.TextSize = 40.000
		ChannelName.TextXAlignment = Enum.TextXAlignment.Left

		TabDisable.Name = "Tab Disable"
		TabDisable.Parent = TabHolder
		TabDisable.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		TabDisable.BorderColor3 = Color3.fromRGB(0, 0, 0)
		TabDisable.BorderSizePixel = 0
		TabDisable.Size = UDim2.new(0, 50, 0, 50)

		Icon_2.Name = "Icon"
		Icon_2.Parent = TabDisable
		Icon_2.AnchorPoint = Vector2.new(0.5, 0.5)
		Icon_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Icon_2.BackgroundTransparency = 1.000
		Icon_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Icon_2.BorderSizePixel = 0
		Icon_2.Position = UDim2.new(0.5, 0, 0.5, 0)
		Icon_2.Size = UDim2.new(1, -4, 1, -4)
		Icon_2.Image = Config.Icon

		Click_2.Name = "Click"
		Click_2.Parent = TabDisable
		Click_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Click_2.BackgroundTransparency = 1.000
		Click_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Click_2.BorderSizePixel = 0
		Click_2.Size = UDim2.new(1, 0, 1, 0)
		Click_2.Font = Enum.Font.SourceSans
		Click_2.Text = ""
		Click_2.TextColor3 = Color3.fromRGB(0, 0, 0)
		Click_2.TextSize = 14.000
		Click_2.Activated:Connect(function()
			UIPageLayout:JumpToIndex(Channel_2.LayoutOrder)
		end)

		CountTab = CountTab + 1
		local Features = {}
		function Features:AddButton(Config)
			Config = Config or {}
			Config.Name = Config.Name or "Button"
			Config.Description = Config.Description or ""
			Config.Callback = Config.Callback or function() end

			local Button = Instance.new("Frame")
			local UICorner_4 = Instance.new("UICorner")
			local Title = Instance.new("TextLabel")
			local UIPadding_3 = Instance.new("UIPadding")
			local Icon_3 = Instance.new("ImageLabel")
			local Click_3 = Instance.new("TextButton")
			local Desc = Instance.new("TextLabel")
			local UIPadding_4 = Instance.new("UIPadding")

			Button.Name = "Button"
			Button.Parent = Channel_2
			Button.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Button.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Button.BorderSizePixel = 0
			Button.Position = UDim2.new(0, 0, 0.182926834, 0)
			Button.Size = UDim2.new(1, 0, 0, 50)

			UICorner_4.CornerRadius = UDim.new(0, 4)
			UICorner_4.Parent = Button

			Title.Name = "Title"
			Title.Parent = Button
			Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Title.BackgroundTransparency = 1.000
			Title.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Title.BorderSizePixel = 0
			Title.Size = UDim2.new(1, 0, 0, 20)
			Title.Font = Enum.Font.GothamBold
			Title.Text = Config.Name
			Title.TextColor3 = Color3.fromRGB(0, 0, 0)
			Title.TextSize = 14.000
			Title.TextXAlignment = Enum.TextXAlignment.Left

			UIPadding_3.Parent = Title
			UIPadding_3.PaddingLeft = UDim.new(0, 7)
			UIPadding_3.PaddingTop = UDim.new(0, 4)

			Icon_3.Name = "Icon"
			Icon_3.Parent = Button
			Icon_3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Icon_3.BackgroundTransparency = 1.000
			Icon_3.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Icon_3.BorderSizePixel = 0
			Icon_3.Position = UDim2.new(0.893999994, 7, 0.125, 0)
			Icon_3.Size = UDim2.new(0, 30, 0, 30)
			Icon_3.Image = "http://www.roblox.com/asset/?id=73848738510637"

			Click_3.Name = "Click"
			Click_3.Parent = Button
			Click_3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Click_3.BackgroundTransparency = 1.000
			Click_3.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Click_3.BorderSizePixel = 0
			Click_3.Size = UDim2.new(1, 0, 1, 0)
			Click_3.Font = Enum.Font.SourceSans
			Click_3.Text = ""
			Click_3.TextColor3 = Color3.fromRGB(0, 0, 0)
			Click_3.TextSize = 14.000

			Desc.Name = "Desc"
			Desc.Parent = Button
			Desc.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Desc.BackgroundTransparency = 1.000
			Desc.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Desc.BorderSizePixel = 0
			Desc.Position = UDim2.new(0, 0, 0, 20)
			Desc.Size = UDim2.new(1, 0, 1, -20)
			Desc.Font = Enum.Font.GothamBold
			Desc.Text = Config.Description
			Desc.TextColor3 = Color3.fromRGB(77, 77, 77)
			Desc.TextSize = 11.000
			Desc.TextXAlignment = Enum.TextXAlignment.Left
			Desc.TextYAlignment = Enum.TextYAlignment.Top

			UIPadding_4.Parent = Desc
			UIPadding_4.PaddingLeft = UDim.new(0, 7)
			UIPadding_4.PaddingTop = UDim.new(0, 2)

			Click_3.Activated:Connect(function()
				Icon_3.Size = UDim2.new(0, 35, 0, 35)
				TweenService:Create(
					Icon_3,
					TweenInfo.new(tonumber(.2), Enum.EasingStyle.Back, Enum.EasingDirection.InOut),
					{Size = UDim2.new(0, 30, 0, 30)}
				):Play()
				Config.Callback()
			end)
		end
		function Features:AddToggle(Config)
			Config = Config or {}
			Config.Name = Config.Name or "Toggle"
			Config.Description = Config.Description or ""
			Config.Default = Config.Default or false
			Config.Callback = Config.Callback or function(Value) print(Value) end

			local Toggle = Instance.new("Frame")
			local UICorner_5 = Instance.new("UICorner")
			local Title_2 = Instance.new("TextLabel")
			local UIPadding_5 = Instance.new("UIPadding")
			local Click_4 = Instance.new("TextButton")
			local Desc_2 = Instance.new("TextLabel")
			local UIPadding_6 = Instance.new("UIPadding")
			local Check = Instance.new("Frame")
			local UICorner_6 = Instance.new("UICorner")
			local checkicon = Instance.new("ImageLabel")
			local PhuongNigga = {}

			Toggle.Name = "Toggle"
			Toggle.Parent = Channel_2
			Toggle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Toggle.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Toggle.BorderSizePixel = 0
			Toggle.Position = UDim2.new(0, 0, 0.182926834, 0)
			Toggle.Size = UDim2.new(1, 0, 0, 50)

			UICorner_5.CornerRadius = UDim.new(0, 4)
			UICorner_5.Parent = Toggle

			Title_2.Name = "Title"
			Title_2.Parent = Toggle
			Title_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Title_2.BackgroundTransparency = 1.000
			Title_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Title_2.BorderSizePixel = 0
			Title_2.Size = UDim2.new(1, 0, 0, 20)
			Title_2.Font = Enum.Font.GothamBold
			Title_2.Text = Config.Name
			Title_2.TextColor3 = Color3.fromRGB(0, 0, 0)
			Title_2.TextSize = 14.000
			Title_2.TextXAlignment = Enum.TextXAlignment.Left

			UIPadding_5.Parent = Title_2
			UIPadding_5.PaddingLeft = UDim.new(0, 7)
			UIPadding_5.PaddingTop = UDim.new(0, 4)

			Click_4.Name = "Click"
			Click_4.Parent = Toggle
			Click_4.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Click_4.BackgroundTransparency = 1.000
			Click_4.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Click_4.BorderSizePixel = 0
			Click_4.Size = UDim2.new(1, 0, 1, 0)
			Click_4.Font = Enum.Font.SourceSans
			Click_4.Text = ""
			Click_4.TextColor3 = Color3.fromRGB(0, 0, 0)
			Click_4.TextSize = 14.000

			Desc_2.Name = "Desc"
			Desc_2.Parent = Toggle
			Desc_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Desc_2.BackgroundTransparency = 1.000
			Desc_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Desc_2.BorderSizePixel = 0
			Desc_2.Position = UDim2.new(0, 0, 0, 20)
			Desc_2.Size = UDim2.new(1, 0, 1, -20)
			Desc_2.Font = Enum.Font.GothamBold
			Desc_2.Text = Config.Description
			Desc_2.TextColor3 = Color3.fromRGB(77, 77, 77)
			Desc_2.TextSize = 11.000
			Desc_2.TextWrapped = true
			Desc_2.TextXAlignment = Enum.TextXAlignment.Left
			Desc_2.TextYAlignment = Enum.TextYAlignment.Top

			UIPadding_6.Parent = Desc_2
			UIPadding_6.PaddingLeft = UDim.new(0, 7)
			UIPadding_6.PaddingTop = UDim.new(0, 2)

			Check.Name = "Check"
			Check.Parent = Toggle
			Check.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
			Check.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Check.BorderSizePixel = 0
			Check.Position = UDim2.new(0.908872902, 0, 0.218181819, 0)
			Check.Size = UDim2.new(0, 27, 0, 27)

			UICorner_6.CornerRadius = UDim.new(0, 4)
			UICorner_6.Parent = Check

			checkicon.Name = "checkicon"
			checkicon.Parent = Check
			checkicon.AnchorPoint = Vector2.new(0.5, 0.5)
			checkicon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			checkicon.BackgroundTransparency = 1.000
			checkicon.BorderColor3 = Color3.fromRGB(0, 0, 0)
			checkicon.BorderSizePixel = 0
			checkicon.Position = UDim2.new(0.5, 0, 0.5, 0)
			checkicon.Size = UDim2.new(0, 0, 0, 0)
			checkicon.Image = "rbxassetid://129110076450322"

			Nigga = false
			function PhuongNigga:Set(Value)
				if Value then
					TweenService:Create(
						checkicon,
						TweenInfo.new(tonumber(.2), Enum.EasingStyle.Back, Enum.EasingDirection.InOut),
						{Size = UDim2.new(1, -7, 1, -7)}
					):Play()
				else
					TweenService:Create(
						checkicon,
						TweenInfo.new(tonumber(.2), Enum.EasingStyle.Back, Enum.EasingDirection.InOut),
						{Size = UDim2.new(0, 0, 0, 0)}
					):Play()
				end
				Nigga = Value
				Config.Callback(Nigga)
			end

			if Config.Default == true then
				PhuongNigga:Set(true)
			end

			Click_4.Activated:Connect(function()
				Nigga = not Nigga
				PhuongNigga:Set(Nigga)
			end)
			return PhuongNigga
		end
		function Features:AddDropdown(Config)
			Config = Config or {}
			Config.Name = Config.Name or "Dropdown"
			Config.Description = Config.Description or ""
			Options = Options or {"1", "2","3"}
			Config.Default = Config.Default or ""
			Config.Callback = Config.Callback or function(Value) print(Value) end


			local Dropdown = Instance.new("Frame")
			local UICorner_7 = Instance.new("UICorner")
			local Title_3 = Instance.new("TextLabel")
			local UIPadding_7 = Instance.new("UIPadding")
			local Icon_4 = Instance.new("ImageLabel")
			local Click_5 = Instance.new("TextButton")
			local Desc_3 = Instance.new("TextLabel")
			local UIPadding_8 = Instance.new("UIPadding")
			local ListFrame = Instance.new("Frame")
			local UICorner_8 = Instance.new("UICorner")
			local List = Instance.new("ScrollingFrame")
			local UIPadding_9 = Instance.new("UIPadding")
			local UIListLayout_3 = Instance.new("UIListLayout")
			local GojoSatoru = {}

			Dropdown.Name = "Dropdown"
			Dropdown.Parent = Channel_2
			Dropdown.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Dropdown.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Dropdown.BorderSizePixel = 0
			Dropdown.Position = UDim2.new(0, 0, 0.548780501, 0)
			Dropdown.Size = UDim2.new(1, 0, 0, 50)

			UICorner_7.CornerRadius = UDim.new(0, 4)
			UICorner_7.Parent = Dropdown

			Title_3.Name = "Title"
			Title_3.Parent = Dropdown
			Title_3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Title_3.BackgroundTransparency = 1.000
			Title_3.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Title_3.BorderSizePixel = 0
			Title_3.Position = UDim2.new(0, 0, 0, 2)
			Title_3.Size = UDim2.new(1, 0, 0, 20)
			Title_3.Font = Enum.Font.GothamBold
			Title_3.Text = Config.Name
			Title_3.TextColor3 = Color3.fromRGB(0, 0, 0)
			Title_3.TextSize = 14.000
			Title_3.TextXAlignment = Enum.TextXAlignment.Left

			UIPadding_7.Parent = Title_3
			UIPadding_7.PaddingLeft = UDim.new(0, 7)

			Icon_4.Name = "Icon"
			Icon_4.Parent = Dropdown
			Icon_4.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Icon_4.BackgroundTransparency = 1.000
			Icon_4.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Icon_4.BorderSizePixel = 0
			Icon_4.Position = UDim2.new(1, -35, 0, 12)
			Icon_4.Size = UDim2.new(0, 25, 0, 25)
			Icon_4.Image = "rbxassetid://91281512475174"
			Icon_4.Rotation = 180.000

			Click_5.Name = "Click"
			Click_5.Parent = Dropdown
			Click_5.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Click_5.BackgroundTransparency = 1.000
			Click_5.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Click_5.BorderSizePixel = 0
			Click_5.Size = UDim2.new(1, 0, 0, 50)
			Click_5.Font = Enum.Font.SourceSans
			Click_5.Text = ""
			Click_5.TextColor3 = Color3.fromRGB(0, 0, 0)
			Click_5.TextSize = 14.000

			Desc_3.Name = "Desc"
			Desc_3.Parent = Dropdown
			Desc_3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Desc_3.BackgroundTransparency = 1.000
			Desc_3.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Desc_3.BorderSizePixel = 0
			Desc_3.Position = UDim2.new(0, 0, 0, 20)
			Desc_3.Size = UDim2.new(1, 0, 0, 30)
			Desc_3.Font = Enum.Font.GothamBold
			Desc_3.Text = Config.Description
			Desc_3.TextColor3 = Color3.fromRGB(77, 77, 77)
			Desc_3.TextSize = 12.000
			Desc_3.TextWrapped = true
			Desc_3.TextXAlignment = Enum.TextXAlignment.Left
			Desc_3.TextYAlignment = Enum.TextYAlignment.Top

			UIPadding_8.Parent = Desc_3
			UIPadding_8.PaddingLeft = UDim.new(0, 7)
			UIPadding_8.PaddingTop = UDim.new(0, 2)

			ListFrame.Name = "ListFrame"
			ListFrame.Parent = Dropdown
			ListFrame.BackgroundColor3 = Color3.fromRGB(32, 32, 32)
			ListFrame.BackgroundTransparency = 0.650
			ListFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
			ListFrame.BorderSizePixel = 0
			ListFrame.Position = UDim2.new(0, 6, 0, 49)
			ListFrame.Size = UDim2.new(1, -12, 1, -56)
			ListFrame.Visible = false

			UICorner_8.CornerRadius = UDim.new(0, 4)
			UICorner_8.Parent = ListFrame

			List.Name = "List"
			List.Parent = ListFrame
			List.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			List.BackgroundTransparency = 1.000
			List.BorderColor3 = Color3.fromRGB(0, 0, 0)
			List.BorderSizePixel = 0
			List.Size = UDim2.new(1, 0, 1, 0)
			List.ScrollBarThickness = 0
			game:GetService("RunService").Stepped:Connect(function ()
				List.CanvasSize = UDim2.new(0, 0, 0, UIListLayout_3.AbsoluteContentSize.Y + 20)
			end)

			UIPadding_9.Parent = List
			UIPadding_9.PaddingBottom = UDim.new(0, 7)
			UIPadding_9.PaddingLeft = UDim.new(0, 7)
			UIPadding_9.PaddingRight = UDim.new(0, 7)
			UIPadding_9.PaddingTop = UDim.new(0, 7)

			UIListLayout_3.Parent = List
			UIListLayout_3.SortOrder = Enum.SortOrder.LayoutOrder
			UIListLayout_3.Padding = UDim.new(0, 4)

			function GojoSatoru:Add(Value)
				for _, v in next, Value do
					local Options = Instance.new("Frame")
					local UICorner_9 = Instance.new("UICorner")
					local TextLabel_2 = Instance.new("TextButton")

					Options.Name = "Options"
					Options.Parent = List
					Options.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
					Options.BorderColor3 = Color3.fromRGB(0, 0, 0)
					Options.BorderSizePixel = 0
					Options.Size = UDim2.new(1, 0, 0, 30)

					UICorner_9.CornerRadius = UDim.new(0, 4)
					UICorner_9.Parent = Options

					TextLabel_2.Parent = Options
					TextLabel_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
					TextLabel_2.BackgroundTransparency = 1.000
					TextLabel_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
					TextLabel_2.BorderSizePixel = 0
					TextLabel_2.Size = UDim2.new(1, 0, 1, 0)
					TextLabel_2.Font = Enum.Font.GothamBold
					TextLabel_2.Text = tostring(v)
					TextLabel_2.TextColor3 = Color3.fromRGB(0, 0, 0)
					TextLabel_2.TextSize = 13.000
					TextLabel_2.Name = "TextLabel"

					TextLabel_2.Activated:Connect(function()
						for r, v in next, List:GetChildren() do
							if v.Name == "Options" then
								v.BackgroundTransparency = 1.000
							end
						end
						for r, v in next, List:GetChildren() do
							if v.Name == "Options" then
								v.TextLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
							end
						end
						TextLabel_2.TextColor3 = Color3.fromRGB(255, 255, 255)
						Options.BackgroundTransparency = 0.930
						Title_3.Text = Config.Name .. " : " ..  TextLabel_2.Text
						Config.Callback(TextLabel_2.Text)
					end)
				end
			end

			function GojoSatoru:Set(acc)
				for i, v in pairs(List:GetChildren()) do
					if v.Name == "Options" then
						if v.TextLabel.Text == acc then
							for r, b in next, List:GetChildren() do
								if b.Name == "Options" then
									b.BackgroundTransparency = 1.000
								end
							end
							for r, b in next, List:GetChildren() do
								if b.Name == "Options" then
									b.TextLabel.TextColor3 = Color3.fromRGB(144, 144, 144)
								end
							end
							v.TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
							v.BackgroundTransparency = 0.930
							Title_3.Text = Config.Name .. " : " .. v.TextLabel.Text
							Config.Callback(v.TextLabel.Text)
						end
					end
				end
			end

			function GojoSatoru:Refresh(Options)
				for i, v in pairs(List:GetChildren()) do
					if v.Name == "Options" then
						v:Destroy()
					end
				end
				GojoSatoru:Add(Options)
				Title_3.Text = Config.Name .. " : "
			end

			Click_5.Activated:Connect(function()
				if Dropdown.Size.Y.Offset <= 50 then
					TweenService:Create(
						Dropdown,
						TweenInfo.new(tonumber(.2), Enum.EasingStyle.Linear, Enum.EasingDirection.InOut),
						{Size = UDim2.new(1, 0, 0, 131)}
					):Play()
					TweenService:Create(
						Icon_4,
						TweenInfo.new(tonumber(.2), Enum.EasingStyle.Linear, Enum.EasingDirection.InOut),
						{Rotation = 0}
					):Play()
					wait(.1)
					ListFrame.Visible = true
				else
					TweenService:Create(
						Dropdown,
						TweenInfo.new(tonumber(.2), Enum.EasingStyle.Linear, Enum.EasingDirection.InOut),
						{Size = UDim2.new(1, 0, 0, 50)}
					):Play()
					TweenService:Create(
						Icon_4,
						TweenInfo.new(tonumber(.2), Enum.EasingStyle.Linear, Enum.EasingDirection.InOut),
						{Rotation = 180.000}
					):Play()
					wait(.1)
					ListFrame.Visible = false
				end
			end)

			GojoSatoru:Refresh(Config.Options)
			GojoSatoru:Set(Config.Default)
			Config.Callback(Config.Default)
			return GojoSatoru
		end
		function Features:AddSlider(Config)
			Config = Config or {}
			Config.Name = Config.Name or "Slider"
			Config.Max = Config.Max or 100
			Config.Min = Config.Min or 1
			Config.Default = Config.Default or 50
			Config.Callback = Config.Callback or function() end

			local Slider = Instance.new("Frame")
			local UICorner_11 = Instance.new("UICorner")
			local Title_4 = Instance.new("TextLabel")
			local UIPadding_10 = Instance.new("UIPadding")
			local SliderFrame = Instance.new("Frame")
			local UICorner_12 = Instance.new("UICorner")
			local Draggable = Instance.new("Frame")
			local UICorner_13 = Instance.new("UICorner")
			local Cricle = Instance.new("Frame")
			local Ngunat = Instance.new("Frame")
			local UICorner_14 = Instance.new("UICorner")
			local TextLabel_4 = Instance.new("TextLabel")
			local SliderFunc = {Value = Config.Default}

			Slider.Name = "Slider"
			Slider.Parent = Channel_2
			Slider.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Slider.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Slider.BorderSizePixel = 0
			Slider.Position = UDim2.new(0, 0, 0.182926834, 0)
			Slider.Size = UDim2.new(1, 0, 0, 50)
			
			UICorner_11.CornerRadius = UDim.new(0, 4)
			UICorner_11.Parent = Slider
			
			Title_4.Name = "Title"
			Title_4.Parent = Slider
			Title_4.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Title_4.BackgroundTransparency = 1.000
			Title_4.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Title_4.BorderSizePixel = 0
			Title_4.Size = UDim2.new(1, 0, 0, 20)
			Title_4.Font = Enum.Font.GothamBold
			Title_4.Text = Config.Name
			Title_4.TextColor3 = Color3.fromRGB(0, 0, 0)
			Title_4.TextSize = 14.000
			Title_4.TextXAlignment = Enum.TextXAlignment.Left
			
			UIPadding_10.Parent = Title_4
			UIPadding_10.PaddingLeft = UDim.new(0, 7)
			UIPadding_10.PaddingTop = UDim.new(0, 2)
			
			SliderFrame.Name = "SliderFrame"
			SliderFrame.Parent = Slider
			SliderFrame.BackgroundColor3 = Color3.fromRGB(58, 58, 58)
			SliderFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
			SliderFrame.BorderSizePixel = 0
			SliderFrame.Position = UDim2.new(0, 7, 0, 26)
			SliderFrame.Size = UDim2.new(0, 325, 0, 8)
			SliderFrame.BackgroundTransparency = 1.00

			Ngunat.Name = "Draggable"
			Ngunat.Parent = SliderFrame
			Ngunat.BackgroundColor3 = Color3.fromRGB(58, 58, 58)
			Ngunat.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Ngunat.BorderSizePixel = 0
			Ngunat.Size = UDim2.new(1, 0, 1, 0)
			
			UICorner_12.CornerRadius = UDim.new(0, 2)
			UICorner_12.Parent = SliderFrame
			
			Draggable.Name = "Draggable"
			Draggable.Parent = SliderFrame
			Draggable.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
			Draggable.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Draggable.BorderSizePixel = 0
			Draggable.Size = UDim2.new(0, 162, 1, 0)
			
			UICorner_13.CornerRadius = UDim.new(0, 2)
			UICorner_13.Parent = Draggable
			
			Cricle.Name = "Cricle"
			Cricle.Parent = Draggable
			Cricle.AnchorPoint = Vector2.new(1, 1)
			Cricle.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
			Cricle.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Cricle.BorderSizePixel = 0
			Cricle.Position = UDim2.new(1.03086424, 0, 1.75, 0)
			Cricle.Size = UDim2.new(0, 10, 0, 20)
			
			UICorner_14.CornerRadius = UDim.new(0, 4)
			UICorner_14.Parent = Cricle
			
			TextLabel_4.Parent = Slider
			TextLabel_4.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			TextLabel_4.BackgroundTransparency = 1.000
			TextLabel_4.BorderColor3 = Color3.fromRGB(0, 0, 0)
			TextLabel_4.BorderSizePixel = 0
			TextLabel_4.Position = UDim2.new(0.774580359, 0, 0.400000006, 0)
			TextLabel_4.Size = UDim2.new(0, 70, 0, 20)
			TextLabel_4.Font = Enum.Font.GothamBold
			TextLabel_4.Text = Config.Default
			TextLabel_4.TextColor3 = Color3.fromRGB(0, 0, 0)
			TextLabel_4.TextSize = 16.000

			local Dragging = false
            local function Round(Number, Factor)
                local Result = math.floor(Number/Factor + (math.sign(Number) * 0.5)) * Factor
                if Result < 0 then Result = Result + Factor end
                return Result
            end
            function SliderFunc:Set(Value)
                Value = math.clamp(Round(Value, 1), Config.Min, Config.Max)
                SliderFunc.Value = Value
                TextLabel_4.Text = tostring(Value)
                Config.Callback(SliderFunc.Value)
                TweenService:Create(
                    Draggable,
                    TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                    {Size = UDim2.fromScale((Value - Config.Min) / (Config.Max - Config.Min), 1)}
                ):Play()
            end
            SliderFrame.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
                    Dragging = true
                end
            end)
            uis.InputEnded:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
                    Dragging = false
                end
            end)            
            uis.InputChanged:Connect(function(input)
                if Dragging then
                    local SizeScale = math.clamp((input.Position.X - SliderFrame.AbsolutePosition.X) / SliderFrame.AbsoluteSize.X, 0, 1)
                    SliderFunc:Set(Config.Min + ((Config.Max - Config.Min) * SizeScale)) 
                end
            end)            
			TextLabel_4:GetPropertyChangedSignal("Text"):Connect(function()
				local Valid = TextLabel_4.Text:gsub("[^%d]", "")
				if Valid ~= "" then
					local ValidNumber = math.min(tonumber(Valid), Config.Max)
					TextLabel_4.Text = tostring(ValidNumber)
				else
					TextLabel_4.Text = tostring(Valid)
				end
			end)

			return SliderFunc
		end
		function Features:AddSeperator(Value)
			local Seperator = Instance.new("Frame")
			local Line = Instance.new("Frame")
			local Title_5 = Instance.new("TextLabel")

			Seperator.Name = "Seperator"
			Seperator.Parent = Channel_2
			Seperator.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Seperator.BackgroundTransparency = 1.000
			Seperator.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Seperator.BorderSizePixel = 0
			Seperator.Size = UDim2.new(1, 0, 0, 30)

			Line.Name = "Line"
			Line.Parent = Seperator
			Line.AnchorPoint = Vector2.new(0.5, 0.5)
			Line.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Line.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Line.BorderSizePixel = 0
			Line.Position = UDim2.new(0.5, 0, 0.5, 0)
			Line.Size = UDim2.new(1, 0, 0, 2)

			Title_5.Name = "Title"
			Title_5.Parent = Line
			Title_5.AnchorPoint = Vector2.new(0.5, 0.5)
			Title_5.BackgroundColor3 = Color3.fromRGB(24, 24, 24)
			Title_5.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Title_5.BorderSizePixel = 0
			Title_5.Position = UDim2.new(0.5, 0, 0.5, 0)
			Title_5.Size = UDim2.new(0, 100, 0, 30)
			Title_5.Font = Enum.Font.GothamBold
			Title_5.Text = Value
			Title_5.TextColor3 = Color3.fromRGB(255, 255, 255)
			Title_5.TextSize = 13.000
		end
		function Features:AddParagraph(Config)
			Config = Config or {}
			Config.Name = Config.Name or "Paragraph"
			Config.Description = Config.Description or "Description"

			local Paragraph = Instance.new("Frame")
			local UICorner_15 = Instance.new("UICorner")
			local TextLabel_5 = Instance.new("TextLabel")
			local UIPadding_11 = Instance.new("UIPadding")
			local Desc_4 = Instance.new("TextLabel")
			local UIPadding_12 = Instance.new("UIPadding")
			local ParaFunc = {}

			Paragraph.Name = "Paragraph"
			Paragraph.Parent = Channel_2
			Paragraph.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Paragraph.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Paragraph.BorderSizePixel = 0
			Paragraph.Size = UDim2.new(1, 0, 0, 45)

			UICorner_15.CornerRadius = UDim.new(0, 4)
			UICorner_15.Parent = Paragraph

			TextLabel_5.Parent = Paragraph
			TextLabel_5.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			TextLabel_5.BackgroundTransparency = 1.000
			TextLabel_5.BorderColor3 = Color3.fromRGB(0, 0, 0)
			TextLabel_5.BorderSizePixel = 0
			TextLabel_5.Position = UDim2.new(0, 0, 0, 2)
			TextLabel_5.Size = UDim2.new(1, 0, 0, 20)
			TextLabel_5.Font = Enum.Font.GothamBold
			TextLabel_5.Text = Config.Name
			TextLabel_5.TextColor3 = Color3.fromRGB(0, 0, 0)
			TextLabel_5.TextSize = 14.000
			TextLabel_5.TextXAlignment = Enum.TextXAlignment.Left

			UIPadding_11.Parent = TextLabel_5
			UIPadding_11.PaddingLeft = UDim.new(0, 7)

			Desc_4.Name = "Desc"
			Desc_4.Parent = Paragraph
			Desc_4.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Desc_4.BackgroundTransparency = 1.000
			Desc_4.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Desc_4.BorderSizePixel = 0
			Desc_4.Position = UDim2.new(0, 0, 0, 20)
			Desc_4.Size = UDim2.new(1, 0, 0, 25)
			Desc_4.Font = Enum.Font.GothamBold
			Desc_4.Text = Config.Description
			Desc_4.TextColor3 = Color3.fromRGB(77, 77, 77)
			Desc_4.TextSize = 12.000
			Desc_4.TextWrapped = true
			Desc_4.TextXAlignment = Enum.TextXAlignment.Left
			Desc_4.TextYAlignment = Enum.TextYAlignment.Top

			UIPadding_12.Parent = Desc_4
			UIPadding_12.PaddingLeft = UDim.new(0, 7)
			UIPadding_12.PaddingTop = UDim.new(0, 2)

			function ParaFunc:Set(ConfigSet)
				ConfigSet = ConfigSet or {}
				ConfigSet.Name = ConfigSet.Name
				ConfigSet.Description = ConfigSet.Description
				
				if ConfigSet.Name ~= "" and ConfigSet.Name ~= nil then
					TextLabel_5.Text = ConfigSet.Name
				end
				if ConfigSet.Description ~= "" and ConfigSet.Description ~= nil then
					Desc_4.Text = ConfigSet.Name
				end
			end
			return ParaFunc
		end
		function Features:AddInput(Config)
			Config = Config or {}
			Config.Name = Config.Name or "Input"
			Config.Description = Config.Description or "Description"
			Config.PlaceholderText = Config.PlaceholderText or "Input..."
			Config.Default = Config.Default or ""
			Config.Callback = Config.Callback or function() end

			local Input = Instance.new("Frame")
			local UICorner_16 = Instance.new("UICorner")
			local TextLabel_6 = Instance.new("TextLabel")
			local UIPadding_13 = Instance.new("UIPadding")
			local Desc_5 = Instance.new("TextLabel")
			local UIPadding_14 = Instance.new("UIPadding")
			local InputFrame = Instance.new("Frame")
			local UICorner_17 = Instance.new("UICorner")
			local TextBox = Instance.new("TextBox")

			Input.Name = "Input"
			Input.Parent = Channel_2
			Input.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Input.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Input.BorderSizePixel = 0
			Input.Size = UDim2.new(1, 0, 0, 45)

			UICorner_16.CornerRadius = UDim.new(0, 4)
			UICorner_16.Parent = Input

			TextLabel_6.Parent = Input
			TextLabel_6.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			TextLabel_6.BackgroundTransparency = 1.000
			TextLabel_6.BorderColor3 = Color3.fromRGB(0, 0, 0)
			TextLabel_6.BorderSizePixel = 0
			TextLabel_6.Position = UDim2.new(0, 0, 0, 2)
			TextLabel_6.Size = UDim2.new(1, 0, 0, 20)
			TextLabel_6.Font = Enum.Font.GothamBold
			TextLabel_6.Text = Config.Name
			TextLabel_6.TextColor3 = Color3.fromRGB(0, 0, 0)
			TextLabel_6.TextSize = 14.000
			TextLabel_6.TextXAlignment = Enum.TextXAlignment.Left

			UIPadding_13.Parent = TextLabel_6
			UIPadding_13.PaddingLeft = UDim.new(0, 7)

			Desc_5.Name = "Desc"
			Desc_5.Parent = Input
			Desc_5.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Desc_5.BackgroundTransparency = 1.000
			Desc_5.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Desc_5.BorderSizePixel = 0
			Desc_5.Position = UDim2.new(0, 0, 0, 20)
			Desc_5.Size = UDim2.new(1, 0, 0, 25)
			Desc_5.Font = Enum.Font.GothamBold
			Desc_5.Text = Config.Description
			Desc_5.TextColor3 = Color3.fromRGB(77, 77, 77)
			Desc_5.TextSize = 12.000
			Desc_5.TextWrapped = true
			Desc_5.TextXAlignment = Enum.TextXAlignment.Left
			Desc_5.TextYAlignment = Enum.TextYAlignment.Top

			UIPadding_14.Parent = Desc_5
			UIPadding_14.PaddingLeft = UDim.new(0, 7)
			UIPadding_14.PaddingTop = UDim.new(0, 2)

			InputFrame.Name = "InputFrame"
			InputFrame.Parent = Input
			InputFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
			InputFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
			InputFrame.BorderSizePixel = 0
			InputFrame.Position = UDim2.new(0.733812928, 0, 0.222222224, 0)
			InputFrame.Size = UDim2.new(0, 100, 0, 25)

			UICorner_17.Parent = InputFrame

			TextBox.Parent = InputFrame
			TextBox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			TextBox.BackgroundTransparency = 1.000
			TextBox.BorderColor3 = Color3.fromRGB(0, 0, 0)
			TextBox.BorderSizePixel = 0
			TextBox.ClipsDescendants = true
			TextBox.Size = UDim2.new(1, 0, 1, 0)
			TextBox.Font = Enum.Font.GothamBold
			TextBox.PlaceholderColor3 = Color3.fromRGB(177, 177, 177)
			TextBox.PlaceholderText = Config.PlaceholderText
			TextBox.Text = Config.Default
			TextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
			TextBox.TextSize = 13.000

			TextBox.FocusLost:Connect(function()
				Config.Callback(TextBox.Text)
			end)
		end
		return Features
	end
	return TabNigga
end
return Library
