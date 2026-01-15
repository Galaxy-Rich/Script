-- Memasukkan GUI ke PlayerGui
local Player = game.Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

-- Membuat ScreenGui Utama
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "ZorVexGui_Final"
ScreenGui.Parent = PlayerGui
ScreenGui.ResetOnSpawn = false

-- FOLDER UTAMA (Disesuaikan agar Center di semua device)
local MainContainer = Instance.new("Frame")
MainContainer.Name = "MainContainer"
MainContainer.Size = UDim2.new(0, 310, 0, 270)
MainContainer.AnchorPoint = Vector2.new(0.5, 0.5) 
MainContainer.Position = UDim2.new(0.5, 0, 0.5, 0) 
MainContainer.BackgroundTransparency = 1 
MainContainer.Parent = ScreenGui

-- 1. Tombol ATAS (Cancel Pakai Script) - Transparansi 0.2
local CancelButton = Instance.new("TextButton")
CancelButton.Name = "CancelButton"
CancelButton.Size = UDim2.new(1, 0, 0, 60)
CancelButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
CancelButton.BackgroundTransparency = 0.2
CancelButton.Text = "Cancel Pakai Script"
CancelButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CancelButton.Font = Enum.Font.SourceSansBold
CancelButton.TextSize = 25
CancelButton.Parent = MainContainer

local UICornerCancel = Instance.new("UICorner")
UICornerCancel.CornerRadius = UDim.new(0, 10)
UICornerCancel.Parent = CancelButton

-- 2. Background PUTIH (Container Bawah) - Transparansi 0.45 + Outline Hitam
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(1, 0, 0, 185)
MainFrame.Position = UDim2.new(0, 0, 0, 70) 
MainFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
MainFrame.BackgroundTransparency = 0.25
MainFrame.Parent = MainContainer

local UICornerFrame = Instance.new("UICorner")
UICornerFrame.CornerRadius = UDim.new(0, 15)
UICornerFrame.Parent = MainFrame

-- MENAMBAHKAN OUTLINE HITAM (UIStroke)
local UIStroke = Instance.new("UIStroke")
UIStroke.Color = Color3.fromRGB(0, 0, 0) -- Warna Hitam
UIStroke.Thickness = 2 -- Ketebalan garis
UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
UIStroke.Parent = MainFrame

local UIPadding = Instance.new("UIPadding")
UIPadding.PaddingTop = UDim.new(0, 15)
UIPadding.Parent = MainFrame

local UIListLayout = Instance.new("UIListLayout")
UIListLayout.Parent = MainFrame
UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
UIListLayout.Padding = UDim.new(0, 10)
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder

-- Fungsi untuk membuat tombol hitam - Transparansi 0.2
local function CreateInnerButton(name, text, sizeX, sizeY)
	local btn = Instance.new("TextButton")
	btn.Name = name
	btn.Size = UDim2.new(sizeX, 0, 0, sizeY)
	btn.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	btn.BackgroundTransparency = 0.2
	btn.Text = text
	btn.TextColor3 = Color3.fromRGB(255, 255, 255)
	btn.Font = Enum.Font.SourceSansBold
	btn.TextSize = 22
	btn.Parent = MainFrame
	
	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(0, 8)
	corner.Parent = btn
	
	return btn
end

local VipButton = CreateInnerButton("VipButton", "Vip", 0.5, 40)
local MemberButton = CreateInnerButton("MemberButton", "Member", 0.5, 40)
local MintaIzinButton = CreateInnerButton("MintaIzinButton", "Minta Izin ZorVex", 0.85, 50)

----------------------------------------------------------------
-- FUNGSI DRAGGING
----------------------------------------------------------------
local UserInputService = game:GetService("UserInputService")
local dragging, dragInput, dragStart, startPos

local function update(input)
	local delta = input.Position - dragStart
	MainContainer.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end

MainContainer.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		dragging = true
		dragStart = input.Position
		startPos = MainContainer.Position
		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then dragging = false end
		end)
	end
end)

MainContainer.InputChanged:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
		dragInput = input
	end
end)

UserInputService.InputChanged:Connect(function(input)
	if input == dragInput and dragging then update(input) end
end)

----------------------------------------------------------------
-- LOGIKA TOMBOL (UPDATE BARU)
----------------------------------------------------------------

-- Tombol Cancel
CancelButton.MouseButton1Click:Connect(function()
	ScreenGui:Destroy()
end)

-- Tombol VIP
VipButton.MouseButton1Click:Connect(function()
    ScreenGui.Enabled = false -- Menyembunyikan UI
    loadstring(game:HttpGet('https://raw.githubusercontent.com/Galaxy-Rich/Huang/refs/heads/main/ZorVex-VIP.lua'))()
end)

-- Tombol Member
MemberButton.MouseButton1Click:Connect(function()
    ScreenGui.Enabled = false -- Menyembunyikan UI
    loadstring(game:HttpGet('https://raw.githubusercontent.com/Galaxy-Rich/Huang/refs/heads/main/ZorVex-Member.lua'))()
end)

-- Tombol Minta Izin ZorVex
MintaIzinButton.MouseButton1Click:Connect(function()
    -- UI Tetap Ada
    loadstring(game:HttpGet('https://raw.githubusercontent.com/Galaxy-Rich/Huang/refs/heads/main/HWID'))()
end)
