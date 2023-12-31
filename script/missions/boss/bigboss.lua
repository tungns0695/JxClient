Include("\\script\\lib\\objbuffer_head.lua")
Include("\\script\\lib\\sharedata.lua")
Include("\\script\\missions\\basemission\\lib.lua")
Include("\\script\\activitysys\\playerfunlib.lua")
--Fix bug missing lib - modified by DinhHQ - 20110425
Include("\\script\\lib\\droptemplet.lua")
IncludeLib("LEAGUE")

BigBoss = {}

BigBoss.TSK_PLAYER_BOSSKILLED = 2598; -- 玩家击杀BOSS数量统计
BigBoss.TSK_BIGBOSS_REWARD = 2661; -- 记录玩家当天是否领奖和领奖类型 日期 | 获得闯关翻倍 | 获得宋金翻倍 |获得经验翻倍奖励 | 是否领奖
BigBoss.CAN_GET_REWARD_BIT = 1;
BigBoss.EXP_REWARD_BIT = 2;
BigBoss.SONGJIN_REWARD_BIT = 3;
BigBoss.CHUANGGUAN_REWARD_BIT = 4;

BigBoss.tbKillRecord = {};
BigBoss.IsBigBossDead = 0;
BigBoss.CallBackParam = {}
--Change big boss reward - modified By DinhHQ - 20130802
BigBoss.tbGlobalReward = 
{
	{szName="H玬 nay tr薾 T鑞g Kim 21:00, 甶觤 t輈h l騳 s� 頲 nh﹏ i", nRate=50, pFun=function() PlayerFunLib:SetTaskBit(BigBoss.TSK_BIGBOSS_REWARD, BigBoss.SONGJIN_REWARD_BIT, 1); Msg2Player(format("Чi hi謕 nh薾 頲 ph莕 thng <color=yellow>%s<color>","H玬 nay tr薾 T鑞g Kim 21:00, 甶觤 t輈h l騳 s� 頲 nh﹏ i"))end},
	{szName="H玬 nay vt 秈 t 21:00, 甶觤 kinh nghi謒 s� 頲 nh﹏ i", nRate=50, pFun=function() PlayerFunLib:SetTaskBit(BigBoss.TSK_BIGBOSS_REWARD, BigBoss.CHUANGGUAN_REWARD_BIT, 1); Msg2Player(format("Чi hi謕 nh薾 頲 ph莕 thng <color=yellow>%s<color>","H玬 nay vt 秈 t 21:00, 甶觤 kinh nghi謒 s� 頲 nh﹏ i"))end},
	--{szName="Nh﹏ i kinh nghi謒 khi nh qu竔 trong 1 gi�", nRate=25, pFun=function() AddSkillState(967, 1, 1, 64800); PlayerFunLib:SetTaskBit(BigBoss.TSK_BIGBOSS_REWARD, BigBoss.EXP_REWARD_BIT, 1); Msg2Player(format("Чi hi謕 nh薾 頲 ph莕 thng <color=yellow>%s<color>","Nh﹏ i kinh nghi謒 khi nh qu竔 trong 1 gi�"))end},
	--{nExp = 10000000, nRate=25},
}
--doc co thien phong
BigBoss.tbKillerReward = 
{
	{tbProp = {6,1,2127,1,0,0}, nCount=1, nExpiredTime=43200},
	{tbProp = {4,239,1,1,0,0}, nCount=10},
	{tbProp = {4,238,1,1,0,0}, nCount=10},
	{tbProp = {4,240,1,1,0,0}, nCount=10},
	{tbProp = {4,353,1,1,0,0}, nCount=20},
	{tbProp = {0,11,450,1,0,0}, nCount=1, nExpiredTime=10080},
	{tbProp = {6,1,907,1,0,0}, nCount=8, nExpiredTime=10080},
	{tbProp = {6,1,1075,1,0,0}, nCount=8},
	{tbProp = {6,1,2126,1,0,0}, nCount=1, nExpiredTime=10080},
}

BigBoss.tbNormalDrop = 
{
	{tbProp = {6,1,1075,1,0,0}, nCount=3},
	{tbProp = {4,239,1,1,0,0}, nCount=20},
	{tbProp = {4,238,1,1,0,0}, nCount=20},
	{tbProp = {4,240,1,1,0,0}, nCount=20},
	{tbProp = {4,353,1,1,0,0}, nCount=20},
	{tbProp = {6,1,1672,1,0,0}, nCount=10},
	{tbProp = {0,11,450,1,0,0}, nCount=1, nExpiredTime=10080},
	{tbProp = {6,1,2115,1,0,0}, nCount=10},
	{tbProp = {6,1,2117,1,0,0}, nCount=10},
	{tbProp = {6,0,6,1,0,0}, nCount=20},
	{tbProp = {6,0,3,1,0,0}, nCount=20},
	{tbProp = {6,1,71,1,0,0}, nCount=20},
	{tbProp = {6,1,1765,1,0,0}, nCount=10},
	{tbProp = {6,1,26,1,0,0}, nCount=10},
	{tbProp = {6,1,22,1,0,0}, nCount=10},
}

-- 襲 ch豱h ph莕 thng r韙 ra - Modified by ThanhLD -20130417
BigBoss.tbVngNewAward = 
{

	------------------------------------test--------------\

 	[1]={{szName="B竛h Trung Thu u Xanh",tbProp={6,1,891,1,0,0},nCount=1,nRate=100},},

	-- [1]={{szName="V� L﹎ M藅 T辌h",tbProp={6,1,26,1,0,0},nCount=1,nRate=1},},
	-- [2]={{szName="T葃 T駓 Kinh",tbProp={6,1,22,1,0,0},nCount=1,nRate=1},},
 -- 	[3]={{szName="Thi誸 La H竛",tbProp={6,1,23,1,0,0},nCount=1,nRate=10},},	
	-- [4]={{szName="T� Th駓 Tinh",tbProp={4,239,1,1,0,0},nCount=1,nRate=5},},
	-- [5]={{szName="Lam Th駓 Tinh",tbProp={4,238,1,1,0,0},nCount=1,nRate=5},},
	-- [6]={{szName="L鬰 Th駓 Tinh",tbProp={4,240,1,1,0,0},nCount=1,nRate=5},},
	-- [7]={{szName="Tinh H錸g B秓 Th筩h",tbProp={4,353,1,1,0,0},nCount=1,nRate=3},},
	-- [8]={{szName="B竎h Qu� L�",tbProp={6,1,73,1,0,0},nCount=1,nRate=10},},
	-- [9]={{szName="Phi Phong",tbProp={6,1,15,1,0,0},nCount=1,nRate=20},},
	-- [10]={{szName="Ph骳 Duy猲 (ti觰)",tbProp={6,1,122,1,0,0},nCount=1,nRate=30},},
	-- [11]={{szName="Ph骳 Duy猲 (trung)",tbProp={6,1,123,1,0,0},nCount=1,nRate=30},},
	-- [12]={{szName="Ph骳 Duy猲 (i)",tbProp={6,1,124,1,0,0},nCount=1,nRate=10},},
	-- [13]={{szName="Чi l鵦 ho祅",tbProp={6,0,3,1,0,0},nCount=1,nRate=9},},
	-- [14]={{szName="Чi l鵦 ho祅",tbProp={6,0,6,1,0,0},nCount=1,nRate=10},},




	-- [1] = {{szName="X輈h L﹏ L謓h",tbProp={6,1,3393,1,0,0},nCount=1,nRate=0.4},},
	-- [2] = {{szName="M秐h X輈h L﹏",tbProp={6,1,3391,1,0,0},nCount=1,nRate=3},},
	-- [3] = {{szName="X輈h L﹏ Kim B礽",tbProp={6,1,3392,1,0,0},nCount=1,nRate=4},},
	-- [4] = {{szName="X輈h L﹏ Tr秓",tbProp={6,1,3394,1,0,0},nCount=1,nRate=7},},
	-- [5] = {{szName="X輈h L﹏ Gi竎",tbProp={6,1,3395,1,0,0},nCount=1,nRate=4},},
	-- [6] = {{szName="X輈h L﹏ T譶h",tbProp={6,1,3396,1,0,0},nCount=1,nRate=2.5},},
	-- [7] = {{szName="B筩h H� Ph竧 Qu竛 - T� ch鋘 h� ph竔",tbProp={6,1,30242,1,0,0},nCount=1,nRate=0.5,tbParam={2,0,0,0,0,0}},},
	-- [8] = {{szName="B筩h H� Kim Kh秈 - T� ch鋘 h� ph竔",tbProp={6,1,30242,1,0,0},nCount=1,nRate=0.3,tbParam={6,0,0,0,0,0}},},
	-- [9] = {{szName="B筩h H� Y猽 Цi - T� ch鋘 h� ph竔",tbProp={6,1,30242,1,0,0},nCount=1,nRate=0.5,tbParam={5,0,0,0,0,0}},},
	-- [10] = {{szName="B筩h H� H筺g Li猲 - T� ch鋘 h� ph竔",tbProp={6,1,30242,1,0,0},nCount=1,nRate=0.5,tbParam={1,0,0,0,0,0}},},
	-- [11] = {{szName="B筩h H� Ng鋍 B閕 - T� ch鋘 h� ph竔",tbProp={6,1,30242,1,0,0},nCount=1,nRate=0.5,tbParam={9,0,0,0,0,0}},},
	-- [12] = {{szName="B筩h H� H礽 - T� ch鋘 h� ph竔",tbProp={6,1,30242,1,0,0},nCount=1,nRate=0.5,tbParam={8,0,0,0,0,0}},},
	-- [13] = {{szName="B筩h H� H� Uy觧 - T� ch鋘 h� ph竔",tbProp={6,1,30242,1,0,0},nCount=1,nRate=0.5,tbParam={4,0,0,0,0,0}},},
	-- [14] = {{szName="B筩h H� Thng Gi韎 Ch� - T� ch鋘 h� ph竔",tbProp={6,1,30242,1,0,0},nCount=1,nRate=0.5,tbParam={3,0,0,0,0,0}},},
	-- [15] = {{szName="B筩h H� H� Gi韎 Ch� - T� ch鋘 h� ph竔",tbProp={6,1,30242,1,0,0},nCount=1,nRate=0.5,tbParam={10,0,0,0,0,0}},},
	-- [16] = {{szName="B筩h H� Kh� Gi韎 - T� ch鋘 h� ph竔",tbProp={6,1,30242,1,0,0},nCount=1,nRate=0.2,tbParam={7,0,0,0,0,0}},},
	-- [17] = {{szName="X輈h L﹏ Ph竧 Qu竛 - T� ch鋘 h� ph竔",tbProp={6,1,30386,1,0,0},nCount=1,nRate=0.07,tbParam={2,0,0,0,0,0}},},
	-- [18] = {{szName="X輈h L﹏ Kim Kh秈 - T� ch鋘 h� ph竔",tbProp={6,1,30386,1,0,0},nCount=1,nRate=0.04,tbParam={6,0,0,0,0,0}},},
	-- [19] = {{szName="X輈h L﹏ Y猽 Цi - T� ch鋘 h� ph竔",tbProp={6,1,30386,1,0,0},nCount=1,nRate=0.07,tbParam={5,0,0,0,0,0}},},
	-- [20] = {{szName="X輈h L﹏ H筺g Li猲 - T� ch鋘 h� ph竔",tbProp={6,1,30386,1,0,0},nCount=1,nRate=0.07,tbParam={1,0,0,0,0,0}},},
	-- [21] = {{szName="X輈h L﹏ Ng鋍 B閕 - T� ch鋘 h� ph竔",tbProp={6,1,30386,1,0,0},nCount=1,nRate=0.07,tbParam={9,0,0,0,0,0}},},
	-- [22] = {{szName="X輈h L﹏ H礽 - T� ch鋘 h� ph竔",tbProp={6,1,30386,1,0,0},nCount=1,nRate=0.07,tbParam={8,0,0,0,0,0}},},
	-- [23] = {{szName="X輈h L﹏ H� Uy觧 - T� ch鋘 h� ph竔",tbProp={6,1,30386,1,0,0},nCount=1,nRate=0.07,tbParam={4,0,0,0,0,0}},},
	-- [24] = {{szName="X輈h L﹏ Thng Gi韎 Ch� - T� ch鋘 h� ph竔",tbProp={6,1,30386,1,0,0},nCount=1,nRate=0.06,tbParam={3,0,0,0,0,0}},},
	-- [25] = {{szName="X輈h L﹏ H� Gi韎 Ch� - T� ch鋘 h� ph竔",tbProp={6,1,30386,1,0,0},nCount=1,nRate=0.06,tbParam={10,0,0,0,0,0}},},
	-- [26] = {{szName="X輈h L﹏ Kh� Gi韎 - T� ch鋘 h� ph竔",tbProp={6,1,30386,1,0,0},nCount=1,nRate=0.03,tbParam={7,0,0,0,0,0}},},
	-- [27] = {{szName="C祅 Kh玭 Song Tuy謙 B閕",tbProp={6,1,2219,1,0,0},nCount=1,nRate=0.6,nExpiredTime=43200},},
	-- [28] = {{szName="C鑞g Hi課 L� bao",tbProp={6,1,30214,1,0,0},nCount=1,nRate=10,nExpiredTime=10080},},
	-- [29] = {{szName="Ki課 Thi誸 L� Bao",tbProp={6,1,30216,1,0,0},nCount=1,nRate=10,nExpiredTime=10080},},
	-- [30] = {{szName="Chi課 B� L� Bao",tbProp={6,1,30218,1,0,0},nCount=1,nRate=10,nExpiredTime=10080},},
	-- [31] = {{szName="Bao Dc ho祅 ",tbProp={6,1,910,1,0,0},nCount=1,nRate=15,nExpiredTime=20160},},
	-- [32] = {{szName="B筩h H� Tr飊g Luy謓 Ng鋍",tbProp={6,1,3187,1,0,0},nCount=1,nRate=3},},
	-- [33] = {{szName="M筩 B綾 Truy襫 T鑞g L謓h",tbProp={6,1,1448,1,0,0},nCount=1,nRate=5,nExpiredTime=20160},},
	-- [34] = {{szName="V� L﹎ M藅 T辌h",tbProp={6,1,26,1,0,0},nCount=1,nRate=5},},
	-- [35] = {{szName="T葃 T駓 Kinh",tbProp={6,1,22,1,0,0},nCount=1,nRate=5},},
	-- [36] = {{szName="Thi猲 Linh Кn",tbProp={6,1,3022,1,0,0},nCount=1,nRate=5,nExpiredTime=10080},},
	-- [37] = {{szName="Чi l鵦 ho祅 l� bao",tbProp={6,1,2517,1,0,0},nCount=1,nRate=7,nExpiredTime=10080},},
	-- [38] = {{szName="Phi t鑓 ho祅 l� bao",tbProp={6,1,2520,1,0,0},nCount=1,nRate=7,nExpiredTime=10080},},
	-- [39] = {{szName="Qu� Ho祅g Kim",tbProp={6,1,907,1,0,0},nCount=1,nRate=10,nExpiredTime=10080},},

}

function AddKillRecord_CallBack(Param, ResultHandle)
	szName = BigBoss.CallBackParam[Param][1];
	nSecondes = BigBoss.CallBackParam[Param][2];
	BigBoss.CallBackParam[Param] = nil;
	if (OB_IsEmpty(ResultHandle) == 0) then
		BigBoss.tbKillRecord = ObjBuffer:PopObject(ResultHandle);
	end
	
	local nIdx = 0;
	
	local nIdx = 0;
	for i=1,getn(BigBoss.tbKillRecord) do
		if (BigBoss.tbKillRecord[i][2] > nSecondes) then
			nIdx = i;
			break;
		end
	end
	
	if (nIdx == 0) then
		nIdx = getn(BigBoss.tbKillRecord) + 1;
	end
	
	tinsert(BigBoss.tbKillRecord, nIdx, {szName, nSecondes});
	
	local nCount = 0;
	
	-- 保留最好成绩
	for i=1,getn(BigBoss.tbKillRecord) do
		if (BigBoss.tbKillRecord[i] and BigBoss.tbKillRecord[i][1] == szName) then
			nCount = nCount + 1;
			if (nCount > 1) then
				tremove(BigBoss.tbKillRecord, nIdx);
			end
		end
	end
	
	SaveShareData("FUNC_BIGBOSS_LADDER", 0, 0, BigBoss.tbKillRecord);
end

function BigBoss:AddKillRecord(szName, nSecondes)
	self.CallBackParam[getn(self.CallBackParam)+1] = {szName, nSecondes};
	
	LoadShareData("FUNC_BIGBOSS_LADDER", 0, 0, "AddKillRecord_CallBack", getn(self.CallBackParam));
end

function BigBoss:GetKillRecord(szCallBack, nParam)
	nParam = nParam or 0;
	LoadShareData("FUNC_BIGBOSS_LADDER", 0, 0, szCallBack, nParam);
end

function BigBoss:BigBossGlobalReward()
	self.CallBackParam[getn(self.CallBackParam) + 1] = PlayerIndex;
	RemoteExecute("\\script\\mission\\boss\\bigboss.lua", "IsBigBossDead", 0, "BigBossGlobalReward_CallBack", getn(self.CallBackParam));
end

function BigBossGlobalReward_CallBack(Param, ResultHandle)
	local Index = BigBoss.CallBackParam[Param]
	if (Index and Index > 0) then
		local OldPlayerIndex = PlayerIndex
		PlayerIndex = Index
		if (OB_IsEmpty(ResultHandle) == 0) then
			IsBigBossDead = ObjBuffer:PopObject(ResultHandle);
			if (IsBigBossDead == 1) then
				PlayerFunLib:AddTaskDaily(BigBoss.TSK_BIGBOSS_REWARD, 0);	-- 重置变量,以防意外
				if (PlayerFunLib:CheckTaskBit(BigBoss.TSK_BIGBOSS_REWARD, BigBoss.CAN_GET_REWARD_BIT, 1, "H玬 nay i hi謕  nh薾 thng r錳!") == 1) then
					PlayerFunLib:SetTaskBit(BigBoss.TSK_BIGBOSS_REWARD, BigBoss.CAN_GET_REWARD_BIT, 0);
					tbAwardTemplet:GiveAwardByList(BigBoss.tbGlobalReward, format("[%s] big boss global reward",date("%Y%m%d")));
				end
			else
				Talk(1, "", format("H玬 nay v蒼 ch璦 nh b筰 <color=red>%s<color>","чc C� Thi猲 Phong"));
			end
		end
		--
		PlayerIndex = OldPlayerIndex
		BigBoss.CallBackParam[Param] = nil
	end
end

function BigBoss:BigBossDeath(nNpcIndex)
	Msg2Player("HNT TEST BBBBBBBBBBBBBBBBBBBBBBBBB")
	-- 记录时间
	local nTime = tonumber(GetLocalDate("%H%M%S"))-194500; -- 死亡时间 - 召唤时间
	
	-- 给最高伤害的人或队伍奖励
	local nTeamSize = GetTeamSize();
	local szName;
	
	if (nTeamSize > 1) then
		for i=1,nTeamSize do
			if(doFunByPlayer(GetTeamMember(i), IsCaptain)==1)then
				szName = doFunByPlayer(GetTeamMember(i), GetName);
			end
			doFunByPlayer(GetTeamMember(i), PlayerFunLib.AddExp, PlayerFunLib, 5000000, 0, format("%s ph莕 thng","Ph莕 thng kinh nghi謒 cho i c� c玭g k輈h m筺h nh蕋 v祇 чc C� Thi猲 Phong"));
		end
	else -- 一个人
		szName = GetName();
		PlayerFunLib:AddExp(10000000, 0, format("%s ph莕 thng","Ph莕 thng kinh nghi謒 cho ngi c� c玭g k輈h m筺h nh蕋 v祇 чc C� Thi猲 Phong"));
	end
	
	local tbRoundPlayer, nCount = GetNpcAroundPlayerList(nNpcIndex, 20);
	
	for i=1,nCount do
		doFunByPlayer(tbRoundPlayer[i], PlayerFunLib.AddExp, PlayerFunLib, 10000000, 0, format("%s ph莕 thng","Ph莕 thng kinh nghi謒 cho ngi ng g莕 khi  b筰 чc C� Thi猲 Phong"));
	end
	
	--tbDropTemplet:GiveAwardByList(nNpcIndex, PlayerIndex, self.tbKillerReward, format("%s r韙","чc C� Thi猲 Phong"), 1);
	
	--tbDropTemplet:GiveAwardByList(nNpcIndex, -1, self.tbNormalDrop, format("%s r韙","чc C� Thi猲 Phong"), 1);
	
	--DC Ph莕 thng - Modified By DinhHQ - 20111010
	--item
--	tbDropTemplet:GiveAwardByList(nNpcIndex, PlayerIndex, self.tbVngNewDropItem, format("%s r韙","чc C� Thi猲 Phong"), 1);
	--trang b�
--	tbDropTemplet:GiveAwardByList(nNpcIndex, PlayerIndex, self.tbVngNewDropEquip, format("%s r韙","чc C� Thi猲 Phong"), 1);

-- 襲 ch豱h ph莕 thng r韙 ra - Modified by ThanhLD -20130417
--admin edit
	tbDropTemplet:GiveAwardByList(nNpcIndex, PlayerIndex, self.tbVngNewAward, format("%s r韙","чc C� Thi猲 Phong"), 1);
	-- BOSS击杀统计
	local nCount = GetTask(self.TSK_PLAYER_BOSSKILLED);
	nCount = nCount + 1;
	SetTask(self.TSK_PLAYER_BOSSKILLED, nCount);
	
	-- BIGBOSS死亡
	local Handle = OB_Create()
	if (Handle > 0) then
		ObjBuffer:PushObject(Handle, 1)
		RemoteExecute("\\script\\mission\\boss\\bigboss.lua", "SetBigBossDead", Handle);
		OB_Release(Handle)
	end
	
	local szNews = format("T� i <color=yellow>%s<color>  ti猽 di謙 th祅h c玭g  <color=yellow>чc C� Thi猲 Phong<color>, h穣 nhanh ch鉵g n l� quan nh薾 thng!",szName);
	AddGlobalNews(szNews);
	LG_ApplyDoScript(1, "", "", "\\script\\event\\msg2allworld.lua", "battle_msg2allworld", szNews , "", "");
	
	self:AddKillRecord(szName, nTime);
end

function BigBoss:RemoveSongJinBonus()
	PlayerFunLib:AddTaskDaily(self.TSK_BIGBOSS_REWARD, 0);	-- 重置变量,以防意外
	PlayerFunLib:SetTaskBit(self.TSK_BIGBOSS_REWARD, self.SONGJIN_REWARD_BIT, 0);
end

function BigBoss:RemoveChuangGuanBonus()
	PlayerFunLib:AddTaskDaily(self.TSK_BIGBOSS_REWARD, 0);	-- 重置变量,以防意外
	PlayerFunLib:SetTaskBit(self.TSK_BIGBOSS_REWARD, self.CHUANGGUAN_REWARD_BIT, 0);
end

function BigBoss:AddSongJinPoint(nBasePoint)
	PlayerFunLib:AddTaskDaily(self.TSK_BIGBOSS_REWARD, 0);	-- 重置变量,以防意外
	local nType = GetBit(PlayerFunLib:GetActivityTask(self.TSK_BIGBOSS_REWARD), self.SONGJIN_REWARD_BIT);
	if (nType == 1) then
		local nHour = tonumber(GetLocalDate("%H"));
		if (nHour <= 22) then -- 21点的宋金22:30结束
			nBasePoint = nBasePoint * 2;
		end
		
	end
	--Lunar new year 2011 - Bobus award - Modified By DinhHQ - 20120103
	local nNowDate = tonumber(GetLocalDate("%Y%m%d%H%M"))
	if nNowDate >= 201201200000 and nNowDate < 201201252400 and nType ~= 1 then
		nBasePoint = nBasePoint * 2;
	end
	return nBasePoint;
end

function BigBoss:AddChuangGuanPoint(nBasePoint)
	PlayerFunLib:AddTaskDaily(self.TSK_BIGBOSS_REWARD, 0);	-- 重置变量,以防意外
	local nType = GetBit(PlayerFunLib:GetActivityTask(self.TSK_BIGBOSS_REWARD), self.CHUANGGUAN_REWARD_BIT);
	if (nType == 1) then
		nBasePoint = nBasePoint * 2;
	end
	--Lunar new year 2011 - Bobus award - Modified By DinhHQ - 20120103
	local nNowDate = tonumber(GetLocalDate("%Y%m%d%H%M"))
	if nNowDate >= 201201200000 and nNowDate < 201201252400 and nType ~= 1 then
		nBasePoint = nBasePoint * 2;
	end
	return nBasePoint;
end

function BigBoss:MakeAllPlayerCanGetReward()
	local nIdx = GetFirstPlayerAtServer();
	while(nIdx > 0) do
		doFunByPlayer(nIdx, PlayerFunLib.AddTaskDaily, PlayerFunLib, self.TSK_BIGBOSS_REWARD, 0);
		doFunByPlayer(nIdx, PlayerFunLib.SetTaskBit, PlayerFunLib, self.TSK_BIGBOSS_REWARD, self.CAN_GET_REWARD_BIT, 1);
		nIdx = GetNextPlayerAtServer();
	end
end