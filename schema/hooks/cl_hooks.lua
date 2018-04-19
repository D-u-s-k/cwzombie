local color = {}
color["$pp_colour_addr"] = 0
color["$pp_colour_addg"] = 0
color["$pp_colour_addb"] = 0
color["$pp_colour_brightness"] = -0.01
color["$pp_colour_contrast"] = 1.35
color["$pp_colour_colour"] = 0.65
color["$pp_colour_mulr"] = 0
color["$pp_colour_mulg"] = 0
color["$pp_colour_mulb"] = 0

function SCHEMA:RenderScreenspaceEffects()
	DrawColorModify(color)
end

netstream.Hook("cDisp", function(text, color)
	SCHEMA:addDisplay(text, color)
end)

netstream.Hook("plyData", function(...)
	vgui.Create("nutData"):setData(...)
end)

netstream.Hook("obj", function(...)
	vgui.Create("nutObjective"):setData(...)
end)

netstream.Hook("voicePlay", function(sounds, volume, index)
	if (index) then
		local client = Entity(index)

		if (IsValid(client)) then
			nut.util.emitQueuedSounds(client, sounds, nil, nil, volume)
		end
	else
		nut.util.emitQueuedSounds(LocalPlayer(), sounds, nil, nil, volume)
	end
end)
