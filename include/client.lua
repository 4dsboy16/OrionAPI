--[[
   ░▒▓██████▓▒░░▒▓███████▓▒░░▒▓█▓▒░░▒▓██████▓▒░░▒▓███████▓▒░  
  ░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░ 
  ░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░ 
  ░▒▓█▓▒░░▒▓█▓▒░▒▓███████▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░ 
  ░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░ 
  ░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░ 
   ░▒▓██████▓▒░░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓██████▓▒░░▒▓█▓▒░░▒▓█▓▒░ 
]]

getgenv().IS_ORION_LOADED = false

-- Shared for Vape V4 support and for other scripts support
getgenv().shared = shared

-- ENV

local defaultRequest = request

getgenv().request = function(options)
  assert(type(options) == "table", "invalid argument #1 to 'request' (table expected, got " .. type(options) .. ") ", 2)

  if options.Headers then
		options.Headers["User-Agent"] = "Orion/1.0"
	else
		options.Headers = {["User-Agent"] = "Orion/1.0"}
	end

  return defaultRequest(options)
end

getgenv().printidentity = function()
  return print("Current identity is 8")
end

getgenv().getrenv = function()
  return table.freeze({
    print = print, warn = warn, error = error, shared = shared, assert = assert, collectgarbage = collectgarbage, require = require,
	  select = select, tonumber = tonumber, tostring = tostring, type = type, xpcall = xpcall,
  	pairs = pairs, next = next, ipairs = ipairs, newproxy = newproxy, rawequal = rawequal, rawget = rawget,
  	rawset = rawset, rawlen = rawlen, gcinfo = gcinfo,
  	coroutine = {
  		create = coroutine.create, resume = coroutine.resume, running = coroutine.running,
  		status = coroutine.status, wrap = coroutine.wrap, yield = coroutine.yield,
  	},
  	bit32 = {
  		arshift = bit32.arshift, band = bit32.band, bnot = bit32.bnot, bor = bit32.bor, btest = bit32.btest,
  		extract = bit32.extract, lshift = bit32.lshift, replace = bit32.replace, rshift = bit32.rshift, xor = bit32.xor,
  	},
  	math = {
  		abs = math.abs, acos = math.acos, asin = math.asin, atan = math.atan, atan2 = math.atan2, ceil = math.ceil,
  		cos = math.cos, cosh = math.cosh, deg = math.deg, exp = math.exp, floor = math.floor, fmod = math.fmod,
  		frexp = math.frexp, ldexp = math.ldexp, log = math.log, log10 = math.log10, max = math.max, min = math.min,
  		modf = math.modf, pow = math.pow, rad = math.rad, random = math.random, randomseed = math.randomseed,
  		sin = math.sin, sinh = math.sinh, sqrt = math.sqrt, tan = math.tan, tanh = math.tanh
  	},
  	string = {
  		byte = string.byte, char = string.char, find = string.find, format = string.format, gmatch = string.gmatch,
  		gsub = string.gsub, len = string.len, lower = string.lower, match = string.match, pack = string.pack,
  		packsize = string.packsize, rep = string.rep, reverse = string.reverse, sub = string.sub,
  		unpack = string.unpack, upper = string.upper,
  	},
  	table = {
  		concat = table.concat, insert = table.insert, pack = table.pack, remove = table.remove, sort = table.sort,
  		unpack = table.unpack,
  	},
  	utf8 = {
  		char = utf8.char, charpattern = utf8.charpattern, codepoint = utf8.codepoint, codes = utf8.codes,
  		len = utf8.len, nfdnormalize = utf8.nfdnormalize, nfcnormalize = utf8.nfcnormalize,
  	},
  	os = {
  		clock = os.clock, date = os.date, difftime = os.difftime, time = os.time,
  	},
  	delay = delay, elapsedTime = elapsedTime, spawn = spawn, tick = tick, time = time, typeof = typeof,
  	UserSettings = UserSettings, version = version, wait = wait, _VERSION = _VERSION,
  	task = {
  		defer = task.defer, delay = task.delay, spawn = task.spawn, wait = task.wait,
  	},
  	debug = {
  		traceback = debug.traceback, profilebegin = debug.profilebegin, profileend = debug.profileend, info = debug.info 
  	},
  	game = game, workspace = workspace, Game = game, Workspace = workspace,
  	getmetatable = getmetatable, setmetatable = setmetatable
  })
end

getgenv().iswriteable = function(tbl)
  return not table.isfrozen(tbl)
end

-- Aliases
request = getgenv().request
getgenv().orion = {}
getgenv().orion.clonefunction = newcclosure(function(func)
    local newfunc = function(...)
        return func(...)
    end
    setfenv(newfunc, getfenv(func))
    return newfunc
end)

print("[ Orion ]: Loaded")

getgenv().IS_ORION_LOADED = true
