Include("\\script\\activitysys\\config\\25\\variables.lua")
tbConfig = {}
tbConfig[1] = --一个细节
{
	nId = 1,
	szMessageType = "nil",
	szName = "nil",
	nStartDate = nil,
	nEndDate  = nil,
	tbMessageParam = {nil},
	tbCondition = 
	{
	},
	tbActition = 
	{
	},
}
tbConfig[2] = --一个细节
{
	nId = 2,
	szMessageType = "ClickNpc",
	szName = "Click v祇 Nguy猲 Фn",
	nStartDate = nil,
	nEndDate  = nil,
	tbMessageParam = {"Nguy猲 Фn"},
	tbCondition = 
	{
	},
	tbActition = 
	{
		{"AddDialogOpt",	{"Gi韎 thi謚 ho箃 ng p tr鴑g vui v�",3} },
		{"AddDialogOpt",	{"D飊g Ch飝 V祅g Nguy猲 Фn p tr鴑g",21} },
		{"AddDialogOpt",	{"D飊g Ch飝 B筩 Nguy猲 Фn p tr鴑g",22} },
		{"AddDialogOpt",	{"D飊g Ch飝 уng Nguy猲 Фn p tr鴑g",23} },
		{"AddDialogOpt",	{"Nh薾 ph莕 thng s� d鬾g Ch飝 B筩 v� Ch飝 V祅g Nguy猲 Фn t n 200 l莕",7} },
		{"SetDialogTitle",	{"<lua random(1,100) < 100 and [[ 產u ]] or [[ i hi謕 xin ng 匽]/>"} },
	},
}
tbConfig[3] = --一个细节
{
	nId = 3,
	szMessageType = "CreateDialog",
	szName = "Gi韎 thi謚 ho箃 ng p tr鴑g vui v�",
	nStartDate = nil,
	nEndDate  = nil,
	tbMessageParam = {"T� 0h ng祔 21 th竛g 12 n╩ 2010 n 24h ng祔 10 th竛g 1 n╩ 2011,i hi謕 ngi c� th� c莔 Ch飝 уng Nguy猲 Фn, Ch飝 B筩 Nguy猲 Фn, Ch飝 V祅g Nguy猲 Фn n ch� c馻 'Nguy猲 Фn'  p tr鴑g, ngi s� nh薾 頲 ni襪 vui b蕋 ng�, i hi謕 n誹 ngi mu鑞 d飊g Ch飝 B筩 Nguy猲 Фn, Ch飝 уng Nguy猲 Фn  p tr鴑g, ngo礽 vi謈 ngi c莕 c� ch飝 tng 鴑g ra, c遪 c莕 ph秈 th醓 m穘 2 甶襲 ki謓 di y<enter>1, c莕 ph秈 t� i v韎 3 ngi, t� i 3 ngi c莕 ph秈 甧o M苩 N� D� Dung nh薾 � L� Quan t筰 Bi謓 Kinh, Tng Dng ho芻 L﹎ An<enter>2, t� i 3 ngi c莕 ph秈 甧o M苩 N� D� Dung c� m祏 s綾 gi鑞g nhau, h譶h d竛g b猲 ngo礽 th� kh玭g gi鑞g nhau <enter> d飊g Ch飝 V祅g Nguy猲 Фn th� kh玭g c莕 甶襲 ki謓 g� c�, trong  Ch飝 уng Nguy猲 Фn ngi c� th� nh薾 � L� Quan, Ch飝 B筩 Nguy猲 Фn i hi謕 c� th� tham gia c竎 h� th鑞g tr� ch琲 trong game th� nh薾 頲, Ch飝 V祅g Nguy猲 Фn b筺 c� th� l蕐 n� � K� Tr﹏ C竎."},
	tbCondition = 
	{
	},
	tbActition = 
	{
	},
}
tbConfig[4] = --一个细节
{
	nId = 4,
	szMessageType = "nil",
	szName = "D飊g Ch飝 V祅g Nguy猲 Фn p tr鴑g",
	nStartDate = nil,
	nEndDate  = nil,
	tbMessageParam = {nil},
	tbCondition = 
	{
		{"PlayerFunLib:CheckTotalLevel",	{80,"default",">="} },
		{"ThisActivity:CheckTask",	{TaskVarIdx_UseSilverHammerTime,200,"Ch飝 B筩 v� Ch飝 V祅g Nguy猲 Фn s� d鬾g trong ho箃 ng l莕 n祔 nhi襲 nh蕋 200 l莕","<"} },
		{"PlayerFunLib:CheckItemInBag",	{{tbProp={6,1,2608,1,0,0},},1,format("Kh玭g c� <color=yellow>%s<color> kh玭g th� p tr鴑g","Ch飝 V祅g Nguy猲 Фn")} },
		{"PlayerFunLib:CheckFreeBagCell",	{1,"default"} },
	},
	tbActition = 
	{
		{"PlayerFunLib:GetItem",	{ItemGoldAward,1,format("Ph莕 thng s� d鬾g %s p tr鴑g","Ch飝 V祅g Nguy猲 Фn")} },
		{"ThisActivity:GetGoldExp",	{GoldExpAward,1,format("Ph莕 thng s� d鬾g %s p tr鴑g","Ch飝 V祅g Nguy猲 Фn"),TaskVarIdx_GetGoldExpSum,GoldExpLimit} },
		{"PlayerFunLib:ConsumeEquiproomItem",	{{tbProp={6,1,2608,1,0,0},},1} },
		{"ThisActivity:AddTask",	{TaskVarIdx_UseSilverHammerTime,1} },
	},
}
tbConfig[5] = --一个细节
{
	nId = 5,
	szMessageType = "nil",
	szName = "D飊g Ch飝 B筩 Nguy猲 Фn p tr鴑g",
	nStartDate = nil,
	nEndDate  = nil,
	tbMessageParam = {nil},
	tbCondition = 
	{
		{"PlayerFunLib:CheckTotalLevel",	{80,"default",">="} },
		{"ThisActivity:CheckTask",	{TaskVarIdx_UseSilverHammerTime,200,"Ch飝 B筩 v� Ch飝 V祅g Nguy猲 Фn s� d鬾g trong ho箃 ng l莕 n祔 nhi襲 nh蕋 200 l莕","<"} },
		{"ThisActivity:CheckCondition",	{nil} },
		{"PlayerFunLib:CheckItemInBag",	{{tbProp={6,1,2607,1,0,0},},1,format("Kh玭g c� <color=yellow>%s<color> kh玭g th� p tr鴑g","Ch飝 B筩 Nguy猲 Фn")} },
		{"PlayerFunLib:CheckFreeBagCell",	{1,"default"} },
	},
	tbActition = 
	{
		{"PlayerFunLib:GetItem",	{ItemSilverAward,1,format("Ph莕 thng s� d鬾g %s p tr鴑g","Ch飝 B筩 Nguy猲 Фn")} },
		{"PlayerFunLib:AddExp",	{SilverExpAward,1,format("Ph莕 thng s� d鬾g %s p tr鴑g","Ch飝 B筩 Nguy猲 Фn")} },
		{"PlayerFunLib:ConsumeEquiproomItem",	{{tbProp={6,1,2607,1,0,0},},1} },
		{"ThisActivity:AddTask",	{TaskVarIdx_UseSilverHammerTime,1} },
	},
}
tbConfig[6] = --一个细节
{
	nId = 6,
	szMessageType = "nil",
	szName = "D飊g Ch飝 уng Nguy猲 Фn p tr鴑g",
	nStartDate = nil,
	nEndDate  = nil,
	tbMessageParam = {nil},
	tbCondition = 
	{
		{"PlayerFunLib:CheckTotalLevel",	{80,"default",">="} },
		{"ThisActivity:CheckTaskDaily",	{TaskVarIdx_UseBronzeHammerTime,5,"Ch飝 уng Nguy猲 Фn m鏸 ng祔 ch� s� d鬾g nhi襲 nh蕋 5 l莕","<"} },
		{"ThisActivity:CheckCondition",	{nil} },
		{"PlayerFunLib:CheckItemInBag",	{{tbProp={6,1,2606,1,0,0},},1,format("Kh玭g c� <color=yellow>%s<color> kh玭g th� p tr鴑g","Ch飝 уng Nguy猲 Фn")} },
		{"PlayerFunLib:CheckFreeBagCell",	{1,"default"} },
	},
	tbActition = 
	{
		{"PlayerFunLib:GetItem",	{ItemBronzeAward,1,format("Ph莕 thng s� d鬾g %s p tr鴑g","Ch飝 уng Nguy猲 Фn")} },
		{"PlayerFunLib:AddExp",	{BronzeExpAward,1,format("Ph莕 thng s� d鬾g %s p tr鴑g","Ch飝 уng Nguy猲 Фn")} },
		{"PlayerFunLib:ConsumeEquiproomItem",	{{tbProp={6,1,2606,1,0,0},},1} },
		{"ThisActivity:AddTaskDaily",	{TaskVarIdx_UseBronzeHammerTime,1} },
	},
}
tbConfig[7] = --一个细节
{
	nId = 7,
	szMessageType = "nil",
	szName = "Nh薾 ph莕 thng s� d鬾g Ch飝 B筩 v� Ch飝 V祅g Nguy猲 Фn t n 200 l莕",
	nStartDate = nil,
	nEndDate  = nil,
	tbMessageParam = {nil},
	tbCondition = 
	{
		{"PlayerFunLib:CheckTotalLevel",	{80,"default",">="} },
		{"ThisActivity:CheckTask",	{TaskVarIdx_UseSilverHammerTime,200,"Чi hi謕 ngi ch璦 s� d鬾g  200 l莕 Ch飝 B筩 v� Ch飝 V祅g Nguy猲 Фn, Ti誴 t鬰 c� g緉g nh�!",">="} },
		{"ThisActivity:CheckTask",	{TaskVarIdx_IsGet300Award,0,"B筺   l躰h thng r錳","=="} },
	},
	tbActition = 
	{
		{"PlayerFunLib:AddExp",	{Get300Award,1,"Nh薾 ph莕 thng s� d鬾g Ch飝 B筩 Nguy猲 Фn t n 200 l莕"} },
		{"ThisActivity:AddTask",	{TaskVarIdx_IsGet300Award,1} },
	},
}
tbConfig[8] = --一个细节
{
	nId = 8,
	szMessageType = "Chuanguan",
	szName = format("Ph莕 thng vt 秈 t n %d 秈",17),
	nStartDate = nil,
	nEndDate  = nil,
	tbMessageParam = {"17"},
	tbCondition = 
	{
	},
	tbActition = 
	{
		{"PlayerFunLib:GetItem",	{{tbProp={6,1,2607,1,0,0},nExpiredTime=20110121,},1,format("Ph莕 thng vt 秈 t n %d 秈",17)} },
	},
}
tbConfig[9] = --一个细节
{
	nId = 9,
	szMessageType = "FinishSongJin",
	szName = format("Ph莕 thng 甶觤 t輈h l騳 T鑞g Kim cao c蕄 t n %d",3000),
	nStartDate = nil,
	nEndDate  = nil,
	tbMessageParam = {-2,"3"},
	tbCondition = 
	{
		{"PlayerFunLib:CheckTask",	{"751",3000,"",">="} },
	},
	tbActition = 
	{
		{"PlayerFunLib:GetItem",	{{tbProp={6,1,2607,1,0,0},nExpiredTime=20110121,},1,format("Ph莕 thng 甶觤 t輈h l騳 T鑞g Kim cao c蕄 t n %d",3000)} },
	},
}
tbConfig[10] = --一个细节
{
	nId = 10,
	szMessageType = "ClickNpc",
	szName = "B蕀 v祇 th� luy謓 阯g trng l穙",
	nStartDate = nil,
	nEndDate  = nil,
	tbMessageParam = {"Trng l穙 Th� Luy謓 Л阯g"},
	tbCondition = 
	{
	},
	tbActition = 
	{
		{"AddDialogOpt",	{"Ho箃 ng p Tr鴑g vui v�",25} },
	},
}
tbConfig[11] = --一个细节
{
	nId = 11,
	szMessageType = "NpcOnDeath",
	szName = "Phong L╪g ",
	nStartDate = nil,
	nEndDate  = nil,
	tbMessageParam = {nil},
	tbCondition = 
	{
		{"NpcFunLib:CheckBoatBoss",	{nil} },
	},
	tbActition = 
	{
		{"NpcFunLib:DropSingleItem",	{{tbProp={6,1,2607,1,0,0},nExpiredTime=20110121,},10,"100"} },
	},
}
tbConfig[12] = --一个细节
{
	nId = 12,
	szMessageType = "NpcOnDeath",
	szName = "Nhi謒 v� S竧 th� ",
	nStartDate = nil,
	nEndDate  = nil,
	tbMessageParam = {nil},
	tbCondition = 
	{
		{"NpcFunLib:CheckKillerdBoss",	{90} },
	},
	tbActition = 
	{
		{"PlayerFunLib:GetItem",	{{tbProp={6,1,2607,1,0,0},nExpiredTime=20110121,},2,format("%s ph莕 thng","Nhi謒 v� S竧 th� ")} },
	},
}
tbConfig[13] = --一个细节
{
	nId = 13,
	szMessageType = "CaiJiHuiHuangZhiGuo",
	szName = "Nh苩 qu� huy ho祅g",
	nStartDate = nil,
	nEndDate  = nil,
	tbMessageParam = {nil},
	tbCondition = 
	{
		{"PlayerFunLib:CheckFreeBagCell",	{1,"default"} },
	},
	tbActition = 
	{
		{"PlayerFunLib:GetItem",	{{tbProp={6,1,2607,1,0,0},nExpiredTime=20110121,},1,format("%s ph莕 thng","Nh苩 qu� huy ho祅g")} },
	},
}
tbConfig[14] = --一个细节
{
	nId = 14,
	szMessageType = "NpcOnDeath",
	szName = "Boss Th� Gi韎 r琲 ra",
	nStartDate = nil,
	nEndDate  = nil,
	tbMessageParam = {nil},
	tbCondition = 
	{
		{"NpcFunLib:CheckWorldBoss",	{nil} },
	},
	tbActition = 
	{
		{"NpcFunLib:DropSingleItem",	{{tbProp={6,1,2607,1,0,0},nExpiredTime=20110121,},15,"100"} },
	},
}
tbConfig[15] = --一个细节
{
	nId = 15,
	szMessageType = "nil",
	szName = "Nh薾 Ch飝 B筩 Nguy猲 Фn",
	nStartDate = nil,
	nEndDate  = nil,
	tbMessageParam = {nil},
	tbCondition = 
	{
		{"PlayerFunLib:CheckTotalLevel",	{80,"default",">="} },
		{"ThisActivity:CheckTaskDaily",	{TaskVarIdx_ShiLianTangYinChui,0,format("H玬 nay ngi  nh薾 � ch� c馻 ta %s r錳","Ch飝 B筩 Nguy猲 Фn"),"=="} },
		{"PlayerFunLib:CheckFreeBagCell",	{1,"default"} },
	},
	tbActition = 
	{
		{"PlayerFunLib:GetItem",	{{tbProp={6,1,2607,1,0,0},nExpiredTime=20110121,},2,"Nh薾 � Th� Luy謓 Л阯g"} },
		{"ThisActivity:AddTaskDaily",	{TaskVarIdx_ShiLianTangYinChui,1} },
	},
}
tbConfig[16] = --一个细节
{
	nId = 16,
	szMessageType = "Chuanguan",
	szName = format("Ph莕 thng vt 秈 t n %d 秈",28),
	nStartDate = nil,
	nEndDate  = nil,
	tbMessageParam = {"28"},
	tbCondition = 
	{
	},
	tbActition = 
	{
		{"PlayerFunLib:GetItem",	{{tbProp={6,1,2607,1,0,0},nExpiredTime=20110121,},2,format("Ph莕 thng vt 秈 t n %d 秈",28)} },
	},
}
tbConfig[17] = --一个细节
{
	nId = 17,
	szMessageType = "ClickNpc",
	szName = "B蕀 v祇 L� Quan",
	nStartDate = nil,
	nEndDate  = nil,
	tbMessageParam = {"L� Quan"},
	tbCondition = 
	{
	},
	tbActition = 
	{
		{"AddDialogOpt",	{"Ho箃 ng p Tr鴑g vui v�",24} },
	},
}
tbConfig[18] = --一个细节
{
	nId = 18,
	szMessageType = "nil",
	szName = "Nh薾 M苩 N� D� Dung",
	nStartDate = nil,
	nEndDate  = nil,
	tbMessageParam = {nil},
	tbCondition = 
	{
		{"PlayerFunLib:CheckTotalLevel",	{80,"default",">="} },
		{"ThisActivity:CheckTaskDaily",	{TaskVarIdx_GetYiRongMianJu,0,format("H玬 nay ngi  nh薾 � ch� c馻 ta %s r錳","M苩 N� D� Dung Nguy猲 Фn"),"=="} },
		{"PlayerFunLib:CheckFreeBagCell",	{1,"default"} },
	},
	tbActition = 
	{
		{"ThisActivity:AddTaskDaily",	{TaskVarIdx_GetYiRongMianJu,1} },
		{"PlayerFunLib:GetItem",	{ItemMianJuAward,1,"Nh薾 t� L� Quan"} },
	},
}
tbConfig[19] = --一个细节
{
	nId = 19,
	szMessageType = "nil",
	szName = "Nh薾 Ch飝 уng Nguy猲 Фn",
	nStartDate = nil,
	nEndDate  = nil,
	tbMessageParam = {nil},
	tbCondition = 
	{
		{"PlayerFunLib:CheckTotalLevel",	{80,"default",">="} },
		{"ThisActivity:CheckTaskDaily",	{TaskVarIdx_GetTongChui,0,format("H玬 nay ngi  nh薾 � ch� c馻 ta %s r錳","Ch飝 уng Nguy猲 Фn"),"=="} },
		{"PlayerFunLib:CheckFreeBagCell",	{1,"default"} },
	},
	tbActition = 
	{
		{"ThisActivity:AddTaskDaily",	{TaskVarIdx_GetTongChui,1} },
		{"PlayerFunLib:GetItem",	{{tbProp={6,1,2606,1,0,0},nExpiredTime=20110121,},5,"Nh薾 t� L� Quan"} },
	},
}
tbConfig[20] = --一个细节
{
	nId = 20,
	szMessageType = "ServerStart",
	szName = "Kh雐 ng sever",
	nStartDate = nil,
	nEndDate  = nil,
	tbMessageParam = {nil},
	tbCondition = 
	{
	},
	tbActition = 
	{
		{"ThisActivity:AddYuanDanDialogNpc",	{nil} },
	},
}
tbConfig[21] = --一个细节
{
	nId = 21,
	szMessageType = "CreateDialog",
	szName = "Ph秈 ch╪g s� d鬾g Ch飝 V祅g",
	nStartDate = nil,
	nEndDate  = nil,
	tbMessageParam = {format("Ngi x竎 nh mu鑞 s� d鬾g <color=yellow>%s<color> kh玭g?","Ch飝 V祅g Nguy猲 Фn")},
	tbCondition = 
	{
	},
	tbActition = 
	{
		{"AddDialogOpt",	{"X竎 nh薾",4} },
	},
}
tbConfig[22] = --一个细节
{
	nId = 22,
	szMessageType = "CreateDialog",
	szName = "Ph秈 ch╪g s� d鬾g Ch飝 B筩",
	nStartDate = nil,
	nEndDate  = nil,
	tbMessageParam = {format("Ngi x竎 nh mu鑞 s� d鬾g <color=yellow>%s<color> kh玭g?","Ch飝 B筩 Nguy猲 Фn")},
	tbCondition = 
	{
	},
	tbActition = 
	{
		{"AddDialogOpt",	{"X竎 nh薾",5} },
	},
}
tbConfig[23] = --一个细节
{
	nId = 23,
	szMessageType = "CreateDialog",
	szName = "Ph秈 ch╪g s� d鬾g Ch飝 уng",
	nStartDate = nil,
	nEndDate  = nil,
	tbMessageParam = {format("Ngi x竎 nh mu鑞 s� d鬾g <color=yellow>%s<color> kh玭g?","Ch飝 уng Nguy猲 Фn")},
	tbCondition = 
	{
	},
	tbActition = 
	{
		{"AddDialogOpt",	{"X竎 nh薾",6} },
	},
}
tbConfig[24] = --一个细节
{
	nId = 24,
	szMessageType = "CreateDialog",
	szName = "цi tho筰 L� Quan",
	nStartDate = nil,
	nEndDate  = nil,
	tbMessageParam = {"<npc>Huan ngh猲h tham gia ho箃 ng p Tr鴑g vui v�"},
	tbCondition = 
	{
	},
	tbActition = 
	{
		{"AddDialogOpt",	{"Nh薾 M苩 N� D� Dung",18} },
		{"AddDialogOpt",	{"Nh薾 Ch飝 уng Nguy猲 Фn",19} },
	},
}
tbConfig[25] = --一个细节
{
	nId = 25,
	szMessageType = "CreateDialog",
	szName = "цi tho筰 Trng L穙 Th� Luy謓 Л阯g",
	nStartDate = nil,
	nEndDate  = nil,
	tbMessageParam = {"<npc>Hoan ngh猲h tham gia ho箃 ng p Tr鴑g vui v�"},
	tbCondition = 
	{
	},
	tbActition = 
	{
		{"AddDialogOpt",	{"Nh薾 Ch飝 B筩 Nguy猲 Фn",15} },
	},
}
