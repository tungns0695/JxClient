--description: 天王帮寝宫 杨瑛　天王出师任务、重返门派任务
--author: yuanlan	
--date: 2003/4/28
--Dan_Deng(2003-07-22), 加入门派任务的等级要求
--Dan_Deng(2003-07-24), 加入重返门派任务
-- Update: Dan_Deng(2003-08-16)
-- Update: Dan_Deng(2003-09-21)重新设计重返门派与镇派绝学相关
-- Update：Dan_Deng(2003-10-27)为重返师门任务加入取消任务功能，以及与新门派对应

function main()
--	if (check_skill() == 0) then
--		return
--	end
	UTask_tw = GetTask(3);
	if (GetTask(39) == 10) and (GetBit(GetTask(40),3) == 0) then				-- 世界任务：武林向背
		Talk(1,"", 11524)
		Uworld40 = SetBit(GetTask(40),3,1)
		SetTask(40,Uworld40)
	elseif (GetSeries() == 0) and (GetFaction() == "tianwang") then
		if (UTask_tw == 60*256+40) and (HaveItem(96) == 1) then					--拿到天王遗书
			Talk(3, "L60_prise", 11525, 11526, 11527)
		elseif (UTask_tw == 60*256) and (GetLevel() >= 50) then
			Talk(3, "L60_get", 11528, 11529, 11530)
		elseif (UTask_tw == 80*256) or (UTask_tw == 80) then						-- 重返后的自由出入
			Say(11531 ,2,"V﹏g, xin Bang ch� ﹏ chu萵. /goff_yes","Kh玭g, ta t� th蕐 c玭g phut藀 luy謓 v蒼 ch璦 . /no")
		elseif (UTask_tw > 60*256) and (UTask_tw < 70*256) then		--已经接到出师任务，尚未完成
			Talk(1,"", 11532)
		else
			Talk(1,"", 11533)
		end
--	elseif (GetTask(7) == 5*256+10) then		-- 转派至少林派
--		Say(11534 ,2,"不错，我意已决/defection_yes","不，我还是不改投少林了/defection_no")
	elseif (GetSeries() == 0) and (GetCamp() == 4) and (GetLevel() >= 60) and (UTask_tw == 70*256) and (GetTask(7) < 5*256) then		-- 重返师门任务
		Talk(1,"return_select", 11535)
	elseif (GetCamp() == 4) and ((UTask_tw == 70*256+10) or (UTask_tw == 70*256+20)) then
		Say(11536 ,2,"Х chu萵 b� xong/return_complete","V蒼 ch璦 chu萵 b� xong/no")
	elseif (UTask_tw >= 70*256) and (GetFaction() ~= "tianwang") then		--已经出师
		Talk(1,"", 11537)
	else
		Talk(1,"", 11538)
	end
end
---------------------- 技能调整相关 ------------------------
function check_skill()
	x = 0
	skillID = 38					-- 盘古九式
	i = HaveMagic(skillID)
	if (i >= 0) then
		x = x + 1
		DelMagic(skillID)
		AddMagicPoint(i)
	end
	if (x > 0) then		-- 若有技能发生变化，则踢下线，否则返回继续流程
		Say(11539 ,1," t� s� ph� /KickOutSelf")
		return 0
	else
		return 1
	end
end

---------------------- 重返任务 ----------------------
function goff_yes()
	Talk(1,"", 11540)
	SetTask(3,70*256)
	AddNote("R阨 kh醝 Thi猲 Vng bang, ti誴 t鬰 h祅h t萿 giang h�. ")
	Msg2Player("Ban  r阨 kh醝 Thi猲 Vng bang, ti誴 t鬰 h祅h t萿 giang h�. ")
	SetFaction("")
	SetCamp(4)
	SetCurCamp(4)
end

function defection_yes()
-- 刷掉技能
	n = 0
	i=29; x = HaveMagic(i); if (x ~= -1) then n = n + x end; DelMagic(i)			-- 斩龙诀
	i=23; x = HaveMagic(i); if (x ~= -1) then n = n + x end; DelMagic(i)			-- 天王枪法
	i=24; x = HaveMagic(i); if (x ~= -1) then n = n + x end; DelMagic(i)			-- 天王刀法
	i=26; x = HaveMagic(i); if (x ~= -1) then n = n + x end; DelMagic(i)			-- 天王锤法
	i=30; x = HaveMagic(i); if (x ~= -1) then n = n + x end; DelMagic(i)			-- 回风落雁
	i=31; x = HaveMagic(i); if (x ~= -1) then n = n + x end; DelMagic(i)			-- 行云诀
	i=32; x = HaveMagic(i); if (x ~= -1) then n = n + x end; DelMagic(i)			-- 无心斩
	i=33; x = HaveMagic(i); if (x ~= -1) then n = n + x end; DelMagic(i)			-- 静心诀
	i=34; x = HaveMagic(i); if (x ~= -1) then n = n + x end; DelMagic(i)			-- 惊雷斩
	i=35; x = HaveMagic(i); if (x ~= -1) then n = n + x end; DelMagic(i)			-- 阳关三叠
	i=36; x = HaveMagic(i); if (x ~= -1) then n = n + x end; DelMagic(i)			-- 天王战意
	i=37; x = HaveMagic(i); if (x ~= -1) then n = n + x end; DelMagic(i)			-- 泼风斩
	i=38; x = HaveMagic(i); if (x ~= -1) then n = n + x end; DelMagic(i)			-- 盘古九式（已取消技能）
	i=40; x = HaveMagic(i); if (x ~= -1) then n = n + x end; DelMagic(i)			-- 断魂剌
	i=41; x = HaveMagic(i); if (x ~= -1) then n = n + x end; DelMagic(i)			-- 血战八方
	i=42; x = HaveMagic(i); if (x ~= -1) then n = n + x end; DelMagic(i)			-- 金钟罩
	AddMagicPoint(n)
-- 刷完技能后继续转门派流程
	SetTask(7,5*256+20)
	SetTask(3,75*256)				-- 为原门派作个标记
	SetRank(79)						-- 头衔降为镇帮元帅
	if (GetRepute() < 200) then
		Msg2Player("V� h祅h vi b蕋 trung v韎 m玭 ph竔, danh v鋘g c馻 b筺 gi秏 xu鑞g "..GetRepute().."甶觤!")
		AddRepute(-1 * GetRepute())
	else
		Msg2Player("V� h祅h vi b蕋 trung v韎 m玭 ph竔, danh v鋘g c馻 b筺 gi秏 xu鑞g 200 甶觤! ")
		AddRepute(-200)
	end
	AddNote("Dng Anh ph� b� v� c玭g Thi猲 Vng bang c馻 b筺, 畂箃 l筰 ch鴆 K譶h Thi猲 Nguy猲 So竔 d錸g th阨 c玭g b� cho thi猲 h� b筺  ra kh醝 Thi猲 Vng Bang. B﹜ gi� ngi c� th� gia nh藀 Thi誹 L﹎ ph竔. ")
	Msg2Player("Dng Anh ph� b� v� c玭g Thi猲 Vng bang c馻 b筺, 畂箃 l筰 ch鴆 K譶h Thi猲 Nguy猲 So竔 d錸g th阨 c玭g b� cho thi猲 h� b筺  ra kh醝 Thi猲 Vng Bang. B﹜ gi� ngi c� th� gia nh藀 Thi誹 L﹎ ph竔. ")
	Talk(1,"KickOutSelf", 11541)
end

function defection_no()
	SetTask(7,1*256)				-- 为企图叛师作个标记，以备将来不时之需
	AddNote("B筺 t� b� � nh gia nh藀 Thi誹 L﹎ ph竔. ")
	Msg2Player("B筺 t� b� � nh gia nh藀 Thi誹 L﹎ ph竔. ")
end

function return_select()
	Say(11542 ,2,"V﹏g, ta mu鑞 tr� l筰 Thi猲 Vng bang /return_yes","Kh玭g, ta ch� bu閠 mi謓g n鉯 v藋 th玦. /return_no")
end;

function return_yes()
	Talk(2,"", 11543, 11544)
	SetTask(3,70*256+20)
	AddNote("H� tr� 50000 lng qu﹏ ph� cho Thi猲 Vng bang c� th� quay l筰 m玭 ph竔. ")
	Msg2Player("H� tr� 50000 lng qu﹏ ph� cho Thi猲 Vng bang c� th� quay l筰 m玭 ph竔. ")
end;

function return_no()
	Talk(1,"", 11545)
end;

function return_complete()
	if(GetCash() >= 50000) then								-- 有50000两
		Talk(1,"", 11546)
		Pay(50000)
		SetTask(3, 80*256)
		SetFaction("tianwang")
		SetCamp(3)
		SetCurCamp(3)
		SetRank(69)
		if (HaveMagic(36) == -1) then
			AddMagic(32)
			AddMagic(41)
			AddMagic(324)
			AddMagic(36)
			Msg2Player("B筺 h鋍 頲 tuy謙 k� tr蕁 ph竔 c馻 Thi猲 Vng bang: Thi猲 Vng Chi課 �, V� C玭g V� T﹎ Tr秏, Huy誸 Chi課 B竧 phng, Th鮝 Long Quy誸. ")
		end
		AddNote("Х quay tr� l筰 Thi猲 Vng bang. ")
		Msg2Faction(GetName().."  tr� l筰 Thi猲 Vng bang, 頲 phong l� K譶h Thi猲 Nguy猲 So竔")
	else
		Talk(2,"", 11547, 11548)
	end
end;

---------------------- 出师任务 ----------------------
function L60_get()
	Say(11549 , 2, "Thu閏 h� t薾 l鵦 thi h祅h /L60_get_yes", "E r籲g kh� c� th� nh薾 nhi謒 v� /no")
end;

function L60_get_yes()
	Talk(1,"", 11550)
	SetTask(3, 60*256+20)
	AddNote("T筰 T萴 cung Thi猲 Vng bang (223, 196) g苝 Dng Anh, ti誴 nh薾 nhi謒 v� 甶 Thanh Loa o thu h錳 Thi猲 Vng Di Th�. ")
	Msg2Player("T筰 T萴 cung Thi猲 Vng bang (223, 196) g苝 Dng Anh, ti誴 nh薾 nhi謒 v� 甶 Thanh Loa o thu h錳 Thi猲 Vng Di Th�. ")
end;

function L60_prise()
DelItem(96)
Msg2Player("Ch骳 m鮪g b筺  xu蕋 s� th祅h c玭g, b筺 頲 phong l� Tr蕁 Bang Nguy猲 So竔! Danh v鋘g t╪g th猰 120 甶觤! ")
--AddGlobalCountNews(GetName().."艺成出师，告别同门师弟开始闯荡江湖。", 1)
Msg2SubWorld("Thi猲 Vng"..GetName().."Xu蕋 s� th祅h c玭g, c竜 bi謙 Dng bang ch� v� c竎 ng m玭 huynh , ti誴 t鬰 h祅h t萿 giang h�. ")
AddRepute(120)
SetRank(79)
SetTask(3, 70*256)
SetFaction("")
SetCamp(4)			   				--玩家退出天王帮
SetCurCamp(4)
AddNote("Quay l筰 T萴 cung Thi猲 Vng Bang, a Thi猲 Vng Di Th� cho Bang ch� Dng Anh, ho祅 th祅h nhi謒 v� xu蕋 s�. Th╪g ch鴆 K譶h Thi猲 Nguy猲 So竔.. ")
end;

function no()
end
