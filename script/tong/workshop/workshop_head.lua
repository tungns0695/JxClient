function DEF_FUN(nTongID, nID)
	return 1
end

if MODEL_GAMESERVER == 1 or MODEL_RELAY == 1 then
--------------------如果非客户端---------------------------
Include("\\script\\tong\\workshop\\workshop_logic.lua")
Include("\\script\\tong\\workshop\\workshop_def.lua")
Include("\\script\\tong\\log.lua")

if (MODEL_GAMESERVER == 1) then --如果是GameServer
	Include("\\script\\tong\\addtongnpc.lua");
	Include([[\script\tong\workshop\tongcolltask.lua]]);--帮会特殊令牌头文件
end

function SVR_CheckUse(nTongID, nWorkshopID, szName)
	if (SubWorldIdx2ID(SubWorld) ~= TONG_GetTongMap(nTongID)) then
		if (GetTask(TASK_LP_COUNT) ~= 0) then --如果有帮会特殊令牌任务
			local nRwlp = rwlp_taskcheck(nTongID, nWorkshopID);
			local szLevel = "<color=yellow>"..GetTask(TASK_LP_ZONGGUANLEVEL).." -c蕄<color> ";
			local szZGName = "<color=yellow>"..tab_Workshop[GetTask(TASK_LP_ZONGGUANIDX)].."Phng t鎛g qu秐<color>";
			if (nRwlp == 2) then --如果地图是对的
				Say("H譶h nh� ngi 產ng l祄 nhi謒 v� l謓h b礽, nhanh ch鉵g t譵  "..szZGName.."xem 玭g 蕐 c� gi髉 頲 g� cho ngi kh玭g.", 0);
				Msg2Player("T譵 i tho筰 "..szZGName.."trong ph筸 vi khu v鵦.");
			elseif (nRwlp == 0) then --
				Say("H譶h nh� ngi 產ng l祄 nhi謒 v� l謓h b礽, nh璶g t鎛g qu秐 khu v鵦 chung kh玭g qu秐 l� vi謈 <color=yellow>th� ti課 c�<color> n祔, h穣 n bang h閕 kh竎 t譵 "..szZGName.."xem 玭g 蕐 c� gi髉 頲 g� cho ngi kh玭g.", 0);
				Msg2Player("Kh玭g th� t譵 th蕐 <color=yellow>th� ti課 c�<color> t筰 khu v鵦 chung.");
			elseif (nRwlp == 1) then --
				rwlp_dedaojianshu(nTongID, nWorkshopID);
			end;
		else
			Say("Зy kh玭g ph秈 l� l穘h a qu� bang, kh玭g th� s� d鬾g T竎 Phng n祔.", 0);
		end;
		return 0
	end
	if (nWorkshopID <= 0) then
		Say("Qu� bang dng nh� ch璦 x﹜ d鵱g T竎 Phng n祔.", 0)
		return 0
	end	
	if (TWS_GetUseLevel(nTongID, nWorkshopID) < 1) then
		Say("Ъng c蕄 t竎 phng n祔 l� 0, t筸 th阨 kh玭g th� s� d鬾g", 0);
		return 0;
	end
	if (TWS_IsOpen(nTongID, nWorkshopID) ~= 1) then
		Say(szName..": Bang h閕 ta ch璦 x﹜ d鵱g t竎 phng n祔, mu鑞 s� d鬾g ph秈 甶 t譵 bang ch� ho芻 trng l穙 khai m�.", 0);
		return 0;
	end	
	if TONG_GetPauseState(nTongID) ~= 0 then
		Say(szName..": T竎 Phng 產ng t筸 ng鮪g ho箃 ng.", 0);
		return 0;
	end
	return 1
end

function RL_DoLevelUp(nTongID, nID, nToLevel)
	if (logicWorkShopLevelUp(nTongID, nID, nToLevel) ~= 0) then
		return 0
	end	
	local eType = TWS_GetType(nTongID, nID)
	local nCurLevel = TWS_GetLevel(nTongID, nID)
	local nCost = wsGetUpgradeCostFund(nTongID, eType, nCurLevel)
	if (TONG_ApplyAddBuildFund(nTongID, -nCost) ~= 1) then
		return 0
	end	
	TONG_ApplyAddTaskValue(nTongID, TONGTSK_WEEK_BFCONSUME, nCost)
	
	-- 帮会历史/事件记录、通知
	local szExecutorName = TONGM_GetName(nTongID, ExecutorId);
	local szRecord = wsGetName(eType).."Th╪g l猲 c蕄 "..nToLevel.."c蕄";
	local szRecordPlus;
	if (szExecutorName ~= "") then
		szRecordPlus = szExecutorName.." l祄 cho"..szRecord;
	else
		szExecutorName = "";
		szRecordPlus = szRecord;
	end
	TONG_ApplyAddHistoryRecord(nTongID, szRecordPlus);	-- 帮会历史记录
	TONG_ApplyAddEventRecord(nTongID, szRecordPlus);	-- 帮会事件记录
	Msg2Tong(nTongID, szRecordPlus);
	
	cTongLog:WriteInfTB("WORKSHOP", "upgrade", nTongID, {workshopid = nID, typename = wsGetName(eType), tolevel = nToLevel})
	
	return 1;
end

function RL_DoDegrade(nTongID, nID, nToLevel)
	--取消降级操作
	do return 0 end
	local nRet = logicWorkShopDegrade(nTongID, nID, nToLevel)
	if (nRet ~= 0) then
		return 0
	end
	local nCurLevel = TWS_GetLevel(nTongID, nID)
	local eType = TWS_GetType(nTongID, nID)
	local bOpen = TWS_IsOpen(nTongID, nID)
	--使用等级
	if TWS_GetUseLevel(nTongID, nID) > nToLevel then
		TWS_ApplySetUseLevel(nTongID, nID, nToLevel)
	end
	local nMaintainAdd = wsGetPerMaintainCost(nTongID, eType, nToLevel, bOpen) - 
			wsGetPerMaintainCost(nTongID, eType, nCurLevel, bOpen);			
	--周维护战备基金变化
	TONG_ApplyAddPerStandFund(nTongID, nMaintainAdd * 7)
	
	-- 帮会历史/事件记录、通知
	local szRecord = wsGetName(eType).."Gi秏 xu鑞g c蕄"..nToLevel.."c蕄";
	local szRecordPlus;
	local szExecutorName = TONGM_GetName(nTongID, ExecutorId);
	if (szExecutorName ~= "") then
		szRecordPlus = szExecutorName.." l祄 cho"..szRecord;
	else
		szExecutorName = "";
		szRecordPlus = szRecord;
	end
	TONG_ApplyAddHistoryRecord(nTongID, szRecordPlus);	-- 帮会历史记录
	TONG_ApplyAddEventRecord(nTongID, szRecordPlus);	-- 帮会事件记录
	Msg2Tong(nTongID, szRecordPlus);
		
	cTongLog:WriteInfTB("WORKSHOP", "degrade", nTongID, {workshopid = nID, typename = wsGetName(eType), tolevel = nToLevel})
	
	return 1	
end

function RL_DoOpen(nTongID, nID)
	if (logicWorkShopOpen(nTongID, nID) ~= 0) then
		return 0
	end	
	local eType = TWS_GetType(nTongID, nID)
	local nCurLevel = TWS_GetUseLevel(nTongID, nID)
	local nCost = wsGetOpenCost(nTongID, eType, nCurLevel)
	if (TONG_ApplyAddBuildFund(nTongID, -nCost) ~= 1) then
		return 0
	end
	TONG_ApplyAddTaskValue(nTongID, TONGTSK_WEEK_BFCONSUME, nCost)
	local nMaintainAdd = wsGetClose2OpenMaintainCost(nTongID, eType, nCurLevel)
	--周维护战备基金变化
	TONG_ApplyAddPerStandFund(nTongID, nMaintainAdd * 7)	
	-- 帮会历史/事件记录、通知
	local szRecord = wsGetName(eType).."Khai m� l筰";
	local szRecordPlus;
	local szExecutorName = TONGM_GetName(nTongID, ExecutorId);
	if (szExecutorName ~= "") then
		szRecordPlus = szExecutorName.." l祄 cho"..szRecord;
	else
		szExecutorName = "";
		szRecordPlus = szRecord;
	end
	TONG_ApplyAddEventRecord(nTongID, szRecordPlus);	-- 帮会事件记录
	Msg2Tong(nTongID, szRecordPlus);
	
	cTongLog:WriteInfTB("WORKSHOP", "open", nTongID, {workshopid = nID, typename = wsGetName(eType), level = nCurLevel})
	
	return 1
end

function RL_DoClose(nTongID, nID)
	local eType = TWS_GetType(nTongID, nID)
	if (logicWorkShopClose(nTongID, nID) ~= 0) then
		return 0
	end
	local nCurLevel = TWS_GetUseLevel(nTongID, nID)
	local nMaintainAdd = wsGetClose2OpenMaintainCost(nTongID, eType, nCurLevel)
	--周维护战备基金变化
	TONG_ApplyAddPerStandFund(nTongID, -nMaintainAdd * 7)	
	-- 帮会历史/事件记录、通知
	local szRecord = wsGetName(eType).."сng";
	local szRecordPlus;
	local szExecutorName = TONGM_GetName(nTongID, ExecutorId);
	if (szExecutorName ~= "") then
		szRecordPlus = szExecutorName.." l祄 cho"..szRecord;
	else
		szExecutorName = "";
		szRecordPlus = szRecord;
	end
	TONG_ApplyAddEventRecord(nTongID, szRecordPlus);	-- 帮会事件记录
	Msg2Tong(nTongID, szRecordPlus);
	
	cTongLog:WriteInfTB("WORKSHOP", "close", nTongID, {workshopid = nID, typename = wsGetName(eType), level = nCurLevel})
	
	return 1
end

function RL_DoDestroy(nTongID, nID)
	local eType = TWS_GetType(nTongID, nID)
	if (logicWorkShopDestroy(nTongID, nID) ~= 0) then
		return 0
	end
	local nCurLevel = TWS_GetUseLevel(nTongID, nID)
	local bOpen = TWS_IsOpen(nTongID, nID)
	local nMaintainAdd = wsGetPerMaintainCost(nTongID, eType, nCurLevel, bOpen)
	--周维护战备基金变化
	TONG_ApplyAddPerStandFund(nTongID, -nMaintainAdd * 7)
	
	-- 帮会历史/事件记录、通知
	local szRecord = wsGetName(eType).."H駓 b�";
	local szRecordPlus;
	local szExecutorName = TONGM_GetName(nTongID, ExecutorId);
	if (szExecutorName ~= "") then
		szRecordPlus = szExecutorName.." l祄 cho"..szRecord;
	else
		szExecutorName = "";
		szRecordPlus = szRecord;
	end
	TONG_ApplyAddHistoryRecord(nTongID, szRecordPlus);	-- 帮会历史记录
	TONG_ApplyAddEventRecord(nTongID, szRecordPlus);	-- 帮会事件记录
	Msg2Tong(nTongID, szRecordPlus);
	
	cTongLog:WriteInfTB("WORKSHOP", "destroy", nTongID, {workshopid = nID, typename = wsGetName(eType), level = TWS_GetLevel(nTongID, nID)})
	
	return 1
end

function RL_DoLearn(nTongID, eType)
	if (logicWorkShopLearn(nTongID, eType) ~= 0) then
		return 0
	end	
	local nCost = wsGetUpgradeCostFund(nTongID, eType, 0)
	if (TONG_ApplyAddBuildFund(nTongID, -nCost) ~= 1) then
		return 0
	end
	TONG_ApplyAddTaskValue(nTongID, TONGTSK_WEEK_BFCONSUME, nCost)
	local nMaintainAdd = wsGetPerMaintainCost(nTongID, eType, 1, 1);
	--周维护战备基金变化
	TONG_ApplyAddPerStandFund(nTongID, nMaintainAdd * 7)	
	-- 帮会历史/事件记录、通知
	local szRecord = "Х x﹜ d鵱g"..wsGetName(eType);
	local szRecordPlus;
	local szExecutorName = TONGM_GetName(nTongID, ExecutorId);
	if (szExecutorName ~= "") then
		szRecordPlus = szExecutorName..szRecord;
	else
		szExecutorName = "";
		szRecordPlus = szRecord;
	end
	TONG_ApplyAddHistoryRecord(nTongID, szRecordPlus);	-- 帮会历史记录
	TONG_ApplyAddEventRecord(nTongID, szRecordPlus);	-- 帮会事件记录
	Msg2Tong(nTongID, szRecordPlus);
	
	cTongLog:WriteInfTB("WORKSHOP", "learn", nTongID, {typename = wsGetName(eType)})
	
	return 1
end

function SVR_CheckLevelUp(nTongID, nID, nToLevel)
	if nTongID == 0 or nID <=0 then
		return 0
	end
	local nRet = logicWorkShopLevelUp(nTongID, nID, nToLevel)
	if (nRet == 0) then
		return 1
	elseif (nRet == 1) then
		Msg2Player("T竎 phng n祔  t n c蕄 cao nh蕋, mu鑞 n﹏g c蕄 t竎 phng c莕 ph秈 n﹏g ng c蕄 ki課 thi誸 trc!")
	elseif (nRet == 2) then
		Msg2Player("Ng﹏ s竎h ki課 thi誸 bang kh玭g , kh玭g th� n﹏g c蕄 t竎 phng n祔.")
	elseif (nRet == 3) then
		Msg2Player("Bang h閕 產ng t筸 ng鮪g ho箃 ng, kh玭g th� n﹏g c蕄 t竎 phng!")	
	elseif (nRet == 4) then
		Msg2Player("Sau khi n﹏g c蕄, ng﹏ s竎h chi課 b� th蕄 h琻 ng﹏ s竎h b秓 tr� h祅g tu莕, kh玭g th� n﹏g c蕄 t竎 phng n祔!")	
	end	
	return 0
end

function SVR_DoLevelUp(nTongID, nID, nToLevel)
		--使用等级
	Say("Ngi c� th� n﹏g ng c蕄 s� d鬾g t竎 phng b籲g v韎 ng c蕄 t竎 phng, c� ng � kh玭g?", 2, "Mu鑞/#SetUSeLevel("..nTongID..","..
		nID..")", "Kh玭g mu鑞/cancel")
	return 1
end

function SetUSeLevel(nTongID, nID)
	local nLevel = TWS_GetLevel(nTongID, nID)
	if nLevel > 0 then
		TWS_ApplySetUseLevel(nTongID, nID, nLevel)
		TWS_ApplySetUseLevelSet(nTongID, nID, nLevel)
	end
	Msg2Player("Ъng c蕄 s� d鬾g t竎 phng 頲 n﹏g l猲 b籲g v韎 ng c蕄 t竎 phng!")
end

function SVR_CheckOpen(nTongID, nID)
	if nTongID == 0 or nID <=0 then
		return 0
	end
	local nRet = logicWorkShopOpen(nTongID, nID)
	if (nRet == 0) then
		return 1
	elseif (nRet == 1) then
	elseif (nRet == 2) then
		Msg2Player("Bang h閕 產ng t筸 ng鮪g ho箃 ng, kh玭g th� khai m� t竎 phng!")
	elseif (nRet == 3) then
		Msg2Player("Ng﹏ s竎h ki課 thi誸 bang kh玭g , kh玭g th� khai m� t竎 phng n祔!")
	elseif (nRet == 4) then
		Msg2Player("Sau khi khai m�, ng﹏ s竎h chi課 b� th蕄 h琻 ng﹏ s竎h b秓 tr� h祅g tu莕, kh玭g th� khai m� t竎 phng n祔!")	
	end
	return 0
end

function SVR_DoOpen(nTongID, nID)
	local eType = TWS_GetType(nTongID, nID)
	return 1
end

function SVR_CheckClose(nTongID, nID)
	if nTongID == 0 or nID <=0 then
		return 0
	end
	if (logicWorkShopClose(nTongID, nID) ~= 0) then
		return 0
	end
	return 1
end

function SVR_DoClose(nTongID, nID)
	local eType = TWS_GetType(nTongID, nID)
	return 1
end

function SVR_CheckDestroy(nTongID, nID)
	if nTongID == 0 or nID <=0 then
		return 0
	end
	local nRet = logicWorkShopDestroy(nTongID, nID)
	if (nRet == 0) then
		return 1
	end	
	return 0
end

function SVR_DoDestroy(nTongID, nID)
	local npcid = TWS_GetBuildingNpc(nTongID, nID)
	if (npcid > 0)then
		DelNpc(npcid)
		TWS_GetBuildingNpc(nTongID, nID, 0)
	end
	return 1
end

function SVR_CheckLearn(nTongID, eType)
	if nTongID == 0 then
		return 0
	end
	local nRet = logicWorkShopLearn(nTongID, eType)
	if (nRet == 0) then
		return 1
	elseif (nRet == 1) then
		Msg2Player("S� lng t竎 phng  t gi韎 h筺, mu鑞 x﹜ d鵱g th猰 c莕 ph秈 n﹏g ng c蕄 ki課 thi誸 l猲!")	
	elseif (nRet == 2) then
		Msg2Player("T竎 phng n祔  c� r錳!")
	elseif (nRet == 3) then
		Msg2Player("Bang h閕 t筸 ng鮪g ho箃 ng, kh玭g th� x﹜ d鵱g t竎 phng!")
	elseif (nRet == 4) then
		Msg2Player("Ng﹏ s竎h ki課 th誸 kh玭g , kh玭g th� th祅h l藀 t竎 phng n祔!")
	elseif (nRet == 5) then
		Msg2Player("Sau khi x﹜ d鵱g, ng﹏ s竎h chi課 b� th蕄 h琻 ng﹏ s竎h b秓 tr� h祅g tu莕, kh玭g th� x﹜ d鵱g t竎 phng n祔!")	
	end
	return 0
end

--DoLearn是GS作坊创建完后才调用的
function SVR_DoLearn(nTongID, nWorkshopID)
	local eType = TWS_GetType(nTongID, nWorkshopID)
	if (eType == 0)then
		_dbgMsg("SVR_DoLearn: ERRORRORORR")
		return 0
	end
	local nMapID = TONG_GetTongMap(nTongID)
	--无帮会地图或非动态地图
	if (nMapID < DYNMAP_ID_BASE)then
		return 1
	end
	nMapID = SubWorldID2Idx(nMapID)
	local nMapCopy = TONG_GetTongMapTemplate(nTongID)
	--地图不在此服务器
	if (nMapID < 0 or nMapCopy <= 0)then
		return 1
	end
	local npcid = add_one_building(nMapID, nMapCopy, eType, 1)
	_dbgMsg("add building npcid:"..npcid)
	if (npcid > 0)then
		TWS_SetBuildingNpc(nTongID, nWorkshopID, npcid)
	end
	return 1
end 

function SVR_CheckDegrade(nTongID, nID, nToLevel)
	--取消降级操作
	do return 0 end
	if nTongID == 0 or nID <=0 then
		return 0
	end
	local nRet = logicWorkShopDegrade(nTongID, nID, nToLevel)
	if (nRet == 0) then
		return 1
	elseif (nRet == 1) then
		Msg2Player("T竎 phng  � c蕄 th蕄 nh蕋, kh玭g th� gi秏 c蕄 n鱝!")
	end
	return 0	
end

function SVR_DoDegrade(nTongID, nID, nToLevel)
	return 1
end 

SET_USELEVELSET_R = DEF_FUN
SET_USELEVELSET_G_1 = DEF_FUN
function SET_USELEVELSET_G_1(nTongID, nID)
	SetULConfirm(nTongID, nID)
	return 0
end

function SetULConfirm(nTongID, nID)
	local nLevel = TWS_GetLevel(nTongID, nID)
	local nCurLevel = TWS_GetUseLevel(nTongID, nID)
	local nCurLevelSet = TWS_GetUseLevelSet(nTongID, nID)
	local nUpperLevel = tongGetWorkshopUpperLevel(nTongID, TONG_GetBuildLevel(nTongID))
	if nCurLevelSet <= 0 then
		nCurLevelSet = nCurLevel
	elseif (nCurLevelSet > nCurLevel)then
		nCurLevelSet = nCurLevel
	elseif (nCurLevelSet > nUpperLevel) then	
		nCurLevelSet = nUpperLevel
	end
	local eType = TWS_GetType(nTongID, nID)
	Say("<#>Hi謓 t筰, <color=yellow>"..wsGetName(eType).."<color>ng c蕄 th鵦 t� l� <color=blue>"..
		nLevel.."<color>, ng c蕄 s� d鬾g l� <color=blue>"..nCurLevel.."<color>\n  頲 甶襲 ch豱h ng c蕄 s� d鬾g, "..
		"sau khi <color=red>b秓 tr� h祅g tu莕<color> s� c� hi謚 l鵦, ng c蕄 s� d鬾g hi謓 t筰 l� <color=blue>"..nCurLevelSet.."<color>, "..
		"ngi mu鑞 甶襲 ch豱h ng c蕄 s� d鬾g cho tu莕 sau th� n祇?",3,"C蕄 1 n 5/#SetUseLevelSet("..nTongID..","..nID..",1)",
		"C蕄 6 n 10/#SetUseLevelSet("..nTongID..","..nID..",2)", "Ta mu鑞 r阨 kh醝!/cancel")
end

function SetUseLevelSet(nTongID, nID, nFlag)
	if nFlag == 1 then
		Say("H穣 l鵤 ch鋘 ng c蕄:  ", 6, "C蕄 1/#SUS_Chose("..nTongID..","..nID..",1)", "C蕄 2/#SUS_Chose("..nTongID..","..nID..",2)",
			"C蕄 3/#SUS_Chose("..nTongID..","..nID..",3)", "C蕄 4/#SUS_Chose("..nTongID..","..nID..",4)",
			"C蕄 5/#SUS_Chose("..nTongID..","..nID..",5)", "Tr� l筰/#SetULConfirm("..nTongID..","..nID..")")
	elseif nFlag == 2 then
		Say("H穣 l鵤 ch鋘 ng c蕄:  ", 6, "C蕄 6/#SUS_Chose("..nTongID..","..nID..",6)", "C蕄 7/#SUS_Chose("..nTongID..","..nID..",7)",
			"C蕄 8/#SUS_Chose("..nTongID..","..nID..",8)", "C蕄 9/#SUS_Chose("..nTongID..","..nID..",9)",
			"C蕄 10/#SUS_Chose("..nTongID..","..nID..",10)", "Tr� l筰/#SetULConfirm("..nTongID..","..nID..")")
	end
end

function SUS_Chose(nTongID, nID, nLevel)
	local nWsLevel = TWS_GetLevel(nTongID, nID)
	if (nLevel > nWsLevel)then
		Say("Ъng c蕄 s� d鬾g 頲 ch鋘 kh玭g th� l韓 h琻 ng c蕄 t竎 phng hi謓 t筰", 1, "Bi誸 r錳/cancel")
		return
	end
	local nUpperLevel = tongGetWorkshopUpperLevel(nTongID, TONG_GetBuildLevel(nTongID))	
	if (nLevel > nUpperLevel)then
		Say("Ъng c蕄 s� d鬾g t竎 phng hi謓 t筰 c馻 qu� bang s� gi韎 h筺 � c蕄: <color=red>"..nUpperLevel.."<color>3. Kh玭g th� ch鋘 ng c蕄 cao h琻 ng c蕄 n祔.", 1, "Bi誸 r錳/cancel")
		return
	end
	local eType = TWS_GetType(nTongID, nID)
	local szMsg = "<color=white>"..GetName().."<color>thi誸 l藀 <color=red>"..wsGetName(eType)..
	"<color> ng c蕄 s� d鬾g l� <color=green>"..nLevel.."<color>, ".."Thay i n祔 s� c� hi謚 l鵦 sau m閠 tu莕"
	Msg2Tong(nTongID, szMsg)
	-- 帮会事件记录
	TONG_ApplyAddEventRecord(nTongID, GetName().."Thi誸 l藀 "..wsGetName(eType).." ng c蕄 s� d鬾g hi謓 t筰 l� "..nLevel.."c蕄");
	TWS_ApplySetUseLevelSet(nTongID, nID, nLevel)
end

SET_USELEVEL_R = DEF_FUN
SET_USELEVEL_G_1 = DEF_FUN
function SET_USELEVEL_G_2(nTongID, nID, nToLevel)
	local npcid = TWS_GetBuildingNpc(nTongID, nID)
	if (npcid > 0)then
		if nToLevel > 0 then
			local eType = TWS_GetType(nTongID, nID)
			ChangeNpcFeature(npcid, 0, 0, building_figure[eType][nToLevel])
		else
			DelNpc(npcid)
			TWS_SetBuildingNpc(nTongID, nID, 0)
		end	
	elseif nToLevel > 0 then
		local nMapID = TONG_GetTongMap(nTongID)
		local eType = TWS_GetType(nTongID, nID)
		--无帮会地图或非动态地图
		if (nMapID < DYNMAP_ID_BASE)then
			return 1
		end
		nMapID = SubWorldID2Idx(nMapID)
		local nMapCopy = TONG_GetTongMapTemplate(nTongID)
		--地图不在此服务器
		if (nMapID <= 0 or eType == 0 or nMapCopy <= 0)then
			return 1
		end
		local npcid = add_one_building(nMapID, nMapCopy, eType, 1)
		_dbgMsg("add building npcid:"..npcid)
		if (npcid > 0)then
			TWS_SetBuildingNpc(nTongID, nID, npcid)
		end
	end
	return 1
end

function cancel()
end
	
else
-----------------如果是客户端---------------
Include("\\script\\tong\\workshop\\workshop_setting.lua")
SET_USELEVELSET_C_1 = DEF_FUN
SET_USELEVELSET_C_2 = DEF_FUN
SET_USELEVEL_C_1 = DEF_FUN
SET_USELEVEL_C_2 = DEF_FUN
end	--if结束

--默认的处理函数，要重载可重新赋值
LEARN_R		= RL_DoLearn
LEARN_G_1	= SVR_CheckLearn
LEARN_G_2	= SVR_DoLearn
LEARN_C_1	= DEF_FUN
LEARN_C_2	= DEF_FUN

REMOVE_R	= RL_DoDestroy
REMOVE_G_1	= SVR_CheckDestroy
REMOVE_G_2	= SVR_DoDestroy
REMOVE_C_1	= DEF_FUN
REMOVE_C_2	= DEF_FUN

OPEN_R		= RL_DoOpen
OPEN_G_1	= SVR_CheckOpen
OPEN_G_2	= SVR_DoOpen
OPEN_C_1 	= DEF_FUN
OPEN_C_2 	= DEF_FUN

CLOSE_R		= RL_DoClose
CLOSE_G_1	= SVR_CheckClose
CLOSE_G_2	= SVR_DoClose
CLOSE_C_1 	= DEF_FUN
CLOSE_C_2 	= DEF_FUN

UPGRADE_R	= RL_DoLevelUp
UPGRADE_G_1	= SVR_CheckLevelUp
UPGRADE_G_2	= SVR_DoLevelUp
UPGRADE_C_1 = DEF_FUN
UPGRADE_C_2 = DEF_FUN

DEGRADE_R	= RL_DoDegrade
DEGRADE_G_1	= SVR_CheckDegrade
DEGRADE_G_2	= SVR_DoDegrade
DEGRADE_C_1 = DEF_FUN
DEGRADE_C_2 = DEF_FUN

--MAINTAIN_R	 = DEF_FUN
MAINTAIN_G_1 = DEF_FUN
MAINTAIN_G_2 = DEF_FUN
MAINTAIN_C_1 = DEF_FUN
MAINTAIN_C_2 = DEF_FUN