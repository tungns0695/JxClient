IncludeLib("ITEM")
Include("\\script\\tong\\tong_award_head.lua");-- by志山，帮会周目标贡献度
Include("\\script\\lib\\progressbar.lua")
Include("\\script\\lib\\awardtemplet.lua")

--	local GREADSEED_SEEDID_TASKID = 2310;
--	local GREADSEED_TIME_TASKID = 2311;

local _Limit = function(nNpcIdx)
	
	if (0 == GetCamp()) then
		Msg2Player("B筺 ch璦 gia nh藀 m玭 ph竔, kh玭g th� h竔 qu�.")
		return
	end

	if (0 == GetFightState() or GetLife(0) <= 0 or GetProtectTime() > 0 ) then
		Msg2Player("kh玭g th� h竔 qu�.")
		return
	end
	
	local nPlayerLevel = GetLevel();
	local nGetSeedLevel = nil;
	if (nPlayerLevel < 90) then
		nGetSeedLevel = 1;
	elseif (nPlayerLevel >= 90 and nPlayerLevel < 120) then
		nGetSeedLevel = 2;
	elseif (nPlayerLevel >= 120) then
		nGetSeedLevel = 3;
	end
	
	if (nGetSeedLevel ~= 3) then -- 如果级别不对,不能进行拾取
		--这里告诉玩家级别不对,不能拾取
		Msg2Player("Lo筰 qu� n祔 ngi ch琲 ph秈 t� c蕄 120 tr� l猲 m韎 c� th� h竔 頲 ")
		return
	end;
	
	return nGetSeedLevel
end

local _GetFruit = function(nNpcIdx, dwNpcId)
	
	if nNpcIdx <= 0 or GetNpcId(nNpcIdx) ~= dwNpcId then
		return 0
	end
	local nGetSeedLevel = %_Limit(nNpcIdx)
	
	if nGetSeedLevel == nil then
		return 0
	end
	
	
	DelNpc(nNpcIdx)
	--Qu� Чi Ho祅g Kim - Modified by DinhHQ - 20130516
	local tbGoldenFruits = 
	{
		{szName = "Qu� Ho祅g Kim", tbProp = {6,1,907,1,0,0,0}, nExpiredTime = 10080, nRate = 80},
		{szName = "Qu� Чi Ho祅g Kim", tbProp = {6,1,30438,1,0,0,0}, nExpiredTime = 10080, nRate = 20}
	}
	tbAwardTemplet:Give(tbGoldenFruits, 1, {"Иm Huy Ho祅g", "H竔 qu� huy ho祅g"})
	
	--T筸 ng t輓h n╪g ch璦 ho箃 ng - Modified by DinhHQ - 20110427
	--tbAwardTemplet:GiveAwardByList({tbProp = {6,1,2804,1,0,0,0}}, "Иm Huy Ho祅g", 30);
	
	tongaward_goldenseed();-- by志山，帮会周目标贡献度
	--Msg2Player("你得到了一个黄金之果。");
	AddGlobalNews(format("Чi hi謕 %s  h竔 頲 qu� Ho祅g Kim!!!",GetName()));
end


local _OnBreak = function()
	Msg2Player("Thu th藀 t 畂筺")
end

function main()
	local nNpcIdx = GetLastDiagNpc();
	local dwNpcId = GetNpcId(nNpcIdx)
	
	if %_Limit(nNpcIdx) == nil then
		return
	end
	--开启进度条
	tbProgressBar:OpenByConfig(2, %_GetFruit, {nNpcIdx, dwNpcId}, %_OnBreak)
end;

