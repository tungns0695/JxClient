--description: 天忍教左护法端木睿
--author: yuanlan	
--date: 2003/5/19
--Dan_Deng(2003-07-22), 加入门派任务的等级要求
-- Update: Dan_Deng(2003-08-14)

-- 与新任务系统相关修改过后的端木睿脚本
-- Edited by peres
-- 2005/01/20

Include("\\script\\task\\newtask\\newtask_head.lua");
Include("\\script\\task\\newtask\\lib_setmembertask.lua");
Include("\\script\\task\\newtask\\master\\xiepai\\maintask.lua");

Include("\\script\\task\\150skilltask\\g_task.lua")
Include("\\script\\dailogsys\\g_dialog.lua")
Include("\\script\\item\\skillbook.lua")

Include("\\script\\global\\skills_table.lua")

function main()

-- 新任务系统与邪教主线相关的脚本 --

local myTaskValue = GetTask(1003)
local myCamp = nt_getCamp()

	if (myTaskValue==360) then
		task_level60_01();
		return
	end


-- 新任务系统与邪教主线相关的脚本 --

	UTask_tr = GetTask(4)
	Uworld123 = GetTask(123)
	if (GetSeries() == 3) and (GetFaction() == "tianren") then
		if (UTask_tr == 50*256) and (GetLevel() >= 50) then
			Say("<color=Red>Tinh Уn Уn Ch� Ph鬾g H蕄 Nh�<color> b� qu﹏ T鑞g b総 giam t筰 <color=Red>t遖 th竝 s総<color> � <color=Red>Bi謓 Kinh<color>, n誹 qu﹏ T鑞g moi 頲 b� m藅 g� t� mi謓g 玭g ta, s� l祄 nguy n i nghi謕 c馻 b鎛 gi竜, v� v藋 b籲g m鋓 gi�, ngi ph秈 c鴘 頲 Ph鬾g H蕄 Nh� v�.",2, "Thu閏 h� tu﹏ m謓h/yes", "Thu閏 h� e r籲g kh玭g m nhi謒 n鎖/no")
		elseif (UTask_tr == 50*256+50) then 
			L50_prise()
		elseif (UTask_tr > 50*256) and (UTask_tr < 50*256+50) then					--已经接到50级任务，尚未完成
			Talk(1,"","<color=Red>Thi誸 Th竝 � Bi謓 Kinh<color> giam <color=Red>Ph鬾g H蕄 Nh�<color> c� <color=Red>ba c� quan<color>, m� 頲 t蕋 c� m韎 c� th� c鴘 頲 Ph鬾g H蕄 Nh�, h穣 nh� b籲g b蕋 c� gi� n祇, c騨g kh玭g th�  Ph鬾g H蕄 Nh� r琲 v祇 tay qu﹏ T鑞g!")
		else							--已经完成50级任务，尚未出师（缺省对话）
			Skill150Dialog("Nh鱪g ngi m韎 trong gi竜 lu玭 lu玭 c�, t譶h h譶h th緉g b筰 l� b蕋 kh� thi")
		end
	elseif (Uworld123 == 60) and (HaveItem(377) == 1) then			-- 唐不染“嫁祸一尘”任务
		if (GetTask(2) >= 70*256) and (GetTask(2) ~= 75*256) then			-- 唐门弟子或唐门出师的才能学到技能
			Talk(11,"Uworld123_step4a","ьi l﹗ nh� v藋, cu鑞 s竎h m藅 c馻 Л阯g M玭 n祔 qu� kh玭g ph� ta!","A! Qu� nhi猲 l� kh玭g kh�, ng ti誧 thi猲 h� l筰 kh玭g ai ngh� ra.","an M閏 ti猲 sinh, ngi xem c� th� hi觰 v� c玭g trong cu鑞 s竎h m藅 Л阯g M玭 n祔 kh玭g?","S竎h m藅 n祔 vi誸 qu� r� r祅g r錳, c� g� m� kh玭g hi觰?","Qu� th鵦 kh玭g d竚 gi蕌, ta trc gi� xem r蕋 輙 s竎h, v藋 n猲 kh玭g hi觰.","N誹  nh� v藋, c� g� kh玭g hi觰 th� ngi c� h醝 l穙 phu.","............","...............� ","............","...............� ")
		else
			Talk(1,"Uworld123_step4b","ьi l﹗ nh� v藋, cu鑞 s竎h m藅 c馻 Л阯g M玭 n祔 qu� kh玭g ph� ta!")
		end
	elseif (UTask_tr >= 70*256) then							--已经出师
		Skill150Dialog("Th祅h t鵸 i s� gi�, nhu b蕋 c﹗ ti觰 ti謙, n誹 nh� l祄 vi謈 g� m� kh玭g quy誸 畂竛, nh髏 nh竧, thi誹 u thi誹 畊玦, nh� v藋 th� kh玭g l祄 頲 tr� tr鑞g g� h誸!")
	else
		Skill150Dialog("V� c玭g v鑞 kh玭g kh玭g c� ch輓h t�, ch� c� m筺h y誹, chuy謓 giang h�, n╪g gi�=3 v� chi, thi猲 h� chi th�, cng gi� chng chi.")
	end
end;

function Skill150Dialog(szTitle)
	local nNpcIndex = GetLastDiagNpc();
	local nCurDate = tonumber(GetLocalDate("%Y%m%d%H%M"))
	local szNpcName = GetNpcName(nNpcIndex)
	if NpcName2Replace then
		szNpcName = NpcName2Replace(szNpcName)
	end
	local tbDailog = DailogClass:new(szNpcName)
	tbDailog.szTitleMsg = format("<npc>%s", szTitle)
	G_TASK:OnMessage("Thi猲 Nh蒼", tbDailog, "DialogWithNpc")
	tbDailog:Show()
end

function yes()
	Talk(1,"","<color=Red>Thi誸 Th竝 � Bi謓 Kinh<color> giam <color=Red>Ph鬾g H蕄 Nh�<color> c� <color=Red>ba c� quan<color>, m� 頲 t蕋 c� m韎 c� th� c鴘 頲 Ph鬾g H蕄 Nh�, h穣 nh� b籲g b蕋 c� gi� n祇, c騨g kh玭g th�  Ph鬾g H蕄 Nh� r琲 v祇 tay qu﹏ T鑞g!")
	SetTask(4, 50*256+20)
	Msg2Player("G苝 頲 T� H� ph竝 an M閏 Du�, nh薾 nhi謒 v� c鴘 ngi, n Bi謓 Kinh Thi誸 Th竝 c鴘 tinh n ch� Ph鬾g H蕄 Nh� 產ng b� T鑞g qu﹏ giam gi�.")
	AddNote("G苝 頲 T� H� ph竝 an M閏 Du�, nh薾 nhi謒 v� c鴘 ngi, n Bi謓 Kinh Thi誸 Th竝 c鴘 tinh n ch� Ph鬾g H蕄 Nh� 產ng b� T鑞g qu﹏ giam gi�.")
end;

function no()
	Talk(1,"","Ngi v鑞 l� Chng K� S� c馻 b鎛 gi竜, m閠 vi謈 nh� th� n祔 l祄 c騨g kh玭g xong, c遪 l祄 頲 g� n鱝?")
end;

function L50_prise()
	Talk(1,"","Ngi tuy l�  t� m韎 nh璶g c� th� m 琻g vi謈 h� tr鋘g, b鎛 gi竜 r蕋 c莕 nh鱪g ngi c l鵦 nh� ngi, ta s� n鉯 v韎 Gi竜 ch�  s綾 phong cho ngi.")
	SetRank(60)
	SetTask(4, 60*256)
	SetTask(21,0)		--用完后就将辅助变量清零，便于今后重复利用
--	AddMagic(143)
	add_tr(60)			-- 调用skills_table.lua中的函数，参数为学到多少级技能。
	Msg2Player("Ch骳 m鮪g b筺  頲 s綾 phong l祄 H� Gi竜 S� c馻 Thi猲 Nh蒼 Gi竜! H鋍 頲 v� c玭g L辌h Ma 箃 H錸.")
	AddNote("V� Thi猲 Nh蒼 Gi竜 n g苝 T� H� ph竝 an M閏 Du� ph鬰 m謓h, ho祅 th祅h nhi謒 v� c鴘 ngi. Th╪g ch鴆 l祄 H� Gi竜 S�.")
end;

function Uworld123_step4a()
	DelItem(377)
	if (HaveMagic(339) == -1) then		-- 必须没有技能的才给技能
		AddMagic(339,1)
	end
	if (HaveMagic(302) == -1) then		-- 必须没有技能的才给技能
		AddMagic(302,1)
	end
	if (HaveMagic(342) == -1) then		-- 必须没有技能的才给技能
		AddMagic(342,1)
	end
	if (HaveMagic(351) == -1) then		-- 必须没有技能的才给技能
		AddMagic(351)
	end
	CheckIsCanGet150SkillTask()
	Msg2Player("B筺 h鋍 頲 Nhi誴 H錸 Nguy謙 秐h, B筼 V� L� Hoa, C鰑 Cung Phi Tinh, Lo筺 Ho祅 K輈h!")
	Msg2Player("an M閏 Du� ti誴 t鬰 m阨 b筺 v� b竜 tin cho Л阯g B蕋 Nhi詍.")
	SetTask(123,75)
	Talk(2,"","Nh� ngi thay ta chuy觧 l阨 cho B蕋 Nhi詍 C玭g T�, n鉯 an M閏 Du� ta quy誸 kh玭g l祄 ng礽 th蕋 v鋘g. ","Л頲! T筰 h� c騨g xin 產 t� ti襫 b鑙 v鮝 r錳  ch� d箉. ")
end

function Uworld123_step4b()
	DelItem(377)
	SetTask(123,70)
	Talk(1,"","R蕋 t鑤! nh� ngi thay ta chuy觧 l阨 cho B蕋 Nhi詍 C玭g T�, n鉯 an M閏 Du� ta quy誸 kh玭g l祄 ng礽 th蕋 v鋘g. ")
	Msg2Player("an M閏 Du� ti誴 t鬰 m阨 b筺 v� b竜 tin cho Л阯g B蕋 Nhi詍.")
end
