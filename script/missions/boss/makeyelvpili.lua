--耶律辟离(563)，生于每天23：05，在226,1724,3227
function main()
	mapindex = SubWorldID2Idx(226)
	if (mapindex < 0 ) then
		return
	end;
	bossid = 563
	bosslvl = 95
	posx = 1724*32
	posy = 3227*32
	AddNpcEx(bossid,bosslvl,3,mapindex,posx,posy,1, "Gia Lu藅 T� Ly", 1)
	AddGlobalNews("Nghe n鉯 H鱱 s� c馻 Thi猲 Nh蒼 Gi竜 Gia Lu藅 T� Ly  xu蕋 hi謓 � M� Cung sa m筩 (215, 201) Йn Ho祅g. ")
end; 