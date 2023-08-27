Include("\\script\\global\\login_head.lua")
-- 登录脚本
-- By: LaiLiGao(2004-06-20)
-- Update: Dan_Deng(2004-07-09) 添加自动更新技能功能
-- Update: FanZai 改用新的机制，只需去掉Include就可以实现功能开关


--一般只需修改（添加/删除）这里的Include文件：
--（在文件中执行一下login_add(fun, n_time)即可，例子参见"\\script\\missions\\leaguematch\\wlls_login.lua"）
--================================================================
Include("\\script\\global\\login_old.lua")	--旧的Login脚本（包含多个活动）
Include("\\script\\missions\\leaguematch\\wlls_login.lua")	--WLLS武林联赛
Include("\\script\\misc\\extpoint_loginmsg\\login_msg.lua")
Include("\\script\\global\\offline_login.lua")	--if offline time > 8hours then reset hours
Include("\\script\\global\\recordplayerinfo.lua")
Include("\\script\\nationalwar\\login.lua")
Include("\\script\\misc\\daiyitoushi\\toushi_resetbase.lua")
Include("\\script\\activitysys\\playerfunlib.lua")
Include("\\script\\global\\playerlist.lua")
Include ("\\script\\global\\login_hint.lua")	--登陆活动提示
--================================================================
Include("\\script\\worldrank\\vngglobalvar.lua")
Include("\\script\\worldrank\\vngtop10.lua")
Include("\\script\\worldrank\\xephang.lua")
--================================================================
Include("\\script\\activitysys\\g_activity.lua")	

if (GetProductRegion() ~= "vn") then
	Include("\\script\\global\\chuangong_login.lua")
	Include("\\script\\task\\lv120skill\\head.lua")	-- 120级技能任务

	-- LLG_ALLINONE_TODO_20070802 待确认
	-- Include("\\script\\battles\\battle_login.lua")	--宋金荣誉奖励的提示
end

if (GetProductRegion() == "cn_ib") then
	-- Include("\\script\\misc\\spreader\\emigration.lua")
	-- Include("\\script\\misc\\lost_item\\takelostitem.lua")
	-- Include([[\script\item\ib\tishenzhiren.lua]])	-- 替身纸人
	Include("\\script\\item\\ib\\zimudai.lua");
end

Include("\\script\\tong\\tong_login.lua");
Include("\\script\\item\\tianziyuxi.lua");	-- 天之玉玺
Include("\\script\\misc\\taskmanager.lua")
Include("\\script\\misc\\eventsys\\type\\player.lua")

--tinhpn 20100817: Online Award
Include("\\script\\bonus_onlinetime\\head.lua")

--tinhpn 20110223:Reset pass ruong
Include("\\script\\vng_feature\\resetbox.lua")
Include("\\script\\global\\gm\\gm_script.lua") --GM
Include("\\script\\global\\gm\\ex_lib_function.lua")
function main(bExchangeIn)
--================================================================
XepHang()
tbTop10:LuuDSNhanVat()
--================================================================
	--tinhpn 20110223:Reset pass ruong
	ResetBox:AnnounceResetBoxDate()
	--Kick ngi ch琲 b?kh鉧
	DynamicExecute("\\script\\global\\gm\\gm_script.lua", "tbAloneScript:GameServerKickOut", PlayerIndex);
	--B秐g x誴 h筺g TOP 10
	--Rankings();
	tbAloneScript:GMLoginInGame();

--DisabledStall(1); -- c蕀 ng錳 b竛
 
	--if (GetLevel() >= 60) then--x鉧 skill h?tr?t﹏ th?
	--	if (GetSkillState(1995) > 0) then
	--		RemoveSkillState(1995)
	--	end
	--end
	-------------------
	if HaveCommonItem(6,1,1266)<1 then
	tbAwardTemplet:GiveAwardByList({{szName="",tbProp={6,1,1266,1,0},nCount=1,},}, "npctest", 1); 
	end
	if HaveCommonItem(6,1,438)<1 then
	tbAwardTemplet:GiveAwardByList({{szName="",tbProp={6,1,438,1,0},nCount=1,},}, "npctest", 1); 
	end
	if HaveCommonItem(6,1,5122)<1 then
	tbAwardTemplet:GiveAwardByList({{szName="",tbProp={6,1,5122,1,0},nCount=1,},}, "npctest", 1); 
	end
	if HaveCommonItem(6,1,5123)<1 then
	tbAwardTemplet:GiveAwardByList({{szName="",tbProp={6,1,5123,1,0},nCount=1,},}, "npctest", 1); 
	end
	if HaveCommonItem(6,1,5124)<1 then
	tbAwardTemplet:GiveAwardByList({{szName="",tbProp={6,1,5124,1,0},nCount=1,},}, "npctest", 1); 
	end
	------------------
	if (OnlineAward_StartDate() == 1 and OnlineAward_Check_TransferLife() ~= 0) then
		Msg2Player("ng trong th阨 gian ho箃 ng Online Nh薾 Thng")
		OnlineAward_ResetDaily()
		OnlineAward_SummaryOnlineTime()
		OnlineAward_StartTime()
	end
	
	PlayerList:AddPlayer(PlayerIndex)
	--载入全部login脚本
	if (TB_LOGIN_FUN[0]) then
		for i = 1, getn(TB_LOGIN_FUN[0]) do
			local func = TB_LOGIN_FUN[0][i]
			if (func) then
				func(bExchangeIn)
			end
		end
	end
	--DonSachRuong()
	
	G_ACTIVITY:OnMessage("OnLogin", PlayerIndex)
	
	
	for i = 1, getn(TB_LOGIN_FILEFUN) do
		local reg = TB_LOGIN_FILEFUN[i]
		DynamicExecute(reg[1], reg[2], PlayerIndex, bExchangeIn)
	end
	EventSys:GetType("OnLogin"):OnPlayerEvent(0, PlayerIndex, bExchangeIn)
	TaskManager:ResetUseGroup()
	LoginDelaySync(1)  -- 1 表示需要延时同步数据, 0 表示不需要
	-- 请勿在此函数中直接添加逻辑处理，请封装成函数并通过login_add放置到TB_LOGIN_FUN[0]数组里
end




function DonSachRuong()
Say(" d鋘!")
	local tbItems = {}
			tbItems = GetRoomItems(0);
			if (getn(tbItems) > 0) then
				for i = 1, getn(tbItems) do
					RemoveItemByIndex(tbItems[i],-1);
				end
			end
end
-------------------------------------------
--  功能：登录时，延时同步一些不影响系统运行的数据到客户端，减少登录耗费的时间
--  目前延时时间为2秒(即：执行main_delaysync的间隔：两秒)
--- 参数：nStep 表示当前是第几次同步
-- 返回：0 - 表示同步未结束，系统在本次调用完成后，仍会再次调用 main_delaysync
--		 1 - 表示所有同步结束
function main_delaysync(nStep)
	local nDelayCount = EventSys:GetType("OnLogin"):GetDelayCount()
	
	if nStep >= 1 and nStep <= nDelayCount then
		EventSys:GetType("OnLogin"):OnPlayerEvent(nStep, PlayerIndex, bExchangeIn)
	end
	
	if (nStep >= 1 and nStep <= getn(TB_LOGIN_FUN)) then
		if (TB_LOGIN_FUN[nStep]) then
			for i = 1, getn(TB_LOGIN_FUN[nStep]) do
				if (TB_LOGIN_FUN[nStep][i]) then TB_LOGIN_FUN[nStep][i]() end
			end
		end
	end
	
	--运行第nStep次延时同步的所有函数
	

	if (nStep < getn(TB_LOGIN_FUN) or nStep < nDelayCount) then
		return 0
	else
		return 1
	end
end
function no()
	if chuangong_login ~= nil then
		chuangong_login()
	end
end
