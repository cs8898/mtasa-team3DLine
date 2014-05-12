--local localplayer = getLocalPlayer()
--dofile("./settings.lua")
local team
local teamMates
local teamMatesPos
local tR, tG, tB
local active = false
local distance = 20
--local autostart = true
local command = "teamline"
local width = 2
--outputChatBox(distance)

--if autostart then
	--init()
--end

function init()
	if not active then
		outputChatBox("TeamLine #00ff00Active  #aaaaaaDistance: #ffff00"..distance.."#ddddddMeter",255,255,00,true)
		getClientTeamMates(getLocalPlayer())
		addEventHandler ( "onClientRender", root, draw )
		active = true
	else
		outputChatBox("TeamLine #ff0000Inactive",255,255,00,true)
		removeEventHandler ( "onClientRender", root, draw )
		active = false
	end
end

function getClientTeamMates( source )
	team = getPlayerTeam( source )
	teamMates = getPlayersInTeam( team )
	tR, tG, tB = getTeamColor ( team )
end

function draw()
	getClientTeamMates(getLocalPlayer())
	for index, value in ipairs(teamMates) do
		local Tx, Ty, Tz = getElementPosition( value )
		local Px, Py, Pz = getElementPosition( getLocalPlayer() )
		if (math.abs(Px-Tx) <= distance) and (math.abs(Py-Ty) <= distance) and (math.abs(Pz-Tz) <= distance ) then
			dxDrawLine3D( Px, Py, Pz, Tx, Ty, Tz, tocolor(tR, tG, tB, 230), width )
		end
	end
end

addCommandHandler ( command, init)