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
            {Position = UDim2.new(0, -410, 1, -(NotifyPosHeigh) - 15)}
        ):Play()
        Time:TweenSize(UDim2.new(0, 0, 0, 1),"Out","Quad",tonumber(ConfigNotify.Time),true)
        task.wait(tonumber(ConfigNotify.Time))
        TweenService:Create(
            NotifyReal,
            TweenInfo.new(tonumber(.2), Enum.EasingStyle.Back, Enum.EasingDirection.InOut),
            {Position = UDim2.new(1, -0, 1, -(NotifyPosHeigh) - 15)}
        ):Play()
        task.wait(tonumber(2))
        NotifyFunc:Close()
        return NotifyFunc
    end)
end

HubName = "Whites Hub"
function Library:AddWindows(Config)
    Config = Config or {}
    Config.Name = Config.Name or "Unique Hub"
    Config.NewUpdate = Config.NewUpdate or "[+] Release New UI And Fix Someone Function"
    Config.Description = Config.Description or "Whites Hub© 2024 discord.gg/Sq8WNGn"
    local UniqueRemake = Instance.new("ScreenGui")
    local Main = Instance.new("Frame")
    local UICorner = Instance.new("UICorner")
    local UIStroke = Instance.new("UIStroke")
    local DropShadowHolder = Instance.new("Frame")
    local DropShadow = Instance.new("ImageLabel")
    local Navitional = Instance.new("Frame")
    local Real = Instance.new("Frame")
    local Ngu = Instance.new("Folder")
    local HomeTab = Instance.new("Frame")
    local UICorner_2 = Instance.new("UICorner")
    local Poster = Instance.new("Frame")
    local Title = Instance.new("TextLabel")
    local Poster_2 = Instance.new("ImageLabel")
    local Desc = Instance.new("TextLabel")
    local Line = Instance.new("Frame")
    local TabThuHai = Instance.new("Frame")
    local TabHolderThu2 = Instance.new("ScrollingFrame")
    local UIPadding = Instance.new("UIPadding")
    local UIListLayout = Instance.new("UIListLayout")
    local Top = Instance.new("Frame")
    local NameHub2 = Instance.new("TextLabel")
    local UIPadding_16 = Instance.new("UIPadding")
    local Logo_5 = Instance.new("ImageLabel")
    local TabNhucac = Instance.new("Frame")
    local TabHolder = Instance.new("Frame")
    local UIPadding_17 = Instance.new("UIPadding")
    local UIListLayout_5 = Instance.new("UIListLayout")
    local TabEnable = Instance.new("Frame")
    local NameTab_7 = Instance.new("TextLabel")
    local Click_10 = Instance.new("TextButton")
    local TabDisable = Instance.new("Frame")
    local NameTab_8 = Instance.new("TextLabel")
    local Click_11 = Instance.new("TextButton")
    local UICorner_28 = Instance.new("UICorner")
    local Frame = Instance.new("Frame")
    local UICorner_3 = Instance.new("UICorner")
    local UIPageLayout = Instance.new("UIPageLayout")
    local UICorner_26 = Instance.new("UICorner")
    local CountTab = 1
    local AnimationGUI = Instance.new("Frame")
    local Cricle = Instance.new("Frame")
    local UICorner = Instance.new("UICorner")
    local NameHub = Instance.new("TextLabel")
    local Cricle_2 = Instance.new("Frame")
    local UICorner_2 = Instance.new("UICorner")
    local Cricle_3 = Instance.new("Frame")
    local UICorner_3 = Instance.new("UICorner")
    local Cricle_4 = Instance.new("Frame")
    local UICorner_4 = Instance.new("UICorner")

    UniqueRemake.Name = "UniqueRemake"
    UniqueRemake.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
    UniqueRemake.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

    AnimationGUI.Name = "Animation GUI"
    AnimationGUI.Parent = UniqueRemake
    AnimationGUI.AnchorPoint = Vector2.new(0.5, 0.5)
    AnimationGUI.BackgroundColor3 = Color3.fromRGB(146, 255, 251)
    AnimationGUI.BackgroundTransparency = 1.000
    AnimationGUI.BorderColor3 = Color3.fromRGB(0, 0, 0)
    AnimationGUI.BorderSizePixel = 0
    AnimationGUI.Position = UDim2.new(0.5, 0, 0.5, 0)
    AnimationGUI.Size = UDim2.new(0, 200, 0, 40)

    Cricle.Name = "Cricle"
    Cricle.Parent = AnimationGUI
    Cricle.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    Cricle.BorderColor3 = Color3.fromRGB(0, 0, 0)
    Cricle.BorderSizePixel = 0
    Cricle.Position = UDim2.new(0.435000002, 0, 0.174999997, 0)

    UICorner.CornerRadius = UDim.new(0, 4)
    UICorner.Parent = Cricle

    NameHub.Name = "NameHub"
    NameHub.Parent = Cricle
    NameHub.AnchorPoint = Vector2.new(0.5, 0.5)
    NameHub.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    NameHub.BackgroundTransparency = 1.000
    NameHub.BorderColor3 = Color3.fromRGB(0, 0, 0)
    NameHub.BorderSizePixel = 0
    NameHub.ClipsDescendants = true
    NameHub.Position = UDim2.new(0.5, 0, 0.5, 0)
    NameHub.Font = Enum.Font.GothamBold
    NameHub.Text = Config.Name
    NameHub.TextColor3 = Color3.fromRGB(255, 255, 255)
    NameHub.TextSize = 16.000
    NameHub.TextWrapped = true
    NameHub.TextXAlignment = Enum.TextXAlignment.Left

    Cricle_2.Name = "Cricle"
    Cricle_2.Parent = Cricle
    Cricle_2.AnchorPoint = Vector2.new(0.5, 0.5)
    Cricle_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Cricle_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
    Cricle_2.BorderSizePixel = 0
    Cricle_2.Position = UDim2.new(0.5, 0, 0.5, 0)

    UICorner_2.CornerRadius = UDim.new(1, 0)
    UICorner_2.Parent = Cricle_2

    Cricle_3.Name = "Cricle"
    Cricle_3.Parent = Cricle
    Cricle_3.AnchorPoint = Vector2.new(0.5, 0.5)
    Cricle_3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Cricle_3.BorderColor3 = Color3.fromRGB(0, 0, 0)
    Cricle_3.BorderSizePixel = 0
    Cricle_3.Position = UDim2.new(0.5, 0, 0.5, 0)

    UICorner_3.CornerRadius = UDim.new(0, 2)
    UICorner_3.Parent = Cricle_3

    Cricle_4.Name = "Cricle"
    Cricle_4.Parent = Cricle
    Cricle_4.AnchorPoint = Vector2.new(0.5, 0.5)
    Cricle_4.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Cricle_4.BorderColor3 = Color3.fromRGB(0, 0, 0)
    Cricle_4.BorderSizePixel = 0
    Cricle_4.Position = UDim2.new(0.5, 0, 0.5, 0)

    UICorner_4.CornerRadius = UDim.new(1, 0)
    UICorner_4.Parent = Cricle_4
    Main.Position = UDim2.new(0.5, 0, 1.5, 0)
    TweenService:Create(
        Cricle,
        TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut),
        {Size = UDim2.new(0, 25, 0, 25)}
    ):Play()
    wait(1)
    TweenService:Create(
        NameHub,
        TweenInfo.new(1, Enum.EasingStyle.Back, Enum.EasingDirection.InOut),
        {Position = UDim2.new(0, -42, 0.5, 0)}
    ):Play()
    TweenService:Create(
        NameHub,
        TweenInfo.new(0.7, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut),
        {Size = UDim2.new(0, 105, 0, 44)}
    ):Play()
    wait(1)
    TweenService:Create(
        Cricle_2,
        TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut),
        {Position = UDim2.new(1.82, 0, 0.5, 0)}
    ):Play()
    TweenService:Create(
        Cricle_2,
        TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut),
        {Size = UDim2.new(0, 25, 0, 25)}
    ):Play()
    TweenService:Create(
        Cricle_2,
        TweenInfo.new(5, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut),
        {Rotation = 1000}
    ):Play()
    wait(1)
    TweenService:Create(
        Cricle_3,
        TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut),
        {Position = UDim2.new(3, 0, 0.5, 0)}
    ):Play()
    TweenService:Create(
        Cricle_3,
        TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut),
        {Size = UDim2.new(0, 25, 0, 25)}
    ):Play()
    TweenService:Create(
        Cricle_3,
        TweenInfo.new(5, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut),
        {Rotation = 1000}
    ):Play()
    wait(1)
    TweenService:Create(
        Cricle_4,
        TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut),
        {Position = UDim2.new(4.28, 0, 0.5, 0)}
    ):Play()
    TweenService:Create(
        Cricle_4,
        TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut),
        {Size = UDim2.new(0, 25, 0, 25)}
    ):Play()
    TweenService:Create(
        Cricle_4,
        TweenInfo.new(5, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut),
        {Rotation = 1000}
    ):Play()
    wait(3)
    TweenService:Create(
        NameHub,
        TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut),
        {Position = UDim2.new(0, -42, -4, 0)}
    ):Play()
    TweenService:Create(
        NameHub,
        TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut),
        {TextTransparency = 1.00}
    ):Play()
    wait(0.5)
    TweenService:Create(
        Cricle,
        TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut),
        {Position = UDim2.new(0.435000002, 0, -4.174999997, 0)}
    ):Play()
    TweenService:Create(
        Cricle,
        TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut),
        {BackgroundTransparency = 1.00}
    ):Play()
    TweenService:Create(
        Cricle_2,
        TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut),
        {Position = UDim2.new(1.82, 0, -4, 0)}
    ):Play()
    TweenService:Create(
        Cricle_2,
        TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut),
        {BackgroundTransparency = 1.00}
    ):Play()
    TweenService:Create(
        Cricle_3,
        TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut),
        {Position = UDim2.new(3, 0, -4, 0)}
    ):Play()
    TweenService:Create(
        Cricle_3,
        TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut),
        {BackgroundTransparency = 1.00}
    ):Play()
    TweenService:Create(
        Cricle_4,
        TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut),
        {Position = UDim2.new(4.28, 0, -4, 0)}
    ):Play()
    TweenService:Create(
        Cricle_4,
        TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut),
        {BackgroundTransparency = 1.00}
    ):Play()
    wait(1)
    TweenService:Create(
        Main,
        TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut),
        {Position = UDim2.new(0.5, 0, 0.5, 0)}
    ):Play()

    Main.Name = "Main"
    Main.Parent = UniqueRemake
    Main.AnchorPoint = Vector2.new(0.5, 0.5)
    Main.BackgroundColor3 = Color3.fromRGB(16, 16, 16)
    Main.BorderColor3 = Color3.fromRGB(0, 0, 0)
    Main.BorderSizePixel = 0
    Main.ClipsDescendants = true
    Main.Size = UDim2.new(0, 541, 0, 369)

    UICorner.Parent = Main

    UIStroke.Parent = Main
    UIStroke.Color = Color3.fromRGB(202, 202, 202)
    UIStroke.Transparency = 0.470
    UIStroke.Thickness = 1.400

    DropShadowHolder.Name = "DropShadowHolder"
    DropShadowHolder.Parent = Main
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
    DropShadow.Image = "rbxassetid://6014261993"
    DropShadow.ImageColor3 = Color3.fromRGB(171, 171, 171)
    DropShadow.ImageTransparency = 0.500
    DropShadow.ScaleType = Enum.ScaleType.Slice
    DropShadow.SliceCenter = Rect.new(49, 49, 450, 450)

    Navitional.Name = "Navitional"
    Navitional.Parent = Main
    Navitional.BackgroundColor3 = Color3.fromRGB(16, 16, 16)
    Navitional.BorderColor3 = Color3.fromRGB(0, 0, 0)
    Navitional.BorderSizePixel = 0
    Navitional.Position = UDim2.new(0, 0, 0, 48)
    Navitional.Size = UDim2.new(1, 0, 1, -50)

    UICorner_3.Parent = Navitional

    Real.Name = "Real"
    Real.Parent = Navitional
    Real.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    Real.BackgroundTransparency = 0
    Real.BorderColor3 = Color3.fromRGB(0, 0, 0)
    Real.BorderSizePixel = 0
    Real.ClipsDescendants = true
    Real.Size = UDim2.new(1, 0, 1, 0)

    UICorner_26.Parent = Real

    Ngu.Name = "Ngu"
    Ngu.Parent = Real

    UIPageLayout.Parent = Ngu
    UIPageLayout.SortOrder = Enum.SortOrder.LayoutOrder
    UIPageLayout.Padding = UDim.new(0, 31)
    UIPageLayout.ScrollWheelInputEnabled = false
    UIPageLayout.TweenTime = 0.3

    HomeTab.Name = "Home Tab"
    HomeTab.Parent = Ngu
    HomeTab.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    HomeTab.BackgroundTransparency = 1.000
    HomeTab.BorderColor3 = Color3.fromRGB(0, 0, 0)
    HomeTab.BorderSizePixel = 0
    HomeTab.Size = UDim2.new(1, 0, 1, 0)
    HomeTab.LayoutOrder = 0

    UICorner_2.Parent = HomeTab

    Poster.Name = "Poster"
    Poster.Parent = HomeTab
    Poster.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Poster.BackgroundTransparency = 1.000
    Poster.BorderColor3 = Color3.fromRGB(0, 0, 0)
    Poster.BorderSizePixel = 0
    Poster.Size = UDim2.new(1, 0, 0, 230)

    Title.Name = "Title"
    Title.Parent = Poster
    Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Title.BackgroundTransparency = 1.000
    Title.BorderColor3 = Color3.fromRGB(0, 0, 0)
    Title.BorderSizePixel = 0
    Title.Position = UDim2.new(0, 14, 0, 17)
    Title.Size = UDim2.new(0, 228, 0, 93)
    Title.Font = Enum.Font.GothamBold
    Title.Text = Config.NewUpdate
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.TextSize = 28.000
    Title.TextWrapped = true

    Poster_2.Name = "Poster"
    Poster_2.Parent = Poster
    Poster_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Poster_2.BackgroundTransparency = 1.000
    Poster_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
    Poster_2.BorderSizePixel = 0
    Poster_2.Position = UDim2.new(0.619223654, 0, -0.0173913036, 0)
    Poster_2.Size = UDim2.new(0, 200, 0, 148)
    Poster_2.Image = "rbxassetid://113060501714751"

    Desc.Name = "Desc"
    Desc.Parent = Poster
    Desc.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Desc.BackgroundTransparency = 1.000
    Desc.BorderColor3 = Color3.fromRGB(0, 0, 0)
    Desc.BorderSizePixel = 0
    Desc.Position = UDim2.new(0.101663589, 0, 0.443478256, 0)
    Desc.Size = UDim2.new(0, 221, 0, 34)
    Desc.Font = Enum.Font.GothamBold
    Desc.Text = Config.Description
    Desc.TextColor3 = Color3.fromRGB(255, 255, 255)
    Desc.TextSize = 14.000
    Desc.TextWrapped = true
    Desc.TextXAlignment = Enum.TextXAlignment.Left

    Line.Name = "Line"
    Line.Parent = Poster
    Line.BackgroundColor3 = Color3.fromRGB(222, 222, 222)
    Line.BorderColor3 = Color3.fromRGB(0, 0, 0)
    Line.BorderSizePixel = 0
    Line.Position = UDim2.new(0, 0, 1, 0)
    Line.Size = UDim2.new(1, 0, 0, 2)

    TabThuHai.Name = "Tab Thu Hai"
    TabThuHai.Parent = HomeTab
    TabThuHai.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    TabThuHai.BackgroundTransparency = 1.000
    TabThuHai.BorderColor3 = Color3.fromRGB(0, 0, 0)
    TabThuHai.BorderSizePixel = 0
    TabThuHai.Position = UDim2.new(0, 0, 0, 230)
    TabThuHai.Size = UDim2.new(1, 0, 1, -230)

    TabHolderThu2.Name = "Tab Holder Thu 2"
    TabHolderThu2.Parent = TabThuHai
    TabHolderThu2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    TabHolderThu2.BackgroundTransparency = 1.000
    TabHolderThu2.BorderColor3 = Color3.fromRGB(0, 0, 0)
    TabHolderThu2.BorderSizePixel = 0
    TabHolderThu2.Size = UDim2.new(1, 0, 1, 0)
    TabHolderThu2.CanvasSize = UDim2.new(1, 300, 0, 0)
    TabHolderThu2.ScrollBarThickness = 0
    local function UpdateCanvaSize()
        local OffsetY = 0
        for _, child in pairs(TabHolderThu2:GetChildren()) do
            if child.Name ~= "UIListLayout" and not string.find(child.Name, "UI") then
				OffsetY = OffsetY + 3 + child.Size.Y.Offset
			end
        end
        TabHolderThu2.CanvasSize = UDim2.new(0, OffsetY, 0, 0)
    end
    TabHolderThu2.ChildAdded:Connect(UpdateCanvaSize)
    TabHolderThu2.ChildRemoved:Connect(UpdateCanvaSize)

    UIPadding.Parent = TabHolderThu2
    UIPadding.PaddingBottom = UDim.new(0, 4)
    UIPadding.PaddingLeft = UDim.new(0, 9)
    UIPadding.PaddingRight = UDim.new(0, 4)
    UIPadding.PaddingTop = UDim.new(0, 14)

    UIListLayout.Parent = TabHolderThu2
    UIListLayout.FillDirection = Enum.FillDirection.Horizontal
    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    UIListLayout.Padding = UDim.new(0, 12)

    Top.Name = "Top"
    Top.Parent = Main
    Top.BackgroundColor3 = Color3.fromRGB(16, 16, 16)
    Top.BorderColor3 = Color3.fromRGB(0, 0, 0)
    Top.BorderSizePixel = 0
    Top.Size = UDim2.new(1, 0, -0.00542005431, 52)
    
    NameHub2.Name = "NameHub2"
    NameHub2.Parent = Top
    NameHub2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    NameHub2.BackgroundTransparency = 1.000
    NameHub2.BorderColor3 = Color3.fromRGB(0, 0, 0)
    NameHub2.BorderSizePixel = 0
    NameHub2.Position = UDim2.new(0.0517560057, 0, 0, 0)
    NameHub2.Size = UDim2.new(0, 200, 0, 38)
    NameHub2.Font = Enum.Font.GothamBold
    NameHub2.Text = Config.Name
    NameHub2.TextColor3 = Color3.fromRGB(255, 255, 255)
    NameHub2.TextSize = 14.000
    NameHub2.TextXAlignment = Enum.TextXAlignment.Left
    
    UIPadding_16.Parent = NameHub2
    UIPadding_16.PaddingLeft = UDim.new(0, 32)
    
    Logo_5.Name = "Logo"
    Logo_5.Parent = Top
    Logo_5.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Logo_5.BackgroundTransparency = 1.000
    Logo_5.BorderColor3 = Color3.fromRGB(0, 0, 0)
    Logo_5.BorderSizePixel = 0
    Logo_5.Position = UDim2.new(-0.0258780029, 0, -0.134615481, 0)
    Logo_5.Size = UDim2.new(0, 83, 0, 52)
    Logo_5.Image = "rbxassetid://108245805944053"
    
    TabNhucac.Name = "Tab Nhu cac"
    TabNhucac.Parent = Top
    TabNhucac.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    TabNhucac.BackgroundTransparency = 1.000
    TabNhucac.BorderColor3 = Color3.fromRGB(0, 0, 0)
    TabNhucac.BorderSizePixel = 0
    TabNhucac.Position = UDim2.new(0.247689471, 0, 0, 0)
    TabNhucac.Size = UDim2.new(-0.0258780029, 421, 1, 0)
    
    TabHolder.Name = "Tab Holder"
    TabHolder.Parent = TabNhucac
    TabHolder.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    TabHolder.BackgroundTransparency = 1.000
    TabHolder.BorderColor3 = Color3.fromRGB(0, 0, 0)
    TabHolder.BorderSizePixel = 0
    TabHolder.Position = UDim2.new(0.0475059375, 0, 0, 0)
    TabHolder.Size = UDim2.new(0.952494085, 0, 1, 0)
    
    UIPadding_17.Parent = TabHolder
    UIPadding_17.PaddingBottom = UDim.new(0, 5)
    UIPadding_17.PaddingLeft = UDim.new(0, 7)
    UIPadding_17.PaddingRight = UDim.new(0, 5)
    UIPadding_17.PaddingTop = UDim.new(0, 10)
    
    UIListLayout_5.Parent = TabHolder
    UIListLayout_5.FillDirection = Enum.FillDirection.Horizontal
    UIListLayout_5.SortOrder = Enum.SortOrder.LayoutOrder
    
    TabEnable.Name = "Tab Enable"
    TabEnable.Parent = TabHolder
    TabEnable.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    TabEnable.BackgroundTransparency = 1.000
    TabEnable.BorderColor3 = Color3.fromRGB(0, 0, 0)
    TabEnable.BorderSizePixel = 0
    TabEnable.Size = UDim2.new(0, 45, 0, 20)
    
    NameTab_7.Name = "Name Tab"
    NameTab_7.Parent = TabEnable
    NameTab_7.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    NameTab_7.BackgroundTransparency = 1.000
    NameTab_7.BorderColor3 = Color3.fromRGB(0, 0, 0)
    NameTab_7.BorderSizePixel = 0
    NameTab_7.Size = UDim2.new(1, -20, 1, 0)
    NameTab_7.FontFace = Font.new([[rbxasset://fonts/families/Nunito.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal)
    NameTab_7.Text = "Home"
    NameTab_7.TextColor3 = Color3.fromRGB(255, 255, 255)
    NameTab_7.TextSize = 14.000
    
    Click_10.Name = "Click"
    Click_10.Parent = TabEnable
    Click_10.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Click_10.BackgroundTransparency = 1.000
    Click_10.BorderColor3 = Color3.fromRGB(0, 0, 0)
    Click_10.BorderSizePixel = 0
    Click_10.Size = UDim2.new(1, 0, 1, 0)
    Click_10.Font = Enum.Font.SourceSans
    Click_10.Text = ""
    Click_10.TextColor3 = Color3.fromRGB(0, 0, 0)
    Click_10.TextSize = 14.000
    Click_10.Activated:Connect(function()
        for _, v in next, TabDisable:GetChildren() do
            if v.Name == "Name Tab" then
                v.TextColor3 = Color3.fromRGB(144, 144, 144)
            end
        end
        for _, v in next, TabEnable:GetChildren() do
            if v.Name == "Name Tab" then
                v.TextColor3 = Color3.fromRGB(255, 255, 255)
            end
        end
        UIPageLayout:JumpToIndex(0)
    end)
    
    TabDisable.Name = "Tab Disable"
    TabDisable.Parent = TabHolder
    TabDisable.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    TabDisable.BackgroundTransparency = 1.000
    TabDisable.BorderColor3 = Color3.fromRGB(0, 0, 0)
    TabDisable.BorderSizePixel = 0
    TabDisable.Size = UDim2.new(0, 45, 0, 20)
    
    NameTab_8.Name = "Name Tab"
    NameTab_8.Parent = TabDisable
    NameTab_8.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    NameTab_8.BackgroundTransparency = 1.000
    NameTab_8.BorderColor3 = Color3.fromRGB(0, 0, 0)
    NameTab_8.BorderSizePixel = 0
    NameTab_8.Size = UDim2.new(1, -20, 1, 0)
    NameTab_8.FontFace = Font.new([[rbxasset://fonts/families/Nunito.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal)
    NameTab_8.Text = "Page"
    NameTab_8.TextColor3 = Color3.fromRGB(144, 144, 144)
    NameTab_8.TextSize = 14.000
    
    Click_11.Name = "Click"
    Click_11.Parent = TabDisable
    Click_11.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Click_11.BackgroundTransparency = 1.000
    Click_11.BorderColor3 = Color3.fromRGB(0, 0, 0)
    Click_11.BorderSizePixel = 0
    Click_11.Size = UDim2.new(1, 0, 1, 0)
    Click_11.Font = Enum.Font.SourceSans
    Click_11.Text = ""
    Click_11.TextColor3 = Color3.fromRGB(0, 0, 0)
    Click_11.TextSize = 14.000
    
    UICorner_28.Parent = Top
    
    Frame.Parent = Top
    Frame.BackgroundColor3 = Color3.fromRGB(16, 16, 16)
    Frame.BorderColor3 = Color3.fromRGB(0, 0, 0)
    Frame.BorderSizePixel = 0
    Frame.Position = UDim2.new(0, 0, 0.75999999, 0)
    Frame.Size = UDim2.new(1, 0, 0, 15)

    UICorner_2.Parent = HomeTab
    makedraggable(Top, Main)

    local Tabcre = {}
    function Tabcre:AddTab(ConfigTab)
        ConfigTab = ConfigTab or {}
        ConfigTab.Name = ConfigTab.Name or "Tab"
        ConfigTab.Icon = ConfigTab.Icon or "rbxassetid://91159587283911"

        local TabKocogi = Instance.new("Frame")
        local UICorner_3 = Instance.new("UICorner")
        local UIStroke_2 = Instance.new("UIStroke")
        local NameTab = Instance.new("Frame")
        local UICorner_4 = Instance.new("UICorner")
        local NameTab_2 = Instance.new("TextLabel")
        local UIPadding_2 = Instance.new("UIPadding")
        local Logo = Instance.new("ImageLabel")
        local Click = Instance.new("TextButton")
        local Channel = Instance.new("ScrollingFrame")
        local UICorner_25 = Instance.new("UICorner")
        local UIPadding_5 = Instance.new("UIPadding")
        local PageSettings = Instance.new("Frame")
        local IDK = Instance.new("TextLabel")
        local UIPadding_6 = Instance.new("UIPadding")
        local Button = Instance.new("Frame")
        local Next = Instance.new("TextLabel")
        local Click_4 = Instance.new("TextButton")
        local UICorner_9 = Instance.new("UICorner")
        local Left = Instance.new("Frame")
        local UIPadding_7 = Instance.new("UIPadding")
        local UIListLayout_2 = Instance.new("UIListLayout")
        local UICorner_10 = Instance.new("UICorner")
        local UIStroke_5 = Instance.new("UIStroke")
        local Right = Instance.new("Frame")
        local UICorner_23 = Instance.new("UICorner")
        local UIListLayout_4 = Instance.new("UIListLayout")
        local UIPadding_13 = Instance.new("UIPadding")
        local UIStroke_8 = Instance.new("UIStroke")

        TabKocogi.Name = "Tab Ko co gi"
        TabKocogi.Parent = TabHolderThu2
        TabKocogi.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        TabKocogi.BackgroundTransparency = 0.930
        TabKocogi.BorderColor3 = Color3.fromRGB(0, 0, 0)
        TabKocogi.BorderSizePixel = 0
        TabKocogi.Position = UDim2.new(0, 0, 0.0526315793, 0)
        TabKocogi.Size = UDim2.new(0, 200, 0, 66)
        OldSize = TabKocogi.Size
        TabKocogi.MouseEnter:Connect(function()
            TweenService:Create(
                TabKocogi,
                TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut),
                {Size = UDim2.new(0, 222, 0, 70)}
            ):Play()
            TweenService:Create(
                NameTab,
                TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut),
                {Size = UDim2.new(0, 172, 0, 65)}
            ):Play()
        end)
        TabKocogi.MouseLeave:Connect(function()
            TweenService:Create(
                TabKocogi,
                TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut),
                {Size = OldSize}
            ):Play()
            TweenService:Create(
                NameTab,
                TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut),
                {Size = UDim2.new(0, 170, 0, 55)}
            ):Play()
        end)

        UICorner_3.CornerRadius = UDim.new(0, 12)
        UICorner_3.Parent = TabKocogi

        UIStroke_2.Parent = TabKocogi
        UIStroke_2.Thickness = 2.000
        UIStroke_2.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

        NameTab.Name = "NameTab"
        NameTab.Parent = TabKocogi
        NameTab.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        NameTab.BorderColor3 = Color3.fromRGB(0, 0, 0)
        NameTab.BorderSizePixel = 0
        NameTab.Position = UDim2.new(0.0850000009, 0, -0.129000112, 3)
        NameTab.Size = UDim2.new(0, 170, 0, 55)

        UICorner_4.CornerRadius = UDim.new(0, 12)
        UICorner_4.Parent = NameTab

        NameTab_2.Name = "NameTab"
        NameTab_2.Parent = NameTab
        NameTab_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        NameTab_2.BackgroundTransparency = 1.000
        NameTab_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
        NameTab_2.BorderSizePixel = 0
        NameTab_2.Size = UDim2.new(1, 0, 1, 0)
        NameTab_2.Font = Enum.Font.GothamBold
        NameTab_2.Text = ConfigTab.Name
        NameTab_2.TextColor3 = Color3.fromRGB(0, 0, 0)
        NameTab_2.TextSize = 20.000

        UIPadding_2.Parent = NameTab_2
        UIPadding_2.PaddingLeft = UDim.new(0, 40)

        Logo.Name = "Logo"
        Logo.Parent = NameTab
        Logo.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        Logo.BackgroundTransparency = 1.000
        Logo.BorderColor3 = Color3.fromRGB(0, 0, 0)
        Logo.BorderSizePixel = 0
        Logo.Position = UDim2.new(0.0588235296, 0, 0.127272725, 0)
        Logo.Size = UDim2.new(0, 40, 0, 40)
        Logo.Image = ConfigTab.Icon
        Logo.ImageColor3 = Color3.fromRGB(0, 0, 0)

        Click.Name = "Click"
        Click.Parent = NameTab
        Click.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        Click.BackgroundTransparency = 1.000
        Click.BorderColor3 = Color3.fromRGB(0, 0, 0)
        Click.BorderSizePixel = 0
        Click.Size = UDim2.new(1, 0, 1, 0)
        Click.Font = Enum.Font.SourceSans
        Click.Text = ""
        Click.TextColor3 = Color3.fromRGB(0, 0, 0)
        Click.TextSize = 14.000

        Channel.Name = "Channel"
        Channel.LayoutOrder = CountTab
        Channel.Parent = Ngu
        Channel.BackgroundTransparency = 1.000
        Channel.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
        Channel.BorderColor3 = Color3.fromRGB(0, 0, 0)
        Channel.BorderSizePixel = 0
        Channel.Size = UDim2.new(1, 0, 1, 0)
        Channel.MidImage = "rbxassetid://91241762908661"
        Channel.ScrollBarThickness = 1

        Click.Activated:Connect(function()
            for _, v in next, TabDisable:GetChildren() do
                if v.Name == "Name Tab" then
                    v.TextColor3 = Color3.fromRGB(255, 255, 255)
                end
            end
            for _, v in next, TabEnable:GetChildren() do
                if v.Name == "Name Tab" then
                    v.TextColor3 = Color3.fromRGB(144, 144, 144)
                end
            end
            OldPage = Channel.LayoutOrder
            UIPageLayout:JumpToIndex(Channel.LayoutOrder)
        end)

        Click_11.Activated:Connect(function()
            for _, v in next, TabDisable:GetChildren() do
                if v.Name == "Name Tab" then
                    v.TextColor3 = Color3.fromRGB(255, 255, 255)
                end
            end
            for _, v in next, TabEnable:GetChildren() do
                if v.Name == "Name Tab" then
                    v.TextColor3 = Color3.fromRGB(144, 144, 144)
                end
            end
            UIPageLayout:JumpToIndex(OldPage)
        end)

        UIPadding_5.Parent = Channel
        UIPadding_5.PaddingBottom = UDim.new(0, 7)
        UIPadding_5.PaddingLeft = UDim.new(0, 7)
        UIPadding_5.PaddingRight = UDim.new(0, 7)
        UIPadding_5.PaddingTop = UDim.new(0, 12)

        PageSettings.Name = "Page Settings"
        PageSettings.Parent = Channel
        PageSettings.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        PageSettings.BackgroundTransparency = 1.000
        PageSettings.BorderColor3 = Color3.fromRGB(0, 0, 0)
        PageSettings.BorderSizePixel = 0
        PageSettings.Size = UDim2.new(1, 0, 0, 25)

        IDK.Name = "IDK"
        IDK.Parent = PageSettings
        IDK.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        IDK.BackgroundTransparency = 1.000
        IDK.BorderColor3 = Color3.fromRGB(0, 0, 0)
        IDK.BorderSizePixel = 0
        IDK.Size = UDim2.new(1, 0, 1, 0)
        IDK.Font = Enum.Font.GothamBold
        IDK.Text = "Page Automatic"
        IDK.TextColor3 = Color3.fromRGB(255, 255, 255)
        IDK.TextSize = 13.000
        IDK.TextXAlignment = Enum.TextXAlignment.Left

        UIPadding_6.Parent = IDK
        UIPadding_6.PaddingLeft = UDim.new(0, 12)

        Button.Name = "Button"
        Button.Parent = IDK
        Button.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        Button.BackgroundTransparency = 1.000
        Button.BorderColor3 = Color3.fromRGB(0, 0, 0)
        Button.BorderSizePixel = 0
        Button.Position = UDim2.new(0.864077687, 0, 0.0384616107, 0)
        Button.Size = UDim2.new(0, 77, 0, 25)

        Next.Name = "Next"
        Next.Parent = Button
        Next.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        Next.BackgroundTransparency = 1.000
        Next.BorderColor3 = Color3.fromRGB(0, 0, 0)
        Next.BorderSizePixel = 0
        Next.Position = UDim2.new(0, -12, 0, 0)
        Next.Size = UDim2.new(1, 0, 1, 0)
        Next.Font = Enum.Font.GothamBold
        Next.Text = "Next"
        Next.TextColor3 = Color3.fromRGB(200, 200, 200)
        Next.TextSize = 13.000

        Click_4.Name = "Click"
        Click_4.Parent = Button
        Click_4.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        Click_4.BackgroundTransparency = 1.000
        Click_4.BorderColor3 = Color3.fromRGB(0, 0, 0)
        Click_4.BorderSizePixel = 0
        Click_4.Size = UDim2.new(1, 0, 1, 0)
        Click_4.Font = Enum.Font.SourceSans
        Click_4.Text = ""
        Click_4.TextColor3 = Color3.fromRGB(0, 0, 0)
        Click_4.TextSize = 14.000
        Click_4.Activated:Connect(function()
            UIPageLayout:JumpToIndex(Channel.LayoutOrder + 1)
            if (Channel.LayoutOrder + 1) <= 0 then
                for _, v in next, TabDisable:GetChildren() do
                    if v.Name == "Name Tab" then
                        v.TextColor3 = Color3.fromRGB(144, 144, 144)
                    end
                end
                for _, v in next, TabEnable:GetChildren() do
                    if v.Name == "Name Tab" then
                        v.TextColor3 = Color3.fromRGB(255, 255, 255)
                    end
                end
            end
        end)

        UICorner_9.Parent = Channel

        Left.Name = "Left"
        Left.Parent = Channel
        Left.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
        Left.BackgroundTransparency = 1.000
        Left.BorderColor3 = Color3.fromRGB(0, 0, 0)
        Left.BorderSizePixel = 0
        Left.Position = UDim2.new(0, 0, 0, 35)
        Left.Size = UDim2.new(0, 259, 0, 400)

        UIPadding_7.Parent = Left
        UIPadding_7.PaddingBottom = UDim.new(0, 3)
        UIPadding_7.PaddingLeft = UDim.new(0, 6)
        UIPadding_7.PaddingRight = UDim.new(0, 6)
        UIPadding_7.PaddingTop = UDim.new(0, 12)

        UIListLayout_2.Parent = Left
        UIListLayout_2.SortOrder = Enum.SortOrder.LayoutOrder
        UIListLayout_2.Padding = UDim.new(0, 7)

        UICorner_10.CornerRadius = UDim.new(0, 4)
        UICorner_10.Parent = Left

        UIStroke_5.Parent = Left
        UIStroke_5.Color = Color3.fromRGB(200, 200, 200)
        UIStroke_5.Transparency = 0.600
        UIStroke_5.Thickness = 1.500

        Right.Name = "Right"
        Right.Parent = Channel
        Right.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
        Right.BackgroundTransparency = 1.000
        Right.BorderColor3 = Color3.fromRGB(0, 0, 0)
        Right.BorderSizePixel = 0
        Right.Position = UDim2.new(0, 269, 0, 35)
        Right.Size = UDim2.new(0, 259, 0, 265)

        UICorner_23.CornerRadius = UDim.new(0, 4)
        UICorner_23.Parent = Right

        UIListLayout_4.Parent = Right
        UIListLayout_4.SortOrder = Enum.SortOrder.LayoutOrder
        UIListLayout_4.Padding = UDim.new(0, 4)

        UIPadding_13.Parent = Right
        UIPadding_13.PaddingBottom = UDim.new(0, 3)
        UIPadding_13.PaddingLeft = UDim.new(0, 3)
        UIPadding_13.PaddingRight = UDim.new(0, 3)
        UIPadding_13.PaddingTop = UDim.new(0, 3)

        UIStroke_8.Parent = Right
        UIStroke_8.Color = Color3.fromRGB(200, 200, 200)
        UIStroke_8.Transparency = 0.600
        UIStroke_8.Thickness = 1.500

        CountTab = CountTab + 1
        local Features = {}
        function Features:AddSeperator(Cc, PutText)
            local Seperator = Instance.new("Frame")
            local UICorner_11 = Instance.new("UICorner")
            local Title_2 = Instance.new("TextLabel")
            local UICorner_12 = Instance.new("UICorner")

            if Cc == 'Left' then
                Choice = Left
            elseif Cc == "Right" then
                Choice = Right
            end

            Seperator.Name = "Seperator"
            Seperator.Parent = Choice
            Seperator.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Seperator.BorderColor3 = Color3.fromRGB(0, 0, 0)
            Seperator.BorderSizePixel = 0
            Seperator.Size = UDim2.new(1, 0, 0, 2)

            UICorner_11.Parent = Seperator

            Title_2.Name = "Title"
            Title_2.Parent = Seperator
            Title_2.AnchorPoint = Vector2.new(0.5, 0.5)
            Title_2.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
            Title_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
            Title_2.BorderSizePixel = 0
            Title_2.Position = UDim2.new(0.5, 0, 0.5, 0)
            Title_2.Size = UDim2.new(0, 69, 0, 20)
            Title_2.Font = Enum.Font.GothamBold
            Title_2.Text = PutText
            Title_2.TextColor3 = Color3.fromRGB(255, 255, 255)
            Title_2.TextSize = 14.000

            UICorner_12.CornerRadius = UDim.new(0, 4)
            UICorner_12.Parent = Title_2
        end
        function Features:AddToggle(Cc, ConfigToggle)
            ConfigToggle = ConfigToggle or {}
            ConfigToggle.Name = ConfigToggle.Name or "Toggle"
            ConfigToggle.Default = ConfigToggle.Default or false
            ConfigToggle.Callback = ConfigToggle.Callback or function() end

            if Cc == 'Left' then
                Choice = Left
            elseif Cc == "Right" then
                Choice = Right
            end

            local Toggle = Instance.new("Frame")
            local Title_3 = Instance.new("TextLabel")
            local UIPadding_8 = Instance.new("UIPadding")
            local CheckBox = Instance.new("Frame")
            local UICorner_13 = Instance.new("UICorner")
            local UIStroke_6 = Instance.new("UIStroke")
            local Check = Instance.new("Frame")
            local UICorner_14 = Instance.new("UICorner")
            local Check_2 = Instance.new("ImageLabel")
            local Click_5 = Instance.new("TextButton")
            local ToggleFunc = {}

            Toggle.Name = "Toggle"
            Toggle.Parent = Choice
            Toggle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Toggle.BackgroundTransparency = 1.000
            Toggle.BorderColor3 = Color3.fromRGB(0, 0, 0)
            Toggle.BorderSizePixel = 0
            Toggle.Size = UDim2.new(1, 0, 0, 30)

            Title_3.Name = "Title"
            Title_3.Parent = Toggle
            Title_3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Title_3.BackgroundTransparency = 1.000
            Title_3.BorderColor3 = Color3.fromRGB(0, 0, 0)
            Title_3.BorderSizePixel = 0
            Title_3.Size = UDim2.new(1, -50, 1, 0)
            Title_3.Font = Enum.Font.GothamBold
            Title_3.Text = ConfigToggle.Name
            Title_3.TextColor3 = Color3.fromRGB(255, 255, 255)
            Title_3.TextSize = 13.000
            Title_3.TextXAlignment = Enum.TextXAlignment.Left

            UIPadding_8.Parent = Title_3
            UIPadding_8.PaddingLeft = UDim.new(0, 12)

            CheckBox.Name = "CheckBox"
            CheckBox.Parent = Toggle
            CheckBox.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
            CheckBox.BorderColor3 = Color3.fromRGB(0, 0, 0)
            CheckBox.BorderSizePixel = 0
            CheckBox.Position = UDim2.new(0.869565189, 0, 0.13333334, 0)
            CheckBox.Size = UDim2.new(0, 22, 0, 22)

            UICorner_13.CornerRadius = UDim.new(0, 4)
            UICorner_13.Parent = CheckBox

            UIStroke_6.Parent = CheckBox
            UIStroke_6.Color = Color3.fromRGB(200, 200, 200)
            UIStroke_6.Transparency = 0.850
            UIStroke_6.Thickness = 1.500

            Check.Name = "Check"
            Check.Parent = CheckBox
            Check.AnchorPoint = Vector2.new(0.5, 0.5)
            Check.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Check.BorderColor3 = Color3.fromRGB(0, 0, 0)
            Check.BorderSizePixel = 0
            Check.Position = UDim2.new(0.5, 0, 0.5, 0)
            Check.Size = UDim2.new(0, 0, 0, 0)

            UICorner_14.CornerRadius = UDim.new(0, 4)
            UICorner_14.Parent = Check

            Check_2.Name = "Check"
            Check_2.Parent = Check
            Check_2.AnchorPoint = Vector2.new(0.5, 0.5)
            Check_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Check_2.BackgroundTransparency = 1.000
            Check_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
            Check_2.BorderSizePixel = 0
            Check_2.Position = UDim2.new(0.5, 0, 0.5, 2)
            Check_2.Size = UDim2.new(0, 0, 0, 0)
            Check_2.Image = "rbxassetid://119385570526578"

            Click_5.Name = "Click"
            Click_5.Parent = CheckBox
            Click_5.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Click_5.BackgroundTransparency = 1.000
            Click_5.BorderColor3 = Color3.fromRGB(0, 0, 0)
            Click_5.BorderSizePixel = 0
            Click_5.Size = UDim2.new(1, 0, 1, 0)
            Click_5.Font = Enum.Font.SourceSans
            Click_5.Text = ""
            Click_5.TextColor3 = Color3.fromRGB(0, 0, 0)
            Click_5.TextSize = 14.000

            Toggled = ConfigToggle.Default
            function ToggleFunc:Set(Value)
                if Value then
                    TweenService:Create(
                        Check,
                        TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut),
                        {Size = UDim2.new(0, 18, 0, 18)}
                    ):Play()
                    TweenService:Create(
                        Check_2,
                        TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut),
                        {Size = UDim2.new(0, 15, 0, 15)}
                    ):Play()
                    TweenService:Create(
                        Title_3,
                        TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut),
                        {TextColor3 = Color3.fromRGB(255, 255, 255)}
                    ):Play()
                else
                    TweenService:Create(
                        Check,
                        TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut),
                        {Size = UDim2.new(0, 0, 0, 0)}
                    ):Play()
                    TweenService:Create(
                        Check_2,
                        TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut),
                        {Size = UDim2.new(0, 0, 0, 0)}
                    ):Play()
                    TweenService:Create(
                        Title_3,
                        TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut),
                        {TextColor3 = Color3.fromRGB(177, 177, 177)}
                    ):Play()
                end
                Toggled = Value
                ConfigToggle.Callback(Toggled)
            end

            ToggleFunc:Set(Toggled)
            Click_5.Activated:Connect(function()
                Toggled = not Toggled
                ToggleFunc:Set(Toggled)
            end)
            return ToggleFunc
        end
        function Features:AddButton(Cc, ConfigButton)
            ConfigButton = ConfigButton or {}
            ConfigButton.Name = ConfigButton.Name or "Button"
            ConfigButton.Callback = ConfigButton.Callback or function() end

            if Cc == 'Left' then
                Choice = Left
            elseif Cc == "Right" then
                Choice = Right
            end

            local Button_2 = Instance.new("Frame")
            local UICorner_17 = Instance.new("UICorner")
            local Cac = Instance.new("TextLabel")
            local Click_7 = Instance.new("TextButton")

            Button_2.Name = "Button"
            Button_2.Parent = Choice
            Button_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Button_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
            Button_2.BorderSizePixel = 0
            Button_2.Size = UDim2.new(1, 0, 0, 20)

            UICorner_17.CornerRadius = UDim.new(0, 3)
            UICorner_17.Parent = Button_2

            Cac.Name = "Cac"
            Cac.Parent = Button_2
            Cac.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Cac.BackgroundTransparency = 1.000
            Cac.BorderColor3 = Color3.fromRGB(0, 0, 0)
            Cac.BorderSizePixel = 0
            Cac.Size = UDim2.new(1, 0, 1, 0)
            Cac.Font = Enum.Font.GothamBold
            Cac.Text = "Button"
            Cac.TextColor3 = Color3.fromRGB(15, 15, 15)
            Cac.TextSize = 13.000

            Click_7.Name = "Click"
            Click_7.Parent = Button_2
            Click_7.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Click_7.BackgroundTransparency = 1.000
            Click_7.BorderColor3 = Color3.fromRGB(0, 0, 0)
            Click_7.BorderSizePixel = 0
            Click_7.Size = UDim2.new(1, 0, 1, 0)
            Click_7.Font = Enum.Font.SourceSans
            Click_7.Text = ""
            Click_7.TextColor3 = Color3.fromRGB(0, 0, 0)
            Click_7.TextSize = 14.000
            Click_7.Activated:Connect(function()
                Cac.TextSize = 18.000
                TweenService:Create(
                    Cac,
                    TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut),
                    {TextSize = 14.000}
                ):Play()
                ConfigButton.Callback()
            end)
            UICorner_9.Parent = Channel
        end
        function Features:AddSlider(Cc, ConfigSlider)
            ConfigSlider = ConfigSlider or {}
            ConfigSlider.Name = ConfigSlider.Name or "Slider"
            ConfigSlider.Max = ConfigSlider.Max or 100
            ConfigSlider.Min = ConfigSlider.Min or 0
            ConfigSlider.Default = ConfigSlider.Default or 50
            ConfigSlider.Callback = ConfigSlider.Callback or function() end

            if Cc == 'Left' then
                Choice = Left
            elseif Cc == "Right" then
                Choice = Right
            end

            local Slider = Instance.new("Frame")
            local Title_5 = Instance.new("TextLabel")
            local UIPadding_10 = Instance.new("UIPadding")
            local SliderFrame = Instance.new("Frame")
            local UICorner_18 = Instance.new("UICorner")
            local Draggble = Instance.new("Frame")
            local UICorner_19 = Instance.new("UICorner")
            local Box = Instance.new("TextBox")
            local UICorner_20 = Instance.new("UICorner")
            local SliderFunc = {Value = ConfigSlider.Default}

            Slider.Name = "Slider"
            Slider.Parent = Choice
            Slider.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Slider.BackgroundTransparency = 1.000
            Slider.BorderColor3 = Color3.fromRGB(0, 0, 0)
            Slider.BorderSizePixel = 0
            Slider.Size = UDim2.new(1, 0, 0, 40)

            Title_5.Name = "Title"
            Title_5.Parent = Slider
            Title_5.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Title_5.BackgroundTransparency = 1.000
            Title_5.BorderColor3 = Color3.fromRGB(0, 0, 0)
            Title_5.BorderSizePixel = 0
            Title_5.Size = UDim2.new(1, 0, 0, 18)
            Title_5.Font = Enum.Font.GothamBold
            Title_5.Text = ConfigSlider.Name
            Title_5.TextColor3 = Color3.fromRGB(200, 200, 200)
            Title_5.TextSize = 13.000
            Title_5.TextXAlignment = Enum.TextXAlignment.Left

            UIPadding_10.Parent = Title_5
            UIPadding_10.PaddingLeft = UDim.new(0, 12)

            SliderFrame.Name = "SliderFrame"
            SliderFrame.Parent = Slider
            SliderFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
            SliderFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
            SliderFrame.BorderSizePixel = 0
            SliderFrame.Position = UDim2.new(0, 12, 0, 21)
            SliderFrame.Size = UDim2.new(1, -50, 0, 5)

            UICorner_18.Parent = SliderFrame

            Draggble.Name = "Draggble"
            Draggble.Parent = SliderFrame
            Draggble.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Draggble.BorderColor3 = Color3.fromRGB(0, 0, 0)
            Draggble.BorderSizePixel = 0
            Draggble.Size = UDim2.new(0, 98, 1, 0)

            UICorner_19.Parent = Draggble

            Box.Name = "Box"
            Box.Parent = Slider
            Box.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
            Box.BackgroundTransparency = 0.600
            Box.BorderColor3 = Color3.fromRGB(0, 0, 0)
            Box.BorderSizePixel = 0
            Box.Position = UDim2.new(1, -33, 0, 12)
            Box.Size = UDim2.new(0, 32, 0, 20)
            Box.Font = Enum.Font.GothamBold
            Box.PlaceholderColor3 = Color3.fromRGB(255, 255, 255)
            Box.PlaceholderText = "Number"
            Box.Text = ConfigSlider.Default
            Box.TextColor3 = Color3.fromRGB(255, 255, 255)
            Box.TextSize = 12.000

            UICorner_20.CornerRadius = UDim.new(0, 4)
            UICorner_20.Parent = Box

            local Dragging = false
            local function Round(Number, Factor)
                local Result = math.floor(Number/Factor + (math.sign(Number) * 0.5)) * Factor
                if Result < 0 then Result = Result + Factor end
                return Result
            end
            function SliderFunc:Set(Value)
                Value = math.clamp(Round(Value, 1), ConfigSlider.Min, ConfigSlider.Max)
                SliderFunc.Value = Value
                Box.Text = tostring(Value)
                ConfigSlider.Callback(SliderFunc.Value)
                TweenService:Create(
                    Draggble,
                    TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                    {Size = UDim2.fromScale((Value - ConfigSlider.Min) / (ConfigSlider.Max - ConfigSlider.Min), 1)}
                ):Play()
            end
            SliderFrame.InputBegan:Connect(function(Input)
                if Input.UserInputType == Enum.UserInputType.MouseButton1 then 
                    Dragging = true 
                end 
            end)
            SliderFrame.InputEnded:Connect(function(Input) 
                if Input.UserInputType == Enum.UserInputType.MouseButton1 then 
                    Dragging = false 
                    ConfigSlider.Callback(SliderFunc.Value)
                end 
            end)
            uis.InputChanged:Connect(function(Input)
                if Dragging and Input.UserInputType == Enum.UserInputType.MouseMovement then 
                    local SizeScale = math.clamp((Input.Position.X - SliderFrame.AbsolutePosition.X) / SliderFrame.AbsoluteSize.X, 0, 1)
                    SliderFunc:Set(ConfigSlider.Min + ((ConfigSlider.Max - ConfigSlider.Min) * SizeScale)) 
                end
            end)
			Box:GetPropertyChangedSignal("Text"):Connect(function()
				local Valid = Box.Text:gsub("[^%d]", "")
				if Valid ~= "" then
					local ValidNumber = math.min(tonumber(Valid), ConfigSlider.Max)
					Box.Text = tostring(ValidNumber)
				else
					Box.Text = tostring(Valid)
				end
			end)
			Box.FocusLost:Connect(function()
				if Box.Text ~= "" then
					SliderFunc:Set(tonumber(Box.Text))
				else
					SliderFunc:Set(0)
				end
			end)
            SliderFunc:Set(tonumber(ConfigSlider.Default))
            return SliderFunc
        end
        function Features:AddDropdown(Cc, ConfigDropdown)
            ConfigDropdown = ConfigDropdown or {}
            ConfigDropdown.Name = ConfigDropdown.Name or "Dropdown" -- Mai Lam
            ConfigDropdown.Options = ConfigDropdown.Options or {}
            ConfigDropdown.Default = ConfigDropdown.Default or ""
            ConfigDropdown.Callback = ConfigDropdown.Callback or function() end

            local Dropdown = Instance.new("Frame")
            local Title_6 = Instance.new("TextLabel")
            local UIPadding_11 = Instance.new("UIPadding")
            local Logo_4 = Instance.new("ImageLabel")
            local ListFrame = Instance.new("Frame")
            local List = Instance.new("Frame")
            local UIPadding_12 = Instance.new("UIPadding")
            local UIListLayout_3 = Instance.new("UIListLayout")
            local Click = Instance.new("TextButton")
            local DropFunc = {}

            if Cc == 'Left' then
                Choice = Left
            elseif Cc == "Right" then
                Choice = Right
            end

            Dropdown.Name = "Dropdown"
            Dropdown.Parent = Choice
            Dropdown.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Dropdown.BackgroundTransparency = 1.000
            Dropdown.BorderColor3 = Color3.fromRGB(0, 0, 0)
            Dropdown.BorderSizePixel = 0
            Dropdown.ClipsDescendants = true
            Dropdown.Position = UDim2.new(0, 0, 0.407792211, 0)
            Dropdown.Size = UDim2.new(1, 0, 0, 20)

            Click.Parent = Dropdown
            Click.Size = UDim2.new(1, 0, 0, 20)
            Click.Position = UDim2.new(0, 0, 0 ,0)
            Click.BackgroundTransparency = 1.000
            Click.Text = ""

            Title_6.Name = "Title"
            Title_6.Parent = Dropdown
            Title_6.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Title_6.BackgroundTransparency = 1.000
            Title_6.BorderColor3 = Color3.fromRGB(0, 0, 0)
            Title_6.BorderSizePixel = 0
            Title_6.Size = UDim2.new(1, 0, 0, 20)
            Title_6.Font = Enum.Font.GothamBold
            Title_6.Text = ConfigDropdown.Name .. " : " .. ConfigDropdown.Default
            Title_6.TextColor3 = Color3.fromRGB(200, 200, 200)
            Title_6.TextSize = 13.000
            Title_6.TextXAlignment = Enum.TextXAlignment.Left

            UIPadding_11.Parent = Title_6
            UIPadding_11.PaddingLeft = UDim.new(0, 12)

            Logo_4.Name = "Logo"
            Logo_4.Parent = Dropdown
            Logo_4.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Logo_4.BackgroundTransparency = 1.000
            Logo_4.BorderColor3 = Color3.fromRGB(0, 0, 0)
            Logo_4.BorderSizePixel = 0
            Logo_4.Rotation = 180.000
            Logo_4.Position = UDim2.new(1, -20, 0, 3)
            Logo_4.Size = UDim2.new(0, 15, 0, 15)
            Logo_4.Image = "http://www.roblox.com/asset/?id=90231306548911"

            ListFrame.Name = "ListFrame"
            ListFrame.Parent = Dropdown
            ListFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            ListFrame.BackgroundTransparency = 1.000
            ListFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
            ListFrame.BorderSizePixel = 0
            ListFrame.Position = UDim2.new(0, 0, 0, 22)
            ListFrame.Size = UDim2.new(1, 0, 0, 89)

            List.Name = "List"
            List.Parent = ListFrame
            List.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            List.BackgroundTransparency = 1.000
            List.BorderColor3 = Color3.fromRGB(0, 0, 0)
            List.BorderSizePixel = 0
            List.Size = UDim2.new(1, 0, 1, 0)

            UIPadding_12.Parent = List
            UIPadding_12.PaddingBottom = UDim.new(0, 12)
            UIPadding_12.PaddingLeft = UDim.new(0, 12)
            UIPadding_12.PaddingRight = UDim.new(0, 12)
            UIPadding_12.PaddingTop = UDim.new(0, 12)

            UIListLayout_3.Parent = List
            UIListLayout_3.SortOrder = Enum.SortOrder.LayoutOrder
            UIListLayout_3.Padding = UDim.new(0, 5)

            Click.Activated:Connect(function()
                if Dropdown.Size.Y.Offset <= 20 then
                    Dropdown:TweenSize(UDim2.new(1, 0, 0, 141),"Out","Quad",0.3,true)
                    TweenService:Create(
                        Logo_4,
                        TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut),
                        {Rotation = 180.000}
                    ):Play()
                else
                    Dropdown:TweenSize(UDim2.new(1, 0, 0, 20),"Out","Quad",0.3,true)
                    TweenService:Create(
                        Logo_4,
                        TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut),
                        {Rotation = 0}
                    ):Play()
                end
            end)

            function DropFunc:Add(Value)
                for _, v in next, Value do
                    local Options = Instance.new("Frame")
                    local UICorner_21 = Instance.new("UICorner")
                    local Title_7 = Instance.new("TextLabel")
                    local Click_8 = Instance.new("TextButton")

                    Options.Name = "Options"
                    Options.Parent = List
                    Options.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    Options.BackgroundTransparency = 1.000
                    Options.BorderColor3 = Color3.fromRGB(0, 0, 0)
                    Options.BorderSizePixel = 0
                    Options.Size = UDim2.new(1, 0, 0, 15)

                    UICorner_21.CornerRadius = UDim.new(0, 4)
                    UICorner_21.Parent = Options

                    Title_7.Name = "Title"
                    Title_7.Parent = Options
                    Title_7.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    Title_7.BackgroundTransparency = 1.000
                    Title_7.BorderColor3 = Color3.fromRGB(0, 0, 0)
                    Title_7.BorderSizePixel = 0
                    Title_7.Size = UDim2.new(1, 0, 1, 0)
                    Title_7.Font = Enum.Font.GothamBold
                    Title_7.Text = tostring(v)
                    Title_7.TextColor3 = Color3.fromRGB(255, 255, 255)
                    Title_7.TextSize = 13.000

                    Click_8.Name = "Click"
                    Click_8.Parent = Options
                    Click_8.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    Click_8.BackgroundTransparency = 1.000
                    Click_8.BorderColor3 = Color3.fromRGB(0, 0, 0)
                    Click_8.BorderSizePixel = 0
                    Click_8.Size = UDim2.new(1, 0, 1, 0)
                    Click_8.Font = Enum.Font.SourceSans
                    Click_8.Text = ""
                    Click_8.TextColor3 = Color3.fromRGB(0, 0, 0)
                    Click_8.TextSize = 14.000

                    Click_8.MouseButton1Click:Connect(function()
                        for r, v in next, List:GetChildren() do
                            if v.Name == "Options" then
                                v.BackgroundTransparency = 1.000
                            end
                        end
                        for r, v in next, List:GetChildren() do
                            if v.Name == "Options" then
                                v.Title.TextColor3 = Color3.fromRGB(144, 144, 144)
                            end
                        end
                        Title_7.TextColor3 = Color3.fromRGB(255, 255, 255)
                        Options.BackgroundTransparency = 0.930
                        Title_6.Text = ConfigDropdown.Name .. " : " ..  Title_7.Text
                        ConfigDropdown.Callback(Title_7.Text)
                    end)
                end
            end

            function DropFunc:Set(acc)
                for i, v in pairs(List:GetChildren()) do
                    if v.Name == "Options" then
                        if v.Title.Text == acc then
                            Title_6.Text = ConfigDropdown.Name .. " : " .. v.Title.Text
                            ConfigDropdown.Callback(v.Title.Text)
                        end
                    end
                end
            end

            function DropFunc:Refresh(Options)
                for i, v in pairs(List:GetChildren()) do
                    if v.Name == "Options" then
                        v:Destroy()
                    end
                end
                DropFunc:Add(Options)
                Title_6.Text = ConfigDropdown.Name .. " : "
            end

            DropFunc:Refresh(ConfigDropdown.Options)
            if ConfigDropdown.Default ~= "" then
                DropFunc:Set(ConfigDropdown.Default)
            end
			ConfigDropdown.Callback(ConfigDropdown.Default)
        end
        function Features:AddTextbox(Cc, ConfigText)
            ConfigText = ConfigText or {}
            ConfigText.Name = ConfigText.Name or "TextBox"
            ConfigText.PlaceholderText = ConfigText.PlaceholderText or "..."
            ConfigText.Default = ConfigText.Default or ""
            ConfigText.Callback = ConfigText.Callback or function() end

            local TextBox = Instance.new("Frame")
            local Title_9 = Instance.new("TextLabel")
            local UIPadding_14 = Instance.new("UIPadding")
            local Real_2 = Instance.new("TextBox")
            local UICorner_24 = Instance.new("UICorner")

            if Cc == 'Left' then
                Choice = Left
            elseif Cc == "Right" then
                Choice = Right
            end

            TextBox.Name = "TextBox"
            TextBox.Parent = Choice
            TextBox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            TextBox.BackgroundTransparency = 1.000
            TextBox.BorderColor3 = Color3.fromRGB(0, 0, 0)
            TextBox.BorderSizePixel = 0
            TextBox.Size = UDim2.new(1, 0, 0, 25)

            Title_9.Name = "Title"
            Title_9.Parent = TextBox
            Title_9.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Title_9.BackgroundTransparency = 1.000
            Title_9.BorderColor3 = Color3.fromRGB(0, 0, 0)
            Title_9.BorderSizePixel = 0
            Title_9.Size = UDim2.new(1, 0, 1, 0)
            Title_9.Font = Enum.Font.GothamBold
            Title_9.Text = ConfigText.Name
            Title_9.TextColor3 = Color3.fromRGB(200, 200, 200)
            Title_9.TextSize = 13.000
            Title_9.TextXAlignment = Enum.TextXAlignment.Left

            UIPadding_14.Parent = Title_9
            UIPadding_14.PaddingLeft = UDim.new(0, 12)

            Real_2.Name = "Real"
            Real_2.Parent = TextBox
            Real_2.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
            Real_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
            Real_2.BorderSizePixel = 0
            Real_2.Position = UDim2.new(1, -60, 0, 2)
            Real_2.Size = UDim2.new(0, 50, 0, 20)
            Real_2.Font = Enum.Font.GothamBold
            Real_2.PlaceholderText = ConfigText.PlaceholderText
            Real_2.Text = ConfigText.Default
            Real_2.TextColor3 = Color3.fromRGB(255, 255, 255)
            Real_2.TextSize = 13.000
            Real_2.ClipsDescendants = true

            UICorner_24.CornerRadius = UDim.new(0, 4)
            UICorner_24.Parent = Real_2

            Real_2.FocusLost:Connect(function()
				ConfigText.Callback(Real_2.Text)
			end)
        end
        function Features:AddLabel(Cc, ConfigLabel)
            ConfigLabel = ConfigLabel or {}
            ConfigLabel.Name = ConfigLabel.Name or "Label"
            
            local Label = Instance.new("Frame")
            local Label_2 = Instance.new("TextLabel")
            local UIPadding_15 = Instance.new("UIPadding")
            local UICorner_26 = Instance.new("UICorner")
            local LabelFunc = {}

            if Cc == 'Left' then
                Choice = Left
            elseif Cc == "Right" then
                Choice = Right
            end

            Label.Name = "Label"
            Label.Parent = Choice
            Label.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Label.BackgroundTransparency = 1.000
            Label.BorderColor3 = Color3.fromRGB(0, 0, 0)
            Label.BorderSizePixel = 0
            Label.Size = UDim2.new(1, 0, 0, 32)

            Label_2.Name = "Label"
            Label_2.Parent = Label
            Label_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Label_2.BackgroundTransparency = 1.000
            Label_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
            Label_2.BorderSizePixel = 0
            Label_2.Size = UDim2.new(1, 0, 1, 0)
            Label_2.Font = Enum.Font.GothamBold
            Label_2.Text = ConfigLabel.Name
            Label_2.TextColor3 = Color3.fromRGB(200, 200, 200)
            Label_2.TextSize = 13.000
            Label_2.TextWrapped = true
            Label_2.TextXAlignment = Enum.TextXAlignment.Left

            UIPadding_15.Parent = Label_2
            UIPadding_15.PaddingLeft = UDim.new(0, 12)

            function LabelFunc:Set(ValueText)
                Label_2.Text = ValueText
            end

            return LabelFunc
        end
        return Features
    end
    return Tabcre
end
return Library