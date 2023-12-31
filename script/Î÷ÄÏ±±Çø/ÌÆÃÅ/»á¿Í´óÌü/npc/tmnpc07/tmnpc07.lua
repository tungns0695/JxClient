--description: 唐门唐仇 20级任务、出师任务 
--author: yuanlan	
--date: 2003/3/11
--Dan_Deng(2003-07-22), 加入门派任务的等级要求
--Dan_Deng(2003-07-24), 加入重返门派任务
-- Update: Dan_Deng(2003-08-13)
-- Update: Dan_Deng(2003-09-21)重新设计重返门派与镇派绝学相关
-- Update：Dan_Deng(2003-10-27)为重返师门任务加入取消任务功能，以及与新门派对应

Include("\\script\\global\\skills_table.lua")
Include([[\script\event\teachersday06_v\prize_qingyika.lua]]);
Include("\\script\\task\\lv120skill\\head.lua")
Include("\\script\\misc\\daiyitoushi\\toushi_function.lua")	-- 带艺投师
--dinhhq: new lunar year 2011
Include("\\script\\vng_event\\LunarYear2011\\npc\\mastergift.lua")

function main()
	if tbVNG_LY2011:isActive() == 1 then
		local tbSay = 
			{
				"T苙g b竛h ng祔 xu﹏/#tbMasterGift:getGift('tangmen')",
				"Mu鑞 th豱h gi竜 vi謈 kh竎/oldMain"
			}
		Say("N╩ m韎 an khang th辬h vng", getn(tbSay), tbSay)
		return
	end
	oldMain()
end

function oldMain()
	if (vt06_isactive() ~= 0) then
		Say("T譵 ta c� vi謈 g�?", 2, "Mu鑞 th豱h gi竜 i s�!/oldentence", "M鮪g l�  S�, t筰 h�  t譵  揟h�  S瓟 v� 揟h� Cao у�./vt06_prizeenter");
		return
	end;
	
	if (GetLevel() >= 120 and GetTask(LV120_SKILL_STATE) ~= 19 and GetLastFactionNumber() == 2) then
		Describe("T譵 ta c� vi謈 g�?", 2,
			"H鋍 k� n╪g c蕄 120./lvl120skill_learn",
			"Mu鑞 th豱h gi竜 vi謈 kh竎/oldentence"
			);
		return
	end;
	
	oldentence()
end;

function oldentence()
--	if (check_skill() == 0) then
--		return
--	end
	local UTask_tm = GetTask(2);
	local nFactID = GetLastFactionNumber();
	
	if (UTask_tm == 70*256) and (GetFaction() == "tangmen") then			-- 回师错误修正
		SetFaction("")
		Say("H� th鑞g ph竧 hi謓 sai s鉻,  k辮 th阨 h錳 phuc!",0)
		return
	elseif (UTask_tm == 70*256) and (GetTask(10) >= 5*256) and (GetTask(10) < 10*256) then		-- 以前接过入门任务的
		SetTask(10,0)
		Say("H� th鑞g ph竧 hi謓 sai s鉻,  k辮 th阨 h錳 phuc!",0)
		return
	elseif (UTask_tm == 80*256) and (GetCamp() == 4) then			-- 回师错误修正
		SetTask(2,70*256)
		Say("H� th鑞g ph竧 hi謓 sai s鉻,  k辮 th阨 h錳 phuc!",0)
		return
	elseif (UTask_tm == 80*256 and nFactID == 2 and GetCamp() == 3 and GetFaction() == "M韎 nh藀 giang h� ") then
		 local _, nTongID = GetTong();
		 if (nTongID == 0) then
			SetFaction("tangmen");
			Say("H� th鑞g ph竧 hi謓 sai s鉻,  k辮 th阨 h錳 phuc!",0)
			return
		end
	elseif (UTask_tm == 70*256 and nFactID == 2 and GetCamp() ~= 4 and GetFaction() == "M韎 nh藀 giang h� ") then
		 local _, nTongID = GetTong();
		 if (nTongID == 0) then
			SetFaction("");
			SetCurCamp(GetCamp());
			Say("H� th鑞g ph竧 hi謓 sai s鉻,  k辮 th阨 h錳 phuc!",0)
			return
		end
	end

	local tbDes = {"Цi ngh� u s�/#daiyitoushi_main(2)", "Mu鑞 th豱h gi竜 vi謈 kh竎/common_talk"};
	
	Say("G莕 y ta c� r蕋 nhi襲 vi謈 gi秈 quy誸, ngi n y c� vi謈 g�.", getn(tbDes), tbDes);
end

function common_talk()
	local UTask_tm = GetTask(2);
	local Uworld51 = GetTask(51)
	if (GetTask(39) == 10) and (GetBit(GetTask(40),2) == 0) then				-- 世界任务：武林向背
		if (GetSex() == 0) then
			Talk(1,"","Л阯g M玭 t� s� gi竜 hu蕁  t� kh玭g 頲 can d� chuy謓 ngo礽. Л阯g C鮱 ta kh玭g d竚 tr竔 l阨. Nh� c玭g t� y chuy觧 l阨 xin l鏸 n чc c� Minh ch�.")
		else
			Talk(1,"","Л阯g M玭 t� s� gi竜 hu蕁  t� kh玭g 頲 can d� chuy謓 ngo礽. Л阯g C鮱 ta kh玭g d竚 tr竔 l阨. Nh� c玭g t� y chuy觧 l阨 xin l鏸 n чc c� Minh ch�.")
		end
		Uworld40 = SetBit(GetTask(40),2,1)
		SetTask(40,Uworld40)
	elseif (Uworld51 == 30) then				-- 洗清冤屈任务进行中
		Talk(4,"Uworld51_40","M玭 ch�, t筰 h� nghe n鉯 ngi c� th祅h ki課 v韎 c玭g t� Nh蕋 Tr莕. Hi謓 gi� h緉 產ng b� ngi hi觰 l莔.","Зy l� chuy謓 c馻 Л阯g gia, kh玭g li猲 quan n ngi!","M玭 ch�, c玭g t� Nh蕋 Tr莕 ch輓h l� con ru閠 c馻 玭g�..!","H�! Ti詎 kh竎h! ")
	elseif (Uworld51 == 80) and (HaveItem(377) == 1) then				-- 洗清冤屈任务：已经夺回秘笈
		Talk(8,"Uworld51_90","M玭 ch�,chuy謓 Thi誹 L﹎ cao t╪g g苝 n筺 ta  tra r�! Sau khi Thi猲 Nh蒼 gi竜 畂箃 頲 B� ki誴 c馻 b鎛 gi竜, l衝 竚 to竛 nh鱪g Thi誹 L﹎ cao th�. B� ki誴 n祔 do B蕋 Nhi詍 c玭g t� ti誸 l� ra ngo礽!","C竔 g�? Sao l筰 nh� v藋 頲?","B蕋 Nhi詍 lo ng筰 Nh蕋 Tr莕 l� con trng, e r籲g tng lai c� th� s� gi祅h l蕐 ng玦 v� Chng m玭. V� th� m� h緉 thng li猲 l筩 v韎 B筩h c玭g t� m藅 s� Kim Qu鑓, tr閙 s竎h cho Thi猲 Nh蒼 gi竜!","Sau khi Thi猲 Nh蒼 gi竜 c� 頲 s竎h n祔,  ph竔 2 t猲 cao th� 甶 竚 s竧 Thi誹 L﹎ cao th�. L莕 n祔 khi h� 產ng chu萵 b� 竚 s竧 C竔 Bang cao th�. T筰 h� s� 甶 h� th� h� v� 畂箃 v� B� ki誴 c馻 b鎛 m玭, xin m玭 ch� ng b薾 t﹎.","B蕋 nhi詍卨筰 c� chuy謓 nh� v藋 �?厖M総 ta m� r錳 n猲 nu玦 nh莔 ngh辌h t�!","M玭 ch� b韙 gi薾, suy cho c飊g B蕋 Nhi詍 c玭g t� ch� nh蕋 th阨 h� . T筰 h� d竚 xin m玭 ch� tha cho h緉 1 l莕!","T猲 i ngh辌h b蕋 o d竚 l祄 c竔 chuy謓 quay l璶g ch鑞g l筰 b鎛 m玭, t閕 ch誸 kh玭g tha v� ng h遪g k� th鮝 ng玦 v� Chng m玭.","Nh� ngi thay ta an 駃 Nh蕋 Tr莕, h鉧 ra ta  tr竎h l莔 h緉!")
	elseif (GetFaction() == "tangmen") and (GetSeries() == 1) then
		if ((UTask_tm >= 20*256+60) and (UTask_tm <= 20*256+70) and (HaveItem(41) == 1)) then		-- 20级任务完成
			Talk(5, "L20_prise", "Зy ch糿g ph秈 l� Kim H筺g Khuy猲 c馻 U mu閕 mu閕 sao? Sao n� l筰 � y?", "Зy l� v藅 m� s� c� nh� t筰 h� trao cho Chng M玭, b�  tha th� cho Chng m玭 r錳!", "U mu閕 mu閕 th藅  tha th� cho ta? C� th藅 n祅g mu鑞 h錳 gia? Ch輓h ngi thuy誸 ph鬰 n祅g �?", "Chuy謓 n祔 l� do Чi s� huynh an b礽,  t� ch糿g bi誸 l祄 g� c�?", "D� ngi c� n鉯 sao, nh璶g ngi  gi髉 ta m� ra ni襪 vui cho cu閏 i n祔. C玭g lao r蕋 l韓, ta s� kh玭g b筩 i ngi.")
		elseif (UTask_tm == 60*256+60) and (HaveItem(49) == 1) then		-- 出师任务完成
			Talk(3, "L60_prise", "Chng m玭, trong Tr骳 T� ng ta t譵 頲 thanh ki誱 c飊 n祔. N� c� ph秈 l� Th蕋 Tinh Tuy謙 M謓h Ki誱 trong truy襫 thuy誸 nh綾 t韎?", "Kh玭g sai. Зy ch輓h l� Th蕋 Tinh Tuy謙 M謓h Ki誱! Tuy b� ngo礽 t莔 thng nh璶g gi� tr� c馻 n� ch輓h l� � ch� ngi  ch鋘 n�.Ngi  thu薾 l頸 xu蕋 s�!", "B筺  頲 phong l祄 Thi猲 th� th莕 v� c馻 Л阯g M玭. T� h玬 nay c� th� t� do h祅h hi謕 giang h�!C� th� ch鋘 gia nh藀 v祇 m玭 ph竔 kh竎 ti誴 t鬰 h鋍 ngh�, c騨g c� th� t� l藀 bang h閕 m� r閚g th� l鵦 giang h�, ho芻 l祄 c kh竎h h祅h oai phong l蒻 li謙! Giang h� ki誱 hi謕, tr阨 cao t r閚g, hy v鋘g b筺 s� ti誴 t鬰 ph竧 tri觧 ti襫  c馻 m譶h")
		elseif (UTask_tm == 60*256+70) then				--出师任务
			Talk(3, "L60_fail", "L� Th蕋 Tinh Tuy謙 M謓h Ki誱 ta c莕 �?", "............", "Ngi  b� ti襫 t礽 b竨 v藅 m� ho芻, l祄 sao ta y猲 t﹎  ngi xu蕋 s� y? Kh玭g ch鮪g c� m閠 ng祔 ngi v� c竔 l頸 l韓 h琻 m� quay l璶g ph秐 l筰 b鎛 m玭!")
		elseif (UTask_tm == 60*256+80) then
			if (GetCash() >= 20000) then
				Talk(1,"","Th蕐 ngi th藅 t﹎ h鑙 l鏸, ta s� cho ngi th猰 m閠 c� h閕. H穣 n Tr骳 T� чng l蕐 v� Th蕋 Tinh Tuy謙 M謓h Ki誱.")
				Pay(20000)
				SetTask(2, 60*256+20)
				AddNote("Tr� 20000 lng, c莡 xin chng m玭 tha th�, n Tr骳 T� ng l蕐 Th蕋 Tinh Tuy謙 M謓h ki誱. ")
				Msg2Player("Tr� 20000 lng, c莡 xin chng m玭 tha th�, n Tr骳 T� ng l蕐 Th蕋 Tinh Tuy謙 M謓h ki誱. ")
			else
				Talk(1,"","H鑙 l鏸 kh玭g th� n鉯 su玭, mau l蕐 ti襫 n閜 ra r錳 m韎 n鉯 chuy謓 v韎 ta!")
			end
		elseif (UTask_tm == 60*256+90) then
			if (GetCash() >= 40000) then
				Talk(1,"","H�! Ta s� cho ngi th猰 m閠 c� h閕. H穣 甶 Tr骳 T� чng l蕐 v� Th蕋 Tinh Tuy謙 M謓h Ki誱..")
				Pay(40000)
				SetTask(2, 60*256+20)
				AddNote("Tr� 40000 lng, c莡 xin chng m玭 tha th�, n Tr骳 T� ng l蕐 Th蕋 Tinh Tuy謙 M謓h ki誱. ")
				Msg2Player("Tr� 40000 lng, c莡 xin chng m玭 tha th�, n Tr骳 T� ng l蕐 Th蕋 Tinh Tuy謙 M謓h ki誱. ")
			else
				Talk(1,"","N祔! Mau n閜 ra 4 v筺 lng, r錳 甶 Tr骳 T� чng l蕐 v� Th蕋 Tinh Tuy謙 M謓h Ki誱.. ")
			end
		elseif ((UTask_tm == 60*256) and (GetLevel() >= 50) and (GetFaction() == "tangmen")) then				--出师任务启动
			Say("Khi ngi � b鎛 m玭 h鋍 th猰, th莥 ph秈 th� th竎h ngi. N琲 r鮪g tr骳 s﹗ th糾 � hng Йng c� 1 <color=Red>Tr骳 T� ng<color>. N誹 ngi c� th� n <color=Red>Tr骳 T� ng<color> l蕐 v� 1 thanh <color=Red> Th蕋 Tinh Tuy謙 M謓h Ki誱 <color> l� c� th� thu薾 l頸 xu蕋 s�!", 2, "Ti誴 nh薾 ki觤 tra /L60_get_yes", "T筸 kh玭g ti誴 nh薾 /no")
		elseif (UTask_tm == 80*256) then						-- 重返后的自由出入
			Say("L筰 ho礽 ni謒 v� s鉵g gi� giang h� sao?",2,"V﹏g, xin m玭 ch� cho  t� 頲 h祅h t萿 giang h�. /goff_yes","е t� t藀 luy謓 c遪 ch璦 , ph秈 n� l鵦 luy謓 c玭g. /no")
		elseif (UTask_tm > 20*256) and (UTask_tm < 20*256+60) then					--已经接到20级任务，尚未完成
			Talk(1,"","Kh玭g bi誸 U mu閕 mu閕 cu閏 s鑞g ra sao? M穒 n h玬 nay n祅g v蒼 kh玭g ch辵 tha th� cho ca ca n祔!")
		elseif (UTask_tm >= 30*256) and (UTask_tm <= 60*256) then					--已经完成20级任务，尚未接到出师任务
			Talk(1,""," Ngi  gi髉 ta t譵 l筰 頲 ngu錸 vui, ta s� kh玭g b筩 i ngi!")
		elseif (UTask_tm > 60*256) and (UTask_tm < 70*256) then					--已经接到出师任务，尚未完成
			Talk(1,"","Ch� c莕 n <color=Red>Tr骳 T� ng<color> l蕐 v� 1 thanh <color=Red> Th蕋 Tinh Tuy謙 M謓h Ki誱 <color> th� xem nh� ngi tr穒 qua th� th竎h xu蕋 s�!")
		else					--已经入门，尚未接20级任务（缺省对话）
			Talk(1,"","K� n╪g c馻 b鎛 m玭 t� trc d課 nay kh玭g truy襫 ra ngo礽. N誹  t� m玭 h� c� ngi ti誸 l� tuy謙 k�, s� chi誹 theo m玭 quy m� h祅h x�, quy誸 kh玭g nng tay!")
		end
--	elseif (GetTask(10) == 5*256+10) then		-- 转门派到五毒教
--		Say("唐仇：想投入五毒？须知本门不许带艺另投，除非你先自行废去本门绝艺。你不再重新考虑一下吗？",2,"不错，我意已决/defection_yes","我还是不去五毒算了/defection_no")
	elseif (GetSeries() == 1) and (GetCamp() == 4) and (GetLevel() >= 60) and (UTask_tm == 70*256) and (GetTask(10) < 5*256) then		-- 重返师门任务
		Say("L莕 n祔 tr� v�, ngi mu鑞 quay l筰 Л阯g M玭 sao?",2,"Tu﹏ l謓h!/return_yes","Kh玭g. /return_no")
	elseif (GetCamp() == 4) and ((UTask_tm == 70*256+10) or (UTask_tm == 70*256+20)) then		-- 重返师门任务中
		Say("Х chu萵 b�  5 v筺 lng ch璦?",2,"Х chu萵 b� xong/return_complete","V蒼 ch璦 chu萵 b� xong/return_uncompleted")
	elseif (Uworld51 >= 90) then			-- 已经完成“洗清冤屈”任务
		Talk(1,"","T猲 s骳 sinh B蕋 Nhi詍 cu鑙 c飊g  ph� ta!")
	elseif (UTask_tm == 70*256) and (GetFaction() ~= "tangmen") then							--已经出师
		Talk(1,"","Sau khi ngi xu蕋 s�, ng  ngi ta xem thng c玭g phu c馻 b鎛 m玭!")
	else
		Talk(1,"","Ngi i u xem Л阯g M玭 l� Long Уm H� Huy謙. Xem Л阯g C鮱 ta l� t猲 ma u h� n� v� thng. H�! C� can h� g� ch�?")
	end
end;
---------------------- 技能调整相关 ------------------------
function check_skill()
	x = 0
	skillID = 51					-- 青木功
	i = HaveMagic(skillID)
	if (i >= 0) then
		x = x + 1
		DelMagic(skillID)
		AddMagicPoint(i)
	end
	if (GetFaction() == "tangmen") and (GetTask(2) == 80*256) and (HaveMagic(253) == -1) then		-- 重返师门且无新技能
		AddMagic(253)
		Msg2Player("B筺 h鋍 頲 Ng� чc Th鵦 C鑤. ")
		Say("Ta  nhi襲 ng祔 b� quan kh� luy謓, ch� t筼 ra 1 chi猽 Ng� чc Th鵦 C鑤, nay ta truy襫 l筰 cho ngi! Sau khi ngi h鋍 xong, ph秈 ch� � ngh� ng琲,  tr竛h t鎛 thng kinh m筩h!",1," t� s� ph� /KickOutSelf")
		return 0
	elseif (x > 0) then		-- 若有技能发生变化，则踢下线，否则返回继续流程
		Say("Ta  nhi襲 ng祔 b� quan kh� luy謓, ch� t筼 ra 1 chi猽 Ng� чc Th鵦 C鑤, nay ta truy襫 l筰 cho ngi! Sau khi ngi h鋍 xong, ph秈 ch� � ngh� ng琲,  tr竛h t鎛 thng kinh m筩h!",1," t� s� ph� /KickOutSelf")
		return 0
	else
		return 1
	end
end

------------------------ 重返门派相关 -------------------------
function goff_yes()
	Talk(1,"","Л頲, h穣 甶 甶! N猲 nh� kh玭g th� k誸 giao v韎 gian t�.")
	SetTask(2,70*256)
	AddNote("Ra kh醝 Л阯g m玭, l筰 甶 h祅h t萿 giang h�. ")
	Msg2Player("B筺 r阨 kh醝 Л阯g m玭, l筰 甶 h祅h t萿 giang h�. ")
	SetFaction("")
	SetCamp(4)
	SetCurCamp(4)
end

function defection_yes()			-- 转派，收回原门派武功技能
-- 刷掉技能
	n = 0
	i=45; x = HaveMagic(i); if (x ~= -1) then n = n + x end; DelMagic(i)			-- 霹雳弹
	i=43; x = HaveMagic(i); if (x ~= -1) then n = n + x end; DelMagic(i)			-- 唐门暗器
	i=44; x = HaveMagic(i); if (x ~= -1) then n = n + x end; DelMagic(i)			-- 唐门刀法
	i=47; x = HaveMagic(i); if (x ~= -1) then n = n + x end; DelMagic(i)			-- 夺魂镖
	i=48; x = HaveMagic(i); if (x ~= -1) then n = n + x end; DelMagic(i)			-- 心眼
	i=50; x = HaveMagic(i); if (x ~= -1) then n = n + x end; DelMagic(i)			-- 追心箭
	i=51; x = HaveMagic(i); if (x ~= -1) then n = n + x end; DelMagic(i)			-- 青木功（已取消）
	i=54; x = HaveMagic(i); if (x ~= -1) then n = n + x end; DelMagic(i)			-- 漫天花雨
	i=55; x = HaveMagic(i); if (x ~= -1) then n = n + x end; DelMagic(i)			-- 淬毒术
	i=57; x = HaveMagic(i); if (x ~= -1) then n = n + x end; DelMagic(i)			-- 冰魄寒光
	i=58; x = HaveMagic(i); if (x ~= -1) then n = n + x end; DelMagic(i)			-- 天罗地网
	i=249;x = HaveMagic(i); if (x ~= -1) then n = n + x end; DelMagic(i)			-- 小李飞刀
	i=253;x = HaveMagic(i); if (x ~= -1) then n = n + x end; DelMagic(i)			-- 驭毒蚀骨
	AddMagicPoint(n)
-- 刷完技能后继续转门派流程
	SetTask(10,5*256+20)
	SetTask(2,75*256)				-- 为原门派作个标记
	SetRank(66)
	if (GetRepute() < 200) then
		Msg2Player("V� h祅h vi b蕋 trung v韎 m玭 ph竔, danh v鋘g c馻 b筺 gi秏 xu鑞g "..GetRepute().."甶觤!")
		AddRepute(-1 * GetRepute())
	else
		Msg2Player("V� h祅h vi b蕋 trung v韎 m玭 ph竔, danh v鋘g c馻 b筺 gi秏 xu鑞g 200 甶觤! ")
		AddRepute(-200)
	end
	AddNote("Л阯g C鮱 thu h錳 v� c玭g Л阯g M玭 c馻 b筺, h駓 b� ch鴆 danh L鬰 C竎 Trng L穙. B﹜ gi� b筺 c� th� gia nh藀 Ng� чc Gi竜 r錓. ")
	Msg2Player("Л阯g C鮱 thu h錳 v� c玭g Л阯g M玭 c馻 b筺, h駓 b� ch鴆 danh L鬰 C竎 Trng L穙. B﹜ gi� b筺 c� th� gia nh藀 Ng� чc Gi竜 r錓. ")
	Talk(1,"KickOutSelf","б ph遪g ti誸 l� tuy謙 h鋍 c馻 b鎛 m玭, ngi  quy誸 l遪g mu鑞 gia nh藀 Ng� чc, ta nh ph秈 thu h錳 tuy謙 k� Л阯g m玭 c馻 ngi!")
end

function defection_no()
	AddNote("B筺 t� b� � nh gia nh藀 Ng� чc Gi竜. ")
	Msg2Player("B筺 t� b� � nh gia nh藀 Ng� чc Gi竜. ")
	SetTask(10,1*256)			-- 为企图叛师做个标记，以备将来不时之需
end

function return_yes()
	Talk(3,"","ng! е t� tr猲 giang h� ch璦 l藀 n猲 c玭g danh g�, mu鑞 xin c竎 v� th骳 b� ch� gi竜 th猰!","Chi誹 theo m玭 quy, ngi ph秈 n閜 5 v筺 lng  tr飊g ph秐 b鎛 m玭!","D�! в  t� chu萵 b� m閠 ch髏!")
	SetTask(2,70*256+20)
	AddNote("Giao n筽 50000 lng b筩 th� l藀 t鴆 c� th� quay l筰 Л阯g m玭 ")
	Msg2Player("Giao n筽 50000 lng b筩 th� l藀 t鴆 c� th� quay l筰 Л阯g m玭 ")
end;

function return_no()
	Talk(2,"","Ta mu鑞 t� m譶h phi猽 b箃 giang h� th猰 1 th阨 gian n鱝.","Х nh� th�, ngi h穣 t� m譶h b秓 tr鋘g!")
end;

function return_complete()
	if(GetCash() >= 50000) then
		Talk(1,"","Hay l緈! Ngi  th祅h t﹎ nh� v藋! Ta sao n� t� ch鑙!")
		Pay(50000)
		SetTask(2,80*256)
		SetRank(76)
--		if (HaveMagic(48) == -1) then
--			AddMagic(249)
--			AddMagic(58)
--			AddMagic(341)
--			AddMagic(48)
		add_tm(70)			-- 调用skills_table.lua中的函数，参数为学到多少级技能。
		Msg2Player("B筺  h鋍 頲 tuy謙 h鋍 tr蕁 ph竔: T﹎ Nh穘, v� c玭g Ti觰 L� Phi o, Thi猲 La мa V鈔g, T竛 Hoa Ti猽. ")
--		end
		SetFaction("tangmen")
		SetCamp(3)
		SetCurCamp(3)
		AddNote("Х quay l筰 Л阯g M玭, ng trong h祅g ng� ")
		Msg2Player(GetName().."Quay l筰 Л阯g M玭, 頲 th╪g l� L鬰 C竎 trng l穙. ")
	else
		Talk(2,"","Ngi r� l� c遪 ch璦 chu萵 b� xong!","Xin l鏸! в ta ki觤 tra l筰.")
	end
end;

function return_uncompleted()
	Talk(1,"","Kh玭g sao, ti誴 t鬰 chu萵 b� 甶!")
end;

----------------------- 20级任务 -----------------------
function L20_prise()
	DelItem(41)
	SetRank(27)	
	SetTask(2, 30*256)
--	AddMagic(303)
	add_tm(30)			-- 调用skills_table.lua中的函数，参数为学到多少级技能。
	Msg2Player("Ch骳 m鮪g b筺! B筺  頲 th╪g l祄 Л阯g M玭 H� Vi謓, 頲 h鋍 v� c玭g чc Th輈h C鑤 ")
	AddNote("Giao Kim H筺g quy觧 cho Л阯g C鮱 chng m玭, ho祅 th祅h nhi謒 v� Л阯g U. Л頲 th╪g l祄 H� Vi謓. ")
end;

----------------------- 出师任务 --------------------------
function L60_get_yes()
	SetTask(2, 60*256+20)
	AddNote("T筰 i s秐h ( 508, 322) , g苝 Л阯g C鮱, nh薾 <color=red>nhi謒 v� xu蕋 s�<color>, t韎 Tr骳 T� чng thu h錳 Th蕋 Tinh Tuy謙 M謓h Ki誱. ")
	Msg2Player("T筰 i s秐h g苝 Л阯g C鮱, nh薾 nhi謒 v� xu蕋 s�, t韎 Tr骳 T� чng thu h錳 Th蕋 Tinh Tuy謙 M謓h Ki誱. ")
end;

function L60_prise()
	DelItem(49)
	Msg2Player("Ch骳 m鮪g b筺 h鋍 th祅h t礽 c� th� xu蕋 s�! B筺 頲 phong l� Thi猲 Th� Th莕 V�.. Danh v鋘g t╪g th猰 120 di觤. ")
--	AddGlobalCountNews(GetName().."艺成出师，告别各位同门行走江湖。", 1)
	Msg2SubWorld("Л阯g M玭"..GetName().."Th祅h t礽 xu蕋 s�, t� bi謙 c竎 huynh mu閕 ng m玭  h祅h t萿 giang h�. ")
	AddRepute(120)
	SetRank(66)
	SetTask(2, 70*256)
	SetFaction("")				    			--玩家退出唐门
	SetCamp(4)
	SetCurCamp(4)
	AddNote("Tr� v� Л阯g M玭, giao Th蕋 Tinh Tuy謙 M謓h Ki誱 cho Л阯g C鮱 chng m玭, ho祅 th祅h nhi謒 v� xu蕋 s�. Л頲 th╪g l祄 Thi猲 Th� Th莕 V�. ")
end;

function L60_fail()
	Say("Chng m玭 t鴆 gi薾 r錳, b筺 ph秈 l祄 sao y?", 2, "Ti襫 n tay r錳 m� c遪 xui x蝟 /L60_faila", "Xin chng m玭 lng th�. /L60_failb")
end;

function L60_faila()
	SetTask(2,60*256+90)
	Talk(1,"","N祔! Mau a 4 v筺 lng r錳 c髏 v� Tr骳 T� ng l蕐 Th蕋 Tinh Tuy謙 M謓h Ki誱 v� cho ta!")
end;

function L60_failb()
	SetTask(2,60*256+80)
	Talk(1,"","Th蕐 ngi th藅 t﹎ h鑙 l鏸, ta s� cho ngi th猰 m閠 c� h閕. L藀 t鴆 n閜 2 v筺 lng ra, r錳 甶 Tr骳 T� чng l蕐 v� Th蕋 Tinh Tuy謙 M謓h Ki誱.")
end;

----------------------- 世界任务 --------------------------
function Uworld51_40()
	SetTask(51,40)
	Msg2Player("Xem ra kh玭g c� c竎h n祇 khuy猲 Л阯g C鮱, b筺 nh 甶 t譵 s� ph� Л阯g H筩 c馻 Л阯g Nh蕋 Tr莕 gi秈 quy誸 chuy謓 n祔 ")
end

function Uworld51_90()
	DelItem(377)
	SetTask(51,90)
	Msg2Player("Ch﹏ tng r� r祅g, Л阯g C鮱 cu鑙 c飊g bi誸 r籲g  hi觰 l莔 Л阯g Nh蕋 Tr莕. Mau 甧m tin t鴆 b竜 cho Nh蕋 Tr莕 c玭g t�. ")
	AddNote("Ch﹏ tng r� r祅g, Л阯g C鮱 cu鑙 c飊g bi誸 r籲g  hi觰 l莔 Л阯g Nh蕋 Tr莕. ")
end

function no()
end
