Include( "\\script\\missions\\leaguematch\\head.lua" )

function main(sel)
--	DisabledUseTownP(0)	--恢复其使用回城符
	Say("<#> Xa phu: Ch祇 m鮪g c竎 v� n tham gia li猲 u V� l﹎, ta l� Xa phu c馻 cu閏 thi n祔, qu� kh竎h mu鑞 ng錳 xe, xin c� d苙 d�!",
		8, "Phng Tng Ph� /#wlls_want2go(1)", "Th祅h Й Ph� /#wlls_want2go(11)", "Чi L�/#wlls_want2go(162)", "Bi謓 Kinh Ph� /#wlls_want2go(37)", "Tng Dng Ph� /#wlls_want2go(78)", "Dng Ch﹗ Ph� /#wlls_want2go(80)", "L﹎ An Ph� /#wlls_want2go(176)", "Зu c騨g kh玭g mu鑞 甶!/OnCancel")
end;

tbCP_STATION = {
	[1] = { {1557, 3112}, {1537, 3237}, {1649, 3287}, {1656, 3167}, "Phng Tng Ph� " },
	[11] = { {3193, 5192}, {3266, 5004}, {3011, 5101}, {3031, 4969}, "Th祅h Й Ph� " },
	[37] = { {1598, 3000}, {1866, 2930}, {1701, 3224}, {1636, 3191}, "Bi謓 Kinh Ph� " },
	[78] = { {1592, 3377}, {1704, 3225}, {1508, 3147}, {1440, 3219}, "Tng Dng Ph� " },
	[80] = { {1670, 2996}, {1598, 3201}, {1722, 3210}, {1834, 3063}, "Dng Ch﹗ Ph� " },
	[162] = { {1669, 3129}, {1696, 3280}, {1472, 3273}, "Чi L�" },
	[176] = { {1603, 2917}, {1692, 3296}, {1375, 3337}, {1356, 3017}, "L﹎ An Ph� " }
}

function wlls_want2go(stationname)
	local n_oldidx = SubWorld
	local SubWorld = SubWorldID2Idx(wlls_get_mapid(3))
	local n_camp = wlls_findfriend(WLLS_MSID_COMBAT, GetName())
	SubWorld = n_oldidx
	if (n_camp) then
		Say("<#> Xa phu: nh鉳 c馻 ngi 產ng thi u? N誹 nh� b﹜ gi� r阨 kh醝 y s� kh玭g nh薾 頲 gi秈 thng. Ngi x竎 nh薾 mu鑞 r阨 kh醝?",
			2, "ng v藋!/#cp_station("..stationname..")", "Kh玭g c莕!/OnCancel")
	else
		cp_station(stationname)
	end
end

function cp_station(stationname)
	if (tbCP_STATION[stationname] == nil) then
		print("chefu cann't find station")
		return
	end
	local count = getn(tbCP_STATION[stationname]) - 1
	local randnum = random(count)
	Msg2Player("Ng錳 y猲 ch璦? Ch髇g ta 甶 "..tbCP_STATION[stationname][count+1])
	NewWorld(stationname, tbCP_STATION[stationname][randnum][1], tbCP_STATION[stationname][randnum][2])
end
