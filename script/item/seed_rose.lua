--玫瑰种子使用后可以call出一个玫瑰圣诞树
--renbin


IncludeLib("SETTING"); --载入SETTING脚本指令库
Include("\\script\\global\\forbidmap.lua")

function main()
	
	if ( GetFightState() == 1 ) then
		local w,x,y = GetWorldPos()
		local mapindex = SubWorldID2Idx(w)
		if ( mapindex < 0 ) then
			Msg2Player("Get MapIndex Error.")
			return 1
		end
		if ( CheckAllMaps(w) == 1 ) then
			Msg2Player("t 產i � y kh玭g th輈h h頿 gieo tr錸g, ra ngo礽 r鮪g tr錸g th� xem!")
			return 1
		end
		local posx = x*32
		local posy = y*32
		bossid = 608
		bosslvl = 1
		i = random (1,5) - 1
		AddNpc(bossid,bosslvl,mapindex,posx,posy,1,GetName().."C﹜ th玭g hoa h錸g",1)
--		CallNpc(i,608 + i,10,GetName().."的玫瑰圣诞树",0,1)
		Msg2Player("B筺  tr錸g th祅h 1 c﹜ Hoa H錸g Gi竛g Sinh! H穣 mau l綾 n�  nh薾 頲 b秓 v藅")
		return 0
	else
		Msg2Player("C秏 琻 b筺  nu玦 dng t玦! Nh璶g t玦 ch� c� th� s鑞g 頲 ngo礽 ng m� th玦! Xin h穣 mang t玦 甶!")
		return 1
	end
		
end