--无UI界面的合成类
--通过调用tbComposeClass:GetMaterialList(tbMaterial)自动产生合成材料信息 
--格式： 物品名 （物品个数/需求个数）
--
--调用 tbComposeClass:Compose(tbFormula, szLogTitle, pFun, ...)
--即可合成，失败返回0，成功返回1
--
--tbFormula格式
--tbFormula = {tbMaterial，tbProduct}
--
--tbMaterial 写法同\script\lib\awardtemplet.lua 的tbItem，目前只能填道具，和钱
--
--tbProduct 写法完全同 \script\lib\awardtemplet.lua 允许为nil





Include("\\script\\task\\system\\task_string.lua");
Include("\\script\\lib\\awardtemplet.lua")
Include("\\script\\lib\\baseclass.lua")
Include("\\script\\lib\\string.lua")
if not tbComposeClass then
	
tbComposeClass = tbBaseClass:new()


--功能:初始化合成类
--参数：类名（必须和你用的变量名一致，并且是全局的），合成公式，日志标题
--无
function tbComposeClass:_init(szClassName, tbFormula, szLogTitle)
	szClassName = szClassName or "tbComposeClass"
	
	self.szClassName = szClassName
	self.tbFormula = tbFormula

	self.szLogTitle = szLogTitle or "M芻 甶nh h頿 th祅h"
	setglobal(szClassName, self)
	
	self:MakeAskNumberFunction()
	
end

--功能：根据材料说明表检查身上材料的情况
--参数：材料说明表
--返回：是否完全匹配(1/0)，身上个数情况，最大合成个数情况
function tbComposeClass:CheckMaterial(tbMaterial, nComposeCount)
	local i
	local flag = 1
	local tbCount  = {}
	local tbMaxSetCount = {}
	nComposeCount = nComposeCount or 1
	
	for i=1,getn(tbMaterial) do
		local tbItem = tbMaterial[i]
		if tbItem.tbProp then
			tbItem.nCount = tbItem.nCount or 1
			local nItemNeedCount = tbItem.nCount * nComposeCount
			if nItemNeedCount > 0 then
				local tbProp = tbItem.tbProp
				tbProp[4] = tbProp[4] or -1		
				local nCurCount = CalcEquiproomItemCount(tbProp[1], tbProp[2], tbProp[3], tbProp[4])
				tbCount[i] = nCurCount
				tbMaxSetCount[i] = floor(nCurCount / nItemNeedCount)
				if nCurCount < nItemNeedCount then
					flag =  0;
				end	
			end			
		elseif tbItem.nJxb then
			local nCash = GetCash()
			tbCount[i] = nCash
			local nNeedJxb = tbItem.nJxb * nComposeCount
			tbMaxSetCount[i] = floor(nCash / nNeedJxb)
			if nCash < nNeedJxb then
				flag = 0
			end
		elseif tbItem.pGetCount then
			local nCurCount = tbItem:pGetCount()
			tbItem.nCount = tbItem.nCount or 1
			local nNeedCount = tbItem.nCount * nComposeCount
			tbCount[i] = nCurCount
			tbMaxSetCount[i] = floor(nCurCount / nNeedCount)
			if nCurCount < nNeedCount then
				flag =  0;
			end	
		end
	end
	return flag, tbCount, tbMaxSetCount;
end

--功能：根据材料说明表判断最多能合成几个
--参数：材料说明表
--返回：最多合成个数
function tbComposeClass:CanMakeMaxCount(tbMaterial)
	local _, _, tbMaxCount = self:CheckMaterial(tbMaterial, 1)
	local nMinCount = tbMaxCount[1]
	for i=2, getn(tbMaxCount) do
		if nMinCount > tbMaxCount[i] then
			nMinCount = tbMaxCount[i]
		end
	end
	return nMinCount;
end

--功能：根据材料说明表消耗掉相应物品
--参数：材料说明表
--返回：是否成功(1/0)
function tbComposeClass:ConsumeMaterial(tbMaterial, nConsumeCount, szLogTitle)
	local i
	nConsumeCount = nConsumeCount or 1
	for i=1,getn(tbMaterial) do
		local tbItem = tbMaterial[i]
		if tbItem.tbProp then				
			tbItem.nCount = tbItem.nCount or 1
			local nConsumeItemCount = tbItem.nCount * nConsumeCount
			if nConsumeItemCount > 0 then
				local tbProp = tbItem.tbProp
				tbProp[4] = tbProp[4] or -1
				--print(tbProp[1], tbProp[2], tbProp[3], tbProp[4])
				if ConsumeEquiproomItem(nConsumeItemCount, tbProp[1], tbProp[2], tbProp[3], tbProp[4]) ~= 1 then
					return 0;
				end
				self:ConsumeLog(nConsumeItemCount.." "..tbItem.szName, szLogTitle)
			end
		elseif tbItem.nJxb then
			local nConsumeJxb = tbItem.nJxb * nConsumeCount
			if Pay(nConsumeJxb) == 0 then
				return 0;
			else
				Msg2Player(format("C莕 <color=yellow>%d<color> lng", nConsumeJxb))
				self:ConsumeLog("Jxb "..nConsumeCount.." * "..tbItem.nJxb, szLogTitle)
			end
		elseif tbItem.pConsume then
			local nConsumeCount = tbItem.nCount * nConsumeCount
			if tbItem:pConsume(nConsumeCount) ~= 1 then
				return 0;
			end
			self:ConsumeLog(nConsumeCount.." "..tbItem.szName, szLogTitle)
		end
	end
	return 1;
end


--功能：根据材料说明表返回材料情况信息
--参数：材料说明表
--返回：情况信息的字符串
function tbComposeClass:GetMaterialList(tbMaterial)
	local szList = format("%-20s  %s","v藅 ph萴 ","S� lng")
	local _, tbCount, tbMaxCount = self:CheckMaterial(tbMaterial, 1)
	local i;
	for i=1,getn(tbMaterial) do
		
		local szColor = "<color=green>"
		if tbMaxCount[i] < 1 then
			szColor = "<color=red>"
		end
		local tbItem = tbMaterial[i]
		if tbItem.nJxb then
			szList = format("%s<enter><color=yellow>%-20s<color>  %s(%d/%d)<color>",szList,"Ng﹏ lng", szColor, tbCount[i], tbMaterial[i].nJxb)
		elseif tbItem.szName and tbItem.nCount then
			szList = format("%s<enter><color=yellow>%-20s<color>  %s(%d/%d)<color>",szList,tbMaterial[i].szName, szColor, tbCount[i], tbMaterial[i].nCount)
		end
	end
	return szList
end



--功能：根据公式合成物品
--参数：合成公式（table）、日志标题（string）、后续处理函数、函数的参数（不定参数）
--返回：是否成功(1/0)
function tbComposeClass:Compose(tbFormula, szLogTitle, nComposeCount, pFun, ...)
	--如果输入为空，使用默认值
	tbFormula	= tbFormula or self.tbFormula
	szLogTitle	= szLogTitle or self.szLogTitle
	
	
	local tbMaterial	= tbFormula.tbMaterial
	local tbProduct		= tbFormula.tbProduct
	
	nComposeCount = nComposeCount or 1
	
	
	if tbFormula.pLimitFun then
		if tbFormula:pLimitFun(nComposeCount) ~= 1 then
			return 0
		end
	end
	
	local nFreeItemCellLimit = tbFormula.nFreeItemCellLimit or 1
	
	nFreeItemCellLimit = ceil(nFreeItemCellLimit * nComposeCount)
	
	if CalcFreeItemCellCount() < nFreeItemCellLimit then
		Say(format("в b秓 m an to祅 t礽 s秐, xin h穣 m b秓 h祅h trang c遪 th鮝 %d � tr鑞g.", nFreeItemCellLimit))
		return 0
	end
	
	
	if self:CheckMaterial(tbMaterial, nComposeCount) ~=1 then
		local szMsg = tbFormula.szFailMsg or "<color=red>Чi hi謕 mang nguy猲 li謚 kh玭g  r錳!<color>"
		Talk(1, "", szMsg)
		return 0;
	end

	if self:ConsumeMaterial(tbMaterial, nComposeCount, szLogTitle) ~= 1 then
		--Say("制作失败，部分物品丢失。",0)
		Msg2Player("Ch� t筼 th蕋 b筰, m蕋 甶 m閠 s� nguy猲 li謚.")
		return 0;
	end
	if type(tbProduct) == "table" then
		tbAwardTemplet:GiveAwardByList(tbProduct, szLogTitle, nComposeCount)
	end
	
	if type(pFun) == "function" then
		call(pFun, arg)
	end 
	return 1;
end

--功能：产生合成对话
--参数：合成公式，对话的回调函数(字符串格式)，回调函数参数（不能有table）
--返回：无
function tbComposeClass:ComposeDailog(tbFormula, szFunctionFormat, bIsAskNumber)
	--如果输入为空，使用默认值
	tbFormula			= tbFormula or self.tbFormula
	local szDefaultFunctionFormat = format("#%s:Compose(nil,nil, 1)", self.szClassName)
	if bIsAskNumber then
		szDefaultFunctionFormat = format("#%s:AskNumber()", self.szClassName)
	end
	szFunctionFormat	= szFunctionFormat or szDefaultFunctionFormat
	local tbMaterial = tbFormula.tbMaterial
	local tbProduct = tbFormula.tbProduct
	local szComposeTitle = tbFormula.szComposeTitle or format("фi %s", tbProduct.szName)
	local szMsg = format("<dec>%s c莕: <enter>%s", szComposeTitle ,self:GetMaterialList(tbMaterial))
	local tbSay = 
	{
		szMsg,
		format("X竎 nh薾/%s", szFunctionFormat ),
		"H駓 b� /OnCancel"
	}
	CreateTaskSay(tbSay)
end


--功能：写消耗日记
--参数：消耗掉的物品名字（包含个数，string），日志标题
--返回：无
function tbComposeClass:ConsumeLog(szItemName, szLogTitle)
	WriteLog(format("[%s]\t%s\tAccount:%s\tName:%s\t consume %s.",szLogTitle,GetLocalDate("%Y-%m-%d %H:%M"), GetAccount(), GetName(), szItemName))
end


function tbComposeClass:AskNumber()	
	local nMaxCount = self:CanMakeMaxCount(self.tbFormula.tbMaterial)
	if nMaxCount < 1 then
		local szMsg = self.tbFormula.szFailMsg or "<color=red>Чi hi謕 mang nguy猲 li謚 kh玭g  r錳!<color>"
		Talk(1, "", szMsg)
	else
		AskClientForNumber(format("%s__AskNumberCallBack", self.szClassName), 1, nMaxCount, "Xin m阨 nh藀 s�");
	end
end

function tbComposeClass:ComposeCountComfirm(nCount)
	
	local nMaxCount = self:CanMakeMaxCount(self.tbFormula.tbMaterial)
	if nCount > nMaxCount then
		nCount = nMaxCount
	end
	
--	local nFreeItemCellLimit = self.tbFormula.nFreeItemCellLimit or 1
--	
--	nFreeItemCellLimit = ceil(nFreeItemCellLimit * nCount)
--	
--	if CalcFreeItemCellCount() < nFreeItemCellLimit then
--		return Say(format("为了您的财物安全，请保证至少有%d个背包空间", nFreeItemCellLimit))
--	end

	if self:Compose(nil, nil, nCount) == 0 then
		return 0;
	end
	
	
	return 1;
end

function tbComposeClass:MakeAskNumberFunction()
	local szFunctionName = format("%s__AskNumberCallBack", self.szClassName)
	local szMsg = format("function %s(nCount) local self = getglobal([[%s]]) return self:ComposeCountComfirm(nCount) end",
					szFunctionName, self.szClassName)
	dostring(szMsg)
end


function tbComposeClass:GetProductName(tbFormula)
	tbFormula	= tbFormula or self.tbFormula
	local tbProduct		= tbFormula.tbProduct
	return tbProduct.szName
end

function tbComposeClass:GetFormulaByString(tbFormula)
	tbFormula	= tbFormula or self.tbFormula
	local tbMaterial = tbFormula.tbMaterial
	local szMsg = nil
	for i=1, getn(tbMaterial) do
		local szName
		if tbMaterial[i].nJxb then
			szName = transferDigit2CnNum(tbMaterial[i].nJxb).." lng"
		else
			szName = tbMaterial[i].szName.."X"..(tbMaterial[i].nCount or 1)
		end
		
		if not szMsg then
			szMsg = szName
		else
			szMsg = szMsg.."+"..szName	
		end
	end
	return szMsg
end


tbComposeClass:_init()

end