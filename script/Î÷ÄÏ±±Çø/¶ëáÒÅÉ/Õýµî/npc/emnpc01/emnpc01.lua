--description: 峨嵋派清晓师太（峨嵋入门任务、50级任务、出师任务、重返门派任务）
--author: yuanlan	
--date: 2003/3/6
--update: Dan_Deng(2003-07-22), 加入门派任务的等级要求
--update: Dan_Deng(2003-07-24), 加“重返门派”任务
-- Update: Dan_Deng(2003-08-12)
-- Update: Dan_Deng(2003-09-21)重新设计重返门派与镇派绝学相关
-- Update：Dan_Deng(2003-10-27)为重返师门任务加入取消任务功能，以及与新门派对应
-- update: xiaoyang(2004\4\19) 峨嵋90级任务

Include("\\script\\global\\skills_table.lua")
Include("\\script\\global\\repute_head.lua")
Include("\\script\\task\\lv120skill\\head.lua")
Include("\\script\\misc\\daiyitoushi\\toushi_function.lua")	-- 带艺投师

Include("\\script\\task\\150skilltask\\g_task.lua")
Include("\\script\\dailogsys\\g_dialog.lua")

Include("\\script\\item\\skillbook.lua")

function main()
	
	local nNpcIndex = GetLastDiagNpc();
	local nCurDate = tonumber(GetLocalDate("%Y%m%d%H%M"))
	local szNpcName = GetNpcName(nNpcIndex)
	if NpcName2Replace then
		szNpcName = NpcName2Replace(szNpcName)
	end
	local tbDailog = DailogClass:new(szNpcName)
	tbDailog.szTitleMsg = "<npc>G莕 y ta c� r蕋 nhi襲 vi謈 gi秈 quy誸, ngi n y c� vi謈 g�."
	G_TASK:OnMessage("Nga Mi", tbDailog, "DialogWithNpc")
	if (GetLevel() >= 120 and GetTask(LV120_SKILL_STATE) ~= 19 and GetLastFactionNumber() == 4) then
		tbDailog:AddOptEntry("H鋍 k� n╪g c蕄 120.", lvl120skill_learn)
	end
	tbDailog:AddOptEntry("Mu鑞 th豱h gi竜 vi謈 kh竎", oldentence)
	tbDailog:Show() 
	
end

function oldentence()
	local UTask_em = GetTask(1)
	local nFactID = GetLastFactionNumber();

	if (UTask_em == 70*256) and (GetFaction() == "emei") then			-- 回师错误修正
		SetFaction("")
		Say("H� th鑞g ph竧 hi謓 sai s鉻,  k辮 th阨 h錳 phuc!",0)
		return
	elseif (UTask_em == 70*256) and (GetTask(6) >= 5*256) and (GetTask(6) < 10*256) then		-- 以前接过入门任务的
		SetTask(6,0)
		Say("H� th鑞g ph竧 hi謓 sai s鉻,  k辮 th阨 h錳 phuc!",0)
		return
	elseif (UTask_em == 80*256) and (GetCamp() == 4) then			-- 回师错误修正
		SetTask(1,70*256)
		Say("H� th鑞g ph竧 hi謓 sai s鉻,  k辮 th阨 h錳 phuc!",0)
		return
	elseif (UTask_em == 80*256 and nFactID == 4 and GetCamp() == 1 and GetFaction() == "M韎 nh藀 giang h� ") then
		 local _, nTongID = GetTong();
		 if (nTongID == 0) then
			SetFaction("emei");
			Say("H� th鑞g ph竧 hi謓 sai s鉻,  k辮 th阨 h錳 phuc!",0)
			return
		end
	elseif (UTask_em == 70*256 and nFactID == 4 and GetCamp() ~= 4 and GetFaction() == "M韎 nh藀 giang h� ") then
		 local _, nTongID = GetTong();
		 if (nTongID == 0) then
			SetFaction("");
			SetCurCamp(GetCamp());
			Say("H� th鑞g ph竧 hi謓 sai s鉻,  k辮 th阨 h錳 phuc!",0)
			return
		end
	end

	local tbDes = {"Цi ngh� u s�/#daiyitoushi_main(4)", "Mu鑞 th豱h gi竜 vi謈 kh竎/common_talk"};
	
	Say("G莕 y ta c� r蕋 nhi襲 vi謈 gi秈 quy誸, ngi n y c� vi謈 g�.", getn(tbDes), tbDes);
end

function common_talk()
	local UTask_em = GetTask(1)
	local Uworld125 = GetTask(125)
	if (GetTask(39) == 10) and (GetBit(GetTask(40),1) == 0) then				-- 世界任务：武林向背
		Talk(1,"","B鎛 ph竔 tuy l� ph薾 n� l璾, nh璶g chuy謓 Qu鑓 gia h璶g vong kh玭g th� ng ngo礽. Xin h錳 p v韎 чc C� minh ch�, Nga Mi tu﹏ theo s� s緋 x誴 c馻 ngi!")
		Uworld40 = SetBit(GetTask(40),1,1)
		SetTask(40,Uworld40)
	elseif (GetSeries() == 2) and (GetFaction() == "emei") then
		if (UTask_em == 80*256) then						-- 重返后的自由出入
			check_skill()
		elseif ((UTask_em == 60*256+50) and (HaveItem(24) == 1)) then		--拿到烟玉指环，出师任务完成
			DelItem(24)
			Talk(1,"L60_prise","Ngi  l蕐 頲 Tr蕁 Ph竔 chi B秓 v� cho b鎛 ph竔, c玭g lao th藅 kh玭g nh�! V韎 n╪g l鵦 v� tr� tu� c馻 ngi  c� th� thu薾 l頸 xu蕋 s�! T� nay h祅h t萿 giang h� ph秈 gi� th﹏ trong s筩h, h穣 nh� l蕐!")
		elseif (UTask_em == 60*256) and (GetLevel() >= 50) then		--出师任务启动
			DelItem(24)
			Say("Y猲 Ng鋍 Ch� ho祅<color=Red> l� t輓 v藅 c馻 Chng m玭, l� tr蕁 ph竔 chi b秓 c馻 s� t� b鎛 ph竔 truy襫 l筰. Nh璶g m蕐 n╩ trc, b鎛 ph竔 c� m閠 ph秐  <color=Red>Thanh H遖<color>. B� ta l� s� t� c馻 th莥, b雐 kh玭g h礽 l遪g ta l祄 chng m玭 n猲  l蕐 tr閙 <color=Red>Y猲 Ng鋍 Ch� ho祅<color>, ngi c� b籲g l遪g gi髉 b鎛 ph竔 畂箃 <color=Red>Y猲 Ng鋍 Ch� ho祅<color> v� kh玭g?" , 2, "уng �!/L60_get_yes", "S� kh玭g l祄 n鎖 /L60_get_no")
		elseif (UTask_em == 50*256+80) then													--50级任务完成
			L50_prise()
		elseif ((UTask_em == 50*256+50) or (UTask_em == 50*256+60)) and (HaveItem(23) == 0) then
			AddEventItem(23)
			Talk(1,"","Danh ti課g v� c玭g c馻 ngi ng祔 m閠 cao, qu� l� rng c閠 c馻 b鎛 ph竔. T� nay h祅h s� kh玭g 頲 t飝 ti謓. Kim Cang Kinh n祔 ph秈 lu玭 mang theo m譶h!")
		elseif (UTask_em == 50*256) and (GetLevel() >= 50) then		--50级任务启动
			DelItem(23)
			Say("Ta v韎 <color=Red>T輓 H秈 i s�<color> tr� tr� <color=Red>T輓 Tng t�<color> c� quan h� tri giao. T輓 Tng t� 頲 x﹜ d鵱g trong nh鱪g n╩ i nghi謕 T飝 D筺g д, n nay  555 n╩. в m鮪g ng祔 T輓 Tng t� th祅h l藀, ta y chu萵 b� m閠 b� Ph藅 m玭 ch� b秓 <color=Red>'Kim Tuy課 T� Tng Kim Cang Kinh'<color> l祄 qu� ch骳 m鮪g. Ngi b籲g l遪g gi髉 ta t苙g ph莕 qu� n祔 ch�?", 2, "уng �!/L50_get_yes", "S� kh玭g l祄 n鎖 /L50_get_no")
		elseif (UTask_em > 50*256) and (UTask_em < 60*256) then								--已经接到50级任务，尚未完成的普通对话
			Talk(1,"","T苙g 頲 'Kim Cang Kinh' ch璦?")
		elseif (UTask_em > 60*256) and (UTask_em < 70*256) then				-- 出师任务中的普通对话
			Talk(1,"","<color=Red>Y猲 Ng鋍 Ch� ho祅<color> l� tr蕁 ph竔 chi b秓 l璾 l筩 b猲 ngo礽. Nghe n鉯 g莕 y <color=Red>Thanh H遖<color> 產ng � <color=Red>Trng Giang Nguy猲 u<color>, ngi ph秈 h誸 m鵦 c萵 th薾!")
		else
			Talk(1,"","Ng� Ph藅 t� bi! Х nh藀 m玭 ph竔 ta, ph秈 nghi猰 th� m玭 quy, mong ngi chuy猲 t﹎ tu luy謓, ng ph� l遪g k� v鋘g c馻 ta!")
		end
--	elseif (UTask_em == 5*256+70) and (HaveItem(17) == 1) and (GetSeries() == 2) and (GetCamp() == 0) then		--拿到白玉如意，入门任务完成
--		enroll_prise()
	elseif (Uworld125 == 20) and (HaveItem(388) == 1)then
		Talk(7,"Uworld125_lose","Ch祇 s� th竔�.","C竎 h� l�...?","T筰 h� nh薾 nhi謒 v� c馻 Ti猽 B� B� mang th竛h v藅 V� T� Thi猲 Th� trao tr� l筰 cho Nga Mi.","Th藅 hay l緈! N祇 ng� m蕐 tr╩ n╩ sau, th莕 c玭g c馻 s� t� n╩ x璦  tr� v� v韎 Nga Mi. N祔 v� b籲g h鱱, xin 產 t� ngi!","Kh玭g c莕 kh竎h s竜!","Зy l� L謓h ti詎 Chng m玭 t鑙 c竜 c馻 Nga Mi. H穣 c莔 l謓h ti詎 甶 Th祅h Й t譵 Ti猽 B� B� nh薾 th� lao. Sau n祔 quay v� Nga Mi, c� th� d飊g l謓h ti詎 甶襲 ng t蕋 c� l鵦 lng c馻 ta."," t� s� th竔!.")
   elseif (Uworld125 == 30) and (HaveItem(389) == 0)then
   	Talk(1,"","H穣 y猲 t﹎, Nga Mi ta p 鴑g 甶襲 ki謓 c馻 ngi quy誸 kh玭g h鑙 h薾. L謓h b礽 y!")
   	AddEventItem(389)
		Msg2Player("L蕐 頲 l謓h ti詎 c馻 Nga Mi ")
   elseif (Uworld125 == 40) then
		Talk(5,"Uworld125_finish","S� th竔 t譵 t筰 h� g蕄 th�, kh玭g bi誸 c� chuy謓 chi?","Nhi襲  t� m玭 h� ta v� luy謓 V� T� Thi猲 Th� m� kinh m筩h o l閚, th﹏ ch辵 tr鋘g thng.","Sao? Kh玭g th� n祇. Ta ch璦 h� ng n m藅 c蕄.","襲 n祔 ta bi誸. Chuy謓 x秠 ra khi mang m藅 c蕄 tr猲 ngi. S� t� luy謓 s竎h n祔 d鵤 v祇 t礽 n╪g tr阨 cho v� s鴆 m筺h n閕 l鵦. Nh璶g ch� ngi n祇 c� duy猲 m韎 c� th� l躰h ng�.","H鉧 ra nh� th�.")
--	elseif (GetTask(6) == 5*256+10) then		-- 转派至翠烟门
--		Say("清晓师太：本门门规虽然不禁转投他派，但不可以带走本门任何武艺。你真的打算要投入翠烟门？",2,"不错，我意已决/defection_yes","不，我还是不改投了/defection_no")
	elseif (GetSeries() == 2) and (GetCamp() == 4) and (GetLevel() >= 60) and (UTask_em == 70*256) and (GetTask(6) < 5*256) then		-- 重返师门任务
		Talk(5,"return_sele","S� ph� ","Con l筰 tr� l猲 n骾 ch琲 n鱝 h�? ","D�, qu� th藅 con nh� nh鱪g ng祔 th竛g tr猲 n骾 v� c飊g. ","�, ta c騨g lu玭 nh� n nh鱪g ng祔 con � tr猲 n骾, ch韕 m総 m閠 c竔 m� con  xu鑞g n骾 r錳. ","giang h� hi觤 竎, kh玭g th� lng h誸 m鋓 甶襲. Th藅 ra b﹜ gi� con mong mu鑞 頲 � l筰 tr猲 n骾. ")
	elseif (GetCamp() == 4) and ((UTask_em == 70*256+10) or (UTask_em == 70*256+20)) then		-- 重返师门任务中
		Say("Х chu萵 b�  5 v筺 lng ch璦?",2,"Х chu萵 b� xong/return_complete","V蒼 ch璦 chu萵 b� xong/return_uncompleted")
	elseif (Uworld125 > 20) and (Uworld125 < 40)then
   	Talk(1,"","Nga Mi v� c竎 h� v蒼 c遪 ch髏 duy猲 ph薾, sau n祔 mong gi髉  th猰.")
	elseif (UTask_em < 10*256) and (GetSeries() == 2) then 								--尚未入门
		Talk(1,"","дn h玬 nay, Nga Mi ta  c� h琻 100 n╩ thu nh薾 ng o  t�, m� r閚g thi謓 duy猲, b蕋 lu薾 c� nh藀 m玭 hay kh玭g,  l猲 n骾 xem nh� ngi c� duy猲.")
	elseif (UTask_em == 70*256) then								--出师弟子（考虑重返门派的兼容）
		Talk(1,"","Ngi  xu蕋 s�, t� nay h祅h t萿 giang h� ph秈 nh� gi� th﹏ trong s筩h!")
	else														-- 非峨嵋派对话
		Talk(1,"","Tuy Nga Mi ta l� ph薾 n� l璾, nh璶g quy誸 kh玭g ng sau c竎 i m玭 ph竔 kh竎.")
	end
end;
---------------------- 技能调整相关 ------------------------
function check_skill()
--	if (HaveMagic(92) == -1) then
--		AddMagic(92)					--佛心慈佑
--		Msg2Player("你学会了“佛心慈佑”")
--		Say("清晓师太：为师这次闭关苦思数日，新创了一招“佛心慈佑”，现在传授于你。你学完后先回去好好休息一番，以免伤到经脉。",1,"多谢师父/KickOutSelf")
--	elseif  (HaveMagic(252) == -1) then
--		AddMagic(252)					--佛法无边
--		Msg2Player("你学会了“佛法无边”")
--		Say("清晓师太：为师这次闭关苦思数日，新创了一招“佛法无边”，现在传授于你。你学完后先回去好好休息一番，以免伤到经脉。",1,"多谢师父/KickOutSelf")
--	else
		Say("L筰 mu鑞 h� s琻 du ngo筺 sao?",2,"D� v﹏g, xin s� ph� cho ph衟 /goff_yes","Kh玭g, ta t� th蕐 c玭g phut藀 luy謓 v蒼 ch璦 . /no")
--	end
end

----------------- 重返师门相关 ------------------
function goff_yes()				-- 重返后的自由出入（出）
	Talk(1,"","T鑤!  m閠 ng祔 ng h鋍 m閠 s祅g kh玭.")
	SetTask(1,70*256)
	AddNote("R阨 kh醝 Nga Mi ph竔, l筰 ngao du giang h�. ")
	Msg2Player("B筺 r阨 kh醝 Nga Mi ph竔, l筰 ngao du giang h� ")
	SetFaction("")
	SetCamp(4)
	SetCurCamp(4)
end

function defection_yes()			-- 转派，收回原门派武功技能
-- 刷掉技能
	n = 0
	i=80; x = HaveMagic(i); if (x ~= -1) then n = n + x end; DelMagic(i)			-- 飘雪穿云
	i=101;x = HaveMagic(i); if (x ~= -1) then n = n + x end; DelMagic(i)			-- 治疗术
	i=77; x = HaveMagic(i); if (x ~= -1) then n = n + x end; DelMagic(i)			-- 峨嵋剑法
	i=79; x = HaveMagic(i); if (x ~= -1) then n = n + x end; DelMagic(i)			-- 峨嵋掌法
	i=81; x = HaveMagic(i); if (x ~= -1) then n = n + x end; DelMagic(i)			-- 秋风叶
	i=82; x = HaveMagic(i); if (x ~= -1) then n = n + x end; DelMagic(i)			-- 四象同归
	i=83; x = HaveMagic(i); if (x ~= -1) then n = n + x end; DelMagic(i)			-- 望月
	i=84; x = HaveMagic(i); if (x ~= -1) then n = n + x end; DelMagic(i)			-- 风雨飘香
	i=85; x = HaveMagic(i); if (x ~= -1) then n = n + x end; DelMagic(i)			-- 一叶知秋
	i=86; x = HaveMagic(i); if (x ~= -1) then n = n + x end; DelMagic(i)			-- 流水
	i=87; x = HaveMagic(i); if (x ~= -1) then n = n + x end; DelMagic(i)			-- 冰心决
	i=88; x = HaveMagic(i); if (x ~= -1) then n = n + x end; DelMagic(i)			-- 不灭不绝
	i=89; x = HaveMagic(i); if (x ~= -1) then n = n + x end; DelMagic(i)			-- 梦蝶
	i=91; x = HaveMagic(i); if (x ~= -1) then n = n + x end; DelMagic(i)			-- 佛光普照
	i=93; x = HaveMagic(i); if (x ~= -1) then n = n + x end; DelMagic(i)			-- 慈航普渡
	i=252;x = HaveMagic(i); if (x ~= -1) then n = n + x end; DelMagic(i)			-- 佛法无边
	i=92; x = HaveMagic(i); if (x ~= -1) then n = n + x end; DelMagic(i)			-- 佛心慈佑
	AddMagicPoint(n)
-- 刷完技能后继续转门派流程
	SetTask(6,5*256+20)
	SetTask(1,75*256)				-- 为原门派作个标记
	SetRank(74)
	if (GetRepute() < 200) then
		Msg2Player("V� h祅h vi b蕋 trung v韎 m玭 ph竔, danh v鋘g c馻 b筺 gi秏 xu鑞g "..GetRepute().."甶觤!")
		AddRepute(-1 * GetRepute())
	else
		Msg2Player("V� h祅h vi b蕋 trung v韎 m玭 ph竔, danh v鋘g c馻 b筺 gi秏 xu鑞g 200 甶觤! ")
		AddRepute(-200)
	end
	AddNote("Thanh Hi觰 S� Th竔  ph� b� v� c玭g, l蕐 l筰 danh hi謚 Th竛h n� Kim жnh, th玭g b竜 v韎 thi猲 h� l�  畊鎖 ngi ra kh醝 Nga Mi. Ngi c� th� gia nh藀 v祇 Th髖 Y猲 m玭 r錳. ")
	Msg2Player("Thanh Hi觰 S� Th竔  ph� b� v� c玭g, l蕐 l筰 danh hi謚 Th竛h n� Kim жnh, th玭g b竜 v韎 thi猲 h� l�  畊鎖 ngi ra kh醝 Nga Mi. Ngi c� th� gia nh藀 v祇 Th髖 Y猲 m玭 r錳. ")
	Talk(1,"KickOutSelf","N祇 ng� v� c玭g n╩ x璦 ta ch th﹏ truy襫 d箉 cho ngi, nay ngi l筰 mu鑞 ph� tru蕋. Th藅 l� th� s� tr竔 ngang!")
end

function defection_no()
	AddNote("Ngi b� � nh gia nh藀 Th髖 Y猲 ph竔. ")
	Msg2Player("Ngi b� � nh gia nh藀 Th髖 Y猲 ph竔. ")
	SetTask(6,1*256)			-- 为企图叛师做个标记，以备将来不时之需
end

function return_sele()
	Say("Ngi  c� th祅h �, ta kh玭g n� ch鑙 t�!",2," t� s� ph� /return_yes","Th玦 kh玭g c莕 u/return_no")
end;

function return_yes()				-- 重返的检查
	Talk(3,""," t� s� ph�! е t� phi猽 b箃 giang h� c騨g d祅h d鬽 頲 ch髏 ng﹏ lng, kh玭g bi誸 s� m玭 c� c莕 kh玭g?"," N祇 ng� ngi l筰 c� l遪g nh� v藋, th� th� quy猲 g鉷 50000 ng﹏ lng tu s鯽 Nga Mi s琻 l� nh�!","D�! в  t� chu萵 b�! ")
	SetTask(1,70*256+20)
	AddNote("G鉷 50 ng祅 lng b筩  tu s鯽 l筰 con 阯g l猲 n骾 Nga Mi, s� 頲 quay v� s� m玭. ")
	Msg2Player("G鉷 50 ng祅 lng b筩  tu s鯽 l筰 con 阯g l猲 n骾 Nga Mi, s� 頲 quay v� s� m玭. ")
end;

function return_no()
	Talk(2,"","Giang h� kh玭g 阯g v�, lu玭 c莕 t� m譶h x玭g t韎, 產 t� m� � c馻 s� ph�!","Kh玭g sao u, n誹 mu鑞 quay l筰, Nga Mi ta l骳 n祇 c騨g r閚g m�!")
end;

function return_complete()			-- 重返成功
	if (GetCash() >= 50000) then
		Talk(1,"","Л頲! Зy 5 v筺 lng  nh薾 頲. Ngi 頲 phong l� Kim жnh Th竛h N� c馻 b鎛 ph竔, hy v鋘g ngi c� g緉g gi髉 b鎛 ph竔 ph竧 dng quang i.")
		Pay(50000)
		SetTask(1,80*256)
		SetFaction("emei")
		SetCamp(1)
		SetCurCamp(1)
		SetRank(64)
--		if (HaveMagic(252) == -1) then
--			AddMagic(88)
--			AddMagic(91)
--			AddMagic(282)
--			AddMagic(252)
		add_em(70)			-- 调用skills_table.lua中的函数，参数为学到多少级技能。
		Msg2Player("B筺 h鋍 頲 tuy謙 h鋍 tr蕁 ph竔: Ph藅 Ph竝 V� Bi猲, V� C玭g B蕋 Di謙 B蕋 Tuy謙t, Ph藅 Quang Ph� Chi誹, Thanh  Ph筺 Xng. ")
--		end
		AddNote("Х quay v� Nga Mi ph竔, ng trong h祅g ng� ")
		Msg2Player(GetName().."Л頲 phong th祅h Kim жnh Th竛h N�, l筰 quay v� Nga Mi ph竔. ")
	else
		Talk(2,"","Dng nh� ngi kh玭g c� 甧m nhi襲 ti襫 theo ","A. Xin l鏸, ta 甶 l蕐 ti襫. ")
	end
end;

--------------- 入门任务 ----------------------
function enroll_prise()		-- 入门任务完成
	Talk(1,"","Ng� Ph藅 t� bi,  c� l遪g th祅h, b莕 ni s� thu nh薾 ngi l祄 m玭 , ng ph� l遪g k� v鋘g c馻 ta.")
	DelItem(17)
	SetFaction("emei")    			
	SetCamp(1)
	SetCurCamp(1)
	SetRank(13)
	AddMagic(80)
	AddMagic(101)
	SetRevPos(13, 13)
	SetTask(1, 10*256)
	AddNote("Giao B筩h Ng鋍 Nh� � cho Thanh Hi觰 S� Th竔, ho祅 th祅h nhi謒 v� nh藀 m玭. Gia nh藀 Nga Mi ph竔, tr� th祅h B� Y Ni, h鋍 頲 Phi猽 Tuy誸 Xuy猲 V﹏, Tr� Li謚 thu藅 ")
	Msg2Player("Giao B筩h Ng鋍 Nh� � cho Chng m玭 Thanh Hi觰 S� Th竔, ho祅 th祅h nhi謒 v� nh藀 m玭. ")
	Msg2Player("Hoan ngh猲h b筺 gia nh藀 Nga Mi ph竔, tr� th祅h B� Y Ni ")
	Msg2Player("H鋍 頲 v� c玭g 'Phi猽 Tuy誸 Xuy猲 V﹏'. ")
	Msg2Player("H鋍 頲 tuy謙 k� Nga Mi ph竔 'Tr� Li謚 Thu藅' ")
end;

--------------------- 50级任务 -----------------------
function L50_get_yes()
	Talk(1,"","<color=Red>T� H秈 i s� <color> b� quan  l﹗, b譶h thng kh玭g mu鑞 g苝 ngi ngo礽, ngi c� th� 甶 t譵 s�  <color=Red>T� V﹏ Ph竝 s�<color>c馻 玭g. ")
	AddEventItem(23)
	Msg2Player("Nh薾 nhi謒 v� n T輓 Tng t�: Лa Kim Tuy課 T� Tng Kim Cang kinh n T輓 Tng t� � Th祅h Й. ")
	Msg2Player("Nh薾 頲 Kim Tuy課 T� Tng Kim Cang Kinh. ")
	SetTask(1, 50*256+50)
	AddNote("G苝 Thanh Hi觰 S� Th竔 � Ch竛h 甶謓, nh薾 nhi謒 v� n T輓 Tng t�, giao Kim Tuy課 T� Tng Kim Cang kinh. ")
end;

function L50_get_no()
	Talk(1,"","V藋 h穣 t譵 玭g 甶!")
end;

function L50_prise()
	Talk(1,"","Chuy謓 n祔 ngi l祄 r蕋 t鑤, ngi t� ch蕋 th玭g minh, ch� c莕 ti誴 t鬰 c� g緉g, ti襫  nh蕋 nh r閚g m�!")
	AddNote("Quay v� Ch竛h 甶謓 ph鬰 m謓h Thanh Hi觰 S� Th竔, ho祅 th祅h nhi謒 v� T輓 Tng t�. Л頲 th╪g ch鴆 T竛 Hoa Thi猲 N�, h鋍 頲 Ph藅 Quang Ph� Chi誹, Ph藅 T﹎ T� H鱱, T� H祅g Ph� ч. ")
	SetRank(18)
	SetTask(1, 60*256)
--	AddMagic(92)
	add_em(60)			-- 调用skills_table.lua中的函数，参数为学到多少级技能。
	Msg2Player("Ch骳 m鮪g b筺! B筺  頲 th╪g ch鴆 T竛 Hoa Thi猲 N�! H鋍 頲 Ph藅 T﹎ T� H鱱. ")
	AddNote("Nhi謒 v� ho祅 th祅h, 頲 phong T竛 Hoa Thi猲 N� ")
end;

----------------------- 出师任务 ------------------------
function L60_get_yes()
	Talk(1,"","Nghe n鉯 g莕 y <color=Red>Thanh H遖<color> xu蕋 hi謓 � <color=Red>Trng Giang nguy猲 u<color>, ngi ph秈 h誸 s鴆 c萵 th薾! ")
	SetTask(1, 60*256+50)
	AddNote("G苝 Thanh Hi觰 S� Th竔 � Ch竛h 甶謓, nh薾 nhi謒 v� xu蕋 s�, gi祅h l筰 Y猲 Ng鋍 Ch� Ho祅. ")
	Msg2Player("Nh薾 nhi謒 v� xu蕋 s� Nga Mi ph竔: 箃 v� t輓 v藅 c馻 chng m玭 Y猲 Ng鋍 Ch� Ho祅. ")
end;

function L60_get_no()
	Talk(1,"","Xem ra ta ch� c� th� 甧m tr鋘g tr竎h n祔 giao cho ngi kh竎 th玦!")
end;

function L60_prise()
	Talk(1, "","Ch骳 m鮪g b筺 th祅h ngh� xu蕋 s�! B筺 頲 phong l� Th竛h N�. T� h玬 nay c� th� t� do h祅h hi謕 giang h�! B筺 c� th� ch鋘 gia nh藀 m玭 ph竔 kh竎 ti誴 t鬰 h鋍 ngh�, c騨g c� th� x﹜ d鵱g bang h閕 m� r閚g th� l鵦 tr猲 giang h�. Ho芻 l祄 m閠 c h祅h n� hi謕 c騨g r蕋 oai phong! Giang h� ki誱 hi謕, bi觧 r閚g tr阨 cao, hy v鋘g b筺 ph竧 tri觧 quy襫 cc, nh蕋 tri觧 h錸g !")
	Msg2Player("Ch骳 m鮪g ngi  h鋍 th祅h t礽! Ngi  頲 phong l� Th竛h n� Nga Mi ph竔! Danh v鋘g t╪g th猰 120 甶觤! ")
--	AddGlobalCountNews("峨嵋"..GetName().."艺成出师，告别同门师妹下山闯荡江湖", 1)
	Msg2SubWorld("е t� Nga Mi ph竔 "..GetName().."Th祅h t礽 xu蕋 s�, t� bi謙 c竎 s� mu閕 ng m玭  xu鑞g n骾 h祅h t萿 giang h� ")
	AddRepute(120)
	SetRank(74)
	SetTask(1, 70*256)
	SetFaction("") 		   					--玩家退出峨嵋派
	SetCamp(4)
	SetCurCamp(4)
	AddNote("V� n Ch竛h 甶謓 giao Y猲 Ng鋍 Ch� Ho祅 cho Thanh Hi觰 S� Th竔, ho祅 th祅h nhi謒 v� xu蕋 s�. Л頲 th╪g l祄 Th竛h n�. ")
end;

function no()
end;

-------------------- 世界任务 ---------------------
function Uworld125_lose()
	DelItem(388)
	AddEventItem(389)
	SetTask(125,30)
	Msg2Player("Лa ra V� T� Thi猲 Th�, l蕐 Nga My l謓h ti詎. ")
	AddNote("L蕐 頲 l謓h ti詎, v� Th祅h Й t譵 Ti誹 B� B� l穘h thng. ")
end

function Uworld125_finish()
	if (GetTask(1) >= 70*256) and (GetTask(1) ~= 75*256) then
		Talk(4,"","Xem ra, duy猲 ph薾 gi鱝 Nga Mi v韎 thi猲 th�  t薾, s� m筺g n祔 l� c馻 c竎 h� m韎 ng!","T筰 h�?","Ph秈, c� l� ch� c� ngi m韎 th蕌 hi觰 頲 b� m藅 b猲 trong. B莕 ni s� 甧m nh鱪g chi猽 th鴆 ghi tr猲 s竎h truy襫 th� cho ngi, mong ngi c� th� t th祅h, ng u鎛g ph� m閠 l莕 luy謓 c玭g kh� nh鋍!","е t� nh蕋 nh kh玭g ph� l遪g. T� nay c� g� d苙 d�,  t� nh蕋 nh蕋 tu﹏ theo!")
		if (HaveMagic(328) == -1) then		-- 必须没有技能的才给技能
			AddMagic(328,1)
		end
		if (HaveMagic(380) == -1) then		-- 必须没有技能的才给技能
			AddMagic(380,1)
		end
		if (HaveMagic(332) == -1) then		-- 必须没有技能的才给技能
			AddMagic(332)
		end
		CheckIsCanGet150SkillTask()
		Msg2Player("Ngi  h鋍 Tam Nga T� Tuy誸, Phong L� Th髖 秐h, Ph� ч T飊g Sinh ")
		SetTask(125,255)  --学得技能的设置变量255
	else
		Talk(1,"","Quy觧 thi猲 th� n祔 v鑞 kh玭g c� ngi n祇 tu luy謓 頲 n猲 nh ph秈 ph秈  trong Kinh L﹗ ch� i h藆 nh﹏. Ngi b玭 ba v蕋 v�  l﹗, m鉵 qu� nh� n祔 xin g鰅 t苙g ngi!","V藋  t� c騨g kh玭g kh竎h s竜!")
	   SetTask(125,245)  --获得声望的设置变量245
	end
	add_repute = ReturnRepute(30,100,4)			-- 声望奖励：最大30点，从100级起每级递减4%
	AddRepute(add_repute)
	Msg2Player("Thi猲 th� Nga My quay v� nh�  nh, nhi謒 v� ho祅 th祅h. Danh v鋘g t╪g th猰 "..add_repute.."甶觤.")
	AddNote("Thi猲 th� Nga My quay v� nh�  nh, nhi謒 v� ho祅 th祅h. ")
end
