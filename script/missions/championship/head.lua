Include("\\script\\lib\\file.lua")
IncludeLib("RELAYLADDER")
IncludeLib("TITLE")
IncludeLib("ITEM")

BID_DATA = "\\data\\tongbid.dat"
LEVELTOP10 = "\\data\\bestlevel.dat"
LEADER_MEMBER = "\\data\\leadmember.dat"
BID_LEADER = "\\data\\bidleader.dat"

TITLETIME = 30 * 24 * 60 * 60 * 18
FRAME2TIME = 18
TRYOUT_TIMER_1 = 20 * FRAME2TIME; --20秒公布一下战况
TRYOUT_TIMER_2 = 4 * 60 * 60 * FRAME2TIME; --为4小时

MATCH_TIMER_1 = 10 * FRAME2TIME; --5秒公布一下战况
MATCH_TIMER_2 = 10 * 60 * FRAME2TIME; --为10分钟

CP_ONEDAY_MAXROUND = floor(TRYOUT_TIMER_2  / (MATCH_TIMER_2 + 5 * 60 * FRAME2TIME))

Faction = {
			{"\\data\\shaolin_top5.dat", "ShaoLin_Top5", "Thi誹 L﹎"},
			{"\\data\\tianwang_top5.dat", "TianWang_Top5", "Thi猲 Vng"},
			{"\\data\\tangmen_top5.dat", "TangMen_Top5", "Л阯g M玭"},
			{"\\data\\wudu_top5.dat", "Wudu_Top5", "Ng� чc"},
			{"\\data\\emei_top5.dat", "EMei_Top5", "Nga Mi"},
			{"\\data\\cuiyan_top5.dat", "CuiYan_Top5", "Th髖 Y猲"},
			{"\\data\\gaibang_top5.dat", "GaiBang_Top5", "C竔 Bang"},
			{"\\data\\tianren_top5.dat", "TianRen_Top5", "Thi猲 Nh蒼"},
			{"\\data\\wudang_top5.dat", "WuDang_Top5", "V� ng"},
			{"\\data\\kunlun_top5.dat", "KunLun_Top5", "C玭 L玭"}
		  }
FactionTitle = {
				"V� L﹎ Чi h閕 Thi誹 L﹎ cao th� ",
				"V� L﹎ Чi h閕 Thi猲 Vng cao th� ",
				"V� L﹎ Чi h閕 Л阯g M玭 cao th� ",
				"V� L﹎ Чi h閕 Ng� чc cao th� ",
				"V� L﹎ Чi h閕 Nga Mi cao th� ",
				"V� L﹎ Чi h閕 Th髖 Y猲 cao th� ",
				"V� L﹎ Чi h閕 C竔 Bang cao th� ",
				"V� L﹎ Чi h閕 Thi猲 Nh蒼  cao th� ",
				"V� L﹎ Чi h閕 V� ng cao th� ",
				"V� L﹎ Чi h閕 C玭 L玭 cao th� ",
				}
CP_TASKID_REGIST = 1083		--1：报过名；9：取消了预选赛资格
CP_TASKID_POINT = 1084		--记录预选赛得分
CP_TASKID_TITLE = 1085		--9：记录已取得决赛圈资格
CP_TASKID_BID = 1086		--
CP_TASKID_ENEMY = 1087		--预赛时对手的阵营号
CP_TASKID_ROUND = 1088		--参赛的次数
CP_TASKID_WIN = 1089		--赢的次数
CP_TASKID_LOSE = 1090		--输的次数；掉线判输，但无法记录
CP_TASKID_TIE = 1091		--平局的次数
CP_TASKID_FLAG = 1092		--正常退出赛场的标记，在下一入场时刷新
CP_TASKID_BACKCONT = 1093	--对于参与投标的玩家根据投标总金额，判断能取几次
CP_TASKID_LOGOUT = 1094		--为 0 时表明正常退出，为 1 时表示非正常退出（如当机、未保存数据、服务器原因）
CP_CASH = 100000
CP_MAXROUND = 30
CP_PLNUM_LIMT = 10
CP_PLNUM_LIMT_ESPECIAL = 4	--五毒、唐门、昆仑人数限制 至少4人
CP_MAPPOS_IN = {1508,3026}
CP_MAPPOS_OUT = {1472,3243}
CP_MAPPOS_PRE = {1596,2977}
CP_MAPTAB = {
				{396, 397, "Thi誹 L﹎"},
				{398, 399, "Thi猲 Vng"},
				{400, 401, "Л阯g M玭"},
			 	{402, 403, "Ng� чc"},
			 	{404, 405, "Nga Mi"},
			 	{406, 407, "Th髖 Y猲"},
			 	{408, 409, "C竔 Bang"},
			 	{410, 411, "Thi猲 Nh蒼"},
			 	{412, 413, "V� ng"},
			 	{414, 415, "C玭 L玭"}
			 }
			 
CP_AWARD_ITEM = {
					{"T� Th駓 Tinh", {4, 239}, 10},
					{"Lam Th駓 Tinh", {4, 238}, 10},
					{"L鬰 Th駓 Tinh", {4, 240}, 10},
					{"Tinh H錸g B秓 Th筩h", {4, 353}, 10},
					{"Huy襫 Tinh Kho竛g Th筩h c蕄 4", {6, 1, 147, 4, 0, 0}, 5},
					{"Huy襫 Tinh Kho竛g Th筩h c蕄 5", {6, 1, 147, 5, 0, 0}, 100},
					{"Huy襫 Tinh Kho竛g Th筩h c蕄 6", {6, 1, 147, 6, 0, 0}, 300},
					{"Чi Ph骳 Duy猲 L� ", {6, 1, 124, 1, 0, 0}, 100},
					{"Trung  Ph骳 Duy猲 L� ", {6, 1, 123, 1, 0, 0}, 200},
					{"Ti觰 Ph骳 Duy猲 L� ", {6, 1, 122, 1, 0, 0}, 400},
					{"Ti猲 Th秓 L� ", {6, 1, 71, 1, 0, 0}, 1000},
					{"Thi猲 s琻  B秓 L� ", {6, 1, 72, 1, 0, 0}, 1125},
					{"Чi B筩h C﹗ ho祅", {6, 1, 130, 1, 0, 0}, 200},
					{"Hoa h錸g", {6, 0, 20, 1, 0, 0}, 1700},
					{"T﹎ T﹎ Tng 竛h ph� ", {6, 1, 18, 1, 0, 0}, 1700},
					{"L謓h b礽 Phong L╪g ч", {4, 489}, 300},
					{"Ph竜 Hoa", {6, 0, 11, 1, 0, 0}, 1700},
				}

CP_FORBID_ITEM = {
					{	"C玭g T鑓 ho祅", {6, 1, 218, 1, 0, 0}, 511	},
					{	"B祇 T鑓 ho祅", {6, 1, 219, 1, 0, 0}, 512	},
					{	"Ph� Ph遪g ho祅", {6, 1, 220, 1, 0, 0}, 513	},
					{	"чc Ph遪g ho祅", {6, 1, 221, 1, 0, 0}, 514	},
					{	"B╪g Ph遪g ho祅", {6, 1, 222, 1, 0, 0}, 515	},
					{	"H醓 Ph遪g ho祅", {6, 1, 223, 1, 0, 0}, 516	},
					{	"L玦 Ph遪g ho祅", {6, 1, 224, 1, 0, 0}, 517	},
					{	"Gi秏 Thng ho祅", {6, 1, 225, 1, 0, 0}, 518	},
					{	"Gi秏 H玭 ho祅", {6, 1, 226, 1, 0, 0}, 519	},
					{	"Gi秏 чc ho祅", {6, 1, 227, 1, 0, 0}, 520	},
					{	"Gi秏 B╪g ho祅", {6, 1, 228, 1, 0, 0}, 521	},
					{	"Ph� C玭g ho祅", {6, 1, 229, 1, 0, 0}, 522	},
					{	"чc C玭g ho祅", {6, 1, 230, 1, 0, 0}, 523	},
					{	"B╪g C玭g ho祅", {6, 1, 231, 1, 0, 0}, 524	},
					{	"H醓 C玭g ho祅", {6, 1, 232, 1, 0, 0}, 525	},
					{	"L玦 C玭g ho祅", {6, 1, 233, 1, 0, 0}, 526	},
					{	"Trng M謓h ho祅", {6, 1, 234, 1, 0, 0}, 527	},
					{	"Trng N閕 ho祅", {6, 1, 235, 1, 0, 0}, 528	},
					{	"Y猲 H錸g 產n", {6, 1, 115, 1, 0, 0}, 450	},
					{	"X� Lam 產n", {6, 1, 116, 1, 0, 0}, 451	},
					{	"N閕 Ph� ho祅", {6, 1, 117, 1, 0, 0}, 453	},
					{	"N閕 чc ho祅", {6, 1, 118, 1, 0, 0}, 454	},
					{	"N閕 B╪g ho祅", {6, 1, 119, 1, 0, 0}, 455	},
					{	"N閕 H醓 ho祅", {6, 1, 120, 1, 0, 0}, 456	},
					{	"N閕 L玦 ho祅", {6, 1, 121, 1, 0, 0}, 457	},
					{	"Trng M謓h ho祅", {6, 0, 1, 1, 0, 0}, 256	},
					{	"Gia B祇 ho祅", {6, 0, 2, 1, 0, 0}, 257	},
					{	"Чi L鵦 ho祅", {6, 0, 3, 1, 0, 0}, 258	},
					{	"Cao Thi觤 ho祅", {6, 0, 4, 1, 0, 0}, 259	},
					{	"Cao Trung ho祅", {6, 0, 5, 1, 0, 0}, 260	},
					{	"Phi T鑓 ho祅", {6, 0, 6, 1, 0, 0}, 261	},
					{	"B╪g Ph遪g ho祅", {6, 0, 7, 1, 0, 0}, 262	},
					{	"L玦 Ph遪g ho祅", {6, 0, 8, 1, 0, 0}, 263	},
					{	"H醓 Ph遪g ho祅", {6, 0, 9, 1, 0, 0}, 264	},
					{	"чc Ph遪g ho祅", {6, 0, 10, 1, 0, 0}, 265	},
					{	"B竛h ch璶g H箃 d� ", {6, 0, 60, 1, 0, 0}, 401	},
					{	"B竛h ch璶g Th辴 heo", {6, 0, 61, 1, 0, 0}, 402	},
					{	"B竛h ch璶g Th辴 b� ", {6, 0, 62, 1, 0, 0}, 403	},
					{	"B竎h Qu� L� ", {6, 1, 73, 1, 0, 0}, 442	},
					{	"C竧 tng h錸g bao", {6, 1, 19, 1, 0, 0}, 442	},
					{"Ho祅g Kim B秓 H筽",	{6,	1,	69,	1,	0,	0},	442}
				}

CP_TRAPIN = "\\settings\\maps\\championship\\linantoplace_trap.txt"
CP_TRAPOUT = ""
CP_MATCH_POS = "\\settings\\maps\\championship\\champion_gmpos.txt"
CP_TRAPIN_FILE = "\\script\\missions\\championship\\trap\\trap_linantoplace.lua"
CP_TRAPOUT_FILE = "\\script\\missions\\championship\\trap\\trap_placetolinan.lua"
CP_BEGIN_BID_DATE = 5051200
CP_END_BID_DATE = 5051412
CP_UPTO_TRYOUT = 5051620
CP_END_TRYOUT = 5052224

CP_HELP_TRYOUT = {
					"<color=yellow>Tr薾 d� tuy觧 Чi h閕 V� l﹎ ki謙 xu蕋<color>, ch鋘 ra <color=yellow>5 h筺g u<color> trong th藀 i m玭 ph竔 � m鏸 khu v鵦 tham gia tr薾 d� tuy觧 tuy觧 th� c馻 'Чi h閕 V� L﹎ to祅 khu v鵦'. Tr薾 d� tuy觧 b総 u t� 16/5 n 22/5 k誸 th骳. M� t� 20:00 n 24:00 m鏸 ng祔; th阨 gian b竜 danh 5 ph髏; th阨 gian thi u 10 ph髏.",
					"Sau khi tr薾 d� tuy觧 b総 u, ngi ch琲 nh� h琻 c蕄 90 c� th� b竜 danh thi u trong u trng Чi h閕 V� l﹎.Ngi ch琲 m韎 tham gia thi u c莕 n閜 10 v筺 lng ph� b竜 danh. M鏸 ngi ch琲  b竜 danh c� th� thi u nhi襲 nh蕋"..CP_MAXROUND.." tr薾. N誹 b筺 kh玭g h礽 l遪g v韎 th祅h t輈h c馻 nh﹏ v藅 n祔, c� th� x鉧 b� t� c竎h thi u c馻 nh﹏ v藅, nh璶g nh薾 v藅  b� x鉧 b� t� c竎h thi u kh玭g th� ti誴 t鬰 b竜 danh thi u n鱝.",
					"Tr薾 d� tuy觧 d鵤 tr猲 h� th鑞g 甶觤 t輈h l騳  ch鋘 ra 5 h筺g u. Ngi ch琲 khi thi u "..CP_MAXROUND.."trong u trng,  th緉g 1 tr薾 頲 3 甶觤, h遖 1 tr薾 頲 1 甶觤, b筰 1 tr薾 kh玭g 頲 甶觤. дn ng祔 23/5, h� th鑞g s� ch鋘 ra 5 ngi ch琲 c� s� 甶觤 t輈h ph﹏ cao nh蕋 � m鏸 m玭 ph竔, nh薾 頲 t� c竎h tham gia 'Чi h閕 V� L﹎ to祅 khu v鵦'",
					"M鏸 ngi ch琲 tham gia b竜 danh trong qu� tr譶h tham gia nh薾 頲 gi秈 thng nh蕋 nh. M鏸 l莕 tham gia 1 v遪g s� 畂箃 頲 gi秈 thng nh蕋 nh, ngo礽 ra ngi ch琲 c遪 nh薾 頲 nh鱪g v藅 ph萴 nh�: Ph竜 hoa, Huy襫 Tinh Kho竛g Th筩h, Ph骳 Duy猲 l�, Ti猲 Th秓 L�, Th駓 Tinh) "
				}
				
CP_HELP_BID = {
				"<color=yellow>Tranh T鎛g L穘h i i c馻 khu v鵦 n祔<color>, nh蕋 thi誸 l� Bang ch� m韎 c� th� n ch� c馻 ta tham gia tranh ch鴆 l穘h o i nh鉳 c馻 to祅 Server. Ti襫 u gi� m鏸 l莕 輙 nh蕋 l� 100 v筺 lng, m鏸 l莕 l蕐 n v� 100 v筺 lng  t╪g th猰. Th阨 gian u gi� b総 u t� 12/05/2005 n 12 h ng祔 14/05 k誸 th骳.",
				"Bang ch� tham gia u gi� xem ngi c� ti襫 u gi� cao nh蕋 (Kh玭g c玭g b� s� ti襫 c� th�) v� t� bi誸 s� ti襫 u gi� c馻 m譶h. дn 12h ng祔 14/5, Bang ch� a m鴆 u gi� cao nh蕋 tr� th祅h T鎛g L穘h i c馻 khu v鵦 n祔 v� nh薾 頲 t� c竎h ph竛 quy誸 thi u v韎 danh hi謚 l� T鎛g L穘h i. C筺h tranh th蕋 b筰 c莕 n ch� ta nh薾 l筰 ti襫 u gi�. M鏸 l莕 l穘h nhi襲 nh蕋 50 v筺 lng, m b秓 ngi ch琲 lu玭 c�  ti襫.",
				"T鎛g L穘h i c� th� ph﹏ ph竧 29 t蕀 V� l﹎ quy誸 u l謓h b礽 cho ngi ch琲 kh竎 t筰 Quan vi猲 V� l﹎ ki謙 xu蕋. Ngi ch琲  c� 頲 t� c竎h � v遪g chung k誸 kh玭g th� nh薾 t� c竎h n鱝."
				}

CP_HELP_FINAL = "<color=yellow>V� L﹎ i h閕<color>, do 90 ngi � m鏸 khu v鵦 l祄 th祅h 1 nh鉳 tham gia V� l﹎ i h閕 to祅 khu v鵦. Trong , 10 ngi l� Th藀 i cao th� c馻 khu v鵦; 50 ngi l� 5 h筺g u trong Th藀 i m玭 ph竔; 30 ngi c遪 l筰 s� b莡 ra 1 ngi l祄 T鎛g L穘h i. T鎛g L穘h i c� quy襫 quy誸 nh ai trong s� 29 ngi c遪 l筰 c� t� c竎h thi u v遪g chung k誸"

function transtoplace()
Say("Tr薾 d� tuy觧 Чi h閕 V� l﹎ ki謙 xu蕋  k誸 th骳 t鑤 p. Hi謓 t筰 c� th� n Quan vi猲 V� l﹎ ki謙 xu蕋 xem k誸 qu� thi u v� nh薾 danh hi謚 tng 鴑g. Vui l遪g ch� i V� l﹎ i h閕 b総 u.", 0)
do return end
	if (GetLevel() < 90) then
		Say("B筺 ph秈 t 頲 c蕄 90 tr� l猲 m韎 c� th� x﹎ nh藀 u trng V� l﹎ i h閕, h穣 ti誴 t鬰 luy謓 th猰!", 0)
		return
	end
	if (GetLastFactionNumber() == -1) then
		Say("V� L﹎ Minh Ch� c� l謓h: Ch� c� ngi c馻 Th藀 i ph竔 頲 tham gia Чi h閕 v� l﹎, ngi kh玭g m玭 kh玭g ph竔 kh玭g th� tham gia. Sau khi gia nh藀 Th藀 i ph竔 m韎 頲 tham gia thi u!", 0)
		return
	elseif(nt_gettask(CP_TASKID_REGIST) ~= CP_UPTO_TRYOUT) then
		Msg2Player("B筺 ch璦 b竜 danh! H穣 n Quan vi猲 V� l﹎ ki謙 xu蕋 b竜 danh tham gia tr薾 d� tuy觧!")
		NewWorld(176, 1444, 3256)
	else
		if(GetLastFactionNumber() == 0) then
			NewWorld(CP_MAPTAB[1][1], CP_MAPPOS_IN[1], CP_MAPPOS_IN[2])--少林
		elseif (GetLastFactionNumber() == 1) then
			NewWorld(CP_MAPTAB[2][1], CP_MAPPOS_IN[1], CP_MAPPOS_IN[2])--天王
		elseif (GetLastFactionNumber() == 2) then
			NewWorld(CP_MAPTAB[3][1], CP_MAPPOS_IN[1], CP_MAPPOS_IN[2])--唐门
		elseif (GetLastFactionNumber() == 3) then
			NewWorld(CP_MAPTAB[4][1], CP_MAPPOS_IN[1], CP_MAPPOS_IN[2])--五毒
		elseif (GetLastFactionNumber() == 4) then
			NewWorld(CP_MAPTAB[5][1], CP_MAPPOS_IN[1], CP_MAPPOS_IN[2])--峨嵋
		elseif (GetLastFactionNumber() == 5) then
			NewWorld(CP_MAPTAB[6][1], CP_MAPPOS_IN[1], CP_MAPPOS_IN[2])--翠烟
		elseif (GetLastFactionNumber() == 6) then
			NewWorld(CP_MAPTAB[7][1], CP_MAPPOS_IN[1], CP_MAPPOS_IN[2])--丐帮
		elseif (GetLastFactionNumber() == 7) then
			NewWorld(CP_MAPTAB[8][1], CP_MAPPOS_IN[1], CP_MAPPOS_IN[2])--天忍
		elseif (GetLastFactionNumber() == 8) then
			NewWorld(CP_MAPTAB[9][1], CP_MAPPOS_IN[1], CP_MAPPOS_IN[2])--武当
		elseif (GetLastFactionNumber() == 9) then
			NewWorld(CP_MAPTAB[10][1], CP_MAPPOS_IN[1], CP_MAPPOS_IN[2])--昆仑
		end
		Talk(1, "", "B筺  v祇 u trng V� l﹎ i h閕, h穣 n vi猲 quan u trng (189, 188) , (191, 190) , (185, 187) xin tham gia thi u v遪g n祔!")
	end
end

function checkmap(flag)
	local mapid = SubWorldIdx2ID(SubWorld)
	local ladder = 0
	if (mapid == 397 or mapid == 396) then
		mapname = "Thi誹 L﹎"
		ladder = 10120
	elseif (mapid == 399 or mapid == 398) then
		mapname = "Thi猲 Vng"
		ladder = 10121
	elseif (mapid == 401 or mapid == 400) then
		mapname = "Л阯g M玭"
		ladder = 10122
	elseif (mapid == 403 or mapid == 402) then
		mapname = "Ng� чc"
		ladder = 10123
	elseif (mapid == 405 or mapid == 404) then
		mapname = "Nga Mi"
		ladder = 10124
	elseif (mapid == 407 or mapid == 406) then
		mapname = "Th髖 Y猲"
		ladder = 10125
	elseif (mapid == 409 or mapid == 408) then
		mapname = "C竔 Bang"
		ladder = 10126
	elseif (mapid == 411 or mapid == 410) then
		mapname = "Thi猲 Nh蒼"
		ladder = 10127
	elseif (mapid == 413 or mapid == 412) then
		mapname = "V� ng"
		ladder = 10128
	elseif (mapid == 415 or mapid == 414) then
		mapname = "C玭 L玭"
		ladder = 10129
	end
	if (flag == 1) then
		return mapname
	elseif(flag == 2) then
		return ladder
	end
end

function help_bid()
	Talk(1, "help_bid_2", CP_HELP_BID[1])
end

function help_bid_2()
	Talk(2, "", CP_HELP_BID[2], CP_HELP_BID[3])
end
function help_tryout()
	Talk(2, "help_tryout_2", CP_HELP_TRYOUT[1], CP_HELP_TRYOUT[2])
end;

function help_tryout_2()
	Talk(2, "", CP_HELP_TRYOUT[3], CP_HELP_TRYOUT[4])
end

function help_final()
	Talk(1, "", CP_HELP_FINAL)
end

function help_championship()
	Say("B筺 mu鑞 nh薾 頲 gi髉  c馻 b猲 n祇?", 4, "Tranh ch蕄 T鎛g L躰h i c馻 khu v鵦/help_bid", "tr薾 d� tuy觧 Чi h閕 V� l﹎ ki謙 xu蕋/help_tryout", "V� L﹎ i h閕/help_final", "C竔 n祔 ta hi觰 r錳!/OnCancel")
end

function validateDate(startt,endt)
	local now = tonumber(date("%y%m%d%H"))
	if(now >= startt and now < endt) then
		return 1
	end
	return nil
end

function AddAword(level, fac, result)
	local awardpro = {}
	if (level >120) then
		level = 120
	end
	aword = (700 + floor((level * 4 - 350) / 5) * 100) * 60 * fac
	AddOwnExp(aword)
	if( result == 0 )then
		return
	end
	for i = 1, getn(CP_AWARD_ITEM) do
		awardpro[i] = CP_AWARD_ITEM[i][3]
	end
	numth = randByProbability(awardpro)
	if (getn(CP_AWARD_ITEM[numth][2]) == 6 ) then
		AddItem(CP_AWARD_ITEM[numth][2][1], CP_AWARD_ITEM[numth][2][2], CP_AWARD_ITEM[numth][2][3], CP_AWARD_ITEM[numth][2][4], CP_AWARD_ITEM[numth][2][5], CP_AWARD_ITEM[numth][2][6])
	else
		AddEventItem(CP_AWARD_ITEM[numth][2][2])
	end
	Msg2Player("B筺 nh薾 頲 m閠"..CP_AWARD_ITEM[numth][1])
end

function randByProbability(aryProbability)
	local nRandNum;
	local nSum = 0;
	local nArgCount = getn( aryProbability );
	for i = 1, nArgCount do
		nSum = nSum + aryProbability[i];
	end
	nRandNum = mod( random( nSum ) + random( 1009 ), nSum ) + 1;
	for i = nArgCount, 1, -1 do
		nSum = nSum - aryProbability[i];
		if( nRandNum > nSum ) then
			return i;
		end
	end
end

-- 设置任务状态
function nt_settask(nTaskID, nTaskValue)
	SetTask(nTaskID, nTaskValue)
	SyncTaskValue(nTaskID) -- 同步到客户端
end

-- 获取任务状态
function nt_gettask(nTaskID)
	return GetTask(nTaskID)
end


------------------------------------------------------------------------------------------
function GetIniFileData(mapfile, sect, key)
	if (IniFile_Load(mapfile, mapfile) == 0) then 
		print("Load IniFile Error!"..mapfile)
		return ""
	else
		return IniFile_GetData(mapfile, sect, key)	
	end
end


------------------------------------------------------------------------------------
-- 打开一个文件
function biwu_loadfile(filename)
	if (IniFile_Load(filename, filename) == 0) then
		File_Create(filename)
	end
end

--获得文件中的szSection的key的值
function biwu_getdata(filename, szsect, szkey)
	return IniFile_GetData(filename, szsect, szkey)
end

--设置文件中的szSection的key值为szValue
function biwu_setdata(filename, szsect, szkey, szvalue)
	IniFile_SetData(filename, szsect, szkey, szvalue)	
end

function biwu_save(filename)
	IniFile_Save(filename, filename)
end

------------------------------------------------------------------------------------
function Sort_Point(array)
	local orgindex = PlayerIndex
	local point_1 = 0
	local point_2 = 0
	local wincount_1 = 0
	local wincount_2 = 0
	local winrate_1 = 0
	local winrate_2 = 0
	for i = 1, getn(array) do
		for j = getn(array), 2, -1 do
			PlayerIndex = array[j]
			point_1 = nt_gettask(CP_TASKID_ROUND)
			wincount_1 = nt_gettask(CP_TASKID_WIN)
			if (point_1 == 0 or wincount_1 == 0) then
				winrate_1 = 0
			else
				winrate_1 = wincount_1/point_1
			end
			
			PlayerIndex = array[j - 1]
			point_2 = nt_gettask(CP_TASKID_ROUND)
			wincount_2 = nt_gettask(CP_TASKID_WIN)
			if (point_2 == 0 or wincount_2 == 0) then
				winrate_2 = 0
			else
				winrate_2 = wincount_2/point_2
			end
			
			if (winrate_1 > winrate_2) then
				a = array[j]
				array[j] = array[j - 1]
				array[j - 1] = a
			end
		end
	end
	PlayerIndex = orgindex
	return array
end

function OnCancel()
end