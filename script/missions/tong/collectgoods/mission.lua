Include([[\script\missions\tong\collectgoods\head.lua]]);

function InitMission()
	local i;
	for i = 1, 40 do
		SetMissionV(i, 0);
	end;
	
	for i = 1, 10 do
		SetMissionS(i, "");
	end;
	
	SetMissionV(COLLG_MS_TIMERSTATE, 1);

	local OldSubWorld = SubWorld;
	SubWorld = SubWorldID2Idx(COLLG_MAPID[2]);
	
	StartMissionTimer(COLLG_MISSIONID, COLLG_RUNTIMERID, COLLG_RUNINTERVER); --
	StartMissionTimer(COLLG_MISSIONID, COLLG_SMALLTIMERID, COLLG_INTERVER);	--
end;

function EndMission()
	local i;
	for i = 1, COLLG_SMALLMAPCOUNT do
		if (GetMSPlayerCount(COLLG_MISSIONID, i) > 0) then
			groupsort(i);
		end;
	end;
	collg_clearfairy();	--清除场地内所有的怪
	collg_gameover(COLLG_MAPID[2], COLLG_MISSIONID);	--将所有玩家清除出地图
	local nTime = tonumber(GetLocalDate("%H%M"));
	local strGlbNews = "C竎 hi謕 kh竎h 甶 t譵 h祅g h鉧  tr� v� r錳."
	AddGlobalNews(strGlbNews);

	StopMissionTimer(COLLG_MISSIONID, COLLG_SMALLTIMERID);
	StopMissionTimer(COLLG_MISSIONID, COLLG_RUNTIMERID);
	SetGlbValue(GLB_COLLG_PHASE, 3); 
	gb_SetTask(COLLG_NAME, 1, 3);
end;

function OnLeave()
	SetLogoutRV(0);
end

--排序函数(根据点击个数由多到少确定将一组成员的名次)；
function groupsort(nGroupId)
	local OldSubWorld = SubWorld;
	SubWorld = SubWorldID2Idx(COLLG_MAPID[2]);
	
	local OldPlayer = PlayerIndex;
	local tabPlayer = {};
	local idx = 0;
	local pidx;
	
	local i;
	for i = 1, COLLG_MAXPLAYERCOUNT do
		idx, pidx = GetNextPlayer(COLLG_MISSIONID, idx, nGroupId);
		
		if (pidx > 0) then
			tabPlayer[i] = {};
			tabPlayer[i][1] = pidx;
			PlayerIndex = pidx;
			tabPlayer[i][2] = GetTask(COLLG_COUNT_ONETIME);
		end;
		
		if (0 == idx) then
			break;
		end;
	end;
	
	local j;
	local temptab = {};
	local nCount = getn(tabPlayer);
	for i = 2, nCount do	--采用一个冒泡排序
		for j = nCount, i, -1 do
			if (tabPlayer[j][2] > tabPlayer[j - 1][2]) then	--采用降序排序
				temptab = tabPlayer[j];
				tabPlayer[j] = tabPlayer[j - 1];
				tabPlayer[j - 1] = temptab;
			end;
		end;
	end;
	local szMsg = ""
	local nRankCount = getn(tabPlayer);
	if (nRankCount > 3) then
		nRankCount = 3;
	end;
	for i=1,nRankCount do
		if ( tabPlayer[i][1] ~= nil ) then
			PlayerIndex = tabPlayer[i][1]
			szMsg = szMsg.."<enter> <color=green>"..i.." "..GetName()..", nh薾 頲 "..tabPlayer[i][2].." t骾 h祅g h鉧"
		end
	end
	--排序后从前到后就是名次的先后
	for i = 1, nCount do
		PlayerIndex = tabPlayer[i][1];
		SetTask(COLLG_TK_RANK, i);
		if (szMsg ~= nil and szMsg ~= "") then
			Msg2Player(szMsg)
		end
		if (GetTask(COLLG_COUNT_ONETIME) == 0) then
			Msg2Player("Th藅 ng ti誧, ngi kh玭g c� t骾 h祅g h鉧 n祇!");
		else
			Msg2Player("B筺 x誴 h筺g th� <color=yellow>"..i.."<color>, c� th� n g苝 <color=yellow>T鎛g qu秐 Ho箃 ng phng<color>  nh薾 thng!");
		end;
	end;
	
	PlayerIndex = OldPlayer;
	SubWorld = OldSubWorld;
end;
