local gpsBlips = {}
local gpsMarkers = {}
function intBul(thePlayer, cmd, intID)
	local playerID = getElementData(thePlayer, "dbid")
	if not intID then
		outputChatBox("KULLANIM: #ffffff/" .. cmd .. " [Kapı Numarası (ID)]", thePlayer, 50, 255, 255, true)
		return false
	end
	if not gpsBlips[playerID] then
		local interior = exports.pool:getElement("interior", intID)
		if interior then
		if getElementData(thePlayer , "faction") == 1 then
				local intposX, intposY, intposZ = getElementPosition(interior)
				gpsBlips[playerID] = createBlip(intposX, intposY, intposZ, 19, 2, 255, 0, 0, 255, 0, 99999.0, thePlayer)
				gpsMarkers[playerID] = createMarker(intposX, intposY, intposZ, "checkpoint", 3, 255, 0, 0, 255, thePlayer)
				attachElements(gpsMarkers[playerID], interior)
				attachElements(gpsBlips[playerID], interior)
				if gpsBlips[playerID] then
					outputChatBox("[!] #ffffffBelirtilen kapı numarası GPS'inizde işaretlendi.", thePlayer, 0, 255, 0, true)
					outputChatBox("[!] #ffffffİşareti kaldırmak için (/ibkapat) yazınız.", thePlayer, 0, 255, 0, true)
				end
			else
				outputChatBox("[!] #ffffffBu işlemi yapabilmek için 'Polis Departmanında' olmalısınız.", thePlayer, 255, 0, 0, true)
			end
		end
	else
		outputChatBox("[!] #ffffffGPS zaten çalışıyor, kapatmak için (/ibkapat)", thePlayer, 255, 0, 0, true)
	end
end
addCommandHandler("intbul", intBul)

function kgpsFunc(thePlayer, cmd)
	local playerID = getElementData(thePlayer, "dbid")
	if gpsBlips[playerID] then
		destroyElement(gpsMarkers[playerID])
		gpsMarkers[playerID] = false
		destroyElement(gpsBlips[playerID])
		gpsBlips[playerID] = false
		outputChatBox("[!] #ffffffKapı numarası GPS'i kaldırıldı.", thePlayer, 0, 255, 0, true)
	end
end
addCommandHandler("ibkapat", kgpsFunc)
