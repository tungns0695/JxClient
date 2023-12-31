Include("\\script\\missions\\dragonboat\\include.lua")
Include("\\script\\missions\\dragonboat\\npc\\duanwu_convert.lua")
IncludeLib("RELAYLADDER")

DWGOLDENLASTDATE = tonumber(date("%d")) --上一次用巨型龙舟换取黄金装备的日期 只记录天
DWGOLDENMAXCOUNT = 2	--端午用巨型龙舟换定国安邦、侠骨柔情，每天每台服务器可以换取的数量，每台gameserver的上限，共16个
DWGOLDENNOWCOUNT = 0 --当前用巨型龙舟换取黄金装备数

DWORELASTDATE = tonumber(date("%d")) --上一次用兽型龙舟换取玄晶、神秘矿石的日期 只记录天
DWOREMAXCOUNT = 12	--端午用兽型龙舟换玄晶、神秘矿石，每天每台服务器可以换取的数量，每台gameserver的上限，共96个
DWORENOWCOUNT = 0 --当前用兽型龙舟换取玄晶、神秘矿石数

AWARD_BIRDBOAT = {
					{"Ti猲 Th秓 L� ",{6,1,71,1,0,0},30},
					{"T� Th駓 Tinh",{239},15},
					{"Lam Th駓 Tinh",{238},15},		
					{"L鬰 Th駓 Tinh",{240},15},
					{"Tinh H錸g B秓 Th筩h",{353},15},	
					{"Thi猲 s琻  B秓 L� ",{6,1,72,1,0,0},10},	
					}

AWARD_BEASTBOAT = {
					{"Huy襫 Tinh c蕄 5",{6,1,147,5,0,0},20},
					{"Huy襫 Tinh c蕄 6",{6,1,147,6,0,0},43},
					{"Huy襫 Tinh c蕄 7",{6,1,147,7,0,0},30},		
					{"Huy襫 Tinh c蕄 8",{6,1,147,8,0,0},3},
					{"Th莕 b� kho竛g th筩h",{6,1,398,1,0,0},4},
					}

AWARD_HUGEBOAT = {
					{"мnh Qu鑓 Thanh Sa Trng Sam",{159},100},
					{"мnh Qu鑓 � Sa Ph竧 Qu竛",{160},51},
					{"мnh Qu鑓 X輈h Quy猲 Nhuy詎 Ngoa",{161},70},	
					{"мnh Qu鑓 T� Щng H� uy觧",{162},70},
					{"мnh Qu鑓 Ng﹏ T祄 Y猽 i",{163},70},
					{"An Bang B╪g Tinh Th筩h H筺g Li猲",{164},51},
					{"An Bang C骳 Hoa Th筩h Ch� ho祅",{165},51},
					{"An Bang 襫 Ho祅g Th筩h Ng鋍 B閕",{166},51},
					{"An Bang K� Huy誸 Th筩h Gi韎 Ch� ",{167},51},
					{"Hi謕 C鑤 Thi誸 Huy誸 Sam",{186},70},
					{"Hi謕 C鑤  T譶h Ho祅",{187},70},
					{"Hi謕 C鑤 n T﹎ Gi韎",{188},70},
					{"Hi謕 C鑤 T譶h � K誸",{189},20},
					{"Nhu T譶h C﹏ Qu鑓 Ngh� Thng",{190},14},
					{"Nhu T譶h Th鬰 N� H筺g Li猲",{191},60},
					{"Nhu T譶h  Ph鬾g Nghi Gi韎 Ch� ",{192},80},
					{"Nhu T譶h  Tu� T﹎ Ng鋍 B閕",{193},51},
					}
																									
function dragonboat_main()
	Say(" Ho箃 ng T誸 an Ng�  k誸 th骳 nh璶g m鋓 ngi v蒼 c� th� d飊g nh鱪g v藅 li謚 c遪 l筰  gh衟 thuy襫 r錸g v� i l蕐 ph莕 thng. Ngi ch琲 trong 10 t猲 ng u c馻 b秐g x誴 h筺g 畊a Thuy襫 r錸g cao v� s� c蕄 nhanh ch﹏ n ch� ta i Trang b� Ho祅g Kim.", 5,"T筼 thuy襫 r錸g/duanwu_convert","D飊g thuy襫 r錸g i ph莕 thng/dragon_award","10 t猲 ng u b秐g x誴 h筺g 畊a thuy襫 r錸g nh薾 Trang b� Ho祅g Kim./dragon_golden","Ho箃 ng c� li猲 quan/aboutboat", "Kh玭g c莕/OnCancel");
end

function want_playboat()
	OldSubWorld = SubWorld
	OldPlayer = PlayerIndex
	local totalboat = 0
	local freeboat = 0
	local startboat = 0
	local blevel = 0
	if (IsCaptain() ~= 1) then
		Say(" Xin l鏸! C莕 i trng b竜 danh tham gia ho箃 ng 畊a thuy襫 r錸g m韎 頲.",0)
		return
	end
	if (GetTeamSize() < 4) then
		Say(" Xin l鏸! чi thi u tham gia ho箃 ng 畊a thuy襫 r錸g c莕 輙 nh蕋 <color=red>4<color> ngi. Hi謓 i c馻 b筺 kh玭g  ngi! H穣 甶 t譵 th猰 b籲g h鱱 nh�!",0)
		return
	end
	if (GetLevel() >= 90) then
		blevel = 1
	end
	
	for i = 1, GetTeamSize() do 
		PlayerIndex = GetTeamMember(i)
		local bmbrlevel = 0
		if (GetLevel() >= 90) then
			bmbrlevel = 1
		end
		
		if (blevel ~= bmbrlevel) then
			if (blevel == 0) then
				Say(" Xin l鏸! Trong i c馻 b筺 c� i vi猲 c� ng c蕄 <color=red>vt qu� c蕄 90<color>, kh玭g th� tham gia thi u! Ki觤 tra l筰 r錳 n b竜 danh tham gia! ",0)
				return
			else
				Say(" Xin l鏸! Trong i c馻 b筺 c� i vi猲 c� ng c蕄 <color=red>ch璦 n c蕄 90<color>, kh玭g th� tham gia thi u! Ki觤 tra l筰 r錳 n b竜 danh tham gia! ",0)
				return
			end
		end
	end
	
	PlayerIndex = OldPlayer
	for i = 1, getn(map_map) do 
		sub = SubWorldID2Idx(map_map[i])
		if (sub >= 0) then
			print("have "..map_map[i])
			totalboat = totalboat + 1
			SubWorld = sub
			local state = GetMissionV(VARV_STATE)
			if (state > 0) then
				startboat = 1
			end
			if ( state == 1 and GetMSPlayerCount(MISSION_MATCH, 1) == 0 and map_isadvanced[map_map[i]] == blevel) then
				freeboat = freeboat + 1
			end
		end
	end
	print("total"..totalboat.."free"..freeboat)
	local strlevel ="";
	if (blevel == 0) then
		strlevel = "畊a thuy襫 r錸g s� c蕄"
	else
		strlevel = "thuy襫 r錸g cao c蕄"
	end
	
	if (startboat == 1) then
		if (freeboat == 0) then
			Say(" Khu v鵦 n祔 產ng trong"..strlevel.." b総 u. Kh玭g c遪 ch� n鱝�.",0)
			return
		else
			Say(" Khu v鵦 n祔 產ng trong"..strlevel.."giai 畂筺 b竜 danh 畊a thuy襫 r錸g, v蒼 c遪 <color=red>"..freeboat.."<color>thuy襫 r錸g c遪 tr鑞g. Tham gia thi u c莕 n閜 <color=red>5 v筺<color>lng, b筺 c� mu鑞 tham gia?",2, "Ph秈! Ta mu鑞 d蒼 d総 i c馻 ta tham gia./dragon_join", "Kh玭g c莕/OnCancel")
			return
		end
	else
		Say(" Xin l鏸! Khu v鵦 n祔"..strlevel.."hi謓 ch璦 m� ho箃 ng 畊a thuy襫 r錸g n祇  tham gia. B竜 danh <color=red>ng m鏸 gi�<color> b総 u. Th阨 gian b竜 danh l� 5 ph髏. Xin ch� � th玭g b竜 c馻 h� th鑞g!",0)
		return
	end
	
end

function dragon_join()
	local blevel = 0
	if (GetLevel() >= 90) then
		blevel = 1
	end
	if (IsCaptain() ~= 1) then
		Say(" Xin l鏸! C莕 i trng b竜 danh tham gia ho箃 ng 畊a thuy襫 r錸g m韎 頲.",0)
		return
	end
	if (GetTeamSize() < 1) then
		Say(" Xin l鏸! чi thi u tham gia ho箃 ng 畊a thuy襫 r錸g c莕 輙 nh蕋 <color=red>4<color> ngi. Hi謓 i c馻 b筺 kh玭g  ngi! H穣 甶 t譵 th猰 b籲g h鱱 nh�!",0)
		return
	end
	local bhaveboat = 0
	local boatstr = "Thuy襫 R錸g nh� "
	if (blevel > 0) then
		boatstr = "Thuy襫 R錸g truy襫 th鑞g"
	end
	
	if (blevel == 0) then
		bhaveboat = CalcEquiproomItemCount( 6, 1, 422, 1 )
	else
		bhaveboat = CalcEquiproomItemCount( 6, 1, 423, 1 )
	end
	
	if (GetCash() < 50000 or bhaveboat == 0 and blevel == 0) then
		Say(" Xin l鏸! Tham gia thi u thuy襫 r錸g c莕 n閜<color=red> 5 v筺 lng v� "..boatstr.."<color>m韎 頲, ti襫 c馻 b筺 kh玭g  ho芻 kh玭g mang theo thuy襫 r錸g nh�!Chu萵 b�  r錳 h穣 n!.", 0)
		return
	end
	if (GetCash() < 50000 or bhaveboat == 0 and blevel == 1) then
		Say(" Xin l鏸! Tham gia thi u thuy襫 r錸g c莕 n閜<color=red> 5 v筺 lng v� "..boatstr.."<color=red>m韎 頲, ti襫 c馻 b筺 kh玭g  ho芻 kh玭g mang theo thuy襫 r錸g truy襫 th鑞g! Chu萵 b�  r錳 h穣 n!", 0)
		return
	end
	
	local OldPlayer = PlayerIndex
	
	for i = 1, GetTeamSize() do 
		PlayerIndex = GetTeamMember(i)
		local bmbrlevel = 0
		if (GetLevel() >= 90) then
			bmbrlevel = 1
		end
		
		if (blevel ~= bmbrlevel) then
			if (blevel == 0) then
				Say(" Xin l鏸! Trong i c馻 b筺 c� i vi猲 c� ng c蕄 <color=red>vt qu� c蕄 90<color>, kh玭g th� tham gia thi u! Ki觤 tra lai r錳 n b竜 danh tham gia! ",0)
				return
			else
				Say(" Xin l鏸! Trong i c馻 b筺 c� i vi猲 c� ng c蕄 <color=red>ch璦 n c蕄 90<color>, kh玭g th� tham gia thi u! Ki觤 tra l筰 r錳 n b竜 danh tham gia! ",0)
				return
			end
		end
	end
	
	PlayerIndex = OldPlayer
	
	OldSubWorld = SubWorld
	
	for i = 1, getn(map_map) do 
		sub = SubWorldID2Idx(map_map[i])
		if (sub >= 0) then
			SubWorld = sub
			local state = GetMissionV(VARV_STATE)
			if ( state == 1 and GetMSPlayerCount(MISSION_MATCH, 1) == 0 and blevel == map_isadvanced[map_map[i]] ) then
				local tabplayer = {}
				for i = 1, GetTeamSize() do 
					tabplayer[i] = GetTeamMember(i)
					print("plal"..tabplayer[i])
				end
				PlayerIndex = tabplayer[1]
				w,x,y = GetWorldPos()
				SetMissionV(VARV_SIGNUP_WORLD, w)
				SetMissionV(VARV_SIGNUP_POSX, x)
				SetMissionV(VARV_SIGNUP_POSY, y)
				SetMissionS(VARS_TEAM_NAME,GetName())
				
				-- DEBUG
				print(format("%s t� (%d, %d, %d) v� tr� v祇 thuy襫 r錸g", GetName(), w, x, y));

				Pay(50000)
				if (blevel == 0) then
					ConsumeEquiproomItem( 1, 6, 1, 422, 1)
				else
					ConsumeEquiproomItem( 1, 6, 1, 423, 1)
				end

				for i = 1 , getn(tabplayer) do 
					PlayerIndex = tabplayer[i]
					print("player"..PlayerIndex)
					JoinMission(MISSION_MATCH, 1)
				end
				return
			end
		end
	end
	SubWorld = OldSubWorld
	PlayerIndex = OldPlayer
	local strlevel ="";
	if (blevel == 0) then
		strlevel = "畊a thuy襫 r錸g s� c蕄"
	else
		strlevel = "thuy襫 r錸g cao c蕄"
	end
	Say("Xin l鏸! Hi謓 t筰<color=red>"..strlevel.."<color>  kh玭g c遪 ch�. Xin i v遪g sau!",0)
end

function dragon_award()
	Say(" Cu閏 畊a thuy襫 r錸g 產ng s玦 n鎖. L穙 phu 產ng thu nh薾 thuy襫 r錸g. B筺 mu鑞 d飊g lo筰 thuy襫 n祇  i ph莕 thng?",7,"Thuy襫 r錸g nh� i B竛h ch璶g nh﹏ u/dousha","Thuy襫 r錸g truy襫 th鑞g i B竛h ch璶g nh﹏ n蕀/xianggu","M� u thuy襫 r錸g i B竛h ch璶g nh﹏ tr鴑g/danhuang"," Thuy襫 r錸g u ph鬾g ng蓇 nhi猲 i l蕐 Ti猲 Th秓 l�, Th駓 Tinh, B秓 Th筩h, Thi猲 S琻 B秓 L� /birdboat_award","Thuy襫 r錸g h譶h th� ng蓇 nhi猲 i l蕐 Kho竛g th筩h th莕 b�, 5-Huy課 Tinh kho竛g th筩h c蕄 8/beastboat_award","Thuy襫 r錸g lo筰 l韓 ng蓇 nhi猲 i l蕐 мnh Qu鑓 An Bang, 1 b� trang b� ho祅g kim Hi謕 C鑤 Nhu T譶h/hugeboat_award","Kh玭g c莕!/OnCancel");
end

function dragon_golden()
	--Say("礼官：龙舟大赛正在如火如荼的进行中，要等到<color=red>活动结束<color>后才能来领奖哦。",0);
	Say(" B筺 mu鑞 nh薾 ph莕 thng thi u n祇?", 3, "a thuy襫 r錸g s� c蕄/dragon_golden_low","a thuy襫 r錸g cao c蕄/dragon_golden_high","Kh玭g c莕!/OnCancel");
end

function dragon_golden_low()
	for i = 1, 10 do
		RoleName, Data = Ladder_GetLadderInfo(10141, i);
		if( GetName() ==  RoleName) then
			if(GetTask(1507) ~= 0) then
				Say(" B筺  l穘h ph莕 thng 10 t猲 ng u trong b秐g x誴 h筺g thuy襫 r錸g s� c蕄!",0);
				return 0
			end			
			if(CalcFreeItemCellCount() < 6) then
				Say(" Ch� tr鑞g h祅h trang c馻 b筺 kh玭g . S緋 x誴 l筰 r錳 h穣 i nh�!",0);
				return 0
			end
			dragon_givegolden();
			SetTask(1507,1);
			return 1
		end
	end
	Say(" B筺 kh玭g n籱 trong 10 t猲 ng u b秐g x誴 h筺g 畊a thuy襫 r錸g s� c蕄, kh玭g th� l穘h thng.",0);
end

function dragon_golden_high()
	for i = 1, 10 do
		RoleName, Data = Ladder_GetLadderInfo(10142, i);
		if( GetName() ==  RoleName) then
			if(GetTask(1508) ~= 0) then
				Say(" B筺  l穘h ph莕 thng 10 t猲 ng u trong b秐g x誴 h筺g thuy襫 r錸g cao c蕄!",0);
				return 0
			end			
			if(CalcFreeItemCellCount() < 6) then
				Say(" Ch� tr鑞g h祅h trang c馻 b筺 kh玭g . S緋 x誴 l筰 r錳 h穣 i nh�!",0);
				return 0
			end
			dragon_givegolden();
			SetTask(1508,1);
			return 1
		end
	end
	Say(" B筺 kh玭g n籱 trong 10 t猲 ng u b秐g x誴 h筺g 畊a thuy襫 r錸g cao c蕄, kh玭g th� l穘h thng.",0);
end

function aboutboat()
	Say(" B筺 mu鑞 t譵 hi觰 m鬰 n祇?", 5,"C玭g th鴆 gh衟 thuy襫 r錸g/aboutmaking","L辌h s� 畊a thuy襫 r錸g/abouthistory","Li猲 quan b竜 danh/aboutjoin","H筺g m鬰 ch� � /aboutnotice","Ta  bi誸 r錳!/OnCancel");
end

function aboutmaking()
	local a = "Thuy襫 r錸g nh� = 1 u r錸g + 1 畊玦 r錸g + 1 th﹏ r錸g + 1sn r錸g + 4 m竔 ch蘯 + 1 b竛h l竔 + 1 tr鑞g";
	local b = "<enter>Thuy襫 r錸g truy襫 th鑞g = 1 Thuy襫 r錸g nh� + 4 m竔 ch蘯";
	local c = "<enter>M� u thuy襫 r錸g = 1 Thuy襫 r錸g nh� + 1 Thuy襫 r錸g truy襫 th鑞g + 1 u r錸g";
	local d = " Thuy襫 r錸g u ph鬾g = 1 Thuy襫 r錸g u ng鵤 + 1 Thuy襫 r錸g truy襫 th鑞g + 1 u r錸g";
	local e = "<enter>Thuy襫 r錸g h譶h th� = 1 Thuy襫 r錸g u ph鬾g + 1 Thuy襫 r錸g u ng鵤 + 1 u r錸g";
	local f = "<enter>Thuy襫 r錸g lo筰 l韓 = 1 Thuy襫 r錸g h譶h th� + 1 Thuy襫 r錸g u ph鬾g + 1 Thuy襫 r錸g u ng鵤";
	Talk(2,"",a..b..c,d..e..f);
end

function abouthistory()
	Talk(1,"","Truy襫 thuy誸 n鉯 r籲g sau khi Khu蕋 Nguy猲 tr莔 m譶h tr猲 s玭g M辌h La. Ngi b� con th﹏ thu閏 � qu� nh� 玭g n籱 m閚g th蕐 Khu蕋 Nguy猲 th﹏ h譶h ti襲 t魕 b蘮 d飊g l� tr骳 g鉯 c琺 th祅h nh鱪g chi誧 b竛h c� g鉩 (B竛h ch璶g) , ch蕋 l猲 thuy襫 r錸g r錳 y ra d遪g s玭g  c竎 lo礽 th駓 t閏 do Long Vuong cai qu秐 di nc nh譶 th蕐 r錸g s� cho l�  c馻 Long Vng a t韎 s� kh玭g d竚 ╪ n猲 c� th� c髇g t� cho Khu蕋 Nguy猲 d飊g. Зy ch輓h l� nguy猲 do c� cu閏 畊a thuy襫 r錸g v� t鬰 ╪ B竛h ch璶g.");
end

function aboutjoin()
	Talk(2,"","Ngi ch琲 gi� <color=red>Thuy襫 r錸g nh� v� Thuy襫 r錸g truy襫 th鑞g<color> l祄 <color=red>i trng<color>, d蒼 theo c竎 i vi猲 n <color=red>L� quan<color> b竜 danh tham gia 畊a thuy襫 r錸g s� v� cao c蕄, m鏸 gi� t� ch鴆 1 l莕, <color=red>ng gi� <color> a ra th玭g b竜 b総 u ti誴 nh薾 b竜 danh. Th阨 gian b竜 danh l� 5ph髏.","Thi u s� c蕄 cho ph衟 nhi襲 nh蕋 <color=red>8<color> i c飊g tham gia i 鴑g v韎 8 t蕀 b秐  thuy襫 r錸g;Thi u cao c蕄 cho ph衟 nhi襲 nh蕋 <color=red>16<color> i c飊g tham gia i 鴑g v韎 16 t蕀 b秐  thuy襫 r錸g. N誹 s� t猲 b竜 danh L� quan � th祅h th� n祇   y. M阨 ngi ch琲 n L� quan c竎 th祅h th� kh竎 b竜 danh.");
end

function aboutnotice()
	Talk(3,"","Sau khi b竜 danh th祅h c玭g, t蕋 c� c竎 i 頲 chuy觧 n b秐  thuy襫 r錸g. Trong l骳 i th阨 gian thi u b総 u, ngi ch琲 b� <color=red>r韙 m筺g ho芻 b� h� g鬰<color> th� 頲 ph竛 nh m蕋 甶 t� c竎h thi u. N誹 i trng b� r韙 m筺g ho芻 b� h� g鬰, c竎 th祅h vi猲 c遪 l筰 v蒼 c� th� ti誴 t鬰 thi u v� nh薾 頲 ph莕 thng c馻 v遪g u, nh璶g th祅h t輈h kh玭g 頲 ghi l猲 b秐g x誴 h筺g.","Sau khi <color=red>2 tu莕<color> ho箃 ng 畊a thuy襫 r錸g k誸 th骳, i trng<color=red> 10 i ng u b秐g x誴 h筺g cu閏 畊a thuy襫 r錸g s� v� cao c蕄<color> c� th� n L� quan l穘h мnh Qu鑓 An Bang, 1 b� trang b� ho祅g kim ng蓇 nhi猲 Hi謕 C鑤 Nhu T譶h.","в bi誸 th玭g tin chi ti誸 xin xem trang ch�: www.volam.com.vn");
end

function dousha()
	Say("  B竛h ch璶g nh﹏ u ng蓇 nhi猲 nh薾 頲 <color=red>1 v筺, 2 v筺, 5 v筺 甶觤 kinh nghi謒<color> ho芻 tham gia <color=red>畊a thuy襫 r錸g s� c蕄<color>, c� th藅 b筺 mu鑞 i kh玭g?",2,"ta mu鑞 i/dousha_yes","Kh玭g c莕!/OnCancel");
end

function dousha_yes()
	if(CalcEquiproomItemCount(6,1,422,1) <= 0) then
		Say(" B筺 kh玭g c� thuy襫 r錸g nh�, kh玭g th� i ph莕 thng!",0);
		return
	end	
	if(CalcFreeItemCellCount() < 1) then
		Say(" Ch� tr鑞g h祅h trang c馻 b筺 kh玭g . S緋 x誴 l筰 r錳 h穣 i nh�!",0);
		return
	end
	DelCommonItem(6,1,422);
	AddItem(6,1,435,1,0,0);
	WriteLog(date("%Y-%m-%d %H:%M:%S").." "..GetAccount()..", ["..GetName().."]:l穘h 1 c竔 B竛h ch璶g nh﹏ u");
	Say(" B筺 nh薾 頲 B竛h ch璶g nh﹏ u.",0);
end

function xianggu()
	Say("  B竛h ch璶g nh﹏ n蕀 ng蓇 nhi猲 nh薾 頲 <color=red>5 v筺, 10 v筺, 25 v筺 甶觤 kinh nghi謒<color>ho芻 tham gia<color=red>thuy襫 r錸g cao c蕄<color>, c� th藅 b筺 mu鑞 i kh玭g?",2,"ta mu鑞 i/xianggu_yes","Kh玭g c莕!/OnCancel");
end

function xianggu_yes()
	if(CalcEquiproomItemCount(6,1,423,1) <= 0) then
		Say(" B筺 kh玭g c� <color=red>Thuy襫 r錸g truy襫 th鑞g<color>, kh玭g th� i ph莕 thng!",0);
		return
	end	
	if(CalcFreeItemCellCount() < 1) then
		Say(" Ch� tr鑞g h祅h trang c馻 b筺 kh玭g . S緋 x誴 l筰 r錳 h穣 i nh�!",0);
		return
	end
	DelCommonItem(6,1,423);
	AddItem(6,1,436,1,0,0);
	WriteLog(date("%Y-%m-%d %H:%M:%S").." "..GetAccount()..", ["..GetName().."]: l穘h 1 c竔 B竛h ch璶g nh﹏ n蕀");	
	Say(" B筺 nh薾 頲 1 c竔 B竛h ch璶g nh﹏ n蕀.",0);
end

function danhuang()
	Say("  B竛h ch璶g nh﹏ tr鴑g ng蓇 nhi謓 nh薾 頲 <color=red>15 v筺, 30 v筺, 75 v筺 甶觤 kinh nghi謒<color>, b筺 th藅 s� mu鑞 i?",2,"ta mu鑞 i/danhuang_yes","Kh玭g c莕!/OnCancel");
end

function danhuang_yes()
	if(CalcEquiproomItemCount(6,1,424,1) <= 0) then
		Say(" B筺 kh玭g c� <color=red>M� u thuy襫 r錸g<color>, kh玭g th� i ph莕 thng!",0);
		return
	end	
	if(CalcFreeItemCellCount() < 1) then
		Say(" Ch� tr鑞g h祅h trang c馻 b筺 kh玭g . S緋 x誴 l筰 r錳 h穣 i nh�!",0);
		return
	end
	DelCommonItem(6,1,424);
	AddItem(6,1,437,1,0,0);
	WriteLog(date("%Y-%m-%d %H:%M:%S").." "..GetAccount()..", ["..GetName().."]:l穘h 1 c竔 B竛h ch璶g nh﹏ tr鴑g");		
	Say(" B筺 nh薾 頲1 c竔 B竛h ch璶g nh﹏ tr鴑g.",0);
end

function birdboat_award()
	local awardpro = {}
	if(CalcEquiproomItemCount(6,1,425,1) <= 0) then
		Say(" B筺 kh玭g c� <color=red>Thuy襫 r錸g u ph鬾g<color>, kh玭g th� i ph莕 thng!",0);
		return
	end	
	if(CalcFreeItemCellCount() < 1) then
		Say(" Ch� tr鑞g h祅h trang c馻 b筺 kh玭g . S緋 x誴 l筰 r錳 h穣 i nh�!",0);
		return
	end
	for i = 1, getn(AWARD_BIRDBOAT) do
		awardpro[i] = AWARD_BIRDBOAT[i][3];
	end
	numth = randomaward(awardpro);
	if( getn(AWARD_BIRDBOAT[numth][2]) == 6 ) then
		AddItem(AWARD_BIRDBOAT[numth][2][1],AWARD_BIRDBOAT[numth][2][2],AWARD_BIRDBOAT[numth][2][3],AWARD_BIRDBOAT[numth][2][4],AWARD_BIRDBOAT[numth][2][6],AWARD_BIRDBOAT[numth][2][6]);
	else
		AddEventItem(AWARD_BIRDBOAT[numth][2][1])
	end
	DelCommonItem(6,1,425);
	WriteLog(date("%Y-%m-%d %H:%M:%S").." "..GetAccount()..", ["..GetName().."]: l穘h 1 c竔"..AWARD_BIRDBOAT[numth][1]);		
	Say(" B筺 nh薾 頲 1 c竔"..AWARD_BIRDBOAT[numth][1]..".",0);
end

function beastboat_award()
	local awardpro = {};
	if(CalcEquiproomItemCount(6,1,426,1) <= 0) then
		Say(" B筺 kh玭g c� <color=red>Thuy襫 r錸g h譶h th�<color>, kh玭g th� i ph莕 thng!",0);
		return
	end	
	if(CalcFreeItemCellCount() < 1) then
		Say(" Ch� tr鑞g h祅h trang c馻 b筺 kh玭g . S緋 x誴 l筰 r錳 h穣 i nh�!",0);
		return
	end
	
	local nNowDate = tonumber(date("%d"));	
	if ( nNowDate == DWORELASTDATE ) then	--如果上次用兽形龙舟换取玄晶、神秘矿石是当天的话
		if ( DWORENOWCOUNT >= DWOREMAXCOUNT ) then	--达到用兽形龙舟换取玄晶、神秘矿石最大数不能再换
			print(" H玬 nay d飊g thuy襫 r錸g h譶h th� i huy襫 tinh v� kho竛g th筩h th莕 b�  vt m鴆.")
			Say(" H玬 nay d飊g thuy襫 r錸g h譶h th� i huy襫 tinh v� kho竛g th筩h th莕 b� qu� nhi襲.L穙 phu kh玭g c遪 h祅g n鱝. H穣 th� 甶 c竎 th祅h th� kh竎 ho芻 ng祔 mai h穣 n!",0);
			return
		end
	else	--如果用兽形龙舟换取玄晶、神秘矿石数日期与当前不是同一天
		DWORELASTDATE = nNowDate;	--更新最近的日期
		DWORENOWCOUNT = 0;	--当前用兽形龙舟换取玄晶、神秘矿石数置0
	end
	
	for i = 1, getn(AWARD_BEASTBOAT) do
		awardpro[i] = AWARD_BEASTBOAT[i][3];
	end
	numth = randomaward(awardpro);
	if( getn(AWARD_BEASTBOAT[numth][2]) == 6 ) then
		AddItem(AWARD_BEASTBOAT[numth][2][1],AWARD_BEASTBOAT[numth][2][2],AWARD_BEASTBOAT[numth][2][3],AWARD_BEASTBOAT[numth][2][4],AWARD_BEASTBOAT[numth][2][6],AWARD_BEASTBOAT[numth][2][6]);
	else
		AddEventItem(AWARD_BEASTBOAT[numth][2][1])
	end
	DWORENOWCOUNT = DWORENOWCOUNT + 1;
	DelCommonItem(6,1,426);
	WriteLog(date("%Y-%m-%d %H:%M:%S").." "..GetAccount()..", ["..GetName().."]: l穘h 1 c竔"..AWARD_BEASTBOAT[numth][1]);		
	Say(" B筺 nh薾 頲 1 c竔"..AWARD_BEASTBOAT[numth][1]..".",0);	
end

function hugeboat_award()
	local awardpro = {};
	if(CalcEquiproomItemCount(6,1,427,1) <= 0) then
		Say(" B筺 kh玭g c� <color=red>Thuy襫 r錸g lo筰 l韓<color>, kh玭g th� i ph莕 thng!",0);
		return
	end	
	if(CalcFreeItemCellCount() < 6) then
		Say(" Ch� tr鑞g h祅h trang c馻 b筺 kh玭g . S緋 x誴 l筰 r錳 h穣 i nh�!",0);
		return
	end
	
	local nNowDate = tonumber(date("%d"));	
	if ( nNowDate == DWGOLDENLASTDATE ) then	--如果上次用巨型龙舟换取黄金装备是当天的话
		if ( DWGOLDENNOWCOUNT >= DWGOLDENMAXCOUNT ) then	--达到用巨型龙舟换取黄金装备最大数不能再换
			print(" H玬 nay d飊g thuy襫 r錸g lo筰 l韓 i Trang b� ho祅g kim  t m鴆.")
			Say(" H玬 nay d飊g thuy襫 r錸g lo筰 l韓 i Trang b� ho祅g kim  qu� nhi襲. L穙 phu kh玭g c遪 h祅g n鱝. H穣 甶 th祅h th� kh竎 th� xem, ho芻 ng祔 mai h穣 n!",0);
			return
		end
	else	--如果用巨型龙舟换取黄金装备日期与当前不是同一天
		DWGOLDENLASTDATE = nNowDate;	--更新最近的日期
		DWGOLDENNOWCOUNT = 0;	--当前用巨型龙舟换取黄金装备数置0
	end
	
	for i = 1, getn(AWARD_HUGEBOAT) do
		awardpro[i] = AWARD_HUGEBOAT[i][3];
	end	
	numth = randomaward(awardpro);
	if( getn(AWARD_HUGEBOAT[numth][2]) == 6 ) then
		AddItem(AWARD_HUGEBOAT[numth][2][1],AWARD_HUGEBOAT[numth][2][2],AWARD_HUGEBOAT[numth][2][3],AWARD_HUGEBOAT[numth][2][4],AWARD_HUGEBOAT[numth][2][6],AWARD_HUGEBOAT[numth][2][6]);
	else
		AddGoldItem(0,AWARD_HUGEBOAT[numth][2][1])
	end
	DWGOLDENNOWCOUNT = DWGOLDENNOWCOUNT + 1;
	DelCommonItem(6,1,427);
	WriteLog(date("%Y-%m-%d %H:%M:%S").." "..GetAccount()..", ["..GetName().."]: l穘h 1 c竔"..AWARD_HUGEBOAT[numth][1]);		
	Say(" B筺 nh薾 頲 1 c竔"..AWARD_HUGEBOAT[numth][1]..".",0);	
end

function randomaward(aryProbability)
	local nRandNum;
	local nSum = 0;
	local nArgCount = getn( aryProbability );
	local nCompareSum = 0;
	for i = 1, nArgCount do
		nSum = nSum + aryProbability[i];
	end
	nRandNum = random(1,nSum);
	for i = 1,nArgCount do
		nCompareSum = nCompareSum + aryProbability[i]
		if( nRandNum <= nCompareSum) then
			return i;
		end
	end
end

function dragon_givegolden()
	local awardpro = {};
	for i = 1, getn(AWARD_HUGEBOAT) do
		awardpro[i] = AWARD_HUGEBOAT[i][3];
	end	
	numth = randomaward(awardpro);
	AddGoldItem(0,AWARD_HUGEBOAT[numth][2][1])
	WriteLog(date("%Y-%m-%d %H:%M:%S").." "..GetAccount()..", ["..GetName().."]: 10 t猲 ng u trong b秐g x誴 h筺g thuy襫 r錸g nh薾 頲 1 c竔"..AWARD_HUGEBOAT[numth][1]);		
	Say(" B筺 nh薾 頲 1 c竔"..AWARD_HUGEBOAT[numth][1]..".",0);	
end	