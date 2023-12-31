Include("\\script\\missions\\miniencounter\\mapmanager.lua");

function OnDeath(nNpcIndex)
	local nMapId = GetWorldPos();									   -- 地图ID
	local tbMap  = EncounterMapManager.tbMapList[nMapId];			   -- 副本地图

	-- 被NPC和玩家杀死都处理的逻辑
	local szPlayerName = GetName();									 -- 被害者名字
	local nPlayerCamp  = tbMap:GetCampByName(szPlayerName);			 -- 被害者阵营
	local tbPlayer	 = tbMap:GetPlayerByCamp(nPlayerCamp, szPlayerName);
	local nX, nY	   = tbMap:GetNewWorldPos(nPlayerCamp);
	SetTempRevPos(nMapId, nX * 32, nY * 32);							-- 设置临时重生点

	-- 死亡时间计算
	local nCurrentTime = GetCurrentTime();
	if nCurrentTime > tbPlayer.nLastDeadTime then
		tbPlayer.nLastDeadTime = nCurrentTime;
	end

	-- 被玩家杀死处理的逻辑
	local nKillerIndex = NpcIdx2PIdx(nNpcIndex);						-- 凶手索引
	if nKillerIndex <= 0 then
		return nil;
	end

	local szKillerName = CallPlayerFunction(nKillerIndex, GetName);	 -- 凶手名字
	local nKillerCamp  = tbMap:GetCampByName(szKillerName);			 -- 凶手阵营
	local tbKiller	 = tbMap:GetPlayerByCamp(nKillerCamp, szKillerName);

	-- 发战场信息
	local strMsg = format(
		"[%s]%s k輈h s竧 [%s]%s r錳!",
		tbKiller:GetTitleString(),
		szKillerName,
		tbPlayer:GetTitleString(),
		szPlayerName
	);
	Msg2Map(tbMap.nMapId, strMsg);

	-- 计算分数
	if nKillerCamp ~= nPlayerCamp then
		-- 杀人数计算
		tbKiller.nKillPlayerNum = tbKiller.nKillPlayerNum + 1;

		-- 连击数计算
		local nValidCombo = DungeonGlobalData:GetValidCombo(tbKiller.nTitleLv, tbPlayer.nTitleLv);

		tbPlayer.nComboTimes = 0;
		tbPlayer.nCurMaxKillComboNum = 0;
		tbKiller.nComboTimes = tbKiller.nComboTimes + nValidCombo;
		tbKiller.nCurMaxKillComboNum = tbKiller.nCurMaxKillComboNum + nValidCombo;

		if tbPlayer.nMaxKillComboNum < tbPlayer.nCurMaxKillComboNum then
			tbPlayer.nMaxKillComboNum = tbPlayer.nCurMaxKillComboNum;
		end

		if tbKiller.nMaxKillComboNum < tbKiller.nCurMaxKillComboNum then
			tbKiller.nMaxKillComboNum = tbKiller.nCurMaxKillComboNum;
		end

		-- 加分扣分计算
		local nIncreasePoint = DungeonGlobalData:GetIncreaseScorePoint(tbKiller.nTitleLv, tbPlayer.nTitleLv);
		local nDecreasePoint = DungeonGlobalData:GetDecreaseScorePoint(tbKiller.nTitleLv, tbPlayer.nTitleLv);

		-- 基本积分
		tbPlayer.nEncounterScore = tbPlayer.nEncounterScore - nDecreasePoint;
		if tbPlayer.nEncounterScore < 0 then
			tbPlayer.nEncounterScore = 0;
		end
		
		tbKiller.nEncounterScore = tbKiller.nEncounterScore + nIncreasePoint;

		-- 记积分任务变量
		tbKiller.nKillEnemyNum  = tbKiller.nKillEnemyNum + 1;
		tbPlayer.nDeathTotalNum = tbPlayer.nDeathTotalNum + 1;

		tbKiller:SetTaskValue(DungeonGlobalData.TASK_KILL_ENEMY_NUM, tbKiller.nKillEnemyNum);
		tbKiller:SetTaskValue(DungeonGlobalData.TASK_CUR_KILL_COMBO_NUM, tbKiller.nCurMaxKillComboNum);
		tbKiller:SetTaskValue(DungeonGlobalData.TASK_MAX_KILL_COMBO_NUM, tbKiller.nMaxKillComboNum);
		tbKiller:SetTaskValue(DungeonGlobalData.TASK_CUR_TITLE_INDEX, tbKiller.nTitleLv);

		tbPlayer:SetTaskValue(DungeonGlobalData.TASK_DEATH_TOTAL_NUM, tbPlayer.nDeathTotalNum);
		tbPlayer:SetTaskValue(DungeonGlobalData.TASK_CUR_KILL_COMBO_NUM, tbPlayer.nCurMaxKillComboNum);
		tbPlayer:SetTaskValue(DungeonGlobalData.TASK_MAX_KILL_COMBO_NUM, tbPlayer.nMaxKillComboNum);
		tbPlayer:SetTaskValue(DungeonGlobalData.TASK_CUR_TITLE_INDEX, tbPlayer.nTitleLv);

		-- 连斩积分
		if tbKiller.nComboTimes >= 3 then
			tbKiller.nComboTimes = 0;
			tbKiller.nEncounterScore = tbKiller.nEncounterScore + 2;
			-- 发信息
			local strMsg = format("[%s]%sth� l鵦 kh玭g th� , ho祅 th祅h 3 l莕 tr秏 li猲 ti誴!", tbKiller:GetTitleString(), szKillerName);
			Msg2Map(tbMap.nMapId, strMsg);
		end

		if tbMap then
			tbMap:SendFuLiTopTenData2Client();
		end
	end

	tbPlayer:RefreshTitle();
	CallPlayerFunction(nKillerIndex, tbKiller.RefreshTitle, tbKiller)

	tbPlayer:PrintInfo();
	tbKiller:PrintInfo();
end
