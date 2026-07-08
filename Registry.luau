local RunService = game:GetService("RunService")

local Util = require(script.Parent.Util)

local Registry = {
	TypeMethods = Util.MakeDictionary({"Transform", "Validate", "Autocomplete", "Parse", "DisplayName", "Listable", "ValidateOnce", "Prefixes", "Default", "ArgumentOperatorAliases"});
	CommandMethods = Util.MakeDictionary({"Name", "Aliases", "AutoExec", "Description", "Args", "Run", "ClientRun", "Data", "Group"});
	CommandArgProps = Util.MakeDictionary({"Name", "Type", "Description", "Optional", "Default"});
	Types = {};
	TypeAliases = {};
	Commands = {};
	CommandsArray = {};
	Cmdr = nil;
	Hooks = {
		BeforeRun = {};
		AfterRun = {}
	};
	Stores = setmetatable({}, {
		__index = function(self, k)
			self[k] = {}
			return self[k]
		end
	});
	AutoExecBuffer = {}
}

function Registry:RegisterType(name, typeObject)
	if not name or typeof(name) ~= "string" then
		error("Invalid type name provided: nil")
	end

	if not name:find("^[%d%l]%w*$") then
		error(('Invalid type name provided: "%s", type names must be alphanumeric and start with a lower-case letter or a digit.'):format(name))
	end

	for key in pairs(typeObject) do
		if self.TypeMethods[key] == nil then
			error("Unknown key/method in type \"" .. name .. "\": " .. key)
		end
	end

	if self.Types[name] ~= nil then
		error(('Type "%s" has already been registered.'):format(name))
	end

	typeObject.Name = name
	typeObject.DisplayName = typeObject.DisplayName or name

	self.Types[name] = typeObject

	if typeObject.Prefixes then
		self:RegisterTypePrefix(name, typeObject.Prefixes)
	end
end

function Registry:RegisterTypePrefix(name, union)
	if not self.TypeAliases[name] then
		self.TypeAliases[name] = name
	end

	self.TypeAliases[name] = ("%s %s"):format(self.TypeAliases[name], union)
end

function Registry:RegisterTypeAlias(name, alias)
	assert(self.TypeAliases[name] == nil, ("Type alias %s already exists!"):format(alias))
	self.TypeAliases[name] = alias
end

function Registry:RegisterTypesIn(container)
	for _, object in pairs(container:GetChildren()) do
		if object:IsA("ModuleScript") then
			object.Parent = self.Cmdr.ReplicatedRoot.Types

			require(object)(self)
		else
			self:RegisterTypesIn(object)
		end
	end
end

Registry.RegisterHooksIn = Registry.RegisterTypesIn

local function CommandIsInGroupList(commandObject, groupDictionary)
	local group = commandObject.Group
	if group == nil then
		return false
	end
	if type(group) == "string" then
		return groupDictionary[group] == true
	end
	if type(group) == "table" then
		for _, g in ipairs(group) do
			if groupDictionary[g] == true then
				return true
			end
		end
	end
	return false
end

function Registry:RegisterCommandObject(commandObject, fromCmdr)
	for key in pairs(commandObject) do
		if self.CommandMethods[key] == nil then
			error("Unknown key/method in command " .. (commandObject.Name or "unknown command") .. ": " .. key)
		end
	end

	if commandObject.Group ~= nil then
		local groupType = type(commandObject.Group)
		if groupType ~= "string" and groupType ~= "table" then
			error(("Command %q: Group must be a string or a table of strings, got %s"):format(commandObject.Name or "unknown", groupType))
		end
		if groupType == "table" then
			for i, g in ipairs(commandObject.Group) do
				if type(g) ~= "string" then
					error(("Command %q: Group table entry #%d must be a string, got %s"):format(commandObject.Name or "unknown", i, type(g)))
				end
			end
		end
	end

	if commandObject.Args then
		for i, arg in pairs(commandObject.Args) do
			if type(arg) == "table" then
				for key in pairs(arg) do
					if self.CommandArgProps[key] == nil then
						error(('Unknown property in command "%s" argument #%d: %s'):format(commandObject.Name or "unknown", i, key))
					end
				end
			end
		end
	end

	if commandObject.AutoExec and RunService:IsClient() then
		table.insert(self.AutoExecBuffer, commandObject.AutoExec)
		self:FlushAutoExecBufferDeferred()
	end

	local oldCommand = self.Commands[commandObject.Name:lower()]
	if oldCommand and oldCommand.Aliases then
		for _, alias in pairs(oldCommand.Aliases) do
			self.Commands[alias:lower()] = nil
		end
	elseif not oldCommand then
		table.insert(self.CommandsArray, commandObject)
	end

	self.Commands[commandObject.Name:lower()] = commandObject

	if commandObject.Aliases then
		for _, alias in pairs(commandObject.Aliases) do
			self.Commands[alias:lower()] = commandObject
		end
	end
end

function Registry:RegisterCommand(commandScript, commandServerScript, filter)
	local commandObject = require(commandScript)
	assert(
		typeof(commandObject) == "table",
		`Invalid return value from command script "{commandScript.Name}" (CommandDefinition expected, got {typeof(commandObject)})`
	)

	if commandServerScript then
		assert(RunService:IsServer(), "The commandServerScript parameter is not valid for client usage.")
		commandObject.Run = require(commandServerScript)
	end

	if filter and not filter(commandObject) then
		return
	end

	self:RegisterCommandObject(commandObject)

	commandScript.Parent = self.Cmdr.ReplicatedRoot.Commands
end

function Registry:RegisterCommandsIn(container, filter)
	local skippedServerScripts = {}
	local usedServerScripts = {}

	for _, commandScript in pairs(container:GetChildren()) do
		if commandScript:IsA("ModuleScript") then
			if not commandScript.Name:find("Server") then
				local serverCommandScript = container:FindFirstChild(commandScript.Name .. "Server")

				if serverCommandScript then
					usedServerScripts[serverCommandScript] = true
				end

				self:RegisterCommand(commandScript, serverCommandScript, filter)
			else
				skippedServerScripts[commandScript] = true
			end
		else
			self:RegisterCommandsIn(commandScript, filter)
		end
	end

	for skippedScript in pairs(skippedServerScripts) do
		if not usedServerScripts[skippedScript] then
			warn("Command script " .. skippedScript.Name .. " was skipped because it has 'Server' in its name, and has no equivalent shared script.")
		end
	end
end

function Registry:RegisterDefaultCommands(arrayOrFunc)
	assert(RunService:IsServer(), "RegisterDefaultCommands cannot be called from the client.")

	local isArray = type(arrayOrFunc) == "table"
	local groupDictionary

	if isArray then
		groupDictionary = Util.MakeDictionary(arrayOrFunc)
	end

	self:RegisterCommandsIn(self.Cmdr.DefaultCommandsFolder, isArray and function(command)
		return CommandIsInGroupList(command, groupDictionary)
	end or arrayOrFunc)
end

function Registry:GetCommand(name)
	name = name or ""
	return self.Commands[name:lower()]
end

function Registry:GetCommands()
	return self.CommandsArray
end

function Registry:GetCommandNames()
	local commands = {}

	for _, command in pairs(self.CommandsArray) do
		table.insert(commands, command.Name)
	end

	return commands
end

Registry.GetCommandsAsStrings = Registry.GetCommandNames

function Registry:GetTypeNames()
	local typeNames = {}

	for typeName in pairs(self.Types) do
		table.insert(typeNames, typeName)
	end

	return typeNames
end

function Registry:GetType(name)
	return self.Types[name]
end

function Registry:GetTypeName(name)
	return self.TypeAliases[name] or name
end

function Registry:RegisterHook(hookName, callback, priority)
	if not self.Hooks[hookName] then
		error(("Invalid hook name: %q"):format(hookName), 2)
	end

	table.insert(self.Hooks[hookName], { callback = callback; priority = priority or 0; })
	table.sort(self.Hooks[hookName], function(a, b) return a.priority < b.priority end)
end

Registry.AddHook = Registry.RegisterHook

function Registry:GetStore(name)
	return self.Stores[name]
end

function Registry:FlushAutoExecBufferDeferred()
	if self.AutoExecFlushConnection then
		return
	end

	self.AutoExecFlushConnection = RunService.Heartbeat:Connect(function()
		self.AutoExecFlushConnection:Disconnect()
		self.AutoExecFlushConnection = nil
		self:FlushAutoExecBuffer()
	end)
end

function Registry:FlushAutoExecBuffer()
	for _, commandGroup in ipairs(self.AutoExecBuffer) do
		for _, command in ipairs(commandGroup) do
			self.Cmdr.Dispatcher:EvaluateAndRun(command)
		end
	end

	self.AutoExecBuffer = {}
end

return function(cmdr)
	Registry.Cmdr = cmdr

	return Registry
end
