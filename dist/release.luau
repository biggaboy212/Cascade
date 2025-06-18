--!nolint
--!nocheck
--!optimize 2

--[[
    @author Proton-Utilities
    @name Cascade
    @description A LuaU UI library based on macOS
    @license MIT License

    This file was automatically generated with darklua, it is not intended for manual editing.
--]]

_P = {
    genDate = "2025-05-22T17:26:50.689157400+00:00",
    cfg = "Release",
    vers = "v2.0.6"
}

local a a={cache={},load=function(b)if not a.cache[b]then a.cache[b]={c=a[b]()}
end return a.cache[b].c end}do function a.a()local b=function(b,c)local d=
Instance.new(b)for e,f in pairs(c)do if d:IsA'Instance'and d[e]~=nil then local
g=typeof(d[e])if g==typeof(f)then d[e]=f else warn(string.format(
'Type mismatch for property %s: Expected %s but got %s',e,g,typeof(f)))end end
end if c.Parent then d.Parent=c.Parent end return d end function process(c,d,e)
local f=b(c,d)if e then for g,h in ipairs(e)do if typeof(h)=='Instance'then h.
Parent=f elseif typeof(h)=='table'then local i=process(h.className,h.properties,
h.children)i.Parent=f else warn(
"Invalid child type: expected 'Instance' or 'table', got "..typeof(h))end end
end return f end return process end function a.b()local b={}function b.Clone(c)
local d=typeof(c)if d=='function'and(clonefunc or clonefunction)then return(
clonefunc or clonefunction)(c),true end if d=='Instance'and(cloneref or
clonereference)then return(cloneref or clonereference)(c),true end if d~='table'
then return c,false end local function e(f,g)if g and g[f]then return g[f]end
local h,i=g or{},{}h[f]=i for j,k in next,f do i[e(j,h)]=e(k,h)end local j=(
getrawmetatable or getmetatable)(f)if j then(setrawmetatable or setmetatable)(i,
e(j,h))end return i end return e(c),true end b.ProtectGui=function(c)local d=b.
Clone(game)local e,f=pcall(function()c.Parent=gethui and gethui()or b.Clone(d:
GetService'CoreGui')end)return e and c or f end b.ProtectGui=newcclosure and
newcclosure(b.ProtectGui)or b.ProtectGui return b end end local b,c=a.load'a',a.
load'b'local d,e=c.ProtectGui,{}function e:Callback(f,...)assert(typeof(f)==
'function',debug.traceback(`Cascade:Callback expects type 'function' for Argument #1, got '{
typeof(f)}'`,2))task.spawn(function(...)local g,h=pcall(f,...)if not g then task
.defer(error,debug.traceback(h,2))end end,...)end e.UIContainer=d(b('ScreenGui',
{OnTopOfCoreBlur=true}))b('TextLabel',{Text='Hello, World!',AutomaticSize=Enum.
AutomaticSize.XY,Position=UDim2.fromScale(0.5,0.5),AnchorPoint=Vector2.new(0.5,
0.5),Parent=e.UIContainer})