--function SCHEMA:OnCharCreated(client, character)
--	local inventory = character:getInv()
--
--	if (inventory) then		
--		if (character:getFaction() == FACTION_CITIZEN) then
--			inventory:add("cid", 1, {
--				name = character:getName(),
--				id = math.random(10000, 99999)
--			})
--		elseif (self:isCombineFaction(character:getFaction())) then
--			inventory:add("radio", 1)
--		end
--	end
--end

function SCHEMA:LoadData()
	self:loadVendingMachines()
	self:loadDispensers()
	self:loadObjectives()
end

function SCHEMA:PlayerMessageSend(client, chatType, message, anonymous, receivers)
	if (!nut.voice.chatTypes[chatType]) then
		return
	end

	for _, definition in ipairs(nut.voice.getClass(client)) do
		local sounds, message = nut.voice.getVoiceList(definition.class, message)

		if (sounds) then
			local volume = 80

			if (chatType == "w") then
				volume = 60
			elseif (chatType == "y") then
				volume = 150
			end
			
			if (definition.onModify) then
				if (definition.onModify(client, sounds, chatType, message) == false) then
					continue
				end
			end

			if (definition.isGlobal) then
				netstream.Start(nil, "voicePlay", sounds, volume)
			else
				netstream.Start(nil, "voicePlay", sounds, volume, client:EntIndex())

				if (chatType == "radio" and receivers) then
					for k, v in pairs(receivers) do
						if (receivers == client) then
							continue
						end

						netstream.Start(nil, "voicePlay", sounds, volume * 0.5, v:EntIndex())
					end
				end
			end

			return message
		end
	end
end

