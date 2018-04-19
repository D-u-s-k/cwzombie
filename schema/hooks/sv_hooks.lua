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
