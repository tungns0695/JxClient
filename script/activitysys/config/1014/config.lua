Include("\\script\\activitysys\\config\\1014\\variables.lua")
tbConfig = {}
tbConfig[1] = --一个细节
{
	nId = 1,
	szMessageType = "ServerStart",
	szName = "server start",
	nStartDate = nil,
	nEndDate  = nil,
	tbMessageParam = {nil},
	tbCondition = 
	{
	},
	tbActition = 
	{
		{"ThisActivity:Init",	{nil} },
	},
}
tbConfig[2] = --一个细节
{
	nId = 2,
	szMessageType = "ClickNpc",
	szName = "click shijianzongguan",
	nStartDate = nil,
	nEndDate  = nil,
	tbMessageParam = {"T鎛g Qu秐 S� Ki謓"},
	tbCondition = 
	{
	},
	tbActition = 
	{
		{"AddDialogOpt",	{"H頿 th祅h ph莕 thng",3} },
		{"AddDialogOpt",	{"Nh薾 ph莕 thng tr鵦 tuy課",7} },
	},
}
tbConfig[3] = --h頿 th祅h ph莕 thng
{
	nId = 3,
	szMessageType = "CreateDialog",
	szName = "compose dialog",
	nStartDate = nil,
	nEndDate  = nil,
	tbMessageParam = {"Xin Ch祇!",0},
	tbCondition = 
	{
		{"PlayerFunLib:CheckTotalLevel",	{150,"default",">="} },
	},
	tbActition = 
	{
		{"AddDialogOpt",	{ITEM_AWARD1.szName,4} },
		{"AddDialogOpt",	{ITEM_AWARD2.szName,5} },
		{"AddDialogOpt",	{ITEM_AWARD3.szName,6} },
		{"AddDialogOpt",	{"Gh衟 b� hoa v祅g",29} },
		{"AddDialogOpt",	{"Gh衟 nh薾 ng蓇 nhi猲 b� hoa xanh ho芻 ",28} },
	},
}
tbConfig[4] = --S竎h l辌h s�
{
	nId = 4,
	szMessageType = "CreateCompose",
	szName = "Gh衟 s竎h l辌h s�",
	nStartDate = nil,
	nEndDate  = nil,
	tbMessageParam = {ITEM_AWARD1.szName,1,1,1,0.02,0,50},
	tbCondition = 
	{
		{"PlayerFunLib:CheckTotalLevel",	{150,"default",">="} },
		{"AddOneMaterial",	{ITEM_MATERIAL_1.szName,ITEM_MATERIAL_1,1} },
		{"AddOneMaterial",	{ITEM_MATERIAL_2.szName,ITEM_MATERIAL_2,2} },
		{"AddOneMaterial",	{ITEM_MATERIAL_3.szName,ITEM_MATERIAL_3,1} },
		{"AddOneMaterial",	{ITEM_MATERIAL_4.szName,ITEM_MATERIAL_4,1} },
	},
	tbActition = 
	{
		{"PlayerFunLib:GetItem",	{ITEM_AWARD1,1,EVENT_LOG_TITLE,"GhepSachLichSu"} },
	},
}
tbConfig[5] = --S竎h a l�
{
	nId = 5,
	szMessageType = "CreateCompose",
	szName = "Gh衟 s竎h a l�",
	nStartDate = nil,
	nEndDate  = nil,
	tbMessageParam = {ITEM_AWARD2.szName,1,1,1,0.02,0,50},
	tbCondition = 
	{
		{"PlayerFunLib:CheckTotalLevel",	{150,"default",">="} },
		{"AddOneMaterial",	{ITEM_MATERIAL_1.szName,ITEM_MATERIAL_1,1} },
		{"AddOneMaterial",	{ITEM_MATERIAL_2.szName,ITEM_MATERIAL_2,2} },
		{"AddOneMaterial",	{ITEM_MATERIAL_3.szName,ITEM_MATERIAL_3,1} },
		{"AddOneMaterial",	{ITEM_MATERIAL_4.szName,ITEM_MATERIAL_4,1} },
		{"AddOneMaterial",	{ITEM_MATERIAL_5.szName,ITEM_MATERIAL_5,1} },
	},
	tbActition = 
	{
		{"PlayerFunLib:GetItem",	{ITEM_AWARD2,1,EVENT_LOG_TITLE,"GhepSachDiaLy"} },
	},
}
tbConfig[6] = --一个细节
{
	nId = 6,
	szMessageType = "CreateCompose",
	szName = "Gh衟 S竎h V╪ H鋍",
	nStartDate = nil,
	nEndDate  = nil,
	tbMessageParam = {ITEM_AWARD3.szName,1,1,1,0.02,0,50},
	tbCondition = 
	{
		{"PlayerFunLib:CheckTotalLevel",	{150,"default",">="} },
		{"AddOneMaterial",	{ITEM_MATERIAL_1.szName,ITEM_MATERIAL_1,1} },
		{"AddOneMaterial",	{ITEM_MATERIAL_2.szName,ITEM_MATERIAL_2,2} },
		{"AddOneMaterial",	{ITEM_MATERIAL_3.szName,ITEM_MATERIAL_3,1} },
		{"AddOneMaterial",	{ITEM_MATERIAL_4.szName,ITEM_MATERIAL_4,1} },
		{"AddOneMaterial",	{ITEM_MATERIAL_7.szName,ITEM_MATERIAL_7,1} },
	},
	tbActition = 
	{
		{"PlayerFunLib:GetItem",	{ITEM_AWARD3,1,EVENT_LOG_TITLE,"GhepSachVanHoc"} },
	},
}
tbConfig[7] = --Nh薾 ph莕 thng Online
{
	nId = 7,
	szMessageType = "nil",
	szName = "get onlineaward",
	nStartDate = nil,
	nEndDate  = nil,
	tbMessageParam = {nil},
	tbCondition = 
	{
		{"PlayerFunLib:CheckTotalLevel",	{150,"default",">="} },
		{"PlayerFunLib:CheckTaskDaily",	{TSK_GET_ONLINEAWARD,MAX_GET_ONLINEAWARD,"H玬 nay ngi kh玭g th� nh薾 n鱝, ng祔 mai h穣 quay l筰.","<"} },
		{"PlayerFunLib:CheckFreeBagCell",	{1,"default"} },
	},
	tbActition = 
	{
		{"ThisActivity:GetOnlineAward",	{nil} },
	},
}
tbConfig[8] = --Цnh qu竔 r韙 Item Cu鑞 s竎h tr緉g
{
	nId = 8,
	szMessageType = "NpcOnDeath",
	szName = "kill monster at field",
	nStartDate = nil,
	nEndDate  = nil,
	tbMessageParam = {nil},
	tbCondition = 
	{
		{"PlayerFunLib:CheckTotalLevel",	{150,"",">="} },
		{"NpcFunLib:CheckInMap",	{"321,322,340,75,225,226,227"} },
	},
	tbActition = 
	{
		{"NpcFunLib:DropSingleItem",	{ITEM_MATERIAL_1,1,"5"} },
	},
}
tbConfig[9] = --Mua lo m鵦
{
	nId = 9,
	szMessageType = "ClickNpc",
	szName = "click lingfan",
	nStartDate = nil,
	nEndDate  = nil,
	tbMessageParam = {"H祅g rong"},
	tbCondition = 
	{
		{"PlayerFunLib:CheckTotalLevel",	{150,"",">="} },
	},
	tbActition = 
	{
		{"AddDialogOpt",	{format("Mua %s",ITEM_MATERIAL_2.szName),10} },
	},
}
tbConfig[10] = --Mua l� m鵦
{
	nId = 10,
	szMessageType = "CreateCompose",
	szName = "buy material2",
	nStartDate = nil,
	nEndDate  = nil,
	tbMessageParam = {ITEM_MATERIAL_2.szName,1,1,1,0.02,0,50},
	tbCondition = 
	{
		{"PlayerFunLib:CheckTotalLevel",	{150,"",">="} },
		{"AddOneMaterial",	{MONEY.szName,MONEY,10000} },
	},
	tbActition = 
	{
		{"PlayerFunLib:GetItem",	{ITEM_MATERIAL_2,1,EVENT_LOG_TITLE,"MuaLoMuc"} },
	},
}
tbConfig[11] = --一个细节
{
	nId = 11,
	szMessageType = "FinishSongJin",
	szName = "songjin mark>=1500 and <3000",
	nStartDate = nil,
	nEndDate  = nil,
	tbMessageParam = {-2,"3"},
	tbCondition = 
	{
		{"PlayerFunLib:CheckTask",	{"751",3000,"","<"} },
		{"PlayerFunLib:CheckTask",	{"751",1500,"",">="} },
	},
	tbActition = 
	{
		{"PlayerFunLib:GetItem",	{ITEM_MATERIAL_3,30,EVENT_LOG_TITLE,"TongKim1000"} },
	},
}
tbConfig[12] = --一个细节
{
	nId = 12,
	szMessageType = "FinishSongJin",
	szName = "songjin mark>=3000",
	nStartDate = nil,
	nEndDate  = nil,
	tbMessageParam = {-2,"3"},
	tbCondition = 
	{
		{"PlayerFunLib:CheckTask",	{"751",3000,"",">="} },
	},
	tbActition = 
	{
		{"PlayerFunLib:GetItem",	{ITEM_MATERIAL_3,45,EVENT_LOG_TITLE,"TongKim3000"} },
	},
}
tbConfig[13] = --一个细节
{
	nId = 13,
	szMessageType = "NpcOnDeath",
	szName = "yandibaozang boss",
	nStartDate = nil,
	nEndDate  = nil,
	tbMessageParam = {nil},
	tbCondition = 
	{
		{"NpcFunLib:CheckId",	{"1289,1290,1291,1292,1293,1294,1295,1296,1297,1298"} },
		{"NpcFunLib:CheckInMap",	{"853,854,855,856,857,858,859,860,861,862"} },
	},
	tbActition = 
	{
		{"PlayerFunLib:GetItem",	{ITEM_MATERIAL_3,6,EVENT_LOG_TITLE,"BossTieuViemDe"} },
	},
}
tbConfig[14] = --一个细节
{
	nId = 14,
	szMessageType = "NpcOnDeath",
	szName = "yandibaozang boss sp",
	nStartDate = nil,
	nEndDate  = nil,
	tbMessageParam = {nil},
	tbCondition = 
	{
		{"NpcFunLib:CheckId",	{"1310,1312,1317,1314,1318,1319,1311,1313,1315,1316"} },
		{"NpcFunLib:CheckInMap",	{"853,854,855,856,857,858,859,860,861,862"} },
	},
	tbActition = 
	{
		{"PlayerFunLib:GetItem",	{ITEM_MATERIAL_3,18,EVENT_LOG_TITLE,"BossDaiViemDe"} },
	},
}
tbConfig[15] = --一个细节
{
	nId = 15,
	szMessageType = "Chuanguan",
	szName = "chuangguan_17",
	nStartDate = nil,
	nEndDate  = nil,
	tbMessageParam = {"17"},
	tbCondition = 
	{
	},
	tbActition = 
	{
		{"PlayerFunLib:GetItem",	{ITEM_MATERIAL_3,30,EVENT_LOG_TITLE,"VuotAi17"} },
	},
}
tbConfig[16] = --一个细节
{
	nId = 16,
	szMessageType = "Chuanguan",
	szName = "chuangguan_28",
	nStartDate = nil,
	nEndDate  = nil,
	tbMessageParam = {"28"},
	tbCondition = 
	{
	},
	tbActition = 
	{
		{"PlayerFunLib:GetItem",	{ITEM_MATERIAL_3,30,EVENT_LOG_TITLE,"VuotAi28"} },
	},
}
tbConfig[17] = --一个细节
{
	nId = 17,
	szMessageType = "NpcOnDeath",
	szName = "fenglingdu_boatboss",
	nStartDate = nil,
	nEndDate  = nil,
	tbMessageParam = {nil},
	tbCondition = 
	{
		{"NpcFunLib:CheckBoatBoss",	{nil} },
	},
	tbActition = 
	{
		{"PlayerFunLib:GetItem",	{ITEM_MATERIAL_3,30,EVENT_LOG_TITLE,"TieuDietThuyTacDauLinh"} },
	},
}
tbConfig[18] = --thu� t芻 i u l躰h
{
	nId = 18,
	szMessageType = "NpcOnDeath",
	szName = "Ti猽 di謙 thu� t芻 i u l躰h",
	nStartDate = nil,
	nEndDate  = nil,
	tbMessageParam = {nil},
	tbCondition = 
	{		
		{"NpcFunLib:CheckId",	{"1692"} },
		{"NpcFunLib:CheckInMap",	{"337,338,339"} },
	},
	tbActition = 
	{
		{"PlayerFunLib:GetItem",	{ITEM_MATERIAL_3,60,EVENT_LOG_TITLE,"TieuDietThuyTacDaiDauLinh"} },		
	},
}
tbConfig[19] = --一个细节
{
	nId = 19,
	szMessageType = "NpcOnDeath",
	szName = "tianchimijing floor3",
	nStartDate = nil,
	nEndDate  = nil,
	tbMessageParam = {nil},
	tbCondition = 
	{
		{"NpcFunLib:CheckInMap",	{"937,938,939,940,941,943,944,945,946"} },
	},
	tbActition = 
	{
		{"NpcFunLib:DropSingleItem",	{ITEM_MATERIAL_3,3,"10"} },
	},
}
tbConfig[20] = --一个细节
{
	nId = 20,
	szMessageType = "MazeTaskFinish",
	szName = "maze task",
	nStartDate = nil,
	nEndDate  = nil,
	tbMessageParam = {nil},
	tbCondition = 
	{
		--{"PlayerFunLib:CheckFreeBagCell",	{1,"nomsg"} },
	},
	tbActition = 
	{
		{"PlayerFunLib:GetItem",	{ITEM_MATERIAL_3,9,EVENT_LOG_TITLE,"KiemGiaMeCung"} },
	},
}
tbConfig[21] = --一个细节
{
	nId = 21,
	szMessageType = "NpcOnDeath",
	szName = "kill world boss",
	nStartDate = nil,
	nEndDate  = nil,
	tbMessageParam = {nil},
	tbCondition = 
	{
		{"NpcFunLib:CheckWorldBoss",	{nil} },
	},
	tbActition = 
	{		
		{"PlayerFunLib:GetItem",	{ITEM_MATERIAL_3,60,EVENT_LOG_TITLE,"TieuDietBossTheGioi"} },	
	},
}
tbConfig[22] = --Thu th藀 hoa tri ﹏
{
	nId = 22,
	szMessageType = "nil",
	szName = "compose material4 dialog",
	nStartDate = nil,
	nEndDate  = nil,
	tbMessageParam = {nil},
	tbCondition = 
	{
		{"PlayerFunLib:CheckTotalLevel",	{150,"default",">="} },
	},
	tbActition = 
	{
		--{"ThisActivity:ComposeMaterial4Dailog",	{nil} },
	},
}
tbConfig[23] = --S竎h l辌h s�
{
	nId = 23,
	szMessageType = "ItemScript",
	szName = "use award1",
	nStartDate = nil,
	nEndDate  = nil,
	tbMessageParam = {ITEM_AWARD1},
	tbCondition = 
	{
		{"PlayerFunLib:CheckTotalLevel",	{150,"default",">="} },
		{"PlayerFunLib:CheckCashLimit",	{1900000000,"default"} },
		{"tbVNG_BitTask_Lib:CheckBitTaskValue",	{TSK_USE_AWARD1,MAX_USE_AWARD1,"Х t n gi韎 h筺, kh玭g th� s� d鬾g ti誴","<"} },
	--	{"PlayerFunLib:CheckFreeBagCell",	{1,"default"} },
	},
	tbActition = 
	{
		{"ThisActivity:UseAward1",	{nil} },
	},
}
tbConfig[24] = --S竎h a l�
{
	nId = 24,
	szMessageType = "ItemScript",
	szName = "use award2",
	nStartDate = nil,
	nEndDate  = nil,
	tbMessageParam = {ITEM_AWARD2},
	tbCondition = 
	{
		{"PlayerFunLib:VnCheckInCity", {"default"}},
		{"PlayerFunLib:CheckFreeBagCell",	{12,"default"} },
		{"PlayerFunLib:CheckTotalLevel",	{150,"default",">="} },
		{"PlayerFunLib:CheckCashLimit",	{1900000000,"default"} },
		{"tbVNG_BitTask_Lib:CheckBitTaskValue",	{TSK_USE_AWARD2,MAX_USE_AWARD2,"Х t n gi韎 h筺, kh玭g th� s� d鬾g ti誴","<"} },
	},
	tbActition = 
	{
		{"ThisActivity:UseAward2",	{nil} },
	},
}
tbConfig[25] = --S竎h v╪ h鋍
{
	nId = 25,
	szMessageType = "ItemScript",
	szName = "use award3",
	nStartDate = nil,
	nEndDate  = nil,
	tbMessageParam = {ITEM_AWARD3},
	tbCondition = 
	{
		{"PlayerFunLib:CheckTotalLevel",	{150,"default",">="} },
		{"PlayerFunLib:CheckCashLimit",	{1900000000,"default"} },
		{"tbVNG_BitTask_Lib:CheckBitTaskValue",	{TSK_USE_AWARD3,MAX_USE_AWARD3,"Х t n gi韎 h筺, kh玭g th� s� d鬾g ti誴","<"} },
	--	{"PlayerFunLib:CheckFreeBagCell",	{3,"default"} },
	},
	tbActition = 
	{
		{"ThisActivity:UseAward3",	{nil} },
	},
}
tbConfig[26] = --一个细节
{
	nId = 26,
	szMessageType = "OnLogin",
	szName = "on login",
	nStartDate = nil,
	nEndDate  = nil,
	tbMessageParam = {nil},
	tbCondition = 
	{
	},
	tbActition = 
	{
		{"ThisActivity:PlayerOnLogin",	{nil} },
	},
}
tbConfig[27] =
{
	nId = 27,
	szMessageType = "ItemScript",
	szName = "H閜 b髏 ch�",
	nStartDate = nil,
	nEndDate  = nil,
	tbMessageParam = {ITEM_MATERIAL_6},
	tbCondition = 
	{
		{"PlayerFunLib:CheckTotalLevel",	{150,"default",">="} },
		{"PlayerFunLib:CheckCashLimit",	{1900000000,"default"} },
		{"PlayerFunLib:CheckFreeBagCell",	{1,"default"} },
	},
	tbActition = 
	{
		{"PlayerFunLib:GetItem",	{ITEM_USE_MATERIAL_6,5,EVENT_LOG_TITLE,"SuDungHopButChi"} },
	},
}
tbConfig[28] = --Ghep nh薾 ng蓇 nhi猲 nh薾 B� hoa m祏 tr緉g ho芻 m祏 xanh
{
	nId = 28,
	szMessageType = "CreateCompose",
	szName = "Gh衟 random B� hoa",
	nStartDate = nil,
	nEndDate  = nil,
	tbMessageParam = {ITEM_AWARD4.szName,1,1,1,0.02,0,50},
	tbCondition = 
	{
		{"PlayerFunLib:CheckTotalLevel",	{150,"default",">="} },
		{"AddOneMaterial",	{ITEM_MATERIAL_1.szName,ITEM_MATERIAL_1,1} },
		{"AddOneMaterial",	{ITEM_MATERIAL_2.szName,ITEM_MATERIAL_2,2} },
		{"AddOneMaterial",	{ITEM_MATERIAL_3.szName,ITEM_MATERIAL_3,1} },
		{"AddOneMaterial",	{ITEM_MATERIAL_4.szName,ITEM_MATERIAL_4,1} },
	},
	tbActition = 
	{
		{"PlayerFunLib:GetItem",	{AWARD_GHEPRANDOMITEM,1,EVENT_LOG_TITLE,"GhepBoHoaNhanRanDom"} },
	},
}
tbConfig[29] = --B� hoa m祏 V祅g
{
	nId = 29,
	szMessageType = "CreateCompose",
	szName = "Gh衟 B� hoa m祏 V祅g",
	nStartDate = nil,
	nEndDate  = nil,
	tbMessageParam = {ITEM_AWARD6.szName,1,1,1,0.02,0,50},
	tbCondition = 
	{
		{"PlayerFunLib:CheckTotalLevel",	{150,"default",">="} },
		{"AddOneMaterial",	{ITEM_MATERIAL_1.szName,ITEM_MATERIAL_1,1} },
		{"AddOneMaterial",	{ITEM_MATERIAL_2.szName,ITEM_MATERIAL_2,2} },
		{"AddOneMaterial",	{ITEM_MATERIAL_3.szName,ITEM_MATERIAL_3,1} },
		{"AddOneMaterial",	{ITEM_MATERIAL_4.szName,ITEM_MATERIAL_4,1} },
		{"AddOneMaterial",	{ITEM_MATERIAL_8.szName,ITEM_MATERIAL_8,1} },
	},
	tbActition = 
	{
		{"PlayerFunLib:GetItem",	{ITEM_AWARD6,1,EVENT_LOG_TITLE,"GhepBoHoaMauVang"} },
	},
}
tbConfig[30] = --B� hoa m祏 Xanh
{
	nId = 30,
	szMessageType = "ItemScript",
	szName = "use award4",
	nStartDate = nil,
	nEndDate  = nil,
	tbMessageParam = {ITEM_AWARD4},
	tbCondition = 
	{
		{"PlayerFunLib:CheckTotalLevel",	{150,"default",">="} },
		{"PlayerFunLib:CheckCashLimit",	{1900000000,"default"} },
		{"tbVNG_BitTask_Lib:CheckBitTaskValue",	{TSK_USE_AWARD4,MAX_USE_AWARD4,"Х t n gi韎 h筺, kh玭g th� s� d鬾g ti誴","<"} },
	},
	tbActition = 
	{
		{"ThisActivity:UseAward4",	{0} },
	},
}
tbConfig[31] = --B� hoa m祏 п
{
	nId = 31,
	szMessageType = "ItemScript",
	szName = "use award 5",
	nStartDate = nil,
	nEndDate  = nil,
	tbMessageParam = {ITEM_AWARD5},
	tbCondition = 
	{
		{"PlayerFunLib:CheckTotalLevel",	{150,"default",">="} },
		{"PlayerFunLib:CheckCashLimit",	{1900000000,"default"} },
		{"tbVNG_BitTask_Lib:CheckBitTaskValue",	{TSK_USE_AWARD4,MAX_USE_AWARD4,"Х t n gi韎 h筺, kh玭g th� s� d鬾g ti誴","<"} },
	},
	tbActition = 
	{
		{"ThisActivity:UseAward4",	{1} },
	},
}
tbConfig[32] = --B� hoa m祏 V祅g
{
	nId = 32,
	szMessageType = "ItemScript",
	szName = "use award 6",
	nStartDate = nil,
	nEndDate  = nil,
	tbMessageParam = {ITEM_AWARD6},
	tbCondition = 
	{
		{"PlayerFunLib:VnCheckInCity", {"default"}},
		{"PlayerFunLib:CheckFreeBagCell",	{12,"default"} },
		{"PlayerFunLib:CheckTotalLevel",	{150,"default",">="} },
		{"PlayerFunLib:CheckCashLimit",	{1900000000,"default"} },
		{"tbVNG_BitTask_Lib:CheckBitTaskValue",	{TSK_USE_AWARD6,MAX_USE_AWARD6,"Х t n gi韎 h筺, kh玭g th� s� d鬾g ti誴","<"} },
	},
	tbActition = 
	{
		{"ThisActivity:UseAward6",	{nil} },
	},
}