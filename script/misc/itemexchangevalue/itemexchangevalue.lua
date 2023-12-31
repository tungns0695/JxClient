Include("\\script\\misc\\timeline\\timelinemanager.lua")
Include("\\script\\activitysys\\playerfunlib.lua")
Include("\\script\\lib\\awardtemplet.lua")
Include("\\script\\lib\\log.lua")

IncludeLib("ITEM")
Include("\\script\\lib\\log.lua")
if (tbItemExchangValue == nil) then
	tbItemExchangValue = {}
	tbItemExchangValue.ExchangeDiscount = 0;
end


function CalcItemExchangValue(nItemIndex, nExchangeValue)
--	if (tbItemExchangValue.ExchangeDiscount == nil or tbItemExchangValue.ExchangeDiscount == 0) then
--		local tbExchange1 = tbTimeLineManager:GetTimeLine("ItemExchange1");
--		local tbExchange2 = tbTimeLineManager:GetTimeLine("ItemExchange2");
--		local tbExchange3 = tbTimeLineManager:GetTimeLine("ItemExchange3");
--		local tbExchange4 = tbTimeLineManager:GetTimeLine("ItemExchange4");
--		local tbExchange5 = tbTimeLineManager:GetTimeLine("ItemExchange5");
		
--		if (tbExchange5 ~= nil and tbExchange5:IsBegin() == 1) then
--			tbItemExchangValue.ExchangeDiscount = 0.5;
--		elseif (tbExchange4 ~= nil and tbExchange4:IsBegin() == 1) then
--			tbItemExchangValue.ExchangeDiscount = 0.6;
--		elseif (tbExchange3 ~= nil and tbExchange3:IsBegin() == 1) then
--			tbItemExchangValue.ExchangeDiscount = 0.7;
--		elseif (tbExchange2 ~= nil and tbExchange2:IsBegin() == 1) then
--			tbItemExchangValue.ExchangeDiscount = 0.8;
--		elseif (tbExchange1 ~= nil and tbExchange1:IsBegin() == 1) then
--			tbItemExchangValue.ExchangeDiscount = 0.9;
--		else
			tbItemExchangValue.ExchangeDiscount = 1;
--		end
		
--	end
	
	local nQuality = GetItemQuality(nItemIndex);
	
	if (nExchangeValue <= 0) then
		return 0
	end
	
	--加8以上白金不能兑换
	local nPlatinaLevel = GetPlatinaLevel(nItemIndex);
	if (nQuality == 4 and nPlatinaLevel > 8) then
		return 0
	end
	
	if (nQuality == 4 and (nPlatinaLevel >= 6 and nPlatinaLevel <= 7)) then
		local nPtMagicAttrExValue = GetPtMagicAttrExValue(nItemIndex);
		if (nPtMagicAttrExValue and nPtMagicAttrExValue > 0) then
			nExchangeValue = nExchangeValue + nPtMagicAttrExValue;
		end
	end
	
	-- 如果是紫裝
	if (nQuality == 2) then
		nExchangeValue = nExchangeValue/150;
	end
	
	nExchangeValue = nExchangeValue * tbItemExchangValue.ExchangeDiscount;
	
	return nExchangeValue
end

function exchange_olditem()
	GiveItemUI("фi h錸 th筩h", "M閠 l莕 ch� c� th� i 1 trang b� kh玭g h筺 s� d鬾g v� kh玭g kh鉧 th祅h h錸 th筩h", "exchange_olditem_compose")
end

function exchange_olditem_compose(nCount)
	if (nCount <= 0) then
		Talk(1, "", "Xin m阨 b� v祇 trang b� c� th� i 頲.");
		return
	end
	
	if (nCount > 1) then
		Talk(1, "", "M閠 l莕 ch� c� th� d飊g m閠 trang b�  i th祅h h錸 th筩h");
		return
	end
	
	local nItemIndex = GetGiveItemUnit(1);
	
	if (nItemIndex == nil or nItemIndex <= 0) then
		Talk(1, "", "Xin m阨 b� v祇 trang b� c� th� i 頲.");
		return
	end
	
	local nBindState = GetItemBindState(nItemIndex);
	
	if (nBindState ~= 0) then
		Talk(1, "", "Ch� c� th� d飊g trang b� kh玭g kh鉧 v� kh玭g c� th阨 h筺 s� d鬾g i th祅h h錸 th筩h");
		return
	end
	
	local nUseTime = ITEM_GetLeftUsageTime(nItemIndex);
	local nExpireTime = ITEM_GetExpiredTime(nItemIndex);
	
	if ((nUseTime > 0 and nUseTime ~= 4294967295)or (nExpireTime > 0)) then
		Talk(1, "", "Ch� c� th� d飊g trang b� kh玭g kh鉧 v� kh玭g c� th阨 h筺 s� d鬾g i th祅h h錸 th筩h");
		return
	end
	
	local nExchangeValue = GetItemExchangeValue(nItemIndex);
	
	if (nExchangeValue <= 0) then
		Talk(1, "", "Xin m阨 b� v祇 trang b� c� th� i 頲.");
		return
	end
	
	exchange_olditem_compse_confirm_dlg(nItemIndex, nExchangeValue);
end

function exchange_olditem_compse_confirm_dlg(nItemIndex, nExchangeValue)
	local tbSay = {};
	tbSay[1] = format("<dec><npc>X竎 nh薾 mu鑞 i <color=red>%s<color> th祅h h錸 th筩h c� ch鴄 <color=red>%d<color> tinh l鵦?", GetItemName(nItemIndex), nExchangeValue);
	
	tinsert(tbSay, format("X竎 nh薾/#exchange_olditem_compse_confirm(%d, %d)",nItemIndex,nExchangeValue));
	
	tinsert(tbSay, "в ta suy ngh� k� l筰 xem/OnExit");
	CreateTaskSay(tbSay);
end

function exchange_olditem_compse_confirm(nItemIndex, nExchangeValue)
	if (IsMyItem(nItemIndex) ~= 1) then
		return 
	end
	local nBind = GetItemBindState(nItemIndex);
	--local nGenre, nDetailType, nParticular, nLevel, nSeries, nLuck = GetItemProp(nItemIndex);
	--local arynMagLvl = GetItemAllParams(nItemIndex);
	--local nQuality = GetItemQuality(nItemIndex);
	local uRandSeed = ITEM_GetItemRandSeed(nItemIndex)
	--local szLogMsg = format("{%d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d,%d}", 4,uRandSeed,nQuality,nGenre,nDetailType,nParticular,nLevel,nSeries,nLuck,unpack(arynMagLvl))
	local szLogMsg = getItemInfo(nItemIndex);
	WriteLog(format("%s\t%s\t%s\t%d\t%s\t%s\t%d\t%s\t%s",GetAccount(), GetName(), "фi h錸 th筩h", GetItemQuality(nItemIndex), szLogMsg, GetItemName(nItemIndex), 0, format("{6,1,2356,1,0,0,%d,0,0,0,0,0}", nExchangeValue), "H錸 Th筩h"))
	
	local szLog = format("%d\t%s\t%u", nExchangeValue, GetItemName(nItemIndex), uRandSeed)
	if (RemoveItemByIndex(nItemIndex) ~= 1) then
		return
	end
	
	tbAwardTemplet:GiveAwardByList({szName="H錸 Th筩h", tbProp={6,1,2356,1,0,0}, tbParam={nExchangeValue,0,0,0,0,0},nBindState=nBind}, format("фi h錸 th筩h (%d)",nExchangeValue));
	_WritePlayerLog("Equip Exchange ", szLog)
end

tbExchangeLingPai = 
{
	["Thanh C﹗ L謓h"] = 
	{
		tbItem = {szName="Thanh C﹗ L謓h", tbProp={6,1,2369,1,0,0}},
		szComposFunc = "exchange_lingpai_qingju",
		nRequireJingLianShi = 1500,
	},
	["V﹏ L閏 L謓h"] = 
	{
		tbItem = {szName="V﹏ L閏 L謓h", tbProp={6,1,2353,1,0,0}},
		szComposFunc = "exchange_lingpai_yunlu",
		nRequireJingLianShi = 4000,
	},
	["Thng Lang L謓h"] = 
	{
		tbItem = {szName="Thng Lang L謓h", tbProp={6,1,2352,1,0,0}},
		szComposFunc = "exchange_lingpai_canglang",
		nRequireJingLianShi = 13000,
	},
	["Huy襫 Vi猲 L謓h"] = 
	{
		tbItem = {szName="Huy襫 Vi猲 L謓h", tbProp={6,1,2351,1,0,0}},
		szComposFunc = "exchange_lingpai_xuanyuan",
		nRequireJingLianShi = 46000,
	},
	["T� M穘g L謓h"] = 
	{
		tbItem = {szName="T� M穘g L謓h", tbProp={6,1,2350,1,0,0}},
		szComposFunc = "exchange_lingpai_zimang",
		nRequireJingLianShi = 70000,
	},
	["Kim � L謓h"] = 
	{
		tbItem = {szName="Kim � L謓h", tbProp={6,1,2349,1,0,0}},
		szComposFunc = "exchange_lingpai_wujin",
		nRequireJingLianShi = 250000,
	},
	["B筩h H� L謓h"] = 
	{
		tbItem = {szName="B筩h H� L謓h", tbProp={6,1,2357,1,0,0}},
		szComposFunc = "exchange_lingpai_baihu",
		nRequireJingLianShi = 500000,
	},
	["у Ph� T� M穘g Thng Gi韎 Ch�"] = 
	{
		tbItem = {szName="у Ph� T� M穘g Thng Gi韎 Ch�", tbProp={6,1,2721,1,0,0}},
		szComposFunc = "exchange_Dopho_Tumang_Thuonggioi",
		nRequireJingLianShi = 100000,
	},
	["у Ph� T� M穘g H� Gi韎 Ch�"] = 
	{
		tbItem = {szName="у Ph� T� M穘g H� Gi韎 Ch�", tbProp={6,1,2722,1,0,0}},
		szComposFunc = "exchange_Dopho_Tumang_Hagioi",
		nRequireJingLianShi = 100000,
	},
	["у Ph� T� M穘g Kh� Gi韎"] = 
	{
		tbItem = {szName="у Ph� T� M穘g Kh� Gi韎", tbProp={6,1,2723,1,0,0}},
		szComposFunc = "exchange_Dopho_Tumang_Khigioi",
		nRequireJingLianShi = 100000,
	},
}

function exchange_lingpai()
	local tbSay = {};
	tbSay[1] = "<dec><npc>M閠 l莕 ch� c� th� d飊g 1 h錸 th筩h i th祅h 1 l謓h b礽.";
	-- format("<enter>云鹿令:需要一个至少灌注了<color=green>%d<color>精力的魂石<enter>苍狼令:需要一个至少灌注了<color=green>%d<color>精力的魂石<enter>玄猿令:需要一个至少灌注了<color=green>%d<color>精力的魂石<enter>紫蟒令:需要一个至少灌注了<color=green>%d<color>精力的魂石<enter>金乌令:需要一个至少灌注了<color=green>%d<color>精力的魂石", 800,2600,9300,22000,24000)
	
--	for sz_key, tb in tbExchangeLingPai do
--		tbSay[1] = tbSay[1].."<enter>"..format("%s:需要一个至少灌注了<color=green>%d<color>精力的魂石", sz_key, tb.nRequireJingLianShi);
--		tinsert(tbSay, format("换取%s/#exchange_lingpai_main_dlg('%s')",sz_key,sz_key));
--	end
	
	
	tbSay[1] = tbSay[1].."<enter>"..format("%s: c莕 輙 nh蕋 h錸 th筩h c� ch鴄<color=green>%d<color> tinh l鵦", "Thanh C﹗ L謓h", tbExchangeLingPai["Thanh C﹗ L謓h"].nRequireJingLianShi);
	tbSay[1] = tbSay[1].."<enter>"..format("%s: c莕 輙 nh蕋 h錸 th筩h c� ch鴄<color=green>%d<color> tinh l鵦", "V﹏ L閏 L謓h", tbExchangeLingPai["V﹏ L閏 L謓h"].nRequireJingLianShi);
	tbSay[1] = tbSay[1].."<enter>"..format("%s: c莕 輙 nh蕋 h錸 th筩h c� ch鴄<color=green>%d<color> tinh l鵦", "Thng Lang L謓h", tbExchangeLingPai["Thng Lang L謓h"].nRequireJingLianShi);
	tbSay[1] = tbSay[1].."<enter>"..format("%s: c莕 輙 nh蕋 h錸 th筩h c� ch鴄<color=green>%d<color> tinh l鵦", "Huy襫 Vi猲 L謓h", tbExchangeLingPai["Huy襫 Vi猲 L謓h"].nRequireJingLianShi);
	tbSay[1] = tbSay[1].."<enter>"..format("%s: c莕 輙 nh蕋 h錸 th筩h c� ch鴄<color=green>%d<color> tinh l鵦", "T� M穘g L謓h", tbExchangeLingPai["T� M穘g L謓h"].nRequireJingLianShi);
	--DinhHQ
	--20110413: b竛  ph??th?r蘮 th莕 b?LA
	tbSay[1] = tbSay[1].."<enter>"..format("%s: c莕 輙 nh蕋 h錸 th筩h c� ch鴄<color=green>%d<color> tinh l鵦", "у Ph� T� M穘g Thng Gi韎 Ch�", tbExchangeLingPai["у Ph� T� M穘g Thng Gi韎 Ch�"].nRequireJingLianShi);
	tbSay[1] = tbSay[1].."<enter>"..format("%s: c莕 輙 nh蕋 h錸 th筩h c� ch鴄<color=green>%d<color> tinh l鵦", "у Ph� T� M穘g H� Gi韎 Ch�", tbExchangeLingPai["у Ph� T� M穘g H� Gi韎 Ch�"].nRequireJingLianShi);
	tbSay[1] = tbSay[1].."<enter>"..format("%s: c莕 輙 nh蕋 h錸 th筩h c� ch鴄<color=green>%d<color> tinh l鵦", "у Ph� T� M穘g Kh� Gi韎", tbExchangeLingPai["у Ph� T� M穘g Kh� Gi韎"].nRequireJingLianShi);
	
	tinsert(tbSay, format("фi %s/#exchange_lingpai_main_dlg('%s')","Thanh C﹗ L謓h","Thanh C﹗ L謓h"));
	tinsert(tbSay, format("фi %s/#exchange_lingpai_main_dlg('%s')","V﹏ L閏 L謓h","V﹏ L閏 L謓h"));
	tinsert(tbSay, format("фi %s/#exchange_lingpai_main_dlg('%s')","Thng Lang L謓h","Thng Lang L謓h"));
	tinsert(tbSay, format("фi %s/#exchange_lingpai_main_dlg('%s')","Huy襫 Vi猲 L謓h","Huy襫 Vi猲 L謓h"));
	tinsert(tbSay, format("фi %s/#exchange_lingpai_main_dlg('%s')","T� M穘g L謓h","T� M穘g L謓h"));
	tinsert(tbSay, format("фi %s/#exchange_lingpai_main_dlg('%s')","Kim � L謓h","Kim � L謓h"));
	tinsert(tbSay, format("фi %s/#exchange_lingpai_main_dlg('%s')","B筩h H� L謓h","B筩h H� L謓h"));
	--DinhHQ
	--20110413: b竛  ph??th?r蘮 th莕 b?LA
	tinsert(tbSay, format("фi %s/#exchange_lingpai_main_dlg('%s')","у Ph� T� M穘g Thng Gi韎 Ch�","у Ph� T� M穘g Thng Gi韎 Ch�"));
	tinsert(tbSay, format("фi %s/#exchange_lingpai_main_dlg('%s')","у Ph� T� M穘g H� Gi韎 Ch�","у Ph� T� M穘g H� Gi韎 Ch�"));
	tinsert(tbSay, format("фi %s/#exchange_lingpai_main_dlg('%s')","у Ph� T� M穘g Kh� Gi韎","у Ph� T� M穘g Kh� Gi韎"));
	
	tinsert(tbSay, "в ta suy ngh� k� l筰 xem/OnExit");
	CreateTaskSay(tbSay);
end

function exchange_lingpai_main_dlg(szLingpai)
	local tbLingpai = tbExchangeLingPai[szLingpai];
	
	if (tbLingpai == nil) then
		return
	end
	
	local szComposeFun = tbExchangeLingPai[szLingpai].szComposFunc;
	
	GiveItemUI(format("фi %s",szLingpai), format("M閠 l莕 ch� c� th� d飊g 輙 nh蕋 h錸 th筩h c� ch鴄 %d tinh l鵦  i %s.", tbLingpai.nRequireJingLianShi, szLingpai), szComposeFun)
end

function exchange_lingpai_compose(nCount, szLingpai)
	if (nCount <= 0) then
		Talk(1, "", format("Xin h穣 b� h錸 th筩h c� ch鴄 輙 nh蕋 <color=green>%d<color> tinh l鵦.",tbExchangeLingPai[szLingpai].nRequireJingLianShi));
		return
	end
	
	if (nCount > 1) then
		Talk(1, "", "M閠 l莕 ch� c� th� b� 1 h錸 th筩h.");
		return
	end
	
	local nItemIndex = GetGiveItemUnit(1);
	
	if (nItemIndex == nil or nItemIndex <= 0) then
		Talk(1, "", format("Xin h穣 b� h錸 th筩h c� ch鴄 輙 nh蕋 <color=green>%d<color> tinh l鵦.",tbExchangeLingPai[szLingpai].nRequireJingLianShi));
		return
	end
	
	local nGenre, nDetailType, nParticular, nLevel, nSeries, nLuck = GetItemProp(nItemIndex);
	
	if (nGenre ~= 6 or nDetailType ~= 1 or nParticular ~= 2356) then
		Talk(1, "", format("Xin h穣 b� h錸 th筩h c� ch鴄 輙 nh蕋 <color=green>%d<color> tinh l鵦.",tbExchangeLingPai[szLingpai].nRequireJingLianShi));
		return
	end
	
	local nJinglianshiCount = GetItemMagicLevel(nItemIndex, 1);
	
	if (nJinglianshiCount < tbExchangeLingPai[szLingpai].nRequireJingLianShi) then
		Talk(1, "", format("Xin h穣 b� h錸 th筩h c� ch鴄 輙 nh蕋 <color=green>%d<color> tinh l鵦.",tbExchangeLingPai[szLingpai].nRequireJingLianShi));
		return
	end
	
	exchange_lingpai_confirm_dlg(nItemIndex, szLingpai);
end

function exchange_lingpai_qingju(nCount)
	exchange_lingpai_compose(nCount, "Thanh C﹗ L謓h");
end

function exchange_lingpai_yunlu(nCount)
	exchange_lingpai_compose(nCount, "V﹏ L閏 L謓h");
end

function exchange_lingpai_canglang(nCount)
	exchange_lingpai_compose(nCount, "Thng Lang L謓h");
end

function exchange_lingpai_xuanyuan(nCount)
	exchange_lingpai_compose(nCount, "Huy襫 Vi猲 L謓h");
end

function exchange_lingpai_zimang(nCount)
	exchange_lingpai_compose(nCount, "T� M穘g L謓h");
end

function exchange_lingpai_wujin(nCount)
	exchange_lingpai_compose(nCount, "Kim � L謓h");
end

function exchange_lingpai_baihu(nCount)
	exchange_lingpai_compose(nCount, "B筩h H� L謓h");
end

function exchange_Dopho_Tumang_Thuonggioi(nCount)
	exchange_lingpai_compose(nCount, "у Ph� T� M穘g Thng Gi韎 Ch�");
end

function exchange_Dopho_Tumang_Hagioi(nCount)
	exchange_lingpai_compose(nCount, "у Ph� T� M穘g H� Gi韎 Ch�");
end

function exchange_Dopho_Tumang_Khigioi(nCount)
	exchange_lingpai_compose(nCount, "у Ph� T� M穘g Kh� Gi韎");
end

function exchange_lingpai_confirm_dlg(nItemIndex, szLingpai)
	local nJinglianshiCount = GetItemMagicLevel(nItemIndex, 1);
	local tbSay = {};
	tbSay[1] = format("<dec><npc>X竎 nh薾 mu鑞 d飊g h錸 th筩h c� ch鴄 <color=red>%d<color> tinh l鵦 i th祅h <color=red>%s<color>?", nJinglianshiCount, szLingpai);
	if (nJinglianshiCount > tbExchangeLingPai[szLingpai].nRequireJingLianShi) then
		tbSay[1] = format("%s<enter><color=red>H錸 th筩h c� s� lng tinh l鵦 vt qu� s� lng  i <color=yellow>%s<color>, s� c莕 thi誸 l�<color=green>%d<color>, s� lng th鮝 s� tr� l筰, i hi謕 c� mu鑞 i kh玭g?<color>", tbSay[1], szLingpai, tbExchangeLingPai[szLingpai].nRequireJingLianShi);
	end
	tinsert(tbSay, format("X竎 nh薾/#exchange_lingpai_confirm(%d, '%s')",nItemIndex,szLingpai));
	
	tinsert(tbSay, "в ta suy ngh� k� l筰 xem/OnExit");
	CreateTaskSay(tbSay);
end

function exchange_lingpai_confirm(nItemIndex, szLingpai)
	if (IsMyItem(nItemIndex) ~= 1) then
		return 
	end
	if (PlayerFunLib:CheckFreeBagCell(1, "default") ~= 1) then
			return 0;
	end
	
	local nBind = GetItemBindState(nItemIndex);
	local nJinglianshiCount = GetItemMagicLevel(nItemIndex, 1);
	--20110419: modified by DinhHQ
	--Fix bug using 1 Soul Stone to buy 2 Lingpai
	if (nJinglianshiCount < tbExchangeLingPai[szLingpai].nRequireJingLianShi) then
		Talk(1, "", format("Xin h穣 b� h錸 th筩h c� ch鴄 輙 nh蕋 <color=green>%d<color> tinh l鵦.",tbExchangeLingPai[szLingpai].nRequireJingLianShi));
		return
	end
	
	WriteLog(format("[%s]\t%s\tName:%s\tAccount:%s\t%s",format("фi %s",szLingpai),GetLocalDate("%Y-%m-%d %H:%M"),GetName(), GetAccount(),format("D飊g h錸 th筩h (%d) i th祅h %s",nJinglianshiCount,szLingpai)))
	
	if (RemoveItemByIndex(nItemIndex) ~= 1) then
		return
	end
	
	if (nJinglianshiCount > tbExchangeLingPai[szLingpai].nRequireJingLianShi) then
		tbAwardTemplet:GiveAwardByList({szName="H錸 Th筩h", tbProp={6,1,2356,1,0,0}, tbParam={nJinglianshiCount-tbExchangeLingPai[szLingpai].nRequireJingLianShi,0,0,0,0,0}, nBindState=nBind}, format("D飊g h錸 th筩h (%d) i %s v� tr� l筰 h錸 th筩h c�  %d tinh l鵦",nJinglianshiCount,szLingpai,nJinglianshiCount-tbExchangeLingPai[szLingpai].nRequireJingLianShi));
	end
		
	local tbLinPaiItem = clone(tbExchangeLingPai[szLingpai].tbItem);
	tbLinPaiItem.nBindState = nBind;
	tbAwardTemplet:GiveAwardByList(tbLinPaiItem, format("D飊g h錸 th筩h (%d) i th祅h %s",nJinglianshiCount,szLingpai));

	local szLog = format("%s\t%d",tbLinPaiItem.szName, tbExchangeLingPai[szLingpai].nRequireJingLianShi)
	
	_WritePlayerLog("Exchange Token", szLog)
end

function OnExit()
end
