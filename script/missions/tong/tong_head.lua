if (1) then -- not __TONG_H__) then
	__TONG_H__ = 1;
IL("TONG");
IncludeLib("FILESYS");
Include("\\script\\missions\\tong\\tong_springfestival\\file_npc_head.lua")
-- Include([[\script\tong\workshop\ws_huodong.lua]]);


SFHD_DATAFILE = [[\settings\tong\workshop\huodong_level_data.txt]];
HUODONG_TASKID = {{1015, 1016}, {1017, 1018}, {1019, 1020}};
TONGGXD = {{800, 4}, {500, 6}, {300, 8}};

--=========任务变量===============
TK_LEAVERMAPID = 2392;	--存储离开游戏的mapid
TK_LEAVERPOSX = 2393;	--存储离开游戏的x坐标点
TK_LEAVERPOSY = 2394;	--存储离开游戏的y坐标点

TK_GROUPID = 2399;	--记录玩家的Group号
TK_EXP_BEISHU = 2400; --
TK_EXP_TIME = 2401;
--================================
	
function FALSE(nParam)
	if (nParam == nil or nParam == "" or nParam == 0) then
		return 0;
	end;
	return 1;
end

function festival_tongjudge(nType, nTongID, nWorkshopID)--判断是否具有资格nType:1-招募弟子2-年兽
	local nLevel = TWS_GetLevel(nTongID, nWorkshopID)
	local nPCount = TONG_GetMemberCount(nTongID, -1);
	if (nLevel < 1 or nLevel > 10) then
		Say("Qu� bang v蒼 ch璦 x﹜ d鵱g T竎 Phng n祔.", 1, "Ta bi誸 r錳!/OnCancel")
		return 0;
	end;
	--local njoinrate = tonumber(GetTabFileData(SFHD_DATAFILE, nLevel + 2, TONGGXD[nType][2]));
	local nMax = 20 --ceil(nPCount * njoinrate);
	local nTimes = TWS_GetTaskValue(nTongID, nWorkshopID, HUODONG_TASKID[nType][1]);
	local nDay = tonumber(GetLocalDate("%d"));
	TDay = TWS_GetTaskValue(nTongID, nWorkshopID, HUODONG_TASKID[nType][2]);
	if (nDay ~= TDay) then
		TWS_ApplySetTaskValue(nTongID, nWorkshopID, HUODONG_TASKID[nType][2], nDay);
		TWS_ApplySetTaskValue(nTongID, nWorkshopID, HUODONG_TASKID[nType][1], 0);
	end;
	if (nTimes >= nMax) then
		Say("Bang h閕 h玬 nay kh玭g c� ho箃 ng n祇, ng祔 kh竎 h穣 n t譵 ta.", 1, "Ta bi誸 r錳!/OnCancel")
		return 0;
	end;
	
	TWS_ApplySetTaskValue(nTongID, nWorkshopID, HUODONG_TASKID[nType][1], nTimes + 1);	
	
	local nGXD = GetContribution();
	if (nGXD < TONGGXD[nType][1]) then
		Say("T鎛g qu秐 Ho箃 ng phng: 觤 c鑞g hi課 c馻 ngi kh玭g "..TONGGXD[nType][1]..", kh玭g th� tham gia ho箃 ng.", 1, "Ta bi誸 r錳!/OnCancel")
		TWS_ApplySetTaskValue(nTongID, nWorkshopID, HUODONG_TASKID[nType][1], nTimes); --不成功人数不加
		return 0;
	end;
	
	return 1;
end;



--三个活动入场时的分组
function chaos(tabPlayerIdx, nMax) --打乱玩家的顺序,分成10个人的一个小分队
	if ("table" ~= type(tabPlayerIdx)) then
		error("tabPlayerIdx is not a table value!");
	end;
	chr_rand_tab(tabPlayerIdx)
	local nPCount = getn(tabPlayerIdx);
	local subTabCount = floor(nPCount / nMax);
	local tabSubTeam = {};
	local i, j;
	local nIndex;
	local nBeginPlayer = random(1, nPCount);
	
	--将能筹齐10个人的入场
	for i = 1, subTabCount do
		tabSubTeam[i] = {}
		for j = 1, nMax do
			local nIndex = subTabCount * (j - 1) + i + nBeginPlayer - 1;
			nIndex = mod(nIndex - 1, nPCount) + 1
			tabSubTeam[i][j] = tabPlayerIdx[nIndex];
		end;
	end;
	--不足10个人的放到另外一个小组里
	tabSubTeam[subTabCount + 1] = {};
	j = 1;
	local nBegin = nMax * subTabCount + 1;
	for i = nBegin, nPCount do
		nIndex = i  + nBeginPlayer - 1; 
		nIndex = mod(nIndex - 1, nPCount) + 1;
		tabSubTeam[subTabCount + 1][j] = tabPlayerIdx[nIndex];
		j = j + 1;
	end;
	return tabSubTeam;
end;

function cancelgame(nMapID, nMissionID)
	local OldWorld = SubWorld;
	SubWorld = SubWorldID2Idx(nMapID);
	local pidx;
	local idx = 0;
	local OldPlayer = PlayerIndex;
	local tabPlayer = {};
	local i;
	for i = 1, 400 do
		idx, pidx = GetNextPlayer(nMissionID, idx, 0);
		if (pidx > 0) then
			tinsert(tabPlayer, pidx);
		end;
		
		if (0 == idx) then
			break;
		end;
	end;
	local nLoop = getn(tabPlayer);
	for i = 1, nLoop do
		PlayerIndex = tabPlayer[i];
		Say("Do s� ngi b竜 danh tham gia 輙 h琻 <color=yellow>5<color> ngi, ho箃 ng l莕 n祔 b� h駓 b�.", 1, "Ta bi誸 r錳!/OnCancel")
		Msg2Player("Do s� ngi b竜 danh tham gia 輙 h琻 <color=yellow>5<color> ngi, ho箃 ng l莕 n祔 b� h駓 b�.");
		NewWorld(GetTask(TK_LEAVERMAPID), GetTask(TK_LEAVERPOSX), GetTask(TK_LEAVERPOSY))
	end;
	PlayerIndex = OldPlayer;
	SubWorld = OldWorld;
end;

--tabParam = {准备场ID, {需要的贡献度, 坐标文件}, {设置为零的任务变量...}, {group值, 开始地图map, MissionID, 活动所在map}}
--tabParam = {nPrepareMapID, {nContri, szFile}, {}, 
--				{nGroupId, nBeginMap, nMissionID, nMissionMap}}
function gogamemap(tabPlayerIdx, tabParam) --
	if ("table" ~= type(tabPlayerIdx)) then
		return
	end;
	local OldSubWorld = SubWorld;
	local nPCount = getn(tabPlayerIdx);
	local OldPlayer = PlayerIndex;
	local nContri, i, PosX, PosY;
	SubWorld = SubWorldID2Idx(tabParam[1]);
	for i = 1, nPCount do
		PlayerIndex = tabPlayerIdx[i];
		if (PlayerIndex > 0) then
				--在这里扣除帮会贡献度
			nContri = GetContribution();
			if (nContri < tabParam[2][1]) then
				Say("觤 c鑞g hi課 kh玭g "..tabParam[2][1]..", kh玭g th� tham gia ho箃 ng.", 1, "Ta bi誸 r錳!/OnCancel");
				DelMSPlayer(tabParam[4][3], PlayerIndex, 0);
				Msg2Player("觤 c鑞g hi課 kh玭g "..tabParam[2][1]..", kh玭g th� tham gia ho箃 ng.");
				NewWorld(GetTask(TK_LEAVERMAPID), GetTask(TK_LEAVERPOSX), GetTask(TK_LEAVERPOSY));
			else
				Msg2Player("Tham gia ho箃 ng phng c馻 bang, ti猽 hao <color=red>甶觤 c鑞g hi課 bang h閕<color><color=yellow> "..tabParam[2][1].."<color>.")
				AddContribution(-1 * tabParam[2][1]);--进场时扣除贡献度

				for j = 1, getn(tabParam[3]) do
					SetTask(tabParam[3][j], 0);
				end;
				SetTask(TK_GROUPID, tabParam[4][1]);	--记录玩家的groupid

				PosX, PosY = getadatabetween(tabParam[2][2], 8 + 8 * tabParam[4][2], 15 + 8 * tabParam[4][2]);
				NewWorld(tabParam[4][4], floor(PosX / 32), floor(PosY / 32));
				SubWorld = SubWorldID2Idx(tabParam[4][4]);
				AddMSPlayer(tabParam[4][3], tabParam[4][1]);
			end;
		end;
	end;
	PlayerIndex = OldPlayer;
	SubWorld = OldSubWorld;
end;

function chr_rand_tab(tab)
	local tab_size = getn(tab);
	for i = 1, tab_size do
		m1 = random(1,tab_size);
		m2 = random(1,tab_size);
		m = tab[m1];
		tab[m1] = tab[m2];
		tab[m2] = m;
	end;
end;

function OnCancel()
end;


end; --//end of __TONG_H__