return function()
	local Cmdr = Instance.new("ScreenGui")
	Cmdr.DisplayOrder = 1000
	Cmdr.Name = "Cmdr"
	Cmdr.ResetOnSpawn = false
	Cmdr.AutoLocalize = false

	local Frame = Instance.new("ScrollingFrame")
	Frame.BackgroundColor3 = Color3.fromRGB(10, 10, 18)
	Frame.BackgroundTransparency = 0.18
	Frame.BorderSizePixel = 0
	Frame.CanvasSize = UDim2.new(0, 0, 0, 0)
	Frame.Name = "Frame"
	Frame.Position = UDim2.new(0.025, 0, 0, 20)
	Frame.ScrollBarThickness = 4
	Frame.ScrollBarImageColor3 = Color3.fromRGB(100, 100, 140)
	Frame.ScrollingDirection = Enum.ScrollingDirection.Y
	Frame.Selectable = false
	Frame.Size = UDim2.new(0.95, 0, 0, 0)
	Frame.Visible = false
	Frame.AutomaticCanvasSize = Enum.AutomaticSize.Y
	Frame.Parent = Cmdr

	local FrameCorner = Instance.new("UICorner")
	FrameCorner.CornerRadius = UDim.new(0, 8)
	FrameCorner.Parent = Frame

	local FrameStroke = Instance.new("UIStroke")
	FrameStroke.Color = Color3.fromRGB(70, 70, 110)
	FrameStroke.Thickness = 1.2
	FrameStroke.Transparency = 0.4
	FrameStroke.Parent = Frame

	local Autocomplete = Instance.new("ScrollingFrame")
	Autocomplete.BackgroundColor3 = Color3.fromRGB(18, 18, 30)
	Autocomplete.BackgroundTransparency = 0.1
	Autocomplete.BorderSizePixel = 0
	Autocomplete.CanvasSize = UDim2.new(0, 0, 0, 0)
	Autocomplete.Name = "Autocomplete"
	Autocomplete.Position = UDim2.new(0, 167, 0, 75)
	Autocomplete.ScrollBarThickness = 4
	Autocomplete.ScrollBarImageColor3 = Color3.fromRGB(100, 100, 140)
	Autocomplete.ScrollingDirection = Enum.ScrollingDirection.Y
	Autocomplete.Selectable = false
	Autocomplete.Size = UDim2.new(0, 220, 0, 220)
	Autocomplete.Visible = false
	Autocomplete.AutomaticCanvasSize = Enum.AutomaticSize.Y
	Autocomplete.Parent = Cmdr

	local AutocompleteCorner = Instance.new("UICorner")
	AutocompleteCorner.CornerRadius = UDim.new(0, 8)
	AutocompleteCorner.Parent = Autocomplete

	local AutocompleteStroke = Instance.new("UIStroke")
	AutocompleteStroke.Color = Color3.fromRGB(80, 80, 140)
	AutocompleteStroke.Thickness = 1.2
	AutocompleteStroke.Transparency = 0.3
	AutocompleteStroke.Parent = Autocomplete

	local UIListLayout = Instance.new("UIListLayout")
	UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
	UIListLayout.Parent = Frame

	local Line = Instance.new("TextBox")
	Line.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Line.BackgroundTransparency = 1
	Line.FontFace = Font.new("rbxasset://fonts/families/ComicNeueAngular.json")
	Line.Name = "Line"
	Line.Size = UDim2.new(1, 0, 0, 20)
	Line.AutomaticSize = Enum.AutomaticSize.Y
	Line.TextColor3 = Color3.fromRGB(220, 220, 235)
	Line.TextSize = 14
	Line.TextXAlignment = Enum.TextXAlignment.Left
	Line.TextEditable = false
	Line.ClearTextOnFocus = false
	Line.Parent = Frame

	local UIPadding = Instance.new("UIPadding")
	UIPadding.PaddingBottom = UDim.new(0, 10)
	UIPadding.PaddingLeft = UDim.new(0, 12)
	UIPadding.PaddingRight = UDim.new(0, 12)
	UIPadding.PaddingTop = UDim.new(0, 10)
	UIPadding.Parent = Frame

	local Entry = Instance.new("Frame")
	Entry.BackgroundColor3 = Color3.fromRGB(22, 22, 38)
	Entry.BackgroundTransparency = 0.2
	Entry.BorderSizePixel = 0
	Entry.LayoutOrder = 999999999
	Entry.Name = "Entry"
	Entry.Size = UDim2.new(1, 0, 0, 26)
	Entry.Parent = Frame

	local EntryCorner = Instance.new("UICorner")
	EntryCorner.CornerRadius = UDim.new(0, 5)
	EntryCorner.Parent = Entry

	local EntryStroke = Instance.new("UIStroke")
	EntryStroke.Color = Color3.fromRGB(90, 90, 150)
	EntryStroke.Thickness = 1
	EntryStroke.Transparency = 0.5
	EntryStroke.Parent = Entry

	local UIListLayout2 = Instance.new("UIListLayout")
	UIListLayout2.SortOrder = Enum.SortOrder.LayoutOrder
	UIListLayout2.Parent = Autocomplete

	local Title = Instance.new("Frame")
	Title.BackgroundColor3 = Color3.fromRGB(30, 30, 55)
	Title.BackgroundTransparency = 0.1
	Title.BorderSizePixel = 0
	Title.LayoutOrder = -2
	Title.Name = "Title"
	Title.Size = UDim2.new(1, 0, 0, 40)
	Title.Parent = Autocomplete

	local Description = Instance.new("Frame")
	Description.BackgroundColor3 = Color3.fromRGB(22, 22, 42)
	Description.BackgroundTransparency = 0.1
	Description.BorderSizePixel = 0
	Description.LayoutOrder = -1
	Description.Name = "Description"
	Description.Size = UDim2.new(1, 0, 0, 20)
	Description.Parent = Autocomplete

	local TextButton = Instance.new("TextButton")
	TextButton.BackgroundColor3 = Color3.fromRGB(30, 30, 52)
	TextButton.BackgroundTransparency = 0.2
	TextButton.BorderSizePixel = 0
	TextButton.Font = Enum.Font.Code
	TextButton.Size = UDim2.new(1, 0, 0, 30)
	TextButton.Text = ""
	TextButton.TextColor3 = Color3.fromRGB(220, 220, 235)
	TextButton.TextSize = 14
	TextButton.TextXAlignment = Enum.TextXAlignment.Left
	TextButton.Parent = Autocomplete

	local UIListLayout3 = Instance.new("UIListLayout")
	UIListLayout3.FillDirection = Enum.FillDirection.Horizontal
	UIListLayout3.SortOrder = Enum.SortOrder.LayoutOrder
	UIListLayout3.Padding = UDim.new(0, 7)
	UIListLayout3.Parent = Entry

	local EntryPadding = Instance.new("UIPadding")
	EntryPadding.PaddingLeft = UDim.new(0, 8)
	EntryPadding.PaddingRight = UDim.new(0, 8)
	EntryPadding.Parent = Entry

	local TextBox = Instance.new("TextBox")
	TextBox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	TextBox.BackgroundTransparency = 1
	TextBox.ClearTextOnFocus = false
	TextBox.FontFace = Font.new("rbxasset://fonts/families/ComicNeueAngular.json")
	TextBox.LayoutOrder = 999999999
	TextBox.Position = UDim2.new(0, 140, 0, 0)
	TextBox.Size = UDim2.new(1, 0, 0, 26)
	TextBox.Text = "x"
	TextBox.TextColor3 = Color3.fromRGB(230, 230, 245)
	TextBox.TextSize = 14
	TextBox.TextXAlignment = Enum.TextXAlignment.Left
	TextBox.Selectable = false
	TextBox.Parent = Entry

	local TextLabel = Instance.new("TextLabel")
	TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	TextLabel.BackgroundTransparency = 1
	TextLabel.FontFace = Font.new("rbxasset://fonts/families/ComicNeueAngular.json", Enum.FontWeight.Bold)
	TextLabel.Size = UDim2.new(0, 0, 0, 26)
	TextLabel.AutomaticSize = Enum.AutomaticSize.X
	TextLabel.Text = ""
	TextLabel.TextColor3 = Color3.fromRGB(255, 0, 0)
	TextLabel.TextSize = 15
	TextLabel.TextXAlignment = Enum.TextXAlignment.Left
	TextLabel.Parent = Entry

	local TextStroke = Instance.new("UIStroke")
	TextStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Contextual
	TextStroke.Color = Color3.fromRGB(0, 0, 0)
	TextStroke.Thickness = 1.5
	TextStroke.Parent = TextLabel

	local Field = Instance.new("TextLabel")
	Field.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Field.BackgroundTransparency = 1
	Field.Font = Enum.Font.SourceSansBold
	Field.Name = "Field"
	Field.Size = UDim2.new(0, 37, 1, 0)
	Field.Text = "from"
	Field.TextColor3 = Color3.fromRGB(200, 200, 240)
	Field.TextSize = 20
	Field.TextXAlignment = Enum.TextXAlignment.Left
	Field.Parent = Title

	local UIPadding2 = Instance.new("UIPadding")
	UIPadding2.PaddingLeft = UDim.new(0, 10)
	UIPadding2.Parent = Title

	local Label = Instance.new("TextLabel")
	Label.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Label.BackgroundTransparency = 1
	Label.Font = Enum.Font.SourceSansLight
	Label.Name = "Label"
	Label.Size = UDim2.new(1, 0, 1, 0)
	Label.Text = ""
	Label.TextColor3 = Color3.fromRGB(200, 200, 220)
	Label.TextSize = 15
	Label.TextWrapped = true
	Label.TextXAlignment = Enum.TextXAlignment.Left
	Label.TextYAlignment = Enum.TextYAlignment.Top
	Label.Parent = Description

	local UIPadding3 = Instance.new("UIPadding")
	UIPadding3.PaddingBottom = UDim.new(0, 8)
	UIPadding3.PaddingLeft = UDim.new(0, 10)
	UIPadding3.PaddingRight = UDim.new(0, 10)
	UIPadding3.Parent = Description

	local Typed = Instance.new("TextLabel")
	Typed.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Typed.BackgroundTransparency = 1
	Typed.FontFace = Font.new("rbxasset://fonts/families/ComicNeueAngular.json")
	Typed.Name = "Typed"
	Typed.Size = UDim2.new(1, 0, 1, 0)
	Typed.Text = ""
	Typed.TextColor3 = Color3.fromRGB(140, 210, 255)
	Typed.TextSize = 14
	Typed.TextXAlignment = Enum.TextXAlignment.Left
	Typed.Parent = TextButton

	local UIPadding4 = Instance.new("UIPadding")
	UIPadding4.PaddingLeft = UDim.new(0, 10)
	UIPadding4.Parent = TextButton

	local Suggest = Instance.new("TextLabel")
	Suggest.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Suggest.BackgroundTransparency = 1
	Suggest.Font = Enum.Font.Code
	Suggest.Name = "Suggest"
	Suggest.Size = UDim2.new(1, 0, 1, 0)
	Suggest.Text = ""
	Suggest.TextColor3 = Color3.fromRGB(210, 210, 230)
	Suggest.TextSize = 14
	Suggest.TextXAlignment = Enum.TextXAlignment.Left
	Suggest.Parent = TextButton

	local Type = Instance.new("TextLabel")
	Type.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Type.BackgroundTransparency = 1
	Type.BorderColor3 = Color3.fromRGB(255, 153, 153)
	Type.Font = Enum.Font.SourceSans
	Type.Name = "Type"
	Type.Position = UDim2.new(1, 0, 0, 0)
	Type.Size = UDim2.new(0, 0, 1, 0)
	Type.Text = ""
	Type.TextColor3 = Color3.fromRGB(160, 200, 255)
	Type.TextSize = 15
	Type.TextXAlignment = Enum.TextXAlignment.Left
	Type.Parent = Field

	Cmdr.Parent = game:GetService("StarterGui")
	return Cmdr
end
