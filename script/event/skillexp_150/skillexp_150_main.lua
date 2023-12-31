-- 文件名　：skillexp_150_main.lua
-- 创建者　：wangjingjun
-- 内容　　：150技能熟练度对话npc
-- 创建时间：2011-07-27 14:27:15

Include("\\script\\global\\autoexec_head.lua")
Include("\\script\\missions\\basemission\\lib.lua")
Include("\\script\\lib\\progressbar.lua")
Include("\\script\\misc\\eventsys\\type\\npc.lua")
Include("\\script\\vng_event\\tochieukynang150\\head.lua")
Include("\\script\\vng_lib\\bittask_lib.lua")

--TSK_DAILY_CHANGE = 2902  -- 每天最多提升的次数
--TSK_CHANGE_DAY = 2903	-- 记录最后一次提升的日期
--DC 60 lan doi exp, By: ThanhLD 20130611
DAILY_CHANGE_MAX_VALUE = 60		-- 每天兑换上限 
MAP_ID = 967		-- 地图id
--By: ThanhLD
NDEL_PLAYEXP_PER = 6000000	-- 每次兑换需要消耗的玩家经验
NADD_SKILLEXP_PER = 50		-- 每次兑换可以获得的熟练度

szScriptPath = "\\script\\event\\skillexp_150\\skillexp_150_main.lua"
szPosition_chefu = "\\settings\\maps\\skillexp_150\\wagoner.txt"
szPosition_shibei = "\\settings\\maps\\skillexp_150\\shibei.txt"

local tbChefu = {
	{nNpcId = 108, szName = "萵 s�", nLevel = 1, szScriptPath = "\\script\\event\\skillexp_150\\npc_trans.lua"},
		}

-- 24个相关的npc
local tbShibeiNpc = {
	{nNpcId = 1623, szName = "Чi L鵦 Kim Cang Chng Bia", tbNpcParam = {1055},},
	{nNpcId = 1623, szName = "Vi У hi課 X� Bia", tbNpcParam = {1056},},
	{nNpcId = 1623, szName = "Tam Gi韎 Quy Thi襫 Bia", tbNpcParam = {1057},},
	{nNpcId = 1623, szName = "Tung Ho祅h B竧 Hoang Bia", tbNpcParam = {1059},},
	{nNpcId = 1623, szName = "B� Vng T筸 Kim Bia", tbNpcParam = {1060},},
	{nNpcId = 1623, szName = "H祇 H飊g Tr秏 Bia", tbNpcParam = {1058},},
	{nNpcId = 1623, szName = "H譶h Ti猽 C鑤 L藀 Bia", tbNpcParam = {1066},},
	{nNpcId = 1623, szName = "U H錸 Ph� 秐h Bia", tbNpcParam = {1067},},
	{nNpcId = 1623, szName = "V� 秐h Xuy猲 Bia", tbNpcParam = {1069},},
	{nNpcId = 1623, szName = "Thi誸 Li猲 T� S竧 Bia", tbNpcParam = {1070},},	-- 10
	{nNpcId = 1623, szName = "C祅 Kh玭 Nh蕋 Tr辌h Bia", tbNpcParam = {1071},},
	{nNpcId = 1623, szName = "Ki誱 Hoa V穘 Tinh Bia", tbNpcParam = {1061},},
	{nNpcId = 1623, szName = "B╪g V� L筩 Tinh Bia", tbNpcParam = {1062},},
	{nNpcId = 1623, szName = "Ng鋍 Tuy襫 T﹎ Kinh Bia", tbNpcParam = {1114},},
	{nNpcId = 1623, szName = "B╪g Tc Ho箃 K�", tbNpcParam = {1063},},
	{nNpcId = 1623, szName = "Th駓 Anh Man T� Bia", tbNpcParam = {1065},},
	{nNpcId = 1623, szName = "Giang H秈 N� Lan Bia", tbNpcParam = {1075},},
	{nNpcId = 1623, szName = "T藅 H醓 Li謚 Nguy猲 Bia", tbNpcParam = {1076},},
	{nNpcId = 1623, szName = "B鎛g Hu齨h Lc мa Bia", tbNpcParam = {1074},},
	{nNpcId = 1623, szName = "Th阨 Th苙g L鬰 Long Bia", tbNpcParam = {1073},},	-- 20
	{nNpcId = 1623, szName = "Ki誱 Th飝 Tinh H� Bia", tbNpcParam = {1079},},
	{nNpcId = 1623, szName = "T筼 H鉧 Th竔 Thanh Bia", tbNpcParam = {1078},},
	{nNpcId = 1623, szName = "C鰑 Thi猲 Cng Phong Bia", tbNpcParam = {1080},},
	{nNpcId = 1623, szName = "Thi猲 L玦 Ch蕁 Nh筩 Bia", tbNpcParam = {1081},},
	}	

function addnpc(szfile, tbNpc)
	local nX = 0
	local nY = 0
	if (TabFile_Load(szfile, szfile) == 0) then
		print(format("can not open file %s", szPosition_chefu))
		return
	end
	local nCount = TabFile_GetRowCount(szfile)
	if (nCount < 2) then
		return
	end
	for i=2,nCount do
		nX = tonumber(TabFile_GetCell(szfile, i, "TRAPX"))
		nY = tonumber(TabFile_GetCell(szfile, i, "TRAPY"))
		local nNpcIndex = basemission_CallNpc(tbNpc[i-1], MAP_ID, nX, nY)
	end
end

function initialization()
	addnpc(szPosition_chefu, %tbChefu)
	
	for i=1,getn(%tbShibeiNpc) do
		%tbShibeiNpc[i].szScriptPath = szScriptPath
	end
	addnpc(szPosition_shibei, %tbShibeiNpc)
end

function checkDailyTask(nSkillId)
--	local nDay = GetTask(TSK_CHANGE_DAY)
--	local nCurDate = tonumber(GetLocalDate("%y%m%d"))
--	if nDay ~= nCurDate then
--		SetTask(TSK_CHANGE_DAY, nCurDate)
--		SetTask(TSK_DAILY_CHANGE, 0)
--	end
	tbTrainSkill150:ResetDailyTask()
	
	local nDayTime;

	if GetCurrentMagicLevel(nSkillId, 0) < 18 then
		 nDayTime = tbVNG_BitTask_Lib:getBitTask(tbTrainSkill150.tbBIT_Free_Use)  + tbVNG_BitTask_Lib:getBitTask(tbTrainSkill150.tbBIT_Fee_Use);
	else
		nDayTime = tbVNG_BitTask_Lib:getBitTask(tbTrainSkill150.tbBIT_Fee_Use)
	end
	local nMaxValue =  tbTrainSkill150:GetMaxTask(nSkillId)
	if nDayTime < nMaxValue then
		return 1
	end
	return 0
end

function addDailyTask_Free(nValue)
--	local nDay = GetTask(TSK_CHANGE_DAY)
--	local nCurDate = tonumber(GetLocalDate("%y%m%d"))
--	if nDay ~= nCurDate then
--		SetTask(TSK_CHANGE_DAY, nCurDate)
--		SetTask(TSK_DAILY_CHANGE, 0)
--	end
-- DC s� l莕 i l猲 60 l莕/ng祔, by ThanhLD 20130611
	tbTrainSkill150:ResetDailyTask();
	local nDayTime = tbVNG_BitTask_Lib:getBitTask(tbTrainSkill150.tbBIT_Free_Use)
	if nDayTime > 60 then
		tbTrainSkill150:addDailyTask_Fee(1)
	else
		tbVNG_BitTask_Lib:addTask(tbTrainSkill150.tbBIT_Free_Use, nValue)
	end
end

-- npc 被点击主函数
function main()
	local nNpcIdx = GetLastDiagNpc()
	local dwNpcId = GetNpcId(nNpcIdx)
	local nSkillId = GetNpcParam(nNpcIdx, 1)
	local nPlayerLevel = GetLevel()
	if checkDailyTask(nSkillId) ~= 1 then
		Msg2Player("S� l莕 h玬 nay c馻 ngi  h誸, ng祔 mai h穣 l筰 y nh�")
		return
	end
	preMsg2Player(nSkillId)
	if nPlayerLevel >= 200 then
		return
	end
	--开启进度条
	tbProgressBar:OpenByConfig(10, playerexp2skillexp, {nNpcIdx, dwNpcId, nSkillId},onbreak)
end

function playerexp2skillexp(nNpcIndex, dwNpcId, nSkillId)
	if nNpcIndex <= 0 or GetNpcId(nNpcIndex) ~= dwNpcId then
		return 0
	end
	
	local szSkillName = GetSkillName(nSkillId)
	local nSkillLevel = HaveMagic(nSkillId)
--	print("nSkillId = " .. nSkillId)
	if nSkillLevel == -1 then
		Msg2Player("цi v韎 lo筰 v� c玭g n祔 h祇 v� u t�, hay l� 甶 l躰h ng� c竔 kh竎 甶")
		return
	end
	
	if GetCurrentMagicLevel(nSkillId, 0) >= GetSkillMaxLevel(nSkillId) then
		Msg2Player("K� n╪g hi謓 t筰  t gi韎 h筺 cao nh蕋, kh玭g c莕 ph秈 t╪g th猰 n鱝")
		return
	end
	
	if nSkillLevel == 20 then
		Msg2Player("K� n╪g c蕄 21 n祔 kh玭g th� th玭g qua c竎h n祔  ti課 h祅h tu luy謓. ")
		return
	end
	
	local nCurPlayerExp = GetExp()
	local nNeedPlayerExp = getNeedPlayerExp(nSkillId)
	local nPlayerLevel = GetLevel()
	
	--Ki觤 tra tr飊g sinh  gi韎 h筺 luy謓 c蕄
	local nlevelskill150 = tbTrainSkill150:CheckTS();
	if (GetCurrentMagicLevel(nSkillId, 0) >= nlevelskill150 and nlevelskill150 > 0) then
		if tbTrainSkill150:Check_UseItem(nSkillId) == 0 then
			Msg2Player("K� n╪g hi謓 t筰  t gi韎 h筺 cao nh蕋, Чi hi謕 h穣 tr飊g sinh l猲  t╪g th猰 c蕄")
			return
		end
	end
	
	if nNeedPlayerExp > nCurPlayerExp then
		Msg2Player(format("L穘h ng� c莕 ph秈 c� %d kinh nghi謒, kinh nghi謒 hi謓 t筰 c馻 ngi kh玭g ", nNeedPlayerExp))
		return 
	end
	
--	print("nSkillId = " .. nSkillId)
	local nNextExp = GetSkillNextExp(nSkillId)	- GetSkillExp(nSkillId)
--	print("nNextExp = " .. nNextExp)
	local nExp = NADD_SKILLEXP_PER					-- 增加熟练度	
	local nTotalExp = NADD_SKILLEXP_PER	
	if not nNextExp then
		return
	end
	ReduceOwnExp(nNeedPlayerExp)	
	if GetCurrentMagicLevel(nSkillId, 0) < 18 then
		
		if tbVNG_BitTask_Lib:getBitTask(tbTrainSkill150.tbBIT_Free_Use) < tbTrainSkill150:GetValueMaxTask(nSkillId)then
			addDailyTask_Free(1)		-- 增加兑换的计数
		else
			tbTrainSkill150:addDailyTask_Fee(1)
		end
	else
		tbTrainSkill150:addDailyTask_Fee(1)
	end
	while nExp > nNextExp do
		if nNextExp <= 0 then
--			print("150级技能熟练度，下一个等级所需要的技能为0，出错了%%%%%%%%%")
			break
		end 
		-- 达到
		local ncurlevel = GetCurrentMagicLevel(nSkillId, 0)
--		print("ncurlevel = " .. ncurlevel)
		if GetCurrentMagicLevel(nSkillId, 0) >= GetSkillMaxLevel(nSkillId) then
			postMsg2Player(nSkillId)
			return 
		end
		nNeedAddExp = nNextExp
		nExp = nExp - nNeedAddExp
--		print("nExp = " .. nExp)
		AddSkillExp(nSkillId, nNeedAddExp, 1)		
		nNextExp = GetSkillNextExp(nSkillId)
--		print("nNextExp = " .. nNextExp)
	end
--	print("while end")
--	print("nExp = " .. nExp)
	AddSkillExp(nSkillId, nExp, 1)
	
	postMsg2Player(nSkillId)
end

function onbreak()
	Msg2Player("L穘h ng� c馻 ngi b� t 畂筺.")
end

function OnTimer(nNpcIndex)
end

function getNeedPlayerExp(nSkillId, nNumber)
	local nNeedPlayerExp = NDEL_PLAYEXP_PER
	local nPlayerLevel = GetLevel()
	--By: ThanhLD 60 lan doi dau tien thi Exp = 600000, sau 50 lan sau Exp = 8000000
	local nDayTime = tbVNG_BitTask_Lib:getBitTask(tbTrainSkill150.tbBIT_Free_Use) + tbVNG_BitTask_Lib:getBitTask(tbTrainSkill150.tbBIT_Fee_Use)
	if nDayTime > DAILY_CHANGE_MAX_VALUE then
		nNeedPlayerExp = 8000000
	end
	if(nNumber == 1 and nDayTime + 1 > DAILY_CHANGE_MAX_VALUE) then
		nNeedPlayerExp = 8000000
	end

	local _, nRet = tbTrainSkill150:GetMaxTask(nSkillId)
	if 	nRet == 1 then
		nNeedPlayerExp = 8000000
	end
	-- 200级特殊处理
	if nPlayerLevel >= 200 then		
		nNeedPlayerExp = 0
	end
	return nNeedPlayerExp
end

function preMsg2Player(nSkillId)
	local nNeedPlayerExp = getNeedPlayerExp(nSkillId, 1)
	local nPlayerLevel = GetLevel()
	local szSkillName = GetSkillName(nSkillId)
	if nPlayerLevel >= 200 then
		Msg2Player(format("Nh﹏ v藅 c蕄 200 kh玭g th� n﹏g cao <color=yellow> %s <color>  tu luy謓", szSkillName))
	else
		Msg2Player(format("Ti猽 hao <color=yellow> %d <color> kinh nghi謒 n﹏g cao i v韎 <color=yellow> %s <color>  tu luy謓.",nNeedPlayerExp,szSkillName))
	end
end

function postMsg2Player(nSkillId)
	local nPlayerLevel = GetLevel()
	local nNeedPlayerExp = getNeedPlayerExp(nSkillId)
	local szSkillName = GetSkillName(nSkillId)
	local nTotalExp = NADD_SKILLEXP_PER
	
	if nPlayerLevel == 200 then
		Msg2Player(format("K� n╪g c馻 ngi <color=yellow> %s <color>  tu luy謓 頲 n﹏g cao %d",szSkillName, nTotalExp))
	else
		Msg2Player(format("Х ti猽 hao <color=yellow> %d <color> kinh nghi謒  k� n╪g <color=yellow> %s <color>  tu luy謓 頲 n﹏g cao <color=yellow> %d <color>",nNeedPlayerExp, szSkillName,nTotalExp))
	end
end

AutoFunctions:Add(initialization)