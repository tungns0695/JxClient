IncludeLib("BATTLE");
Include("\\script\\battles\\battlehead.lua")
Include("\\script\\battles\\boss\\head.lua")

-- 普通BOSS表: NPCID、BOSS等级、BOSS五行、BOSS名称、BOSS套用的模版（无实际作用）
BattleBoss_tbCommonBoss = 
{
	{1465,	95,	0,	" %s qu鑓 tng qu﹏", "Vng T� "},
	{1466,	95,	1,	" %s qu鑓 tng qu﹏", "Л阯g Phi Y課"},
	{1467,	95,	1,	" %s qu鑓 tng qu﹏", "B筩h Doanh Doanh"},
	{1468,	95,	2,	" %s qu鑓 tng qu﹏", "Thanh Tuy謙 S� Th竔"},
	{1469,	95,	2,	" %s qu鑓 tng qu﹏", "Chung Linh T� "},
	{1470,	95,	3,	" %s qu鑓 tng qu﹏", "H� Nh﹏ Ng� "},
	{1471,	95,	3,	" %s qu鑓 tng qu﹏", "an M閏 Du� "},
	{1472,	95,	4,	" %s qu鑓 tng qu﹏", "Thanh Li猲 T� "},
	{1473,	95,	4,	" %s qu鑓 tng qu﹏", "Чo Thanh Ch﹏ Nh﹏"},
}

-- BigBOSS表: NPCID、BOSS等级、BOSS名称
BattleBoss_tbBigBoss = 
{
	{1474, 95, "T鑞g qu鑓 i tng qu﹏"},
	{1475, 95, "Kim qu鑓 i tng qu﹏"},
}

-- 双方各自增加9个普通BOSS
function BattleBoss_AddAllCommonBoss()
	local nBossID = 0;
	for nBossPosID = 1,9 do
		nBossID = random(1, getn(BattleBoss_tbCommonBoss));
		BattleBoss_AddBoss(nBossID, 1, nBossPosID);
		nBossID = random(1, getn(BattleBoss_tbCommonBoss));
		BattleBoss_AddBoss(nBossID, 2, nBossPosID);
	end
	Msg2MSAll(MISSIONID, "<color=yellow>T鑞g Kim chi課 b竜: M鏸 b猲 T鑞g Kim s� c� ra 9 v� tng qu﹏ c馻 t鮪g ph竔  ti誴 vi謓!");
end

-- 双方各自在中路增加3个普通BOSS
function BattleBoss_AddSomeCommonBoss()
	local nBossID = 0;
	for nBossPosID = 4,6 do
		nBossID = random(1, getn(BattleBoss_tbCommonBoss));
		BattleBoss_AddBoss(nBossID, 1, nBossPosID);
		nBossID = random(1, getn(BattleBoss_tbCommonBoss));
		BattleBoss_AddBoss(nBossID, 2, nBossPosID);
	end
	Msg2MSAll(MISSIONID, "<color=yellow>T鑞g Kim chi課 b竜: M鏸 b猲 T鑞g Kim s� c� ra 3 v� tng qu﹏ c馻 t鮪g ph竔  ti誴 vi謓!");
end

-- 指定阵营增加大BOSS
function BattleBoss_AddBigBoss(nBossCamp)
	
	if (nBossCamp == 1) then
		Msg2MSAll(MISSIONID, "<color=0x00FFFF>T鑞g Kim chi課 b竜: C蕄 b竜! T鑞g qu﹏ i tng qu﹏  xu蕋 hi謓!")
	else
		Msg2MSAll(MISSIONID, "<color=0x9BFF9B>T鑞g Kim chi課 b竜: C蕄 b竜! Kim qu﹏ i tng qu﹏  xu蕋 hi謓!")
	end
	
	BattleBoss_AddBoss(0, nBossCamp, 0);
end

-- 在战场中加入Boss	
-- nBossID: 	Boss的ID 0为BigBoss，大于0为普通Boss
-- nBossCamp:	Boss的阵营 1为宋 2为金
-- nBossPosID:	Boss的位置ID 0为主营，1-9 分别为营外的左中右三路
function BattleBoss_AddBoss(nBossID, nBossCamp, nBossPosID)
	
	if nBossID < 0 or nBossID > getn(BattleBoss_tbCommonBoss) then
		return
	end
	if nBossPosID < 0 or nBossPosID > 9 then
		return
	end
	
	local szCampName;
	local szArea    = "Area_";
	local szMapFile = GetMapInfoFile(BT_GetGameData(GAME_MAPID));
	
	if nBossCamp == 1 then
		szArea = szArea..BT_GetGameData(GAME_CAMP1AREA);
		szCampName = "T鑞g";
	elseif nBossCamp == 2 then
		szArea = szArea..BT_GetGameData(GAME_CAMP2AREA);
		szCampName = "Kim";
	else
		return		
	end
	
	-- 确定BOSS的坐标
	local szBossPosFile = GetIniFileData(szMapFile, szArea, "bosspos");
	local nX = GetTabFileData(szBossPosFile, nBossPosID + 2, 1);
	local nY = GetTabFileData(szBossPosFile, nBossPosID + 2, 2);
	
	-- 确定BOSS的NPC属性
	local nNpcID, nNpcLevel, nNpcSeries, szNpcName;
	
	if nBossID == 0 then
		-- 大BOSS
		nNpcID     = BattleBoss_tbBigBoss[nBossCamp][1];
		nNpcLevel  = BattleBoss_tbBigBoss[nBossCamp][2];
		nNpcSeries = random(1,5)-1;
		szNpcName  = BattleBoss_tbBigBoss[nBossCamp][3];
	else
		-- 普通BOSS
		nNpcID     = BattleBoss_tbCommonBoss[nBossID][1];
		nNpcLevel  = BattleBoss_tbCommonBoss[nBossID][2];
		nNpcSeries = BattleBoss_tbCommonBoss[nBossID][3];
		szNpcName  = format(BattleBoss_tbCommonBoss[nBossID][4], szCampName);	
	end
	
	-- 增加BOSS
	local nNpcIdx = AddNpcEx(nNpcID, nNpcLevel, nNpcSeries, SubWorld, nX*32, nY*32, 1, szNpcName, 1);
	if nNpcIdx > 0 then
		SetNpcCurCamp(nNpcIdx, nBossCamp);
		SetNpcDeathScript(nNpcIdx, "\\script\\battles\\boss\\bossset.lua");
	end
	
end

-- BOSS死亡
function OnDeath(nNpcIndex)
	
	if (GetMissionV(MS_STATE) ~= 2) then
		return
	end
	
	-- 如果是死于其它Npc则不统计排行
	if (PlayerIndex == nil or PlayerIndex == 0) then
		return
	end
	
	-- 确认杀死的BOSS的类别 0:错误 1:普通BOSS 2:BigBoss
	local nDeathBossType = 0;
	
	for i = 1,getn(BattleBoss_tbCommonBoss) do
		if GetNpcSettingIdx(nNpcIndex) == BattleBoss_tbCommonBoss[i][1] then
			nDeathBossType = 1;
			break
		end
	end
	
	for i = 1,getn(BattleBoss_tbBigBoss) do
		if GetNpcSettingIdx(nNpcIndex) == BattleBoss_tbBigBoss[i][1] then
			nDeathBossType = 2;
			break
		end
	end
	
	local nPointAward = 0;
	if nDeathBossType == 1 then
		-- 普通BOSS	 
		nPointAward = 2000;
		
		if (GetCurCamp() == 1) then
			local nNewKillBossCount = GetMissionV(MS_KILLBOSSCOUNT_S) + 1;
			SetMissionV(MS_KILLBOSSCOUNT_S, nNewKillBossCount);
			Msg2MSAll(MISSIONID, format("<color=yellow>B竜 c竜 chi課 d辌h: T鑞g binh %s v鮝 l蕐 th� c蕄 tng qu﹏ phe Kim! S� lng tng qu﹏ c馻 phe Kim b� phe T鑞g s竧 h筰 l� %d.", GetName(), nNewKillBossCount));
		else
			local nNewKillBossCount = GetMissionV(MS_KILLBOSSCOUNT_J) + 1;
			SetMissionV(MS_KILLBOSSCOUNT_J, nNewKillBossCount);
			Msg2MSAll(MISSIONID, format("<color=yellow>B竜 c竜 chi課 d辌h: Kim binh %s v鮝 l蕐 th� c蕄 tng qu﹏ phe T鑞g! S� lng tng qu﹏ c馻 phe T鑞g b� phe Kim s竧 h筰 l� %d.", GetName(), nNewKillBossCount));
		end
		 
	elseif nDeathBossType == 2 then
		-- 大BOSS
		nPointAward = 4000;
		
		if GetMissionV(MS_MARSHALDEATH) == 0 then
			SetMissionV(MS_MARSHALDEATH, GetCurCamp());
		else
			SetMissionV(MS_MARSHALDEATH, 0);
		end	
		
		if (GetCurCamp() == 1) then
			Msg2MSAll(MISSIONID, format("<color=yellow>B竜 c竜 chi課 d辌h: T鑞g binh %s v鮝 m韎 ti猽 di謙 i tng qu﹏ phe Kim!!!", GetName()));
		else
			Msg2MSAll(MISSIONID, format("<color=yellow>B竜 c竜 chi課 d辌h: Kim binh %s v鮝 m韎 ti猽 di謙 i tng qu﹏ phe T鑞g!!!", GetName()));
		end
		
	else 
		 return
	end
	
	bt_addtotalpoint(nPointAward);
	mar_addmissionpoint(nPointAward);
	Msg2Player(format("в t苙g thng cho chi課 c玭g gi誸 BOSS, c竎 h� thu 頲 ph莕 thng %d 甶觤 t輈h l騳!", nPointAward));
	BT_SetData(PL_KILLNPC, BT_GetData(PL_KILLNPC) + 1);
	BT_SortLadder();
	BT_BroadSelf();
	return
end

