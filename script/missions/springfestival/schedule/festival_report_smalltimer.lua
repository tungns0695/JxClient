Include([[\script\missions\springfestival\festival_head.lua]]);

function OnTimer()
	local nNewsValue = GetMissionV(MS_FE_NEWSVALUE) + 1;
	SetMissionV(MS_FE_NEWSVALUE, nNewsValue);
	
	if (20 == nNewsValue) then
		CloseMission(FE_MISSIONID);
		return
	end;
	
	local i;
	for i = 1, FE_SMALLMAPCOUNT do
		if (nNewsValue >= 18) then
			groupsort(i, 1, FE_ANIMALNAME);
			groupsort(i + FE_SMALLMAPCOUNT, 1, FE_MOUSENAME);
		else
			groupsort(i, 0, FE_ANIMALNAME);
			groupsort(i + FE_SMALLMAPCOUNT, 0, FE_MOUSENAME);
		end;
	end;
	
	if (0 == mod(nNewsValue, 2)) then
		local nTime = floor(nNewsValue / 2);
		nTime = 10 - nTime;
		if (nTime > 0) then
			local OldSubWorld = SubWorld;
			SubWorld = SubWorldID2Idx(FE_MAPID[2]);
			Msg2MSAll(FE_MISSIONID, "Ho箃 ng v蒼 c遪<color=yellow>"..nTime.."<color>ph髏 k誸 th骳!");
			SubWorld = OldSubWorld;
		end;
	end;
end;

--排序函数(根据点击个数由多到少确定将一组成员的名次)；
function groupsort(nGroupId, bSave, szAnimalName)
	local OldSubWorld = SubWorld;
	SubWorld = SubWorldID2Idx(FE_MAPID[2]);
	
	local OldPlayer = PlayerIndex;
	local tabPlayer = {};
	local idx = 0;
	local pidx;
	
	local i;
	for i = 1, FE_MAXPLAYERCOUNT do
		idx, pidx = GetNextPlayer(FE_MISSIONID, idx, nGroupId);
		
		if (pidx > 0) then
			tabPlayer[i] = {};
			tabPlayer[i][1] = pidx;
			PlayerIndex = pidx;
			tabPlayer[i][2] = GetTask(TK_FE_COUNT_ONETIME);
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
			if (nGroupId > FE_SMALLMAPCOUNT) then
			    szMsg = szMsg.."<enter> <color=green>"..i.." "..GetName()..", b総 頲"..tabPlayer[i][2].."c竔"..FE_MOUSENAME;
			else
			    szMsg = szMsg.."<enter> <color=orange>"..i.." "..GetName()..", nh tr髇g"..FE_ANIMALNAME..tabPlayer[i][2].."l莕";
			end;
		end
	end
	--排序后从前到后就是名次的先后
	nCount = nCount;
	for i = 1, nCount do
		PlayerIndex = tabPlayer[i][1];
		if (bSave == 1) then
			SetTask(TK_FE_RANK, i);
		end;
		if (szMsg ~= nil and szMsg ~= "") then
			Msg2Player(szMsg)
		end
		if (nGroupId > FE_SMALLMAPCOUNT) then
		    Msg2Player("B筺  b総 頲<color=yellow>"..GetTask(TK_FE_COUNT_ONETIME).."<color>c竔"..szAnimalName..", hi謓 產ng x誴 th� <color=yellow>"..i.."<color>.");
		else
		    Msg2Player("Hi謓 t筰 b筺 nh tr髇g <color=yellow>"..szAnimalName..GetTask(TK_FE_COUNT_ONETIME).."<color>l莕"..", hi謓 產ng x誴 th� <color=yellow>"..i.."<color>.");
		end;
	end;
	
	PlayerIndex = OldPlayer;
	SubWorld = OldSubWorld;
end;
