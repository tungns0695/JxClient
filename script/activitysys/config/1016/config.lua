Include("\\script\\activitysys\\config\\1016\\variables.lua")
Include("\\script\\activitysys\\config\\1016\\awardlist.lua")
Include("\\script\\activitysys\\config\\1016\\extend.lua")
tbConfig = {}
tbConfig[1] = --Цnh qu竔 r韙 Item
{
	nId = 1,
	szMessageType = "NpcOnDeath",	
	szName = "B秐  nh qu竔 nh薾 Lam Th筩h",
	nStartDate = nil,
	nEndDate  = nil,
	tbMessageParam = {nil},
	tbCondition = 
	{
		{"PlayerFunLib:CheckTotalLevel",	{150,"",">="} },
		{"NpcFunLib:CheckInMap",	{"75,321,322,340,225,226,227"} },
	},
	tbActition = 
	{
		{"NpcFunLib:DropSingleItem",	{ITEM_MATERIAL_2,1,"8"} },		
	},
}
tbConfig[2] = --一个细节
{
	nId = 2,
	szMessageType = "FinishSongJin",
	szName = "songjin mark>=1000",
	nStartDate = nil,
	nEndDate  = nil,
	tbMessageParam = {-2,"3"},
	tbCondition = 
	{
		{"PlayerFunLib:CheckTotalLevel",	{150,"",">="} },
		{"PlayerFunLib:CheckTask",	{"751",1000,"",">="} },
	},
	tbActition = 
	{
		{"PlayerFunLib:GetItem",	{ITEM_MATERIAL_3,30,EVENT_LOG_TITLE,"TongKim1000"} },
	},
}
tbConfig[3] = --一个细节
{
	nId = 3,
	szMessageType = "Chuanguan",
	szName = "K誸 th骳 m鏸 秈",
	nStartDate = nil,
	nEndDate  = nil,
	tbMessageParam = {nil},
	tbCondition = 
	{
		{"PlayerFunLib:CheckTotalLevel",	{150,"",">="} },
	},
	tbActition = 
	{
		{"PlayerFunLib:GetItem",	{ITEM_MATERIAL_3,1,EVENT_LOG_TITLE,"VuotquamoiAi"} },
	},
}
tbConfig[4] = --vt 秈 17
{
	nId = 4,
	szMessageType = "Chuanguan",
	szName = "chuangguan_17",
	nStartDate = nil,
	nEndDate  = nil,
	tbMessageParam = {"17"},
	tbCondition = 
	{
		{"PlayerFunLib:CheckTotalLevel",	{150,"",">="} },
	},
	tbActition = 
	{
		{"PlayerFunLib:GetItem",	{ITEM_MATERIAL_3,5,EVENT_LOG_TITLE,"VuotAi17"} },
	},
}
tbConfig[5] = --vt 秈 28
{
	nId = 5,
	szMessageType = "Chuanguan",
	szName = "chuangguan_28",
	nStartDate = nil,
	nEndDate  = nil,
	tbMessageParam = {"28"},
	tbCondition = 
	{
		{"PlayerFunLib:CheckTotalLevel",	{150,"",">="} },
	},
	tbActition = 
	{
		{"PlayerFunLib:GetItem",	{ITEM_MATERIAL_3,5,EVENT_LOG_TITLE,"VuotAi28"} },
	},
}
tbConfig[6] =
{
	nId = 6,
	szMessageType = "FinishFengLingDu",
	szName = "FinishFengLingDu",
	nStartDate = nil,
	nEndDate  = nil,
	tbMessageParam = {nil},
	tbCondition = 
	{
		{"PlayerFunLib:CheckTotalLevel",	{150,"",">="} },
	},
	tbActition = 
	{
		{"PlayerFunLib:GetItem",	{ITEM_MATERIAL_3,5,EVENT_LOG_TITLE,"HoanThanhPLD"} },
	},
}
tbConfig[7] =
{
	nId = 7,
	szMessageType = "NpcOnDeath",
	szName = "kill_boat_boss",
	nStartDate = nil,
	nEndDate  = nil,
	tbMessageParam = {nil},
	tbCondition = 
	{
		{"PlayerFunLib:CheckTotalLevel",	{150,"",">="} },
		{"NpcFunLib:CheckBoatBoss",	{nil} },		
	},
	tbActition = 
	{
		{"PlayerFunLib:GetItem",	{ITEM_MATERIAL_3,5,EVENT_LOG_TITLE,"TieuDietThuyTacDauLinh"} },
	},
}
tbConfig[8] =
{
	nId = 8,
	szMessageType = "NpcOnDeath",
	szName = "kill_boat_big_boss",
	nStartDate = nil,
	nEndDate  = nil,
	tbMessageParam = {nil},
	tbCondition = 
	{
		{"NpcFunLib:CheckId",	{"1692"} },
		{"PlayerFunLib:CheckTotalLevel",	{150,"",">="} },
	},
	tbActition = 
	{
		{"PlayerFunLib:GetItem",	{ITEM_MATERIAL_3,10,EVENT_LOG_TITLE,"TieuDietThuyTacDaiDauLinh"} },
	},
}
tbConfig[9] =
{
	nId = 9,
	szMessageType = "YDBZguoguan",
	szName = "YanDi",
	nStartDate = nil,
	nEndDate  = nil,
	tbMessageParam = {nil},
	tbCondition = 
	{
		{"PlayerFunLib:CheckTotalLevel",	{150,"",">="} },
	},
	tbActition = 
	{
		{"PlayerFunLib:GetItem",	{ITEM_MATERIAL_3,2,EVENT_LOG_TITLE,"QuaAiViemDe"} },
	},
}
tbConfig[10] =
{
	nId = 10,
	szMessageType = "YDBZguoguan",
	szName = "YanDi 10",
	nStartDate = nil,
	nEndDate  = nil,
	tbMessageParam = {10},
	tbCondition = 
	{
		{"PlayerFunLib:CheckTotalLevel",	{150,"",">="} },
	},
	tbActition = 
	{
		{"PlayerFunLib:GetItem",	{ITEM_MATERIAL_3,10,EVENT_LOG_TITLE,"QuaAi10ViemDe"} },
	},
}
tbConfig[11] =
{
	nId = 11,
	szMessageType = "NpcOnDeath",
	szName = "killer boss",
	nStartDate = nil,
	nEndDate  = nil,
	tbMessageParam = {nil},
	tbCondition = 
	{
		{"NpcFunLib:CheckKillerdBoss",	{90} },
		{"PlayerFunLib:CheckTotalLevel",	{150,"",">="} },
	},
	tbActition = 
	{
		{"PlayerFunLib:GetItem",	{ITEM_MATERIAL_3,10,EVENT_LOG_TITLE,"HoanThanhBossST90"} },
	},
}

--Chuong Dang Cung Nu
tbConfig[12] = 
{
	nId = 12,
	szMessageType = "ClickNpc",
	szName = "click lingfan",
	nStartDate = nil,
	nEndDate  = nil,
	tbMessageParam = {"Chng Жng Cung N�"},
	tbCondition = 
	{
		{"PlayerFunLib:CheckTotalLevel",	{150,"",">="} },
	},
	tbActition = 
	{
		{"SetDialogTitle",	{"Th竛g 7 nhi襲 ho箃 ng s玦 n鎖, h穣 nhanh ch﹏ n ch�  tham gia ho箃 ng gh衟 Tinh Th筩h  nh薾 nhi襲 ph莕 thng h蕄 d蒼."} },			
		{"AddDialogOpt",	{format("Mua %s",ITEM_MATERIAL_1.szName),13} },
		{"AddDialogOpt",	{"Gh衟 Nguy猲 Li謚 ",14} },
		{"AddDialogOpt",	{"Nh薾 thng m鑓 s� d鬾g Huy襫 B╪g Tinh",24} },
	},
}
tbConfig[13] = 
{
	nId = 13,
	szMessageType = "CreateCompose",
	szName = "Mua Huy襫 Tinh Th筩h",
	nStartDate = nil,
	nEndDate  = nil,
	tbMessageParam = {ITEM_MATERIAL_1.szName,1,1,1,0.04,0,250},	
	tbCondition = 
	{
		{"PlayerFunLib:CheckTotalLevel",	{150,"",">="} },
		{"AddOneMaterial",	{MONEY.szName,MONEY,20000} },
	},
	tbActition = 
	{
		{"PlayerFunLib:GetItem",	{ITEM_MATERIAL_1,1,EVENT_LOG_TITLE,"MuaHuyenTinhThach"} },
	},
}

tbConfig[14] =
{
	nId = 14,
	szMessageType = "CreateDialog",
	szName = "Ghep phan thuong",
	nStartDate = nil,
	nEndDate  = nil,
	tbMessageParam = {"<npc>Xin ch鋘 lo筰 ph莕 thng?"},
	tbCondition = 
	{
		{"PlayerFunLib:CheckTotalLevel",	{150,"",">="} },
	},
	tbActition = 
	{		
		{"AddDialogOpt",	{"Gh衟 Ti觰 Lam B╪g Tinh",15} },
		{"AddDialogOpt",	{"Gh衟 Чi Lam B╪g Tinh",16} },
		{"AddDialogOpt",	{"Gh衟 Ti觰 Ho祅g B╪g Tinh",17} },
		{"AddDialogOpt",	{"Gh衟 Чi Ho祅g B╪g Tinh",18} },
		{"AddDialogOpt",	{"Gh衟 Ti觰 Huy襫 B╪g Tinh",19} },
		{"AddDialogOpt",	{"Gh衟 Чi Huy襫 B╪g Tinh",20} },
	},
}
tbConfig[15] = 
{
	nId = 15,
	szMessageType = "CreateCompose",
	szName = "Ta mu鑞 Gh衟 Ti觰 Lam B╪g Tinh",
	nStartDate = nil,
	nEndDate  = nil,
	tbMessageParam = {"Ti觰 Lam B╪g Tinh",1,1,1,0.04},
	tbCondition = 
	{
		{"PlayerFunLib:CheckTotalLevel",	{150,"Ъng c蕄 c馻 ngi kh玭g , l莕 sau h穣 n nh�!",">="} },		
		{"AddOneMaterial",	{ITEM_MATERIAL_1.szName,ITEM_MATERIAL_1,1} },
		{"AddOneMaterial",	{ITEM_MATERIAL_2.szName,ITEM_MATERIAL_2,1} },
	},
	tbActition = 
	{
		{"PlayerFunLib:GetItem",	{ITEM_AWARD_1,1,EVENT_LOG_TITLE,"GhepTieuLamBangTinh"} },
	},
}
tbConfig[16] = 
{
	nId = 16,
	szMessageType = "CreateCompose",
	szName = "Ta mu鑞 Gh衟 Чi Lam B╪g Tinh",
	nStartDate = nil,
	nEndDate  = nil,
	tbMessageParam = {"Чi Lam B╪g Tinh",1,1,1,0.04},
	tbCondition = 
	{
		{"PlayerFunLib:CheckTotalLevel",	{150,"Ъng c蕄 c馻 ngi kh玭g , l莕 sau h穣 n nh�!",">="} },
			{"AddOneMaterial",	{ITEM_MATERIAL_1.szName,ITEM_MATERIAL_1,1} },
			{"AddOneMaterial",	{ITEM_MATERIAL_2.szName,ITEM_MATERIAL_2,1} },		
	},
	tbActition = 
	{
		{"PlayerFunLib:GetItem",	{ITEM_AWARD_2,1,EVENT_LOG_TITLE,"GhepDaiLamBangTinh"} },
	},
}

tbConfig[17] = 
{
	nId = 17,
	szMessageType = "CreateCompose",
	szName = "Ta mu鑞 Gh衟 Ti觰 Ho祅g B╪g Tinh",
	nStartDate = nil,
	nEndDate  = nil,
	tbMessageParam = {"Ti觰 Ho祅g B╪g Tinh",1,1,1,0.04},
	tbCondition = 
	{
		{"PlayerFunLib:CheckTotalLevel",	{150,"Ъng c蕄 c馻 ngi kh玭g , l莕 sau h穣 n nh�!",">="} },
			{"AddOneMaterial",	{ITEM_MATERIAL_1.szName,ITEM_MATERIAL_1,1} },
			{"AddOneMaterial",	{ITEM_MATERIAL_3.szName,ITEM_MATERIAL_3,1} },		
	},
	tbActition = 
	{
		{"PlayerFunLib:GetItem",	{ITEM_AWARD_3,1,EVENT_LOG_TITLE,"GhepTieuHoangBangTinh"} },
	},
}
tbConfig[18] = 
{
	nId = 18,
	szMessageType = "CreateCompose",
	szName = "Ta mu鑞 Gh衟 Чi Ho祅g B╪g Tinh",
	nStartDate = nil,
	nEndDate  = nil,
	tbMessageParam = {"Чi Ho祅g B╪g Tinh",1,1,1,0.04},
	tbCondition = 
	{
		{"PlayerFunLib:CheckTotalLevel",	{150,"Ъng c蕄 c馻 ngi kh玭g , l莕 sau h穣 n nh�!",">="} },
			{"AddOneMaterial",	{ITEM_MATERIAL_1.szName,ITEM_MATERIAL_1,1} },
			{"AddOneMaterial",	{ITEM_MATERIAL_3.szName,ITEM_MATERIAL_3,1} },		
	},
	tbActition = 
	{
		{"PlayerFunLib:GetItem",	{ITEM_AWARD_4,1,EVENT_LOG_TITLE,"GhepDaiHoangBangTinh"} },
	},
}
tbConfig[19] = 
{
	nId = 19,
	szMessageType = "CreateCompose",
	szName = "Ta mu鑞 Gh衟 Ti觰 Huy襫 B╪g Tinh",
	nStartDate = nil,
	nEndDate  = nil,
	tbMessageParam = {"Ti觰 Huy襫 B╪g Tinh",1,1,1,0.04},
	tbCondition = 
	{
		{"PlayerFunLib:CheckTotalLevel",	{150,"Ъng c蕄 c馻 ngi kh玭g , l莕 sau h穣 n nh�!",">="} },
			{"AddOneMaterial",	{ITEM_MATERIAL_2.szName,ITEM_MATERIAL_2,1} },
			{"AddOneMaterial",	{ITEM_MATERIAL_4.szName,ITEM_MATERIAL_4,1} },		
	},
	tbActition = 
	{
		{"PlayerFunLib:GetItem",	{ITEM_AWARD_5,1,EVENT_LOG_TITLE,"GhepTieuHuyenBangTinh"} },
	},
}
tbConfig[20] =
{
	nId = 20,
	szMessageType = "CreateCompose",
	szName = "Ta mu鑞 Gh衟 Чi Huy襫 B╪g Tinh",
	nStartDate = nil,
	nEndDate  = nil,
	tbMessageParam = {" Чi Huy襫 B╪g Tinh",1,1,1,0.04},
	tbCondition = 
	{
		{"PlayerFunLib:CheckTotalLevel",	{150,"Ъng c蕄 c馻 ngi kh玭g , l莕 sau h穣 n nh�!",">="} },
			{"AddOneMaterial",	{ITEM_MATERIAL_2.szName,ITEM_MATERIAL_2,1} },
			{"AddOneMaterial",	{ITEM_MATERIAL_4.szName,ITEM_MATERIAL_4,1} },		
	},
	tbActition = 
	{
		{"PlayerFunLib:GetItem",	{ITEM_AWARD_6,1,EVENT_LOG_TITLE,"GhepDaiHuyenBangTinh"} },
	},
}
--S� d鬾g Item
tbConfig[21] = 
{
	nId = 21,
	szMessageType = "ItemScript",
	szName = "S� d鬾g Ti觰 Lam B╪g Tinh",
	nStartDate = nil,
	nEndDate  = nil,
	tbMessageParam = {ITEM_AWARD_1},
	tbCondition = 
	{
		{"PlayerFunLib:CheckTotalLevel",	{150,"default",">="} },				
		{"tbVNG_BitTask_Lib:CheckBitTaskValue", {tbBITTSK_LIMIT_1, 1000, "S� d鬾g v藅 ph萴 qu� gi韎 h筺, kh玭g th� s� d鬾g th猰", "<"}},	
	},
	tbActition = 
	{		
		{"tbVNG_BitTask_Lib:addTask", {tbBITTSK_LIMIT_1, 1}},
		{"PlayerFunLib:AddExp",	{1e6,0,EVENT_LOG_TITLE,"SuDungTieuLamBangTinh"} },
	},
}
tbConfig[22] = 
{
	nId = 22,
	szMessageType = "ItemScript",
	szName = "S� d鬾g Ti觰 Ho祅g B╪g Tinh",
	nStartDate = nil,
	nEndDate  = nil,
	tbMessageParam = {ITEM_AWARD_3},
	tbCondition = 
	{
		{"PlayerFunLib:CheckTotalLevel",	{150,"default",">="} },				
		{"tbVNG_BitTask_Lib:CheckBitTaskValue", {tbBITTSK_LIMIT_2, 2000, "S� d鬾g v藅 ph萴 qu� gi韎 h筺, kh玭g th� s� d鬾g th猰", "<"}},	
	},
	tbActition = 
	{		
		{"tbVNG_BitTask_Lib:addTask", {tbBITTSK_LIMIT_2, 1}},
		{"PlayerFunLib:AddExp",	{2e6,0,EVENT_LOG_TITLE,"SuDungTieuHoangBangTinh"} },
	},
}
tbConfig[23] = 
{
	nId = 23,
	szMessageType = "ItemScript",
	szName = "S� d鬾g Ti觰 Huy襫 B╪g Tinh",
	nStartDate = nil,
	nEndDate  = nil,
	tbMessageParam = {ITEM_AWARD_5},
	tbCondition = 
	{
		{"PlayerFunLib:CheckTotalLevel",	{150,"default",">="} },				
		{"tbVNG_BitTask_Lib:CheckBitTaskValue", {tbBITTSK_LIMIT_3, 15000, "S� d鬾g v藅 ph萴 qu� gi韎 h筺, kh玭g th� s� d鬾g th猰", "<"}},
		{"PlayerFunLib:CheckFreeBagCellWH",	{2,4,1,"default"} },
	},
	tbActition = 
	{		
		{"tbVNG_BitTask_Lib:addTask", {tbBITTSK_LIMIT_3_COUNT, 1}},	
		{"ThisActivity:UseTieuHuyenBT",	{nil} },	
	},
}
--Nhan thuong moc su dung
tbConfig[24] =
{
	nId = 24,
	szMessageType = "CreateDialog",
	szName = "Ghep phan thuong",
	nStartDate = nil,
	nEndDate  = nil,
	tbMessageParam = {"<npc>S� d鬾g Ti觰 Huy襫 B╪g Tinh v� Чi Ho祅g B╪g Tinh t t鎛g s� 500, 1000, 2000 n y ta s� t苙g th猰 ph莕 thng cho c竎 h�, Hi謓 t筰 c竎 h�  s� d鬾g 頲: <color=yellow><lua GetBitTask(3013, 17, 12) /><color> c竔"},
	tbCondition = 
	{
		{"PlayerFunLib:CheckTotalLevel",	{150,"",">="} },
	},
	tbActition = 
	{		
		{"AddDialogOpt",	{"Nh薾 thng m鑓 500",25} },
		{"AddDialogOpt",	{"Nh薾 thng m鑓 1000",26} },
		{"AddDialogOpt",	{"Nh薾 thng m鑓 2000",27} },
	},
}
tbConfig[25] = 
{
	nId = 25,
	szMessageType = "nil",
	szName = "Thng t m鑓 500  Huy襫 B╪g Tinh",
	nStartDate = nil,
	nEndDate  = nil,
	tbMessageParam = {nil},
	tbCondition = 
	{			
		{"tbVNG_BitTask_Lib:CheckBitTaskValue",	{tbBITTSK_LIMIT_3_COUNT,500,"Y猽 c莡 s� d鬾g t鎛g Ti觰 Huy襫 B╪g Tinh v� Чi Huy襫 B╪g Tinh <color=red>500<color> l莕 tr� l猲 m韎 nh薾 頲 ph莕 thng n祔.",">="} },
		{"tbVNG_BitTask_Lib:CheckBitTaskValue",	{tbTSK_INFO_1,0,"Ngi  nh薾 ph莕 thng n祔 r錳","=="} },
		{"PlayerFunLib:CheckFreeBagCellWH",	{1,1,1,"default"} },
	},
	tbActition = 
	{		
		{"tbVNG_BitTask_Lib:setBitTask",	{tbTSK_INFO_1,1} },
		{"PlayerFunLib:GetItem",	{tbAward_Limit_Old["500"],1,EVENT_LOG_TITLE,"NhanThuongSuDung500Lan"} },
	},
}
tbConfig[26] = 
{
	nId = 26,
	szMessageType = "nil",
	szName = "Thng t m鑓 1000  Huy襫 B╪g Tinh",
	nStartDate = nil,
	nEndDate  = nil,
	tbMessageParam = {nil},
	tbCondition = 
	{			
		{"tbVNG_BitTask_Lib:CheckBitTaskValue",	{tbBITTSK_LIMIT_3_COUNT,1000,"Y猽 c莡 s� d鬾g t鎛g Ti觰 Huy襫 B╪g Tinh v� Чi Huy襫 B╪g Tinh <color=red>1000<color> l莕 tr� l猲 m韎 nh薾 頲 ph莕 thng n祔.",">="} },
		{"tbVNG_BitTask_Lib:CheckBitTaskValue",	{tbTSK_INFO_2,0,"Ngi  nh薾 ph莕 thng n祔 r錳","=="} },
		{"PlayerFunLib:CheckFreeBagCellWH",	{1,1,1,"default"} },
	},
	tbActition = 
	{		
		{"tbVNG_BitTask_Lib:setBitTask",	{tbTSK_INFO_2,1} },
		{"PlayerFunLib:GetItem",	{tbAward_Limit_Old["1000"],1,EVENT_LOG_TITLE,"NhanThuongSuDung1000Lan"} },
	},
}
tbConfig[27] = 
{
	nId = 27,
	szMessageType = "nil",
	szName = "Thng t m鑓 2000  Huy襫 B╪g Tinh",
	nStartDate = nil,
	nEndDate  = nil,
	tbMessageParam = {nil},
	tbCondition = 
	{			
		{"tbVNG_BitTask_Lib:CheckBitTaskValue",	{tbBITTSK_LIMIT_3_COUNT,2000,"Y猽 c莡 s� d鬾g t鎛g Ti觰 Huy襫 B╪g Tinh v� Чi Huy襫 B╪g Tinh <color=red>2000<color> l莕 tr� l猲 m韎 nh薾 頲 ph莕 thng n祔.",">="} },
		{"tbVNG_BitTask_Lib:CheckBitTaskValue",	{tbTSK_INFO_3,0,"Ngi  nh薾 ph莕 thng n祔 r錳","=="} },
		{"PlayerFunLib:CheckFreeBagCellWH",	{1,1,1,"default"} },
	},
	tbActition = 
	{		
		{"tbVNG_BitTask_Lib:setBitTask",	{tbTSK_INFO_3,1} },
		{"PlayerFunLib:GetItem",	{tbAward_Limit_Old["2000"],1,EVENT_LOG_TITLE,"NhanThuongSuDung2000Lan"} },
	},
}