
---------------------------------------------------------------------------------
--  严重声明：此文件不抽字符串
---------------------------------------------------------------------------------

-- 礼官脚本
-- Li_Xin 2004-8-17
--Include( "\\script\\global\\中秋活动.lua" )

--TASKID_HOLIDAY_GIFT_DATE = 160;				-- 任务变量ID of 玩家最后一次领取节日礼物时间
--TASKTMPID_HOLIDAY_GIFT_DATE = 160;			-- 临时任务变量ID of 玩家最后一次领取节日礼物时间
Include( "\\script\\event\\eventhead.lua" )
Include("\\script\\event\\maincity\\event.lua")	-- 主城奖励
Include("\\script\\event\\superplayeract2007\\event.lua")----超级玩家活动
Include("\\script\\event\\great_night\\event.lua")	-- 辉煌之夜
Include("\\script\\misc\\ex_goldequp_coin.lua");	-- 兑换黄金装备金牌
Include("\\script\\event\\jiefang_jieri\\201004\\main.lua");
Include("\\script\\event\\jiefang_jieri\\201004\\refining_iron\\Npc.lua") -- 炼金活动


-- 越南0904解放活动
--Include("\\script\\event\\jiefang_jieri\\200904\\zhanshenzhujiu\\jiu_hecheng.lua");
--Include("\\script\\event\\jiefang_jieri\\200904\\jinnangshijian\\jinnangshijian.lua");
--Include("\\script\\event\\jiefang_jieri\\200904\\denggao\\denggao.lua");
--Include("\\script\\event\\jiefang_jieri\\200904\\shuizei\\shuizei.lua");
--Include("\\script\\event\\jiefang_jieri\\200904\\taskctrl.lua");

Include("\\script\\event\\guoqing_jieri\\200908\\compose.lua")
Include("\\script\\event\\other\\jilixinwanjia\\200908\\npcdailog.lua")

-- 越南0905生日活动
--Include("\\script\\event\\birthday_jieri\\200905\\npc\\npc_liguan_dailog.lua");
Include("\\script\\misc\\vngpromotion\\ipbonus\\ipbonus_2_npc.lua");

Include("\\script\\activitysys\\g_activity.lua")
Include("\\script\\dailogsys\\g_dialog.lua")
Include("\\script\\activitysys\\playerfunlib.lua")

Include("\\script\\activitysys\\npcfunlib.lua")

Include("\\script\\task\\killmonster\\killmonster.lua")
Include("\\script\\misc\\eventsys\\type\\npc.lua")

--tinhpn 20100817: Online Award
Include("\\script\\bonus_onlinetime\\head.lua")
Include("\\script\\bonus_onlinetime\\func_onlineaward.lua")
Include("\\script\\vonghoa\\exchangitem\\exchangeitem.lua")
Include("\\script\\vonghoa\\item\\head.lua")
Include("\\script\\traogiaithdnb\\thdnb7.lua");--20100908 haint code function trao giai thdnb
Include("\\script\\baoruongthanbi\\dialogmain.lua")
Include("\\script\\vlkh\\vlkh1.lua")

--tinhpn 20101022: Event Thang 10
Include("\\script\\vng_event\\201010\\head.lua")
Include("\\script\\vng_event\\compensate.lua")
Include("\\script\\vng_event\\traogiai\\vldnb2010\\vlbnb.lua")

--[DinhHQ]
	--[20110107]:trao giai Phuong Anh Hao thang 12 2010
	Include("\\script\\vng_event\\traogiai\\pah_12_2010\\head.lua")
	--[20110124]:Vip account 2011
	Include("\\script\\vng_event\\vip_account_2011\\npc\\lequan.lua")
	--[20110216]:THDNB8
	Include("\\script\\vng_event\\20110215_THDNB8\\vng_thdnb8_award.lua")
	--[20110225]: 8/3/2011
	Include("\\script\\vng_event\\20110225_8_thang_3\\npc\\lequan.lua")
	--[20110311]: NPAH thang 02 2011
	Include("\\script\\vng_event\\20110215_THDNB8\\vng_npah0211.lua")
	
	Include("\\script\\vng_event\\traogiai\\NPAH\\vng_ToolAward.lua")
--tinhpn 20110223:Reset pass ruong
Include("\\script\\vng_feature\\resetbox.lua")
Include("\\script\\vng_event\\traogiai\\vlmc2011\\vlmc2011_main.lua")

function main()
	

	local nCurDate = tonumber(GetLocalDate("%Y%m%d%H%M"))
	local nNpcIndex = GetLastDiagNpc();
	local szNpcName = GetNpcName(nNpcIndex)
	if NpcName2Replace then
		szNpcName = NpcName2Replace(szNpcName)
	end

	local tbDailog = DailogClass:new(szNpcName)
	EventSys:GetType("AddNpcOption"):OnEvent(szNpcName, tbDailog, nNpcIndex)
--[DinhHQ]
	--[20110107]:Nh薾 thng gi秈 u Phng Anh H祇
	--	tbPAH122010_Head:addDialog(tbDailog)
	--[20110124]:Vip account 2011
	tbVNG_VipAcc2011_LeQuan:addDialog(tbDailog)
	--[20110216]:THDNB8
	tbVNG_THDNB8:AddDialog(tbDailog)
	--[20110225]: 8/3/2011
	tbVNGWD2011_LeQuan:AddDialog(tbDailog)
	--[20110311]: NPAH thang 02 2011
	tbVNG_NPAH0211:AddDialog(tbDailog)
	--Trao v遪g h祇 quang VLMC2011 - Modified by DinhHQ - 20110523
	tbVLMC2011_Tittle:AddDialog(tbDailog)
	tbVngToolAward:AddDialog(tbDailog)	
	G_ACTIVITY:OnMessage("ClickNpc", tbDailog, nNpcIndex)
	--弹出对话框
	tbDailog:AddOptEntry("Иm Huy Ho祅g", onGreat_Night)
--	tbDailog:AddOptEntry("Tham gia ho箃 ng B秓 Rng Th莕 B�", BRTB_Dialog_main)
--	tbDailog:AddOptEntry("Nh薾 thng Chung K誸 V� L﹎ е Nh蕋 Bang", GetBonusVLDNB2010_main)
--	tbDailog:AddOptEntry("Nh薾 l筰 Ti襫 уng", Compensate_main)
--	if (VH_ActiveDay()==1) then
--		tbDailog:AddOptEntry("Ta n i v藅 ph萴 event th竛g 8", ExChangeItem_main)
--	end
	tbDailog:AddOptEntry("M� Pass Rng", ResetBox.ShowDialog, {ResetBox})
	
	--tinhpn 20101022: Event Thang 10
--	if (Event201010:IsActive() == 1) then
--		tbDailog:AddOptEntry("фi thng ho箃 ng th竛g 10", Event201010.ShowDialog, {Event201010}) 	
--	end
	
	if IsIPBonus() then
		tbDailog:AddOptEntry("H� tr� cho m竬 s� d鬾g CSM", IpBonus)
	end
	
	--tinhpn 20100817: Online Award
--	if (OnlineAward_StartDate() ~= 0 and OnlineAward_Check_TransferLife() ~= 0) then
--		tbDailog:AddOptEntry("Tham gia online nh薾 thng", OnlineAward); 
--	end
	
	local ncity = gb_GetTask("MAINCITYCFG", 1);
	local nCurMapID = SubWorldIdx2ID(SubWorld);
	if (ncity >= 1 and ncity <= 7 and nCurMapID == TB_MAINCITY_CITYWAR_T[ncity][2]) then
		tbDailog:AddOptEntry("Nh薾 ph莕 thng d祅h cho Th竔 Th�", maincity_award_entry)	
	end
	if tbJILIWanJia0908:IsActDate() then
		tbDailog:AddOptEntry("Ho箃 ng k輈h t﹏ th�", tbJILIWanJia0908.DailogMain, {tbJILIWanJia0908} )
	end
		
		
	if FreedomEvent2010:IsActive1() == 1 then
		tbDailog:AddOptEntry("Чo c� t蕀 竜 chi課 s�", FreedomEvent2010.LiGuanEventItemDlg, {FreedomEvent2010}) 	
	end
	
	if tbRefiningIron:CheckCondition() == 1 then
		tbDailog:AddOptEntry("Ho箃 ng t玦 luy謓 th衟", tbRefiningIron.NpcTalk, {tbRefiningIron}) 	
	end
	
	tbDailog:Show()
end

function jiefang0904_act()
	Say("L� Quan: Hi謓 產ng trong th阨 gian di詎 ra ho箃 ng ch祇 m鮪g ng祔 gi秈 ph鉵g,b� con 產ng n竜 n鴆 ╪ m鮪g chi課 th緉g, i hi謕 c� mu鑞 tham gia kh玭g n祇?", 6, 
			"Ta n nh薾 c萴 nang s� ki謓/jf0904_getjinnangshijian",
			format("Ho箃 ng ru m鮪g chi課 th緉g/#tbJiefang0904_jiu:OnDailogMain()"),
			"Ho箃 ng chinh ph鬰 nh FanXiPan/about_denggao",
			"Ho箃 ng Oanh Li謙 Thi猲 Thu/about_shuizei",
			"Ho箃 ng Ti猽 Di謙 Th駓 T芻/about_shuizei",
			"Ta ch� n xem!/OnCancel");
end

Include([[\script\event\menglan_2006\menglan_2006.lua]]);
function v_menglanjie()
	Say("Qu� h鉧! Qu� h鉧! Ta thay m苩 Phng trng Thi誹 L﹎ c秏 琻 v� ch骳 ph骳 cho ngi!", 7, 
		"Ta mu鑞 d﹏g t苙g v遪g Kim Li猲 Hoa/#v_mljaward(1)",
		"Ta mu鑞 d﹏g t苙g v遪g M閏 Li猲 Hoa/#v_mljaward(2)",
		"Ta mu鑞 d﹏g t苙g v遪g Th駓 Li猲 Hoa/#v_mljaward(3)",
		"Ta mu鑞 d﹏g t苙g v遪g H醓 Li猲 Hoa/#v_mljaward(4)",
		"Ta mu鑞 d﹏g t苙g v遪g Th� Li猲 Hoa/#v_mljaward(5)",
		"Ta mu鑞 d﹏g t苙g v遪g Li猲 Hoa, m鏸 h� m閠 c竔./v_mljaward_all",
		"Ch� l� hi誹 k� gh� qua xem th玦!/OnCancel"
	);
end;

function v_mljaward(nIdx)
	if (CalcEquiproomItemCount(6,1,tab_NPCIdx[nIdx][1] + 5,-1) < 1) then
		Say("Ngi ch糿g ph秈 mu鑞 d﹏g t苙g "..tab_NPCIdx[nIdx][2].." sao? H譶h nh� ngi kh玭g mang theo "..tab_NPCIdx[nIdx][2].."!", 1, "в ta 甶 chu萵 b� !/OnCancel")
		return
	end;
	
	local nCount = GetTask(tab_NPCIdx[nIdx][3]);
	if (nCount >= SIMGER_LIMIT) then
		Say("Ngi  d﹏g t苙g  s� "..tab_NPCIdx[nIdx][2].." n祔 r錳! H穣 d﹏g t苙g lo筰 kh竎 甶!", 0);
		return
	end;
	
	ConsumeEquiproomItem(1, 6, 1, tab_NPCIdx[nIdx][1] + 5, -1);
	SetTask(tab_NPCIdx[nIdx][3], nCount + 1);
	AddOwnExp(500000);
	Say("Qu� h鉧 qu�! Зy l� ch髏 t﹎ � m� Phng trng Thi誹 L﹎ v� chng m玭 Nga Mi g雐 t苙g ngi.", 1, "Nh薾 l蕐 l� v藅./OnCancel");
	Msg2Player("B筺 nh薾 頲 <color=yellow>500000<color> 甶觤 kinh nghi謒.");
end;

function v_mljaward_all()
	for i = 1, getn(tab_NPCIdx) do
		if (CalcEquiproomItemCount(6,1,tab_NPCIdx[i][1] + 5,-1) < 1) then
			Say("Ngi ch糿g ph秈 mu鑞 d﹏g t苙g "..tab_NPCIdx[i][2].." sao? H譶h nh� ngi kh玭g mang theo "..tab_NPCIdx[i][2].."!", 1, "в ta 甶 chu萵 b� !/OnCancel")
			return
		end;
	end;
	
	local nCount = GetTask(TK_LOTUS_ALL);
	if (nCount >= TOGETHER_LIMIT) then
		Say("Th藅 c竚 琻 ngi! Nh璶g 12 Bao l� x� c馻 ta  t苙g ngi h誸 r錳.", 0);
		return
	end;
	
	for i = 1, getn(tab_NPCIdx) do
		ConsumeEquiproomItem(1, 6, 1, tab_NPCIdx[i][1] + 5, -1);
	end;
	SetTask(TK_LOTUS_ALL, nCount + 1);
	
	AddOwnExp(1000000);
	AddItem(6, 1, 1136, 1, 0, 0, 0); --加一个大风包；
	Say("Qu� h鉧 qu�! Зy l� ch髏 t﹎ � m� Phng trng Thi誹 L﹎ v� chng m玭 Nga Mi g雐 t苙g ngi.", 1, "Nh薾 l蕐 l� v藅./OnCancel");
	Msg2Player("B筺 nh薾 頲 <color=yellow>1000000<color> 甶觤 kinh nghi謒 v� 1 <color=yellow>Bao l� x�<color>");
end;

-- 节日列表
aryHoliday = {	-- 节日时间, 符合节日时间所调函数名, 重复领礼品的提示文本 
				{ 20040822, onHoliday_QiXi, "C秐h p tr阨 trong! Hai b筺 sao kh玭g 甶 ch琲 l�, c遪 � l筰 y l祄 g�?" }
				-- 其它节日
			 };
	
function valentineGift()
	if (GetBit(GetTask(67),24) == 1) then
		if (GetBit(GetTask(1313),1) ~= 1) then
			SetTask(1313, SetBit(GetTask(1313), 1, 1))
			Talk(1, "", "<#> H玬 nay l� m閠 ng祔 h筺h ph骳 cho nh鱪g i lng duy猲! Ta c� m鉵 qu� n祔 t苙g cho nh鱪g ai  k誸 h玭! Ch骳 c竎 v� 'B竎h ni猲 giai l穙' ")
			-- 送2个“心心相印符”
			for i = 1, 2 do
				AddItem( 6, 1, 18, 1, 0, 0 ,0);
			end
			Msg2Player( "<#>B筺 nh薾 頲 2 T﹎ T﹎ Tng 竛h ph�!" );
			-- 送9朵“玫瑰花”
			for i = 1, 9 do
				AddItem( 6, 0, 20, 1, 0, 0 ,0);
			end	
			Msg2Player( "<#>B筺 nh薾 頲  9 b玭g hoa h錸g!" );
			-- 50级以上玩家加送1个“天山玉露”
			if( GetLevel() >= 50 ) then
				AddItem(6, 1, 72, 1, 0, 0, 0);
				Msg2Player( "<#>B筺 nh薾 頲 m閠 b譶h Thi猲 S琻 B秓 L�!" );
			end
		else
			Talk(1, "", "<#> Ngi ch糿g ph秈  nh薾 qu� r錳 sao? Nhng cho ngi kh竎 v韎 ch�!")
		end
	else
		Talk(1, "", "<#> Ngi ch璦 k誸 h玭, kh玭g th� nh薾 頲 qu�!")
	end
end		 	
---------------- 取消 ----------------------------------------
function OnCancel()
end

function LiguanLog(object)
	WriteLog(date("%H%M%S") .. ": T礽 kho秐:" .. GetAccount() .. ", nh﹏ v藅:" .. GetName() .. "," .. object);
end
