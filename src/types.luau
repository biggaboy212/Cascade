type ScreenGui = {
	-- Instance
	Name: string?,
	Parent: Instance?,
	Archivable: boolean?,
	ClassName: string?,

	-- GuiBase2d
	AutoLocalize: boolean?,
	RootLocalizationTable: LocalizationTable?,
	SelectionBehaviorDown: Enum.SelectionBehavior?,
	SelectionBehaviorLeft: Enum.SelectionBehavior?,
	SelectionBehaviorRight: Enum.SelectionBehavior?,
	SelectionBehaviorUp: Enum.SelectionBehavior?,
	SelectionGroup: boolean?,

	-- LayerCollector
	Enabled: boolean?,
	ResetOnSpawn: boolean?,
	ZIndexBehavior: Enum.ZIndexBehavior?,

	-- ScreenGui
	DisplayOrder: number?,
	IgnoreGuiInset: boolean?,
	ScreenInsets: Enum.ScreenInsets?,
	ClipToDeviceSafeArea: boolean?,
	SafeAreaCompatibility: Enum.SafeAreaCompatibility?,
}

type Frame = {
	-- Instance
	Name: string?,
	Parent: Instance?,
	Archivable: boolean?,
	ClassName: string?,
	
	-- GuiObject
	AnchorPoint: Vector2?,
	BackgroundColor3: Color3?,
	BackgroundTransparency: number?,
	BorderColor3: Color3?,
	BorderMode: Enum.BorderMode?,
	BorderSizePixel: number?,
	ClipsDescendants: boolean?,
	LayoutOrder: number?,
	Position: UDim2?,
	Rotation: number?,
	Selectable: boolean?,
	SelectionImageObject: GuiObject?,
	Size: UDim2?,
	SizeConstraint: Enum.SizeConstraint?,
	Visible: boolean?,
	ZIndex: number?,
	AutomaticSize: Enum.AutomaticSize?,

	-- Frame
	Style: Enum.FrameStyle?,
}

export type ValueState = {
	Value: any,
	Connect: (...any) -> any
}

export type Theme = {[any]: any} -- TODO

--// Components
-- App
export type AppProperties = ScreenGui & {
	Theme: Theme?,
}

export type App = AppProperties & Components

-- Window
export type WindowProperties = Frame & {
	Draggable: boolean?,
	Resizable: boolean?,
	Title: string?,
	Description: string?,

	Dropshadow: boolean?,
	UIBlur: boolean?,
}

export type Window = Components & WindowProperties

-- Section
export type SectionProperties = Frame & {
	Name: string?,
	Disclosure: boolean?,
	Expanded: boolean?,
}

export type Section = Components & SectionProperties

-- Tab
export type TabProperties = Frame & {
	Name: string?,
	Icon: string?,
	Indentation: number?,
	Selected: boolean?
}

export type Tab = Components & TabProperties

-- Export
export type Components = {
	Window: (self: any, properties: WindowProperties?) -> Window,
	Section: (self: any, properties: SectionProperties?) -> Tab,
	Tab: (self: any, properties: TabProperties?) -> Tab,
}

return 1
