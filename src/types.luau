export type ScreenGui = {
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

export type Frame = {
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
	Connect: (...any) -> any,
}

export type Theme = { [any]: any } -- TODO

--// Components
export type BaseComponent = {
	Type: string,
	Theme: Theme,
	Structures: { [string]: Instance | { any } },
}

-- App
export type AppProperties = ScreenGui & {
	Theme: Theme?,
}

export type App = AppProperties & Components

-- Window
export type WindowProperties = Frame & {
	Searching: boolean?,
	Draggable: boolean?,
	Resizable: boolean?,
	Title: string?,
	Subtitle: string?,
	Maximized: boolean?,
	Minimized: boolean?,

	Dropshadow: boolean?,
	UIBlur: boolean?,
}

export type Window = BaseComponent & Components & WindowProperties

-- Section
export type SectionProperties = Frame & {
	Label: string?,
	Disclosure: boolean?,
	Expanded: boolean?,
}

export type Section = BaseComponent & Components & SectionProperties

-- Tab
export type TabProperties = Frame & {
	Label: string?,
	Icon: string?,
	Indentation: number?,
	Selected: boolean?,
}

export type Tab = BaseComponent & Components & TabProperties

-- Form
export type FormProperties = Frame
export type Form = BaseComponent & Components & FormProperties

-- Row
export type RowProperties = Frame & {
	SearchIndex: string?,
	Title: string?,
	Subtitle: string?,
}
export type Row = BaseComponent & Components & RowProperties

-- TitleStack
export type TitleStackProperties = Frame & {
	Title: string?,
	Subtitle: string?,
}
export type TitleStack = BaseComponent & Components & TitleStackProperties

-- Export
export type Components = {
	Window: (self: any, properties: WindowProperties?) -> Window,
	Section: (self: any, properties: SectionProperties?) -> Tab,
	Tab: (self: any, properties: TabProperties?) -> Tab,
	Form: (self: any, properties: FormProperties?) -> Form,
	Row: (self: any, properties: RowProperties?) -> Row,
	TitleStack: (self: any, properties: TitleStackProperties?) -> TitleStack,
}

return 1
