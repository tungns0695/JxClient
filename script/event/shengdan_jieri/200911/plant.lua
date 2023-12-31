-------------------------------------
-- description 	: 摆设圣诞树
-- author		: wangbin
-- date			: 2009.11.25
-------------------------------------

Include("\\script\\lib\\pay.lua")
Include("\\script\\activitysys\\playerfunlib.lua")
IL("SETTING")

GAME_FPS 			= 18
LIMIT_JOINCOUNT		= 7					-- 每天参加次数限制
LIMIT_PLANTCOUNT	= 1					-- 每天种树次数限制
TASK_JOINDATE  		= 1912				-- YMMDD * 100 + 参加次数，年数为当前年份-2000
TASK_PLANTDATE 		= 1913				-- YMMDD * 100 + 种树次数，年数为当前年份-2000
LOG_HEAD			= "2009CHRISTMAS"
SCRIPT_TREE			= "\\script\\event\\shengdan_jieri\\200911\\tree.lua"

-- 新手村地图ID
NewbieMapTable = {
	20,		-- 江津村
	53,		-- 巴陵县
	174,	-- 龙泉村
	121,	-- 龙门镇
	153,	-- 石鼓镇
	101,	-- 稻香村
	99,		-- 永乐镇
	100,	-- 朱仙镇
	1,		-- 凤翔
	11,		-- 成都
	37,		-- 汴京
	78,		-- 襄阳
	80,		-- 扬州
	162,	-- 大理
	176,	-- 临安
}

-- 奖励经验表
AwardTable = {
	Leader = {10000000, 15000000, 20000000},	-- 队长的固定奖励：未转生，1转，2转
	Member = {5000000,  8000000,  12000000},	-- 队员的固定奖励：未转生，1转，2转
	Extend = {0, 20, 30, 40, 50, 60, 70, 80}	-- 额外奖励：队伍人数为1-8人的百分比
}

-- 按照圣诞树NPCINDEX索引的队伍数据
TreeTable = {}

function DelTree(TreeIdx)
	DelNpc(TreeIdx)
	TreeTable[TreeIdx] = nil
end

-- 阶段处理函数
function Process(TreeIdx, Table)
	DelTree(TreeIdx)
	for Name, Step in Table.MemberState do
		if (Table.Step ~= Step) then
			BroadCast(Table, "C﹜ gi竛g sinh  bi課 m蕋")
			WriteLog(format("[%s]Tree[%d] timeout: Step(%d), Captain(%s), MemberCount(%d)",
				LOG_HEAD,
				TreeIdx,
				Table.Step,
				Table.Captain,
				Table.MemberCount))
			return 0
		end
	end
	-- 创建下一个阶段的NPC
	local NextStep = Table.Step + 1
	NewTree = CreateTree(ProcTable[NextStep].NpcId, Table)
	if (NewTree == 0) then
		WriteLog(format("[%s ERROR]Failed to create new tree: Tree[%d], Captain(%s), Step(%d)",
			LOG_HEAD,
			TreeIdx,
			Table.Captain,
			Table.Step))
		return 0
	end
	TreeTable[NewTree] = Table
	BroadCast(Table, ProcTable[NextStep].Hint)
	WriteLog(format("[%s]TreeChange[%d]=>[%d], Captain(%s), CurrentStep(%d)",
		LOG_HEAD,
		TreeIdx,
		NewTree,
		Table.Captain,
		Table.Step))
	return NewTree
end

function Wait(TreeIdx, Table)
	WriteLog(format("[%s]Tree[%d] stop award", LOG_HEAD, TreeIdx))
	return TreeIdx
end

function Destroy(TreeIdx, Table)
	DelTree(TreeIdx)
	WriteLog(format("[%s]Tree[%d] destroy", LOG_HEAD, TreeIdx))
	return 0
end

-- 装饰圣诞树
function DecorateTree(TreeIdx, Table)
	local Step = Table.Step
	local Name = GetName()
	if (Table.MemberState[Name] ~= Step) then
		local Msg = ProcTable[Step].DlgMsg
		BroadCast(Table, format(Msg, Name))
		Table.MemberState[Name] = Step
	else
		Say(ProcTable[Step].ErrMsg)
	end
end

-- 种树的队伍内广播
function BroadCast(Table, Msg)
	local CurrentPlayerIdx = PlayerIndex
	for Name, _ in Table.MemberState do
		PlayerIndex = SearchPlayer(Name)
		if (PlayerIndex > 0) then
			Msg2Player(Msg)
		end
	end
	PlayerIndex = CurrentPlayerIdx
end

-- 是否在队伍中
function InMemberList(Player, Table)
	for Name, _ in Table.MemberState do
		if (Name == Player) then
			return 1
		end
	end
	return 0
end

-- 领奖
function Award(TreeIdx, Table)
	local Name = GetName()
	local Step = Table.MemberState[Name]
	if (Step == nil) then
		Say("H穣 t譵 c﹜ gi竛g sinh c馻 m譶h  l躰h thng!")
		return
	elseif (Step == Table.Step) then
		Say("Чi hi謕  nh薾 thng r錳!")
		return
	end
	local IsCaptain = 0
	if (Name == Table.Captain) then
		IsCaptain = 1
	end
	local Exp = AwardExp(IsCaptain, ST_GetTransLifeCount(), Table.MemberCount)
	AddOwnExp(Exp)
	Table.MemberState[Name] = Table.Step
	
	Msg2Player(format("T� i c� %d ngi, i hi謕 nh薾 %u 甶觤 kinh nghi謒", Table.MemberCount, Exp))
	WriteLog(format("[%s]Tree[%d]: %s get exp(%d)", LOG_HEAD, TreeIdx, Name, Exp))
	Say(format("Ch骳 m鮪g i hi謕  nh薾 頲 ph莕 thng <color=red>%d<color> kinh nghi謒.", Exp))
end

-- 计算领奖经验
function AwardExp(IsCaptain, TranCount, MemberCount)
	local BaseAward = AwardTable.Member
	local ExtAward = AwardTable.Extend
	if (IsCaptain == 1) then
		BaseAward = AwardTable.Leader
	end
	local BaseIdx = TranCount + 1
	if (BaseIdx > getn(BaseAward)) then
		BaseIdx = getn(BaseAward)
	end
	local ExtIdx = MemberCount
	if (ExtIdx > getn(ExtAward)) then
		ExtIdx = getn(ExtAward)
	end
	local Exp = BaseAward[BaseIdx]
	return Exp + floor(Exp * ExtAward[ExtIdx] / 100)
end

ProcTable = {
	[1] = {
		OnTimeout = Process,					-- 定时器到期触发的函数
		Dialog = DecorateTree,					-- 与NPC对话选项触发的函数
		Timeout = 60,							-- 定时器时间（秒数）
		DlgMsg = "Th祅h vi猲 %s  treo t竜 th祅h c玭g l猲 c﹜ gi竛g sinh.",	-- 操作完成提示
		ErrMsg = "Х treo t竜 l猲 c﹜ r錳.",			-- 操作失败提示
		Hint = "Xin m阨 treo t竜 l猲 c﹜ gi竛g sinh!",			-- 阶段开始时的提示
		Option = "Xin m阨 treo t竜 l猲 c﹜ gi竛g sinh!",		-- 对话选项,
		NpcId = 1490,							-- 光秃秃的圣诞树
		},
	[2] = {
		OnTimeout = Process,
		Dialog = DecorateTree,
		Timeout = 60,
		DlgMsg = "Th祅h vi猲 %s  treo n th祅h c玭g l猲 c﹜ gi竛g sinh.",
		ErrMsg = "Х treo n l猲 c﹜ r錳",
		Hint = "Xin m阨 treo n l猲 c﹜ gi竛g sinh!",
		Option = "Xin m阨 treo n l猲 c﹜ gi竛g sinh!",
		NpcId = 1491,	-- 挂上苹果的圣诞树
		},
	[3] = {
		OnTimeout = Process,
		Dialog = DecorateTree,
		Timeout = 60,
		DlgMsg = "Th祅h vi猲 %s  treo k裲 th祅h c玭g l猲 c﹜ gi竛g sinh.",
		ErrMsg = "Х treo k裲 l猲 c﹜ r錳",
		Hint = "Xin m阨 treo k裲 l猲 c﹜ gi竛g sinh",
		Option = "Xin m阨 treo k裲 l猲 c﹜ gi竛g sinh",
		NpcId = 1492,	-- 挂上光球的玫瑰树
		},
	[4] = {
		OnTimeout = Process,
		Dialog = DecorateTree,
		Timeout = 60,
		DlgMsg = "Th祅h vi猲 %s  treo chu玭g th祅h c玭g l猲 c﹜ gi竛g sinh.",
		ErrMsg = "Х treo chu玭g l猲 c﹜ r錳.",
		Hint = "Xin m阨 treo chu玭g l猲 c﹜ gi竛g sinh.",
		Option = "Xin m阨 treo chu玭g l猲 c﹜ gi竛g sinh.",
		NpcId = 1493,	-- 挂上糖果的玫瑰树
		},
	[5] = {
		OnTimeout = Process,
		Dialog = DecorateTree,
		Timeout = 60,
		DlgMsg = "Th祅h vi猲 %s  treo ng玦 sao th祅h c玭g l猲 c﹜ gi竛g sinh.",
		ErrMsg = "Х treo ng玦 sao l猲 c﹜ r錳",
		Hint = "Xin m阨 treo ng玦 sao l猲 c﹜ gi竛g sinh!",
		Option = "Xin m阨 treo ng玦 sao l猲 c﹜ gi竛g sinh!",
		NpcId = 1494,	-- 挂上钟的玫瑰树I
		},
	[6] = {
		OnTimeout = Wait,	
		Dialog = Award,
		Timeout = 300,
		Hint = "Ch骳 m鮪g c竎 i hi謕, ch髇g ta  c� 1 c﹜ gi竛g sinh th藅 l閚g l蓎 v� 蕀 竝!",
		Option = "Ta mu鑞 nh薾 thng",
		NpcId = 1495,	-- 挂上星星的玫瑰树
		},
	[7] = {
		OnTimeout = Destroy,
		Timeout = 24 * 3600 - 300,
		Option = nil,
	}
}

-- 创建圣诞树
function CreateTree(Id, Table)
	local TreeIdx = AddNpc(Id, 1, Table.Pos[1], Table.Pos[2] * 32, Table.Pos[3] * 32, 1, Table.Captain)
	if (TreeIdx <= 0) then
		return 0
	end
	SetNpcScript(TreeIdx, SCRIPT_TREE)
	return TreeIdx
end

-- 检查是否在新手村
function InNewbieCity()
	local MapId, _, _ = GetWorldPos()
	for i = 1, getn(NewbieMapTable) do
		if (MapId == NewbieMapTable[i]) then
			return 1
		end
	end
	return 0
end

-- 把日期和次数合成任务变量值
function EncodeTask(Date, Count)
	return Date * 100 + Count
end

-- 把任务变量值分解成日期和次数
function DecodeTask(Task)
	local Date = floor(Task / 100)
	local Count = mod(Task, 100)
	return Date, Count
end

-- 累加次数
function IncTaskCount(Task, CurrDate)
	local Date, Count = DecodeTask(Task)
	if (Date == CurrDate) then
		Count = Count + 1
	else
		Date = CurrDate
		Count = 1
	end
	return EncodeTask(Date, Count)
end

-- 检查种树和参加的公用条件
function CheckCommonCondition(Err)
	-- 要求是充值玩家
	if (IsCharged() == 0) then
		Err.Msg = format("Th祅h vi猲 %s ch璦  甶襲 ki謓 tham gia ho箃 ng.", GetName())
		return 0
	end
	-- 未转生：>=150级；已转生：>=90级
	local ReqLevel = 90
	if (ST_IsTransLife() == 0) then
		ReqLevel = 150
	end
	if (GetLevel() < ReqLevel) then
		Err.Msg = format("Th祅h vi猲 %s ch璦  甶襲 ki謓 tham gia ho箃 ng.", GetName())
		return 0
	end
	return 1
end

-- 检查种树条件
function CheckPlantCondition(CurrDate, Err)
	-- 只能队长种树
	local TeamId = GetTeam()
	if (TeamId == nil or IsCaptain() == 0) then
		Err.Msg = "Ph秈 l� i trng m韎 c� th� trang tr� c﹜ gi竛g sinh!"
		return 0
	end
	-- 检查种树次数限制
	local TaskDate, PlantCount = DecodeTask(PlayerFunLib:GetActivityTask(TASK_PLANTDATE))
	if (TaskDate == CurrDate and PlantCount >= LIMIT_PLANTCOUNT) then
		Err.Msg = format("M閠 ng祔 ch� c� th� tr錸g %d c﹜ gi竛g sinh!", LIMIT_PLANTCOUNT)
		return 0
	end
	return 1
end

-- 检查参加条件
function CheckJoinCondition(CurrDate, Err)
	-- 每人参加次数限制
	local Task = PlayerFunLib:GetActivityTask(TASK_JOINDATE)
	if (Task ~= 0) then
		local TaskDate, JoinCount = DecodeTask(Task)
		if (CurrDate == TaskDate and JoinCount >= LIMIT_JOINCOUNT) then
			Err.Msg = format("%s  tham gia  %d l莕.", GetName(), LIMIT_JOINCOUNT)
			return 0
		end
	end
	return 1
end

-- 检查队伍成员是否符合条件
function CheckTeamCondition(CurrDate, Err)
	local MemberCount = GetTeamSize()
	local Captain = PlayerIndex
	for i = 1, MemberCount do
		local Idx = GetTeamMember(i)
		-- 队长已经检查过了
		if (Idx ~= Captain) then
			PlayerIndex = Idx
			if (CheckCommonCondition(Err) == 0 or CheckJoinCondition(CurrDate, Err) == 0) then
				PlayerIndex = Captain
				return 0
			end
		end
	end
	PlayerIndex = Captain
	return 1
end

-- 检查是否符合种树的条件
function CheckCondition()
	-- 新手村非战斗区
	if (InNewbieCity() == 0 or GetFightState() == 1) then
		Msg2Player("Ch� c� th� � t﹏ th� th玭 v� th祅h th� s� d鬾g.")
		return 0
	end
	local CurrDate = mod(tonumber(GetLocalDate("%Y%m%d")), 100000)
	local Err = {Msg = ""}
	-- 检查种树资格
	if (CheckCommonCondition(Err) == 0 or CheckPlantCondition(CurrDate, Err) == 0) then
		Msg2Player(Err.Msg)
		return 0
	end
	-- 检查队伍成员条件
	if (CheckTeamCondition(CurrDate, Err) == 0) then
		Msg2Team(Err.Msg)
		return 0	
	end
	return 1
end

-- 开始种圣诞树：返回1（成功）或者0（失败）
function PlantTree()
	local Name = GetName()
	local Table = {
		Pos = {},
		Step = 1,
		Captain = Name,
		MemberState = {},
		MemberCount = 0
		}
	-- 设置当前位置
	Table.Pos[1] = SubWorld
	_, Table.Pos[2], Table.Pos[3] = GetWorldPos()
	local TreeIdx = CreateTree(ProcTable[Table.Step].NpcId, Table)
	if (TreeIdx == 0) then
		WriteLog(format("[%s ERROR]%s failed to plant tree", LOG_HEAD, Name))
		return 0
	end
	-- 累加种树次数
	local CurrDate = mod(tonumber(GetLocalDate("%Y%m%d")), 100000)
	local Task = IncTaskCount(PlayerFunLib:GetActivityTask(TASK_PLANTDATE), CurrDate)
	PlayerFunLib:SetActivityTask(TASK_PLANTDATE, Task)
	-- 给队员累加参加次数
	local CurrentPlayerIdx = PlayerIndex
	local MemberCount = GetTeamSize()
	Table.MemberCount = MemberCount
	for i = 1, MemberCount do
		PlayerIndex = GetTeamMember(i)
		if (PlayerIndex ~= CurrentPlayerIdx) then
			-- 种树人不累加参加次数
			Task = IncTaskCount(PlayerFunLib:GetActivityTask(TASK_JOINDATE), CurrDate)
			PlayerFunLib:SetActivityTask(TASK_JOINDATE, Task)
		end
		Table.MemberState[GetName()] = 0
	end
	PlayerIndex = CurrentPlayerIdx
	TreeTable[TreeIdx] = Table
	AddTimer(ProcTable[1].Timeout * GAME_FPS, "OnTime", TreeIdx)
	BroadCast(Table, format("%s  ti課 h祅h tr錸g C﹜ gi竛g sinh, h穣 nhanh ch鉵g ti課 h祅h trang tr�!", Name))
	BroadCast(Table, "Xin m阨 treo t竜 l猲 c﹜ gi竛g sinh!")
	WriteLog(format("[%s]%s plant Tree[%d]", LOG_HEAD, Name, TreeIdx))
	return 1
end

-- 定时器回调函数
function OnTime(TreeIdx)
	local Table = TreeTable[TreeIdx]
	if (Table == nil) then
		WriteLog(format("[%s ERROR]OnTime: Tree[%d] is nil", LOG_HEAD, TreeIdx))
		return 0
	end
	local Result = ProcTable[Table.Step].OnTimeout(TreeIdx, Table)
	if (Result == 0) then
		return 0
	else
		local Step = Table.Step + 1
		Table.Step = Step
		return ProcTable[Step].Timeout * GAME_FPS, Result
	end
end

-- 与圣诞树对话
function Dlg2Tree()
	local TreeIdx = GetLastDiagNpc()
	local Table = TreeTable[TreeIdx]
	if (Table == nil) then
		WriteLog(format("[%s]Dlg2Tree: Tree[%d] is nil", LOG_HEAD, TreeIdx))
	elseif (InMemberList(GetName(), Table) == 0) then
		Say("Xin m阨 t譵 n c﹜ gi竛g sinh c馻 m譶h")
	else
		ProcTable[Table.Step].Dialog(TreeIdx, Table)
	end
end

function TreeDialog()
	local TreeIdx = GetLastDiagNpc()
	local Table = TreeTable[TreeIdx]
	if (Table == nil) then
		local Msg = format("[%s ERROR]TreeDialog: Tree[%d] is nil", LOG_HEAD, TreeIdx)
		WriteLog(Msg)
		return
	end
	local Caption = "Зy l� m閠 c﹜ gi竛g sinh th藅 l閚g l蓎 v� 蕀 竝."
	local Option = ProcTable[Table.Step].Option
	if (Option ~= nil) then
		Say(Caption,
			2,
			format("%s/%s", Option, "Dlg2Tree"),
			"Ta mu鑞 xem th� /Cancel")
	else
		Say(Caption)
	end
end
