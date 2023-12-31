--======================================================================
--Author:   Tan Qingyu
--Date:     2012-4-1 18:23:50
--Describe: 汴京地宫 变量定义
--======================================================================

BJDG_HEAD = {}

BJDG_HEAD.tbInDungeonPlayerList = {}		-- role name is the key, value is 1
BJDG_HEAD.nDailyLimitTime = 2 * 60 * 60
BJDG_HEAD.nInDungeonTimeTaskId = 3412
BJDG_HEAD.nLastResetDateTaskId = 3413
BJDG_HEAD.nTimeInterval_Dungeon = 10
BJDG_HEAD.tbEntrancePos = {37, 1692, 2917}
BJDG_HEAD.tbLeaveTargetPos = {37, 1695, 2914}
BJDG_HEAD.tbCallBigBossTime = {[11] = 1, [19] = 1}
BJDG_HEAD.nLitterBossCount = 3
BJDG_HEAD.nMapId = 985
BJDG_HEAD.nTimeInterval_Boss = 3600
BJDG_HEAD.nRevMinDisThreshold = 50
BJDG_HEAD.nIsOpen = 1
BJDG_HEAD.tbOpenDate = {nBegin = 0, nEnd = 0}	-- Left close, right open

BJDG_HEAD.tbOpenTime = {
	[00] = 1, [01] = 1, [02] = 0, [03] = 0, [04] = 0, [05] = 0, 
	[06] = 0, [07] = 0, [08] = 0, [09] = 0, [10] = 1, [11] = 1, 
	[12] = 1, [13] = 1, [14] = 1, [15] = 1, [16] = 1, [17] = 1, 
	[18] = 1, [19] = 1, [20] = 1, [21] = 1, [22] = 1, [23] = 1, 
}

BJDG_HEAD.tbPosName = {
	"Thanh Long Tr薾",
	"B筩h H� Tr薾",
	"Chu Tc Tr薾",
	"Huy襫 V� Tr薾",
}

BJDG_HEAD.tbPos = {
	["Thanh Long Tr薾"] = {BJDG_HEAD.nMapId, 2177, 3859},
	["B筩h H� Tr薾"] = {BJDG_HEAD.nMapId, 1742, 3400},
	["Chu Tc Tr薾"] = {BJDG_HEAD.nMapId, 1741, 3867},
	["Huy襫 V� Tr薾"] = {BJDG_HEAD.nMapId, 2188, 3414},
}

BJDG_HEAD.tbEntryNpc = {
	nNpcId = 1926,
	szName = "Phong Th竔 Linh",
	nLevel = 95,
	bNoRevive = 1,
	szScriptPath = "\\script\\missions\\bianjingdigong\\npc_dialog\\on_entry_dialog.lua"
}

BJDG_HEAD.tbFakeBigBoss = {
	nNpcId = 1921,
	szName = "Жng 謕",
	nLevel = 95,
	bNoRevive = 1,
	nIsboss = 1,
	szDeathScript = "\\script\\missions\\bianjingdigong\\npc_fight\\false_boss.lua",
	szScriptPath = "\\script\\missions\\bianjingdigong\\npc_fight\\false_boss.lua",
	nTime = 2 * 3600,
}

BJDG_HEAD.tbBigBoss = {
	nNpcId = 1921,
	szName = "Жng 謕",
	nLevel = 95,
	bNoRevive = 1,
	nIsboss = 1,
	szDeathScript = "\\script\\missions\\bianjingdigong\\npc_fight\\true_boss.lua",
	szScriptPath = "\\script\\missions\\bianjingdigong\\npc_fight\\true_boss.lua",
	nTime = 2 * 3600,
}

BJDG_HEAD.tbMonsterPosFile = 
{
	[1] = "\\settings\\maps\\bianjingdigong\\pos_lingdie.txt",
	[2] = "\\settings\\maps\\bianjingdigong\\pos_xiaodie.txt",
	[3] = "\\settings\\maps\\bianjingdigong\\pos_midie.txt",
}

BJDG_HEAD.tbEliteMonster = {
	{
		nNpcId = 1918,
		szName = "Linh 謕 Tinh Anh",
		nLevel = 95,
		bNoRevive = 1,
		nIsboss = 1,
		szDeathScript = "\\script\\missions\\bianjingdigong\\npc_fight\\litter_boss.lua",
		szScriptPath = "\\script\\missions\\bianjingdigong\\npc_fight\\litter_boss.lua",
		nTime = 3600,
	},
	{
		nNpcId = 1919,
		szName = "Ki猽 謕 Tinh Anh",
		nLevel = 95,
		bNoRevive = 1,
		nIsboss = 1,
		szDeathScript = "\\script\\missions\\bianjingdigong\\npc_fight\\litter_boss.lua",
		szScriptPath = "\\script\\missions\\bianjingdigong\\npc_fight\\litter_boss.lua",
		nTime = 3600,
	},
	{
		nNpcId = 1920,
		szName = "M� 謕 Tinh Anh",
		nLevel = 95,
		bNoRevive = 1,
		nIsboss = 1,
		szDeathScript = "\\script\\missions\\bianjingdigong\\npc_fight\\litter_boss.lua",
		szScriptPath = "\\script\\missions\\bianjingdigong\\npc_fight\\litter_boss.lua",
		nTime = 3600,
	},
}

BJDG_HEAD.tbNpcTypeList = --npc的类型
{
	["Linh 謕"] = 
	{
		nNpcId = 1915,
		szName = "Linh 謕",
		nLevel = 95,
		bNoRevive = 0,
		nIsboss = 1,
		szPosPath = BJDG_HEAD.tbMonsterPosFile[1],
		szDeathScript = "\\script\\missions\\bianjingdigong\\npc_fight\\monster.lua",
	},
	["Ki猽 謕 "] = 
	{
		nNpcId = 1916,
		szName = "Ki猽 謕 ",
		nLevel = 95,
		bNoRevive = 0,
		nIsboss = 1,
		szPosPath = BJDG_HEAD.tbMonsterPosFile[2],
		szDeathScript = "\\script\\missions\\bianjingdigong\\npc_fight\\monster.lua",
	},
	["M� 謕 "] = 
	{
		nNpcId = 1917,
		szName = "M� 謕 ",
		nLevel = 95,
		bNoRevive = 0,
		nIsboss = 1,
		szPosPath = BJDG_HEAD.tbMonsterPosFile[3],
		szDeathScript = "\\script\\missions\\bianjingdigong\\npc_fight\\monster.lua",
	},
	["觤 NPC truy襫 t鑞g trong n閕 trng"] =
	{
		nNpcId = 1925,
		szName = "K� L鬰 Nh﹏",
		nLevel = 95,
		bNoRevive = 1,
		szPosPath = "\\settings\\maps\\bianjingdigong\\pos_qiluren.txt",
		szScriptPath = "\\script\\missions\\bianjingdigong\\npc_dialog\\on_dungeon_dialog.lua"
	},
	["Dc 誱"] = 
	{
		nNpcId = 203,
		szName = "Ch� dc 甶誱",
		nLevel = 95,
		szScriptPath = "\\script\\missions\\bianjingdigong\\npc_dialog\\npc_yaodian.lua",
		szPosPath = "\\settings\\maps\\bianjingdigong\\pos_yaodian.txt",
	},
	["Rng ch鴄 "] = 
	{
		nNpcId = 625,
		szName = "Rng ch鴄 ",
		nLevel = 95,
		szScriptPath = "\\script\\missions\\bianjingdigong\\npc_dialog\\npc_chuwuxiang.lua",	
		szPosPath = "\\settings\\maps\\bianjingdigong\\pos_chuwuxiang.txt",
	},
}

BJDG_HEAD.tbTrapList = 
{
	["safetofight"] = 
	{
		szPosPath = "\\settings\\maps\\bianjingdigong\\trap_safe2fight.txt",
		szTrapFile = "\\script\\missions\\bianjingdigong\\npc_player\\on_trap_s2f.lua",
	},
	["fighttosafe"] = 
	{
		szPosPath = "\\settings\\maps\\bianjingdigong\\trap_fight2safe.txt",
		szTrapFile = "\\script\\missions\\bianjingdigong\\npc_player\\on_trap_f2s.lua",
	},
}

BJDG_HEAD.tbBigBossPos = {
	[1] = {
		{x = 61248, y = 115360}, 
		{x = 62400, y = 117472}, 
		{x = 64096, y = 112000}, 
		{x = 64800, y = 107104}, 
		{x = 64512, y = 114688}, 
	},
	[2] = {
		{x = 62528, y = 126784}, 
		{x = 63776, y = 122944}, 
		{x = 69984, y = 115616}, 
		{x = 71968, y = 117632}, 
		{x = 74208, y = 116000}, 
	},
	[3] = {
		{x = 53984, y = 114112}, 
		{x = 54720, y = 119200}, 
		{x = 57760, y = 115744}, 
		{x = 58336, y = 119616}, 
		{x = 59360, y = 123712}, 
	},
}

function BJDG_HEAD:CopyTo(tbTarget)
	for k, v in BJDG_HEAD do
		tbTarget[k] = v
	end
	tbTarget["CopyTo"] = nil
end
