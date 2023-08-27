--两湖区 巴陵县 杂货店老板对话　天王40级任务
-- Update: Dan_Deng(2003-08-16)
Include("\\script\\task\\newtask\\education\\jiaoyutasknpc.lua")
Include("\\script\\task\\newtask\\newtask_head.lua")
Include("\\script\\global\\global_zahuodian.lua");
Include("\\script\\activitysys\\g_activity.lua")
Include("\\script\\dailogsys\\g_dialog.lua")
Include("\\script\\activitysys\\npcfunlib.lua")
Include("\\script\\activitysys\\playerfunlib.lua")
function main(sel)
	local nNpcIdx = GetLastDiagNpc()
	local dwNpcId = GetNpcId(nNpcIdx)
	local szNpcName = GetNpcName(nNpcIdx)
	local tbDailog = DailogClass:new(szNpcName)
	G_ACTIVITY:OnMessage("ClickNpc", tbDailog)
	tbDailog.szTitleMsg = "<npc>Trc y ta l� ngi b竛 h祅g rong, t輈h c鉷 頲 輙 v鑞, m� ti謒 t筽 h鉧 nh� n祔"
	if (GetTask(3) == 40*256+50) and (GetTask(14) == 5) and (HaveItem(148) == 0) then 		--天王帮40级任务
		tbDailog:AddOptEntry("C� b竛 h箃 sen kh玭g?", lotus)
	end
	tbDailog:AddOptEntry("Giao d辌h", yes)
	tbDailog:AddOptEntry("Kh玭g giao d辌h", no)
	tbDailog:Show()
end

function lotus()
	Say("H箃 sen ch輓h l� c s秐 c馻 b鎛 ti謒, d� nhi猲 l� c�, ch� c� 500 lng th玦", 2, "Mua/yes1", "Kh玭g mua/no")
end;

function yes1()
	if (GetCash() >= 500) then
		Pay(500)
		AddEventItem(148)
		Msg2Player("Mua 頲 h箃 sen")
--		SetTask(14, 3)	
		AddNote("Mua 頲 h箃 sen t筰 ti謒 t筽 h鉧 Ba L╪g huy謓 ")
	else
		Say("C�  ti襫 r錳 h穣 n mua 甶, h穣 xem nh鱪g m鉵 h祅g kh竎 trc 甶.", 2, "Giao d辌h/yes", "Kh玭g giao d辌h/no")
	end
end;

function yes()
Sale(38);  			
end;

function no()
end;
