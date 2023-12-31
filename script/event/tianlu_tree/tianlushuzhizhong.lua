-- 天禄树之种
Include("\\script\\activitysys\\functionlib.lua")
Include("\\script\\activitysys\\playerfunlib.lua")
Include("\\script\\event\\tianlu_tree\\tree.lua")
Include("\\script\\activitysys\\g_activity.lua")
--New eventsys action - modified by DinhHQ - 20130625
Include("\\script\\misc\\eventsys\\eventsys.lua")

local TSK_DAYLY_PLANT_NUM = 4015  -- 每日种树数量
local TSK_PLANT_TIME = 4016   -- 种树时间
local MAX_LIMIT_PLANT_NUM = 40 -- 每日种树上限
local PLANT_DELTA_TIME = 50  -- 种树间隔时间
local MAX_LIMIT_PLANT_NUM_2 = 80

function main(nItemIndex)
	-- Change limit use by level - modified by DinhHQ - 20130531
	local nMaxLimit 
	local nTranslifeCount = ST_GetTransLifeCount() 
	if nTranslifeCount > 4 or (nTranslifeCount == 4 and GetLevel() >= 180) then
		nMaxLimit = %MAX_LIMIT_PLANT_NUM_2
	else
		nMaxLimit = %MAX_LIMIT_PLANT_NUM
	end
	if not PlayerFunLib:CheckTaskDaily(%TSK_DAYLY_PLANT_NUM, nMaxLimit, "H玬 nay i hi謕  tr錸g "..nMaxLimit.." c﹜, kh玭g th� tr錸g th猰 n鱝, ngh� ng琲 r錳 ng祔 mai l筰 n.", "<") then
		return 1
	end
	-- 检查种树位置
	local szMapList = "11,1,37,,176,162,78,80,174,121,153,101,99,100,20,53,175"
	local _,_,nMapIndex = GetPos()
	local nMapId = SubWorldIdx2ID(nMapIndex)
	if lib:CheckInList(szMapList, nMapId) then
		-- 检查种树间隔时间
		local deltaTime = GetCurServerTime() - GetTask(%TSK_PLANT_TIME)  
--		if GetTask(%TSK_PLANT_TIME)~=0 and deltaTime<%PLANT_DELTA_TIME then
--			Msg2Player("Чi hi謕 ngi m謙 qu� r錳 , ngh� ng琲 m閠 l竧 r錳 h穣 ti誴 t鬰.")
--			return 1
--		end
		-- 种树
		SetTask(%TSK_PLANT_TIME, GetCurServerTime()) -- 设置种树时间
		PlayerFunLib:AddTaskDaily(%TSK_DAYLY_PLANT_NUM, 1) -- 更新种树数量		
		--New eventsys action - modified by DinhHQ - 20130625
		EventSys:GetType("HarvestPlants"):OnPlayerEvent("use_tianlu_seed", PlayerIndex)
		G_ACTIVITY:OnMessage("Use_Tianlu_Seed");
		--B竎h ni猲 h閕 ng� l謓h b礽 2012 - modified by DinhHQ - 20120927
		DynamicExecuteByPlayer(PlayerIndex, "\\script\\activitysys\\config\\1005\\personal_quest.lua", "tbPVLB_Quest:AddTreeQuest")
		-- 在这里调用种树接口
		%CreateTree(PlayerIndex)
		return 0
	else
		Talk(1, "","Чo c� n祔 ch� 頲 s� d鬾g t筰 c竎 th祅h th� v� th玭 tr蕁.")
		return 1
	end
end