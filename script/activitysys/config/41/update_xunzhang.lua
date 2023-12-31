Include("\\script\\lib\\composeex.lua")
Include("\\script\\activitysys\\config\\41\\head.lua")
Include("\\script\\activitysys\\config\\41\\variables.lua")
Include("\\script\\dailogsys\\g_dialog.lua")
Include("\\script\\lib\\log.lua")
Include("\\script\\lib\\progressbar.lua")

tbMaterial_Medal = {
	[1]={szName="Huy Hi謚 c蕄 1",tbProp={6,1,3133,1,0,0},nExpiredTime=20120501,nCount=2,},
	[2]={szName="Huy Hi謚 c蕄 2",tbProp={6,1,3134,1,0,0},nExpiredTime=20120501,nCount=1,},
	}
tbMaterial_Shijin = {szName="Th筩h Kim",tbProp={6,1,3136,1,0,0},nExpiredTime=20120501,nCount=1,}
	
tbProduct = {
	[1] = {szName="Huy Hi謚 c蕄 2",tbProp={6,1,3134,1,0,0},nExpiredTime=20120501,},
	[2] = {szName="Huy Hi謚 c蕄 3",tbProp={6,1,3135,1,0,0},nExpiredTime=20120501,}
	}

tbMedalLevelUpRate = {50,35 }	

tbMedalLog = {
	[1] = {
		szSuccess = "NangcapThanhCongHuyHieuCap2",
		szFail = "NangcapThatBaiHuyHieuCap2",
		},
	[2] = {
		szSuccess = "NangcapThanhCongHuyHieuCap3",
		szFail = "NangcapThatBaiHuyHieuCap3",
		},
	}

pActivity.tbUpdateCompose = {}
tbUpdateXunZhang = tbActivityCompose:new()

function tbUpdateXunZhang:ComposeDailog()
	--如果输入为空，使用默认值
	if self.nRoomType == INVENTORY_ROOM.room_giveitem then
		return self:ComposeGiveUI()
	end
	local tbMaterial = self.tbFormula.tbMaterial
	local tbProduct = self.tbFormula.tbProduct
	
	local szComposeTitle = self.tbFormula.szComposeTitle or format("фi %s", tbProduct.szName)
	
	local szMsg = format("%s y猽 c莡: <enter>%s", szComposeTitle ,self:GetMaterialList(tbMaterial))
	local tbOpt = {}
	tbOpt[1] = {"X竎 nh薾", self.OpenProgressBar, {self}}
	tbOpt[2] = {"H駓 b� "}
	CreateNewSayEx(szMsg, tbOpt)
	
end


function tbUpdateXunZhang:OpenProgressBar()
	local tbMaterial	= self.tbFormula.tbMaterial
	local nComposeCount = 1
	if self:CheckMaterial(tbMaterial, nComposeCount) ~=1 then
		local szMsg = self.tbFormula.szFailMsg or "<color=red>Чi hi謕 mang nguy猲 li謚 kh玭g  r錳!<color>"
		Talk(1, "", szMsg)
		return 0;
	end
	
	DynamicExecuteByPlayer(PlayerIndex, "\\script\\activitysys\\config\\41\\update_xunzhang.lua",  "tbProgressBar:OpenByConfig", 14, self.WantCompose, {self, GetName()})
end

function tbUpdateXunZhang:CanCompose()
	local nRate = random(1,100)
	if nRate <= self.tbFormula.nRate then
		return 1
	else
		return 0
	end
end

function tbUpdateXunZhang:WantCompose(szName)
	local nPlayerIndex = SearchPlayer(szName)
	if nPlayerIndex <= 0 then
		return 
	end
	CallPlayerFunction(nPlayerIndex, self.Compose, self)
end

function tbUpdateXunZhang:Compose()
	local tbMaterial	= self.tbFormula.tbMaterial
	local tbProduct		= self.tbFormula.tbProduct
	
	nComposeCount = nComposeCount or 1
	
	if type(self.tbFormula.pLimitFun) == "function" then
		if self.tbFormula:pLimitFun(nComposeCount) ~= 1 then
			return 0
		end
	end
	local nFreeItemCellLimit = self.tbFormula.nFreeItemCellLimit or 1
	nFreeItemCellLimit = ceil(nFreeItemCellLimit * nComposeCount)
	
	if self.tbFormula.nWidth ~= 0 and self.tbFormula.nHeight ~= 0 and CountFreeRoomByWH(self.tbFormula.nWidth, self.tbFormula.nHeight, nFreeItemCellLimit) < nFreeItemCellLimit then
		Say(format("в b秓 m t礽 s秐 c馻 i hi謕, xin h穣  tr鑞g %d %dx%d h祅h trang", nFreeItemCellLimit, self.tbFormula.nWidth, self.tbFormula.nHeight))
		return 0
	end
	if self:CheckMaterial(tbMaterial, nComposeCount) ~=1 then
		local szMsg = self.tbFormula.szFailMsg or "<color=red>Чi hi謕 mang nguy猲 li謚 kh玭g  r錳!<color>"
		Talk(1, "", szMsg)
		return 0;
	end
	if self:ConsumeMaterial(tbMaterial, nComposeCount, self.szLogTitle) ~= 1 then
		Msg2Player("Ch� t筼 th蕋 b筰, m蕋 甶 m閠 s� nguy猲 li謚.")
		return 0;
	end
	local bSuccess = self:CanCompose()
	if bSuccess == 0 then
		%tbLog:PlayerAwardLog(%EVENT_LOG_TITLE, self.tbFormula.tbLog.szFail)
		Msg2Player("Th藅 ng ti誧, n﹏g c蕄 th蕋 b筰")
		return 0
	else
		%tbLog:PlayerAwardLog(%EVENT_LOG_TITLE, self.tbFormula.tbLog.szSuccess)
		Msg2Player("Ch骳 m鮪g, n﹏g c蕄 th祅h c玭g")
	end
	
	if type(tbProduct) == "table" then
		tbAwardTemplet:GiveAwardByList(tbProduct, self.szLogTitle, nComposeCount)
	end
	
	if type(self.tbFormula.pProductFun) == "function" then
		
		self.tbFormula:pProductFun(nComposeCount)

	end
	return 1;
end
function pActivity:InitUpdateCompose()
	self.tbUpdateCompose = {}
	for nType=1,getn(%tbMaterial_Medal) do
		tbFormulaList = {	
			nWidth = 1,
			nHeight = 1,
			nFreeItemCellLimit = 0.02,
			}
		tbFormulaList.tbMaterial = {}
		tbFormulaList.tbProduct = {}
		tinsert(tbFormulaList.tbMaterial, %tbMaterial_Medal[nType])
		tinsert(tbFormulaList.tbMaterial, %tbMaterial_Shijin)
		
		tbFormulaList.tbProduct = %tbProduct[nType]
		tbFormulaList.nRate = %tbMedalLevelUpRate[nType]
		tbFormulaList.tbLog = %tbMedalLog[nType]
		p = %tbUpdateXunZhang:new(tbFormulaList, "updatemedal", INVENTORY_ROOM.room_equipment)
		tinsert(self.tbUpdateCompose, nType, p)
	end

end

function pActivity:toUpdatecompose(nType)
	self.tbUpdateCompose[nType]:ComposeDailog()
end

pActivity.nPak = curpack()