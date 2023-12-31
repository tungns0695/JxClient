-------------------------------------------------------------------------
-- FileName		:	newtaskprize.lua
-- Author		:	xiaoyang
-- CreateTime	:	2004-12-20 21:52:16
-- Desc			:	新任务特殊奖励
-- 					以每个玩家出师时的门派为阵营的判断
-------------------------------------------------------------------------

Include("\\script\\task\\newtask\\newtask_head.lua")
Include("\\script\\task\\newtask\\master\\clearskillpoint.lua")
Include("\\script\\task\\newtask\\master\\extent_prize.lua")

function prize()
Uworld1000 = nt_getTask(1000)
Uworld1001 = nt_getTask(1001)
Uworld1002 = nt_getTask(1002)
Uworld1003 = nt_getTask(1003)
local curCamp = nt_getCamp()
		if ( Uworld1001 == 50 ) then  --and ( )  缺少奖励变量判断
			if ( curCamp == 0 ) then
				AddItem(0,10,2,1,1,1)  --增加20级马
				AddGoldItem(0,184) --增加一双20跑的鞋子
				Msg2Player("B筺 nh薾 頲 1 con tu蕁 m� c蕄 20 v� 1 i gi祔 t鑓 ")
			end
				nt_setTask(1001,60)
		elseif ( Uworld1001 == 120 ) then
			if ( curCamp == 0 ) then
				AddGoldItem(0,177)  --增加蓝帽子
				Msg2Player("B筺 nh薾 頲 1 chi誧 m�.")
			end
				nt_setTask(1001,130)
		elseif ( Uworld1001 == 190 ) then
			if ( curCamp == 0 ) then
				ClearMagicPoint()  --增加40级时洗点的功能
				Msg2Player("B筺 nh薾 頲 1 c� h閕 t葃 甶觤 k� n╪g mi詎 ph� ")
			end
				nt_setTask(1001,200)
		elseif ( Uworld1001 == 260 ) then
			if ( curCamp == 0 ) then
				AddItem(6,1,71,1,1,1)  --增加一个仙草露
				Msg2Player("B筺 nh薾 頲 1 b譶h Ti猲 Th秓 L� ")	
			end	
				nt_setTask(1001,270)
		elseif ( Uworld1001 == 320 )  or ( Uworld1002 == 310 ) or ( Uworld1003 == 430 ) then  
			local	taskgoldenprize = random(1,9)
					if ( taskgoldenprize == 1 ) then
						AddGoldItem(0,168)  --增加一件黄金装备
					elseif ( taskgoldenprize == 2 ) then
						AddGoldItem(0,169)
					elseif ( taskgoldenprize == 3 ) then
						AddGoldItem(0,170)
					elseif ( taskgoldenprize == 4 ) then
						AddGoldItem(0,171)
					elseif ( taskgoldenprize == 5 ) then
						AddGoldItem(0,172)
					elseif ( taskgoldenprize == 6 ) then
						AddGoldItem(0,173)
					elseif ( taskgoldenprize == 7 ) then
						AddGoldItem(0,174)
					elseif ( taskgoldenprize == 8 ) then
						AddGoldItem(0,175)
					elseif ( taskgoldenprize == 9 ) then
						AddGoldItem(0,176)
					end
					if ( Uworld1001 == 320 ) then
						nt_setTask(1001,1000)
					elseif ( Uworld1002 == 310) then
						nt_setTask(1002,1000)
					elseif ( Uworld1003 == 430 ) then
						nt_setTask(1003,1000)
					end
					Msg2Player("B筺 nh薾 頲 1 m鉵 b秓 kh� ")	
					WriteLog(date("%H%M%S")..": T礽 kho秐"..GetAccount()..", nh﹏ v藅"..GetName().."Nh薾 頲 1 b� trang b� Ho祅g Kim sau khi ho祅 th祅h nhi謒 v� ch輓h tuy課")	
		end
end

function prize1()
Uworld1000 = nt_getTask(1000)
Uworld1001 = nt_getTask(1001)
Uworld1002 = nt_getTask(1002)
Uworld1003 = nt_getTask(1003)
local curCamp = nt_getCamp()
		if ( Uworld1002 == 50 ) then 
			if ( curCamp == 1 ) then
				AddItem(0,10,2,1,1,1)  --增加20级马
				AddGoldItem(0,184) --增加一双20跑的鞋子
				Msg2Player("B筺 nh薾 頲 1 con tu蕁 m� c蕄 20 v� 1 i gi祔 t鑓 ")
			end
			nt_setTask(1002,60)
		elseif ( Uworld1002 == 100 ) then
			if ( curCamp == 1 ) then
				AddGoldItem(0,177)  --增加蓝帽子
				Msg2Player("B筺 nh薾 頲 1 chi誧 m�.")
			end
			nt_setTask(1002,110)
		elseif ( Uworld1002 == 170 )  then
			if ( curCamp == 1 ) then
				ClearMagicPoint()  --增加40级时洗点的功能
				Msg2Player("B筺 nh薾 頲 1 c� h閕 t葃 甶觤 k� n╪g mi詎 ph� ")
			end
			nt_setTask(1002,180)
		elseif  ( Uworld1002 == 230 ) then
			if ( curCamp == 1 ) then
				AddItem(6,1,71,1,1,1)  --增加一个仙草露
				Msg2Player("B筺 nh薾 頲 1 b譶h Ti猲 Th秓 L� ")
			end
			nt_setTask(1002,240)		
		end
end
