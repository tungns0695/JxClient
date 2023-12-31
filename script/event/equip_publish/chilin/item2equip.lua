Include("\\script\\lib\\composeex.lua")
Include("\\script\\misc\\eventsys\\type\\npc.lua")
Include("\\script\\event\\equip_publish\\chilin\\formula_def.lua")
IncludeLib("ITEM")
tbItem2Chilin = tbActivityCompose:new()

function tbItem2Chilin:GetComposeRate()
	local tbRoomItems = self:GetRoomItems(self.nRoomType)
	local tbAdditivelMaterial = self.tbFormula.tbMaterial.tbAdditivelMaterial
	return self:CalcRate(tbAdditivelMaterial ,tbRoomItems) + self.nSuccessRate
end

function tbItem2Chilin:CalcRate(tbAdditive, tbRoomItems)	
	-- 获取成功率
	local nSuccessRate = 0
	for k, v in tbAdditive do
		local nCount = self:CalcItemCount(tbRoomItems, v)	
		local nSR = nCount * v.nSuccessRate
		nSuccessRate = nSuccessRate + nSR;				
	end
	return nSuccessRate
end

function tbItem2Chilin:ConsumeAdditive(tbAdditive, szLogTitle)
	for i=1,getn(tbAdditive) do
		local tbItem = tbAdditive[i]
		local tbRoomItems =  self:GetRoomItems(self.nRoomType)	
		local nCount = self:CalcItemCount(tbRoomItems, tbItem)
		if nCount > 0 then
			self:ConsumeItem(tbRoomItems, nCount, tbItem)
		end
		self:ConsumeLog(nCount.." "..tbItem.szName, szLogTitle)
	end
	return 1;
end

function tbItem2Chilin:CheckEquip(nItemIndex, tbEquip, nProductId)

	if IsMyItem(nItemIndex) ~= 1 then
		return
	end
	
	if not self.bAccessBindItem and GetItemBindState(nItemIndex) ~= 0 then
		return
	end
	local nItemGenre = GetItemProp(nItemIndex)
	if nItemGenre == 7 then
		return
	end
	local nExpiredTime = ITEM_GetExpiredTime(nItemIndex)
	local nLeftUsageTime = ITEM_GetLeftUsageTime(nItemIndex)
	if nExpiredTime ~= 0 or nLeftUsageTime ~= 4294967295 then
		return 
	end
	local nQuality = GetItemQuality(nItemIndex)
	local nEqIndex = -1
	if nQuality == 1 then
		nEqIndex = GetGlodEqIndex(nItemIndex)
	elseif nQuality == 4 then
		nEqIndex = GetPlatinaEquipIndex(nItemIndex)
		if GetPlatinaLevel(nItemIndex) > 0 then
			return
		end
	end	
	
	if tbEquip.tbEqIndex[nEqIndex] == nProductId then
		return 1
	end
	return 
end

function tbItem2Chilin:ConsumeEquip(nItemIndex, tbItem, nProductId)
	if self:CheckEquip(nItemIndex, tbItem, nProductId) then
		if RemoveItemByIndex(nItemIndex) == 1 then
			return 1
		end
	end
end

function tbItem2Chilin:TraversalRoom(pCallBack, tbItem, nProductId)
	local tbRoomItems = self:GetRoomItems(self.nRoomType)
	for i=1, getn(tbRoomItems) do
		local nItemIndex = tbRoomItems[i]
		if nItemIndex and nItemIndex > 0 then
			if pCallBack(self, nItemIndex, tbItem, nProductId) then
				return 1
			end
		end
	end
	return
end

function tbItem2Chilin:Compose(nProductId)
	local tbProduct		= self.tbFormula.tbProduct[nProductId]
	local tbMaterial	= self.tbFormula.tbMaterial
	local tbCommonMaterial = tbMaterial.tbCommonMaterial
	local tbAdditivelMaterial = tbMaterial.tbAdditivelMaterial
	local tbFragment = tbMaterial.tbFragment
	local tbEquip = tbMaterial.tbEquip
	if not tbProduct then
		return 
	end
	
	if not self:CheckLimit(nProductId) then
		return 
	end
	
	-- 计算成功率
	
	local nSuccessRate = self:GetComposeRate()
	
	-- 检查材料是否充足
	if self:ConsumeMaterial(tbCommonMaterial, nComposeCount, self.szLogTitle) ~= 1 then
		Msg2Player("Ch� t筼 th蕋 b筰, m蕋 甶 m閠 s� nguy猲 li謚.")
		return 0;
	end
	if self:ConsumeAdditive(tbAdditivelMaterial, self.szLogTitle) ~= 1 then
		Msg2Player("Ch� t筼 th蕋 b筰, m蕋 甶 m閠 s� nguy猲 li謚.")
		return 0;
	end
	
	if self:ConsumeMaterial(tbFragment, nComposeCount, self.szLogTitle) ~= 1 then
		Msg2Player("Ch� t筼 th蕋 b筰, m蕋 甶 m閠 s� nguy猲 li謚.")
		return 0;
	end
	
	if random(1, 100) > nSuccessRate then
		Msg2Player("Th藅 ng ti誧 ch� t筼  th蕋 b筰")
		if self.tbFormula.szAction then
			tbLog:PlayerActionLog(self.szLogTitle, self.tbFormula.szAction, nSuccessRate, "fail")
		end
		return 0
	end	
	
	if self:TraversalRoom(self.ConsumeEquip, tbEquip, nProductId) ~= 1 then
		Msg2Player("Ch� t筼 th蕋 b筰, m蕋 甶 m閠 s� nguy猲 li謚.")
		return 0;
	end
	
	if type(tbProduct) == "table" then
		tbAwardTemplet:Give(tbProduct, nComposeCount, {self.szLogTitle})
	end
	return 1;
end

function tbItem2Chilin:CheckLimit(nProductId)
	local tbMaterial	= self.tbFormula.tbMaterial
	local tbCommonMaterial = tbMaterial.tbCommonMaterial
	local tbAdditivelMaterial = tbMaterial.tbAdditivelMaterial
	local tbFragment = tbMaterial.tbFragment
	local tbEquip = tbMaterial.tbEquip
	
	-- 检查背包空间
	if self.tbFormula.nWidth  and self.tbFormula.nHeight and CountFreeRoomByWH(self.tbFormula.nWidth, self.tbFormula.nHeight, 1) < 1 then
		Say(format("в b秓 m t礽 s秐 c馻 i hi謕, xin h穣  tr鑞g %d %dx%d h祅h trang", 1, self.tbFormula.nWidth, self.tbFormula.nHeight))
		return
	end
	if self:CheckMaterial(tbCommonMaterial, nComposeCount) ~=1 then
		local szMsg = "<color=red>Чi hi謕 mang nguy猲 li謚 kh玭g  r錳!<color>"
		Talk(1, "", szMsg)
		return
	end
	if self:CheckMaterial(tbFragment, nComposeCount) ~=1 then
		local szMsg = "<color=red>Чi hi謕 mang nguy猲 li謚 kh玭g  r錳!<color>"
		Talk(1, "", szMsg)
		return
	end
	if self:TraversalRoom(self.CheckEquip, tbEquip, nProductId) ~= 1 then
		local szMsg = format("<color=red>C莕 %d %s<color>", tbEquip.nCount, tbEquip.szName)
		Talk(1, "", szMsg)
		return
	end
	return 1
end

function tbItem2Chilin:GiveUIOk(nId, nCount)
	if not self:CheckLimit(nId) then
		return 
	end
	local nSuccessRate = self:GetComposeRate()
	local szMsg = format("t nguy猲 li謚 v祇 nh薾 頲 t� l� th祅h c玭g l�%d%%, i hi謕 c� mu鑞 ti誴 t鬰 ch� t筼 kh玭g?", nSuccessRate)
	if nSuccessRate > 100 then
		szMsg = "T� l� th祅h c玭g vt qu� 100% s� l穘g ph� nguy猲 li謚 c馻 i hi謕, ngi c� mu鑞 ti誴 t鬰 ch� kh玭g?"
	end
	
	local tbOpt = 
	{
		{"Ti誴 t鬰 ch� t筼", self.Compose, {self, nId}},
		{"t v祇 l莕 n鱝", self.ComposeGiveUI, {self, nId}},
		{"H駓 b� "},
	}
	CreateNewSayEx(szMsg, tbOpt)
end
function tbItem2Chilin:GettbAdditivelDesc(tbMaterial)
	local szList = ""
	for i=1,getn(tbMaterial) do
		local tbItem = tbMaterial[i]
		if tbItem.szName and tbItem.nSuccessRate then
			szList = format("%s<enter>M鏸 khi b� v祇  1 %s s� t╪g %d%% t� l� th祅h c玭g", szList,tbItem.szName, tbItem.nSuccessRate)
		end
	end
	return szList
end

function tbItem2Chilin:GetMaterialDesc(tbMaterial)
	local szList = ""
	for i=1,getn(tbMaterial) do
		local tbItem = tbMaterial[i]
		if tbItem.nJxb then
			szList = format("%s<enter>%-20s  %d",szList,"Ng﹏ lng", tbItem.nJxb * tbItem.nCount)
		elseif tbItem.szName and tbItem.nCount then
			szList = format("%s<enter>%-20s  %d",szList,tbItem.szName, tbItem.nCount or 1)
		end
	end
	return szList
end
function tbItem2Chilin:GetComposeDesc()
	local szList = format("%-20s  %s","v藅 ph萴 ","S� lng")
	local tbMaterial = self.tbFormula.tbMaterial
	local tbCommonMaterial = tbMaterial.tbCommonMaterial
	local tbAdditivelMaterial = tbMaterial.tbAdditivelMaterial
	local tbFragment = tbMaterial.tbFragment
	local tbEquip = tbMaterial.tbEquip
	szList = szList..self:GetMaterialDesc(tbCommonMaterial)
	szList = szList..self:GetMaterialDesc(tbFragment)
	szList = szList..self:GetMaterialDesc({tbEquip})
	szList = szList..("<enter>B� th猰 c竎 o c� sau y s� gia t╪g t� l� th祅h c玭g")
	szList = szList..self:GettbAdditivelDesc(tbAdditivelMaterial)
	return szList
end
function tbItem2Chilin:ComposeGiveUI(nId)
	g_GiveItemUI(format("Ch� t筼 %s", self.tbFormula.tbProduct[nId].szName), self:GetComposeDesc(), {self.GiveUIOk, {self, nId}}, nil, self.bAccessBindItem)
end

function tbItem2Chilin:SelectEquip(nId, nCountPerPage)
	local szMsg = format("Chon m閠 c竔 %s", self.tbFormula.tbProduct.szName)
	local nProductCount = getn(self.tbFormula.tbProduct)
	local nEndId = nCountPerPage + nId - 1
	if nEndId > nProductCount then
		nEndId = nProductCount
	end
	local tbOpt = {}
	for i=nId, nEndId  do 
		tinsert(tbOpt, {self.tbFormula.tbProduct[i].szDesc, self.ComposeGiveUI, {self, i}})
	end
	if nId >= nCountPerPage + 1  then
		tinsert(tbOpt, {"Trang trc", self.SelectEquip, {self, nId-nCountPerPage, nCountPerPage}})
	end
	if nEndId < nProductCount then
		tinsert(tbOpt, {"Trang k� ", self.SelectEquip, {self, nId+nCountPerPage, nCountPerPage}})
	end
	tinsert(tbOpt, {"H駓 b� "})
	CreateNewSayEx(szMsg, tbOpt)
end

local tbComposeOpt = {}
for i=1, getn(tbFormulaList) do
	local p = tbItem2Chilin:new(tbFormulaList[i], "tbItem2Chilin", INVENTORY_ROOM.room_giveitem)
	p.nSuccessRate = 80
	local szOpt = format("Ch� t筼 %s", tbFormulaList[i].tbProduct.szName)
	tinsert(tbComposeOpt, {szOpt, p.SelectEquip, {p, 1, 5}})
end
tinsert(tbComposeOpt, {"в ta suy ngh� k� l筰 xem", cancel})

function tbItem2Chilin:Dialog()
	CreateNewSayEx("Чi hi謕 mu鑞 ch� t筼 b� ph薾 n祇 c馻 trang b� X輈h L﹏", %tbComposeOpt)
end

Include("\\script\\event\\equip_publish\\dialog.lua")
MAKE_EQUIP_LIST["chilin"] = {}
MAKE_EQUIP_LIST["chilin"].nPak = curpack()
MAKE_EQUIP_LIST["chilin"].pFun = tbItem2Chilin.Dialog
MAKE_EQUIP_LIST["chilin"].pSelf = tbItem2Chilin
MAKE_EQUIP_LIST["chilin"].szOpt = "Ch� t筼 trang b� X輈h L﹏"