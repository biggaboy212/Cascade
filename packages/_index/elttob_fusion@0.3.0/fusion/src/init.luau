--!strict
--!nolint LocalUnused
--!nolint LocalShadow
local task = nil -- Disable usage of Roblox's task scheduler
--[[
	The entry point for the Fusion library.
]]

local Types = require("@self/Types")
local External = require("@self/External")

type Fusion = Types.Fusion

export type Animatable = Types.Animatable
export type UsedAs<T> = Types.UsedAs<T>
export type Child = Types.Child
export type Computed<T> = Types.Computed<T>
export type Contextual<T> = Types.Contextual<T>
export type GraphObject = Types.GraphObject
export type For<KO, VO> = Types.For<KO, VO>
export type Observer = Types.Observer
export type PropertyTable = Types.PropertyTable
export type Scope<Constructors = Fusion> = Types.Scope<Constructors>
export type ScopedObject = Types.ScopedObject
export type SpecialKey = Types.SpecialKey
export type Spring<T> = Types.Spring<T>
export type StateObject<T> = Types.StateObject<T>
export type Task = Types.Task
export type Tween<T> = Types.Tween<T>
export type Use = Types.Use
export type Value<T, S = T> = Types.Value<T, S>
export type Version = Types.Version

-- Down the line, this will be conditional based on whether Fusion is being
-- compiled for Roblox.
do
	local RobloxExternal = require("@self/RobloxExternal")
	External.setExternalProvider(RobloxExternal)
end

local Fusion: Fusion = table.freeze {
	-- General
	version = {major = 0, minor = 3, isRelease = true},
	Contextual = require("@self/Utility/Contextual"),
	Safe = require("@self/Utility/Safe"),

	-- Memory
	cleanup = require("@self/Memory/legacyCleanup"),
	deriveScope = require("@self/Memory/deriveScope"),
	doCleanup = require("@self/Memory/doCleanup"),
	innerScope = require("@self/Memory/innerScope"),
	scoped = require("@self/Memory/scoped"),
	
	-- Graph
	Observer = require("@self/Graph/Observer"),

	-- State
	Computed = require("@self/State/Computed"),
	ForKeys = require("@self/State/ForKeys") :: Types.ForKeysConstructor,
	ForPairs = require("@self/State/ForPairs") :: Types.ForPairsConstructor,
	ForValues = require("@self/State/ForValues") :: Types.ForValuesConstructor,
	peek = require("@self/State/peek"),
	Value = require("@self/State/Value"),

	-- Roblox API
	Attribute = require("@self/Instances/Attribute"),
	AttributeChange = require("@self/Instances/AttributeChange"),
	AttributeOut = require("@self/Instances/AttributeOut"),
	Child = require("@self/Instances/Child"),
	Children = require("@self/Instances/Children"),
	Hydrate = require("@self/Instances/Hydrate"),
	New = require("@self/Instances/New"),
	OnChange = require("@self/Instances/OnChange"),
	OnEvent = require("@self/Instances/OnEvent"),
	Out = require("@self/Instances/Out"),

	-- Animation
	Tween = require("@self/Animation/Tween"),
	Spring = require("@self/Animation/Spring"),
} :: Fusion

return Fusion
