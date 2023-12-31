-- 闯关宝箱物品（随机获得一样物品）
-- By: Wangjingjun(2011-03-02)

Include("\\script\\lib\\awardtemplet.lua")
Include("\\script\\vng_event\\change_request_baoruong\\exp_award.lua")
Include("\\script\\lib\\objbuffer_head.lua")
Include("\\script\\task\\metempsychosis\\translife_6.lua")
Include("\\script\\misc\\eventsys\\type\\func.lua")
local  _Message =  function (nItemIndex)
	local handle = OB_Create()
	local msg = format("<color=green>Ch骳 m鮪g cao th� <color=yellow>%s<color=green>  nh薾 頲 <color=yellow><%s><color=green> t� <color=yellow><B秓 Rng Vt 秈><color>" ,GetName(),GetItemName(nItemIndex))
	ObjBuffer:PushObject(handle, msg)
	RemoteExecute("\\script\\event\\msg2allworld.lua", "broadcast", handle)
	OB_Release(handle)
end

tbCOT_Key_Require = {
	["chiakhoanhuy"] = {6, 1, 2744},
	["chiakhoavang"] = {6, 1, 30191},
}
tbCOT_Box_Award = 
{
	["chiakhoanhuy"] = 
	{
		{szName="觤 kinh nghi謒 1", 
					pFun = function (tbItem, nItemCount, szLogTitle)
						%tbvng_ChestExpAward:ExpAward(1000000, "B秓 rng vt 秈")
					end,
					nRate = 52,
		},
		{szName="觤 kinh nghi謒 2", 
					pFun = function (tbItem, nItemCount, szLogTitle)
						%tbvng_ChestExpAward:ExpAward(2000000, "B秓 rng vt 秈")
					end,
					nRate = 30,
		},
		{szName="觤 kinh nghi謒 3", 
					pFun = function (tbItem, nItemCount, szLogTitle)
						%tbvng_ChestExpAward:ExpAward(3000000, "B秓 rng vt 秈")
					end,
					nRate = 10,
		},
		{szName="觤 kinh nghi謒 4", 
					pFun = function (tbItem, nItemCount, szLogTitle)
						%tbvng_ChestExpAward:ExpAward(4000000, "B秓 rng vt 秈")
					end,
					nRate = 5,
		},
		{szName="觤 kinh nghi謒 5", 
					pFun = function (tbItem, nItemCount, szLogTitle)
						%tbvng_ChestExpAward:ExpAward(5000000, "B秓 rng vt 秈")
					end,
					nRate = 3,
		},		
	},	
	-- Thay i ph莕 thng s� d鬾g B秓 rng vt 秈  -Modifiled by ThanhLD - 20140226
	["chiakhoavang"] = 
	{
		-- {szName="Ch﹏ Nguy猲 n",tbProp={6,1,4134,1,0,0},nCount=10,nRate=5},
		-- {szName="Ch﹏ Nguy猲 Кn (trung)",tbProp={6,1,30228,1,0,0},nCount=7,nRate=8,nBindState=-2},
		-- {szName="Ch﹏ Nguy猲 Кn (i)",tbProp={6,1,30229,1,0,0},nCount=7,nRate=5,nBindState=-2},
		-- {szName="H鏽 nguy猲 ch﹏ n",tbProp={6,1,30301,1,0,0},nCount=1,nRate=2},
		-- {szName="H� M筩h Кn",tbProp={6,1,3203,1,0,0},nCount=50,nRate=9.376},
		-- {szName="Huy誸 Long Щng C蕄 9",tbProp={6,1,30289,9,0,0},nCount=5,nRate=1.2},
		-- {szName="Huy誸 Long Щng C蕄 11",tbProp={6,1,30289,11,0,0},nCount=5,nRate=1.1},
		-- {szName="Huy誸 Long Щng C蕄 12",tbProp={6,1,30289,12,0,0},nCount=5,nRate=0.5},
		-- {szName="Tinh Tinh Kho竛g",tbProp={6,1,3811,1,0,0},nCount=1,nRate=1},
		-- {szName="Tinh Thi誸 Kho竛g",tbProp={6,1,3810,1,0,0},nCount=1,nRate=0.5},
		-- {szName = "у Ph� Щng Long Y", tbProp = {6, 1, 30529,1,0,0}, nRate = 0.002,},
		-- {szName = "у Ph� Щng Long Kh� Gi韎", tbProp = {6, 1, 30537,1,0,0}, nRate = 0.001,},
		-- {szName = "Tinh Sng L謓h", tbProp = {6, 1, 30506,1,0,0}, nRate = 0.052,},
		-- {szName = "Huy襫 Thi誸", tbProp = {6, 1, 30507,1,0,0}, nRate = 0.035,},
		-- {szName = "у Ph� Tinh Sng Y", tbProp = {6, 1, 30006,1,0,0}, nRate = 0.320,},
		-- {szName = "у Ph� Tinh Sng Kh� Gi韎", tbProp = {6, 1, 30505,1,0,0}, nRate = 0.23,},
		-- {szName = "у Ph� Nguy謙 Khuy誸 H筺g Li猲", tbProp = {6, 1, 30329,1,0,0}, nRate = 0.0052},
		-- {szName = "у Ph� Nguy謙 Khuy誸 Kh玦", tbProp = {6, 1, 30330,1,0,0}, nRate = 0.0035},
		-- {szName = "у Ph� Nguy謙 Khuy誸 Thng Gi韎 Ch�", tbProp = {6, 1, 30331,1,0,0}, nRate = 0.0052},
		-- {szName = "у Ph� Nguy謙 Khuy誸 H� Uy觧", tbProp = {6, 1, 30332,1,0,0}, nRate = 0.0052},
		-- {szName = "у Ph� Nguy謙 Khuy誸 Y猽 Цi", tbProp = {6, 1, 30333,1,0,0}, nRate = 0.0052},
		-- {szName = "у Ph� Nguy謙 Khuy誸 Y", tbProp = {6, 1, 30334,1,0,0}, nRate = 0.0022},
		-- {szName = "у Ph� Nguy謙 Khuy誸 Kh� Gi韎", tbProp = {6, 1, 30335,1,0,0}, nRate = 0.0013},
		-- {szName = "у Ph� Nguy謙 Khuy誸 H礽", tbProp = {6, 1, 30336,1,0,0}, nRate = 0.0052},	
		-- {szName = "у Ph� Nguy謙 Khuy誸 B閕", tbProp = {6, 1, 30337,1,0,0}, nRate = 0.0052},	
		-- {szName = "у Ph� Nguy謙 Khuy誸 H� Gi韎 Ch�", tbProp = {6, 1, 30338,1,0,0}, nRate = 0.0052},
		{szName="觤 kinh nghi謒 1", 
					pFun = function (tbItem, nItemCount, szLogTitle)
						%tbvng_ChestExpAward:ExpAward(2000000,"B秓 rng vt 秈")
					end,
					nRate = 27.3436,
		},
		{szName="觤 kinh nghi謒 2", 
					pFun = function (tbItem, nItemCount, szLogTitle)
						%tbvng_ChestExpAward:ExpAward(4000000,"B秓 rng vt 秈")
					end,
					nRate = 16,
		},
		{szName="觤 kinh nghi謒 3", 
					pFun = function (tbItem, nItemCount, szLogTitle)
						%tbvng_ChestExpAward:ExpAward(5000000,"B秓 rng vt 秈")
					end,
					nRate = 12,
		},
		{szName="觤 kinh nghi謒 4", 
					pFun = function (tbItem, nItemCount, szLogTitle)
						%tbvng_ChestExpAward:ExpAward(6000000,"B秓 rng vt 秈")
					end,
					nRate = 6,
		},
		{szName="觤 kinh nghi謒 5", 
					pFun = function (tbItem, nItemCount, szLogTitle)
						%tbvng_ChestExpAward:ExpAward(8000000,"B秓 rng vt 秈")
					end,
					nRate = 4,
		},	
		{szName="觤 kinh nghi謒 6", 
					pFun = function (tbItem, nItemCount, szLogTitle)
						%tbvng_ChestExpAward:ExpAward(10000000,"B秓 rng vt 秈")
					end,
					nRate = 2,
		},
	},
}

nWidth = 1
nHeight = 1
nFreeItemCellLimit = 1

function main(nIndexItem)	
	local tbKey1 = tbCOT_Key_Require["chiakhoanhuy"]
	local tbKey2 = tbCOT_Key_Require["chiakhoavang"]
	local nCount1 = CalcItemCount(3, tbKey1[1], tbKey1[2], tbKey1[3], -1) 
	local nCount2 = CalcItemCount(3, tbKey2[1], tbKey2[2], tbKey2[3], -1) 
	if nCount1 == 0 and nCount2 == 0 then
		Say("C莕 ph秈 c� Ch譨 Kh鉧 V祅g ho芻 Ch譨 Kh鉧 Nh� � m韎 c� th� m� 頲 B秓 Rng Vt 秈", 1, "сng/no")
		return 1
	end

	if CountFreeRoomByWH(nWidth, nHeight, nFreeItemCellLimit) < nFreeItemCellLimit then
		Say(format("в b秓 m t礽 s秐 c馻 i hi謕, xin h穣  tr鑞g %d %dx%d h祅h trang", nFreeItemCellLimit, nWidth, nHeight))
		return 1
	end	
	local tbOpt = {}
	if nCount1 ~= 0 then
		tinsert(tbOpt,format("S� d鬾g Ch譨 kh鉧 nh� �/#VnCOTBoxNewAward(%d, '%s')", nIndexItem, "chiakhoanhuy"))
	end
	if nCount2 ~= 0 then
		tinsert(tbOpt,format("S� d鬾g Ch譨 kh鉧 v祅g/#VnCOTBoxNewAward(%d, '%s')", nIndexItem, "chiakhoavang"))
	end
	if getn(tbOpt) > 0 then
		tinsert(tbOpt, "сng/Oncancel")
		Say("S� d鬾g ch譨 kh鉧  m� rng:", getn(tbOpt), tbOpt)
	end
	return 1
end

function Oncancel()end

function VnCOTBoxNewAward(nItemIdx, strKeyType)
	local tbKey = tbCOT_Key_Require[strKeyType]
	local tbAward = tbCOT_Box_Award[strKeyType]
	if not tbKey or not tbAward then
		return
	end
	if ConsumeItem(3, 1, tbKey[1], tbKey[2], tbKey[3], -1) ~= 1 then
		Say("C莕 ph秈 c� Ch譨 Kh鉧 V祅g ho芻 Ch譨 Kh鉧 Nh� � m韎 c� th� m� 頲 B秓 Rng Vt 秈", 1, "сng/no")
		return
	end
	
	if ConsumeItem(3, 1, 6, 1, 2742, -1) ~= 1 then
		Say("Kh玭g t譵 th蕐 B秓 Rng Vt 秈", 1, "сng/no")
		return
	end
	
	if strKeyType == "chiakhoavang" then
		%TransLife6:OnFinishEvent(%TASK_ID_BOX)
	end
	
	tbAwardTemplet:Give(tbAward, 1, {"chuangguan", "use chuangguanbaoxiang"})
	AddStatData("baoxiangxiaohao_kaichuangguanbaoxiang", 1)	--数据埋点第一期
	EventSys:GetType("OpenFuncAwardBox"):OnPlayerEvent("OpenAwardBoxEvent", PlayerIndex)
end
