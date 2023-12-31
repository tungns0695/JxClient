Include("\\script\\missions\\miniencounter\\mapmanager.lua");

function main(sel)
	local tbTargetPos = 
	{
		[1] = {1833, 3143},
		[2] = {1824, 3143},
		[3] = {1826, 3150},
		[4] = {1833, 3153},
		[5] = {1838, 3151},
		[6] = {1840, 3144},
		[7] = {1837, 3141},
		[8] = {1833, 3138},
	};

	SetTmpCamp(2);
	SetCurCamp(2);
	local nTargetPosNum = getn(tbTargetPos);
	local nRandom = random(1, nTargetPosNum);

	local nMapId = GetWorldPos();
	local tbMap  = EncounterMapManager:FindInMapList(nMapId);

	if tbMap then
		local tbPlayer = tbMap:GetPlayer(GetName());
		local nCurrentTime = GetCurrentTime();

		-- 比赛未到时间给信息
		if nCurrentTime - tbMap.nGameStartTime <= DungeonGlobalData.MAP_WAIT_TIME or
		   tbMap.nGameState <= 1 then
			Msg2Player("Tr薾 chi課 v蒼 ch璦 b総 u. Xin i trong gi﹜ l竧!");
			return nil;
		end

		if nCurrentTime >= tbPlayer.nLastDeadTime + DungeonGlobalData.MAP_REBORN_TIME then
			SetFightState(1);		   -- 设置战斗状态
			SetPos(tbTargetPos[nRandom][1], tbTargetPos[nRandom][2]);
		else
			Msg2Player("Ngi  b� tr鋘g thng, ngh� ng琲 t� 甶!");
		end
	end
end

