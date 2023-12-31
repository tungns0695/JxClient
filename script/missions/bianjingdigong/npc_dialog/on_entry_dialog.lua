--======================================================================
--Author:   Tan Qingyu
--Date:     2012-3-31 11:01:04
--Describe: 汴京地宫 入口NPC对话脚本
--======================================================================

Include("\\script\\dailogsys\\g_dialog.lua")
Include("\\script\\activitysys\\g_activity.lua")
Include("\\script\\activitysys\\playerfunlib.lua")
Include("\\script\\missions\\bianjingdigong\\bianjingdigong_head.lua")

function main()
	--若跨天了，则清空地宫时间积累任务变量
	local nCurDate = tonumber(GetLocalDate("%Y%m%d"))
	
	local tbOpenDate = BJDG_HEAD.tbOpenDate
	local nIsOpen = BJDG_HEAD.nIsOpen
	
	if (nIsOpen == 0) or (nCurDate < tbOpenDate.nBegin) or (nCurDate >= tbOpenDate.nEnd and tbOpenDate.nEnd ~= 0) then
		Talk(1, "", "Giang h� n r籲g trong th祅h Bi謓 Kinh c� m閠 мa Cung th莕 b�, nghe n鉯 trong  ti襪 萵 v� s� b秓 t祅g qu� gi�, b籲g m鋓 gi� ta ph秈 v祇 a cung cho b籲g 頲. Ta tin r籲g s� c� 1 ng祔, nh蕋 nh s� l祄 cho мa Cung hi觧 di謓 trc b祅 d﹏ thi猲 h�!")
		return
	end
	
	local nLastResetDate = GetTask(BJDG_HEAD.nLastResetDateTaskId)
	if nCurDate ~= nLastResetDate then
		SetTask(BJDG_HEAD.nInDungeonTimeTaskId, 0)
		SetTask(BJDG_HEAD.nLastResetDateTaskId, nCurDate)
	end

	local nNpcIndex = GetLastDlgNpc()
	local szNpcName = GetNpcName(nNpcIndex)
	local tbDialog = DailogClass:new(szNpcName)
	tbDialog.szTitleMsg = "<npc>Huynh mu閕 ch髇g t玦 n y  甶襲 tra b� m藅 c馻 мa Cung Bi謓 Kinh, v�  l藀 n猲 4 tr薾 ph竝 trong мa Cung n祔. Trong tr薾 ph竝 c� th� b秓 h� cho ngi. Ngi c� th� t� ch� c馻 ta l鵤 ch鋘 truy襫 t鑞g n b蕋 k� tr薾 ph竝 n祇 ngi mu鑞, c騨g c� th� i tho筰 v韎 gia huynh K� L鬰 Nh﹏ � trong мa Cung  truy襫 t鑞g. Trong мa Cung v� c飊g nguy hi觤, m鏸 ng祔 ngi ch� c� th� l璾 l筰 n琲  2 ti課g ng h� m� th玦, c遪 n誹 nh� ngi c� 頲 l頸 l閏 g� khi v祇  hay kh玭g, th� c遪 ph秈 xem b秐 l躰h c馻 nh� ngi nh� th� n祇 ."
	G_ACTIVITY:OnMessage("ClickNpc", tbDialog, nNpcIndex)
	tinsert(tbDialog, {" v祇 мa Cung", SendMeToDlg})
	tinsert(tbDialog, {"Ki觤 tra th阨 gian c遪 l筰", QueryLeftTime})
	tinsert(tbDialog, {"K誸 th骳 i tho筰"})
	CreateNewSayEx(tbDialog.szTitleMsg, tbDialog)
end

function SendMeToDlg()
	local nNpcIndex = GetLastDlgNpc()
	local szNpcName = GetNpcName(nNpcIndex)
	local tbDialog = DailogClass:new(szNpcName)
	
	if PlayerFunLib:CheckTotalLevel(135, "default", ">=") ~= 1 then
		return
	end
	
	if GetCamp() == 0 then
		Talk(1, "", "Ch祇 i hi謕: мa Cung mu玭 tr飊g hi觤 nguy, ngi m韎 gia nh藀 giang h� nh� c竎 h� kh玭g th� v祇 ")
		return
	end
	
	local nHour = tonumber(GetLocalDate("%H"))
	if BJDG_HEAD.tbOpenTime[nHour] ~= 1 then
		Talk(1, "", "M鏸 ng祔 v祇 l骳 10:00-24:00, 0:00-2:00 l� th阨 gian m� b秐  m� cung.")
		return
	end
	
	local nInDungeonTime = GetTask(BJDG_HEAD.nInDungeonTimeTaskId)
	if nInDungeonTime >= BJDG_HEAD.nDailyLimitTime then
		Talk(1, "", "мa Cung l� n琲 v� c飊g nguy hi觤, m鏸 ng祔 ngi ch� c� th� v祇  頲 2 ti課g ng h� m� th玦.")
		return
	else
		tbDialog.szTitleMsg = "<npc>Xin h穣 l鵤 ch鋘 甶觤 truy襫 t鑞g"
		G_ACTIVITY:OnMessage("ClickNpc", tbDialog, nNpcIndex)
		tinsert(tbDialog, {"Thanh Long Tr薾", SendMeTo, {"Thanh Long Tr薾"}})
		tinsert(tbDialog, {"B筩h H� Tr薾", SendMeTo, {"B筩h H� Tr薾"}})
		tinsert(tbDialog, {"Chu Tc Tr薾", SendMeTo, {"Chu Tc Tr薾"}})
		tinsert(tbDialog, {"Huy襫 V� Tr薾", SendMeTo, {"Huy襫 V� Tr薾"}})
		tinsert(tbDialog, {"K誸 th骳 i tho筰"})
	end
	CreateNewSayEx(tbDialog.szTitleMsg, tbDialog)
end

function SendMeTo(szPos)
	NewWorld(unpack(BJDG_HEAD.tbPos[szPos]))
end

function QueryLeftTime()
	local nLeftTime = BJDG_HEAD.nDailyLimitTime - GetTask(BJDG_HEAD.nInDungeonTimeTaskId)
	if nLeftTime <= 0 then
		nLeftTime = 0
	end
	local nLeftHours = floor(nLeftTime / 3600);
	local nLeftMinutes = floor(mod(nLeftTime, 3600) / 60);
	local nLeftSeconds = mod(nLeftTime, 60);
	
	Talk(1, "", format("H玬 nay c竎 h� c遪 c� th� l璾 l筰 trong мa Cung [%02d:%02d:%02d]", nLeftHours, nLeftMinutes, nLeftSeconds))
end
