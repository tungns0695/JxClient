Include("\\script\\event\\wulin_final_match\\awardhead.lua")

Include("\\script\\task\\task_addplayerexp.lua")  --给玩家累加经验的公共函数
Include("\\script\\lib\\file.lua")

function wl_get_zonename( clientid )
	for i = 1, getn( WL_TAB_ZONEINFO ) do
		if ( WL_TAB_ZONEINFO[ i ][ 2 ] == clientid ) then
			return WL_TAB_ZONEINFO[ i ][ 1 ]
		end
	end
	return nil
end

function safe_tonumber( str )
	local ret=tonumber(str)
	if (ret==nil) then
		return 0
	else
		return	ret
	end
end

function wl_get_zonefile_match( zonename )
	if ( zonename ~= nil and zonename ~= "" ) then
		return "\\data\\wulin\\"..zonename.."award.dat"
	end
	return nil
end

function wl_get_zonefile_actor( zonename )
	if ( zonename ~= nil and zonename ~= "" ) then
		return "\\data\\wulin\\"..zonename.."actoraward.dat"
	end
	return nil
end

------------------------------------------------------------------------------------
-- 打开一个文件
function biwu_loadfile(filename)
	if (IniFile_Load(filename, filename) == 0) then
		File_Create(filename)
	end
end

--获得文件中的szSection的key的值
function biwu_getdata(filename, szsect, szkey)
	return IniFile_GetData(filename, szsect, szkey)
end

--设置文件中的szSection的key值为szValue
function biwu_setdata(filename, szsect, szkey, szvalue)
	IniFile_SetData(filename, szsect, szkey, szvalue)	
end

function biwu_save(filename)
	IniFile_Save(filename, filename)
end

------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------
function GetIniFileData(mapfile, sect, key)
	if (IniFile_Load(mapfile, mapfile) == 0) then 
		print("Load IniFile Error!"..mapfile)
		return ""
	else
		return IniFile_GetData(mapfile, sect, key)	
	end
end


------------------------------------------------------------------------------------

--主要作用：判断是否可以领取该项奖励
--==========================================================================
--当查询区服获一、二、三等奖数量时：
--nMatchType：ZONEAWARD_TASKID_FIRST 或 ZONEAWARD_TASKID_SECOND 或 ZONEAWARD_TASKID_THIRD
--nAwardLevel：无用
--[返回]：该项奖励的数量
----------------------------------------------
--当查询其他奖项时：
--nMatchType：即为TaskID，代表比赛类型
--nAwardLevel：奖励等级
--	nAwardLevel=0表示：返回该奖项的奖励等级
--[返回]-1：	表示已经领过了
--[返回]0：	表示没有奖励
--[返回]1：	表示可以领取该项奖励
---------------------------------------------------
function wl_CheckAward(nMatchType, nAwardLevel)
	if( GetTask(nMatchType) == -1 ) then
		return -1
	end

	local nClientID = GetGateWayClientID()
	local strPlayerAccount = GetAccount()
	local strZoneName = wl_get_zonename( nClientID )
	local strPlayerName = GetName()
	local strZoneSection = tostring( nClientID )

	--必须是比赛区服
	if (strZoneName == nil) then
		-- print("必须是比赛区服")
		return 0
	end
	--必须50级以上
	if (GetLevel() < 50) then
		-- print("必须50级以上")
		return 0
	end

	--全区服获得一、二、三等奖数量（全服奖励）
	if (nMatchType == ZONEAWARD_TASKID_FIRST or nMatchType == ZONEAWARD_TASKID_SECOND or nMatchType == ZONEAWARD_TASKID_THIRD) then
		local strAwardType
		if (nMatchType == ZONEAWARD_TASKID_FIRST) then
			strMatchType="First"
		elseif (nMatchType == ZONEAWARD_TASKID_SECOND) then
			strMatchType="Second"
		elseif (nMatchType == ZONEAWARD_TASKID_THIRD) then
			strMatchType="Third"
		end

		biwu_loadfile( WL_FILE_ZONEAWARD )
		local nAwardCount = safe_tonumber(biwu_getdata( WL_FILE_ZONEAWARD, strZoneSection, strMatchType ))
		return nAwardCount
	end

	--其他奖励必须是参赛队员
	local nChampTitle = champ_checktitle();
	if (nChampTitle == nil) then
		-- print("必须是参赛队员")
		return 0
	end

	--参赛人员奖励（队员、领队）
	local nReadAwardLevel	--读取到的奖励等级
	if (nMatchType == ZONEAWARD_TASKID_ACTORAWARD or nMatchType == ZONEAWARD_TASKID_LEADAWARD) then
		if (nMatchType == ZONEAWARD_TASKID_LEADAWARD and nChampTitle~=7) then
			-- print("必须是领队")
			return 0
		end
		biwu_loadfile( WL_FILE_ACTORAWARD )
		nReadAwardLevel = safe_tonumber(biwu_getdata( WL_FILE_ACTORAWARD, strZoneSection, "ZoneAwardType" ))
	--区服团体赛奖励
	elseif (nMatchType == ZONEAWARD_TASKID_ZONE) then
		biwu_loadfile( WL_FILE_ACTORAWARD )
		nReadAwardLevel = safe_tonumber(biwu_getdata( WL_FILE_ACTORAWARD, strZoneSection, "ZoneMatch" ))
	--单项奖奖励（单人、双人、五行、十人、十六人）
	else
		local strMatchType
		if (nMatchType == ZONEAWARD_TASKID_SINGLE) then
			strMatchType="SingleMatch"
		elseif (nMatchType == ZONEAWARD_TASKID_DOUBLE) then
			strMatchType="DoubleMatch"
		elseif (nMatchType == ZONEAWARD_TASKID_FIVE) then
			strMatchType="FiveMatch"
		elseif (nMatchType == ZONEAWARD_TASKID_TEN) then
			strMatchType="TenMatch"
		elseif (nMatchType == ZONEAWARD_TASKID_SIXTEEN) then
			strMatchType="SixteenMatch"
		else
			-- print("无此奖励类型！")
			return 0
		end

		biwu_loadfile( WL_FILE_MATCHAWARD )
		local strReadPlayerName = biwu_getdata( WL_FILE_MATCHAWARD, strPlayerAccount, "Key" )
		if (strReadPlayerName == nil or strReadPlayerName ~= strPlayerName) then
			-- print("没有该角色信息")
			return 0
		end

		nReadAwardLevel = safe_tonumber(biwu_getdata(WL_FILE_MATCHAWARD, GetAccount(), strMatchType))
	end

	if (nAwardLevel == nil or nAwardLevel <= 0) then
		return nReadAwardLevel
	elseif (nAwardLevel == nReadAwardLevel) then
		return 1
	else
		-- print("奖项不符")
		return 0
	end
end

-----------------------------------------------------------

--最终领取奖品（含保护）
--返回：1、成功；0、失败
function wl_FinalTakeMatch( nTaskID, nCount )
	local nAwardLevel = wl_CheckAward(nTaskID)

	if( nAwardLevel == -1 ) then
		Say("Sao? Ngi l穘h r錳 m�, sao c遪 n y?!!", 0)
		-- print("你应该已经领取过了")
		return 0
	elseif( nAwardLevel == 0 ) then
		Say("Xin l鏸! Ngi kh玭g th� nh薾 ph莕 thng !", 0)
		WriteLog("Ph莕 thng v� l﹎ i h閕 b� l鏸!!    C� ngi 產ng l穘h thng 'nh﹏ i kinh nghi謒' kh玭g ph秈 c馻 m譶h! ["..GetName().."]  TaskID:"..nTaskID);
		-- print("尝试领取不能领取的奖项！	["..GetName().."]  TaskID:"..nTaskID);
		return 0
	end
	
	local nClientID = GetGateWayClientID();
	local strZoneName = tostring( nClientID )

	--一等奖奖励
	if (nTaskID == ZONEAWARD_TASKID_FIRST) then
		if( nCount == nil or nCount <= 0 ) then
			-- print("领取仙草露数目不大于 0 或 nil 。")
			WriteLog("Ph莕 thng v� l﹎ i h閕 b� l鏸!!    L穘h 'Ti猲 Th秓 L�' kh玭g 頲 vt qu� m鴆 0 ho芻 nil")
			return 0
		end;
		
		if( wl_get_awardcount( nAwardLevel , nTaskID ) < nCount ) then
			Say("S� lng nh薾 頲 h譶h nh� kh玭g ng!", 0)
			-- print("有人尝试领取过多的仙草露！	["..GetName().."]:SecondAward:"..nCount.."/"..GetTask( nTaskID ));
			WriteLog("Ph莕 thng v� l﹎ i h閕 b� l鏸!!    C� ngi l穘h thng 'Ti猲 Th秓 L�' vt qu� s� l莕 cho ph衟! ["..GetName().."]:SecondAward:"..nCount.."/"..GetTask( nTaskID ));
			return 0
		end;
		
		local nRoom = CalcFreeItemCellCount()
		if ( nRoom < nCount ) then
			Say("H祅h trang  h誸 ch�! S緋 x誴 l筰 r錳 h穣 n y!  Vt qu� m鴆 thng 'Ti猲 Th秓 L�'", 0)
			-- print("你的背包好像没有那么多位置", 0)
			return 0
		end;
		
		SetTask( nTaskID, GetTask( nTaskID ) - nCount )
		if( GetTask( nTaskID ) == 0 ) then
			SetTask( nTaskID, -1 )
		end;
		for i = 1, nCount do
			AddItem( 6, 1, 71, 1, 0, 0, 0 )
		end;
		Msg2Player("Ch骳 m鮪g, b筺 nh薾 頲"..nCount.."1 Ti猲 Th秓 l� ")
		WriteLog(date("%y-%m-%d,%H:%M,").."Account==["..GetAccount().."],RoleName=="..GetName()..", Ph莕 thng trong khu v鵦 nh薾 頲"..nCount.."Ti猲 Th秓 L� ")
		return 1
	--二、三等奖奖励，都是加双倍经验
	elseif (nTaskID == ZONEAWARD_TASKID_SECOND or nTaskID == ZONEAWARD_TASKID_THIRD) then
		if( nCount == nil or nCount <= 0 ) then
			WriteLog("Ph莕 thng v� l﹎ i h閕 b� l鏸!!    L穘h '甶觤 kimh nghi謒' kh玭g 頲 vt qu� m鴆 0 ho芻 nil")
			-- print("领取双倍经验数目不大于 0 或 nil。")
			return 0
		end;
		
		if( wl_get_awardcount( nAwardLevel , nTaskID ) < nCount ) then
			WriteLog("Ph莕 thng v� l﹎ i h閕 b� l鏸!!    C� ngi l穘h thng 'nh﹏ i kinh nghi謒' vt qu� s� l莕 cho ph衟!! ["..GetName().."]:SecondAward:"..nCount.."/"..GetTask( nTaskID ));
			-- print("尝试领取过多的双倍经验！	["..GetName().."]:SecondAward:"..nCount.."/"..GetTask( nTaskID ));
			return 0
		end
		SetTask( nTaskID, GetTask(nTaskID) - nCount )
		
		if( GetTask( nTaskID ) == 0 ) then
			SetTask( nTaskID, -1 )
		end
		
		local nDoubleTime = 15 * nCount
		if (nTaskID == ZONEAWARD_TASKID_SECOND) then
			nDoubleTime = nDoubleTime * 2;
		end
		
		AddSkillState(440, 1, 1, nDoubleTime * 60 * 18)
		Msg2Player("Ch骳 m鮪g, b筺 nh薾 頲"..nDoubleTime.."s� ph髏 t╪g g蕄 i 甶觤 kinh nghi謒")
		WriteLog(date("%y-%m-%d,%H:%M,").."Account==["..GetAccount().."],RoleName=="..GetName().."Ph莕 thng trong khu v鵦 nh薾 頲"..nDoubleTime.."s� ph髏 t╪g g蕄 i 甶觤 kinh nghi謒")
		return 1
	--参赛选手奖励
	elseif (nTaskID == ZONEAWARD_TASKID_ACTORAWARD) then
		--总数控制
		biwu_loadfile( WL_FILE_MATCHAWARD )
		local nAwardCount = safe_tonumber(biwu_getdata( WL_FILE_MATCHAWARD, strZoneName, "ActorAwardGot"))
		if( nAwardCount >= 100 ) then
			Say("Xin l鏸! Ph莕 thng   頲 l穘h h誸!", 0)
			-- print("奖品已经领完了，仍有人尝试领奖！	["..GetName().."]:ActorAward");
			WriteLog("Ph莕 thng v� l﹎ i h閕 b� l鏸!!    C� ngi  nh薾 thng r錳, nh璶g l筰 n nh薾 n鱝! ["..GetName().."]:ActorAward");
			return 0
		else
			biwu_setdata( WL_FILE_MATCHAWARD, strZoneName, "ActorAwardGot", nAwardCount+1);
			biwu_save(WL_FILE_MATCHAWARD)
		end
		
		nCount = WL_TAB_ACTORAWARD_INFO[ nAwardLevel ][ 2 ]
		local nRoom = CalcFreeItemCellCount()
		if( nRoom < nCount ) then
			Say("H祅h trang  h誸 ch�! S緋 x誴 l筰 r錳 h穣 n y!Ph莕 thng n祔  c� ngi l穘h r錳.", 0)
			Say("Ch� tr鑞g trong h祅h trang c馻 b筺 kh玭g ", 0)
			return 0
		end
		
		SetTask( ZONEAWARD_TASKID_ACTORAWARD, -1 )

		wl_addownexp( WL_TAB_ACTORAWARD_INFO[ nAwardLevel ][ 3 ] )
		AddItem( 6, 1, 831, 1, 0, 0, 0 )		--武林大会红包	？？
		Msg2Player("Ch骳 m鮪g, b筺 nh薾 頲"..WL_TAB_ACTORAWARD_INFO[ nAwardLevel ][ 1 ])
		WriteLog(date("%y-%m-%d,%H:%M,").."Account==["..GetAccount().."],RoleName=="..GetName()..", tuy觧 th� tham gia thi u khu v鵦 nh薾 頲"..WL_TAB_ACTORAWARD_INFO[ nAwardLevel ][ 1 ].."X誴 h筺g t輈h l騳 khu v鵦"..nAwardLevel)
		return 1
	--总领队奖励
	elseif (nTaskID == ZONEAWARD_TASKID_LEADAWARD) then
		--总数控制
		biwu_loadfile( WL_FILE_MATCHAWARD )
		local nAwardCount = safe_tonumber(biwu_getdata( WL_FILE_MATCHAWARD, strZoneName, "LeadAwardGot"))
		if( nAwardCount >= 1 ) then
			Say("Xin l鏸! Ph莕 thng   頲 l穘h h誸!", 0)
			WriteLog("Ph莕 thng v� l﹎ i h閕 b� l鏸!!    C� ngi  nh薾 thng r錳, nh璶g l筰 n nh薾 n鱝! ["..GetName().."]:LeadAward");
			-- print("奖品已经领完了，仍有人尝试领奖！	["..GetName().."]:LeadAward");
			return 0
		else
			biwu_setdata( WL_FILE_MATCHAWARD, strZoneName, "LeadAwardGot", 1);
			biwu_save(WL_FILE_MATCHAWARD)
		end
		
		nCount = WL_TAB_LEADERAWARD_INFO[ nAwardLevel ][ 2 ]
		local nRoom = CalcFreeItemCellCount()
		
		if( nRoom < nCount or (nAwardLevel == 1 and nRoom < nCount + 6)) then
			Say("H祅h trang  h誸 ch�! S緋 x誴 l筰 r錳 h穣 n y!Ph莕 thng n祔  c� ngi l穘h r錳.", 0)
			-- print("背包空间好像不够", 0)
			return 0
		end
		
		if( nAwardLevel == 1 ) then
			wl_addgolditem_random()
		end
		
		for i = 1, nCount do
			AddItem( 6, 1, 831, 1, 0, 0, 0 )		--武林大会红包	？？
		end;

		SetTask( ZONEAWARD_TASKID_LEADAWARD, -1 )
		Msg2Player("Ch骳 m鮪g, b筺 nh薾 頲"..nCount.."1 V� L﹎ i h錸g bao")
		WriteLog(date("%y-%m-%d,%H:%M,").."Account==["..GetAccount().."],RoleName=="..GetName()..", T鎛g l穘h i khu v鵦 nh薾 頲"..WL_TAB_LEADERAWARD_INFO[ nAwardLevel ][ 1 ].."X誴 h筺g t輈h l騳 khu v鵦"..nAwardLevel)
		return 1
	end

	--单项奖奖励（单人、双人、五行、十人、十六人、团体）
	local strMatchName
	if (nTaskID == ZONEAWARD_TASKID_SINGLE) then
		strMatchName = "SingleMatch"
	elseif (nTaskID == ZONEAWARD_TASKID_DOUBLE) then
		strMatchName = "DoubleMatch"
	elseif (nTaskID == ZONEAWARD_TASKID_FIVE) then
		strMatchName = "FiveMatch"
	elseif (nTaskID == ZONEAWARD_TASKID_TEN) then
		strMatchName = "TenMatch"
	elseif (nTaskID == ZONEAWARD_TASKID_SIXTEEN) then
		strMatchName = "SixteenMatch"
	elseif (nTaskID == ZONEAWARD_TASKID_ZONE) then
		strMatchName = "ZoneMatch"
	end

	local strAwardCountName
	if (nTaskID == ZONEAWARD_TASKID_ZONE) then
		strAwardCountName = "ZoneMatchLeft"
	else
		strAwardCountName = strMatchName..tostring(nAwardLevel).."Left"
	end

	--奖品总数控制
	biwu_loadfile( WL_FILE_MATCHAWARD )
	local nAwardCount = safe_tonumber(biwu_getdata( WL_FILE_MATCHAWARD, strZoneName, strAwardCountName))
	if( nAwardCount <= 0 ) then
		Say("Xin l鏸! Ph莕 thng   頲 l穘h h誸!", 0)
		WriteLog("Ph莕 thng v� l﹎ i h閕 b� l鏸!!    C� ngi  nh薾 thng r錳, nh璶g l筰 n nh薾 n鱝! ["..GetName().."]:matchtype:"..strMatchName..":award:"..nAwardLevel);
		-- print("奖品已经领完了，仍有人尝试领奖！	["..GetName().."]:matchtype:"..strMatchName..":award:"..nAwardLevel);
		return 0
	else
		biwu_setdata( WL_FILE_MATCHAWARD, strZoneName, strAwardCountName, nAwardCount-1);
		biwu_save(WL_FILE_MATCHAWARD)
	end

	--如果是门派单项赛冠军则奖励是固定的 大黄金装备
	if(nTaskID == ZONEAWARD_TASKID_SINGLE and nAwardLevel == 1) then
		if ( wl_awardgolditem( GetLastFactionNumber(), nTaskID ) ~= nil ) then
			SetTask( nTaskID, -1 )
		end
		return 1
	end
	
	local nCount = WL_TAB_MATCHAWARD_INFO[ strMatchName ][nAwardLevel][2]
	if( nCount == nil or nCount == 0 ) then
		WriteLog( "Ph莕 thng v� l﹎ i h閕 b� l鏸    count==0 match=="..strMatchName..", ph莕 thng l� "..WL_TAB_MATCHAWARD_INFO[ strMatchName ][nAwardLevel][1] )
		-- print( "武林大会奖励出错		count==0 match=="..strMatchName..",奖励为"..WL_TAB_MATCHAWARD_INFO[ strMatchName ][nAwardLevel][1] )
		return 0
	end
	
	--如果是双人赛的或者五行赛的冠军则，每人还有一件随机的大黄金
	if( ( strMatchName == "DoubleMatch" or strMatchName == "FiveMatch" ) and nAwardLevel == 1 ) then
		wl_addgolditem_random()	--奖励随机的大黄金
	end
	
	local q = WL_TAB_MATCHAWARD_INFO[ strMatchName ][nAwardLevel][3]
	local g = WL_TAB_MATCHAWARD_INFO[ strMatchName ][nAwardLevel][4]
	local d = WL_TAB_MATCHAWARD_INFO[ strMatchName ][nAwardLevel][5]
	local l = WL_TAB_MATCHAWARD_INFO[ strMatchName ][nAwardLevel][6]
	local f = WL_TAB_MATCHAWARD_INFO[ strMatchName ][nAwardLevel][7]
	local k = WL_TAB_MATCHAWARD_INFO[ strMatchName ][nAwardLevel][8]
	local m = WL_TAB_MATCHAWARD_INFO[ strMatchName ][nAwardLevel][9]
	for i = 1, nCount do
		AddItem( q, g, d, l, f, k, m )
	end
	SetTask( nTaskID, -1 )
	Msg2Player( "Ch骳 m鮪g, b筺 nh薾 頲"..WL_TAB_MATCHAWARD_INFO[ strMatchName ][nAwardLevel][1] )
	WriteLog(date("%y-%m-%d,%H:%M").."Account==["..GetAccount().."] RoleName=="..GetName()..",  nh薾 頲"..WL_TAB_MATCHAWARD_INFO[ strMatchName ][nAwardLevel][1].."tham gia tr薾 u l� "..strMatchName)
	return 1
end

--============================================

function wl_get_awardcount( count, taskid )
	if ( GetTask( taskid ) == 0 ) then
		SetTask( taskid, count )
		return count
	end
	if( GetTask( taskid ) == -1 ) then
		return 0
	end
	return GetTask( taskid )
end

function champ_checktitle()
	
	local nClientID = GetGateWayClientID();
	local zonename = wl_get_zonename( nClientID )
	if( zonename == nil ) then	--不是比赛区服
		return nil
	end
	local prefix = "\\data\\wulin\\"..nClientID.."\\"
	local name = ""	--判断是不是总领队
	biwu_loadfile( prefix .. BID_LEADER )
	name = biwu_getdata( prefix..BID_LEADER, "Leader_Name", "Name")
	if( GetName() == name ) then
		return 7
	end
	
	name = ""	--判断是不是世界十大
	biwu_loadfile(prefix.. LEVELTOP10 )
	for i = 1, 10 do
		name = biwu_getdata(prefix..LEVELTOP10, "LevelTop10", "Top"..i);
		if( name == GetName() ) then
			return 1
		end
	end

	name = ""	--判断是不是门派赛前五名
	local fanctionnum = GetLastFactionNumber()
	--for fanctionnum = 0, 9 do	--temp
	biwu_loadfile( prefix..WL_FACTION[fanctionnum+1][1] )
	for i = 1, 5 do
		name = biwu_getdata(prefix..WL_FACTION[fanctionnum+1][1], WL_FACTION[fanctionnum+1][2], "Top"..i);
		if( name == GetName() ) then
			return 1
		end
	end
	--end	--temp

	name = ""	--判断是不是总领队给与的参赛资格
	local count = 0
	biwu_loadfile( prefix..LEADER_MEMBER )
	count = tonumber(biwu_getdata(prefix..LEADER_MEMBER, "LeadMember", "Count"))
	if( count == 0 ) then
		return nil
	end
	for i = 1, count do
		name = biwu_getdata(prefix..LEADER_MEMBER, "LeadMember", "Member"..i)
		if( GetName() == name ) then
			return 1
		end
	end
	
	return nil
end;

------------------------------------------------------------------------------------
--main
function wulin_awardmain()
	local nClientID = GetGateWayClientID();
	local zonename = wl_get_zonename( nClientID )
	local nowday = tonumber(date("%Y%m%d"))
	local bAwardNow = 1
	if (nowday > WL_AWARD_TIME[2] or nowday < WL_AWARD_TIME[1]) then
		bAwardNow = 0
	end
		
	if( zonename == nil or bAwardNow == 0) then	--不是比赛区服
		Say("V� l﹎ i h閕  k誸 th骳, k誸 qu� chi ti誸 li猲 h� trang ch�.", 0)
		return
	end

	if ( GetLevel() < 50 ) then
		Say("V� l﹎ i h閕  ch輓h th鴆 h� m祅, k誸 qu� chi ti誸 xin li猲 h� trang ch�. <color=red>c蕄 50<color> tr� l猲 c� th� � ch� ta nh薾 ph莕 thng khu v鵦", 0)
		return
	end
	
	local zonesection = tostring( nClientID )
	biwu_loadfile( WL_FILE_ZONEAWARD )
	local firstcount = tonumber(biwu_getdata( WL_FILE_ZONEAWARD, zonesection, "First" ))--biwu_getdata( WL_FILE_ZONEAWARD, zonesection, "First" )
	local secondcount = tonumber(biwu_getdata( WL_FILE_ZONEAWARD, zonesection, "Second" ))
	local thirdcount = tonumber(biwu_getdata( WL_FILE_ZONEAWARD, zonesection, "Third" ))
	
	WL_FILE_MATCHAWARD = wl_get_zonefile_match( zonesection )
	WL_FILE_ACTORAWARD = wl_get_zonefile_actor( zonesection )
	
	local count = 0
	local tbOpp = {}
	count = firstcount + secondcount + thirdcount
	if (GetLastFactionNumber() ~= -1 and GetCamp() > 0) then
		if ( champ_checktitle() ~= nil ) then	--是不是参赛选手
			tbOpp[ getn( tbOpp ) + 1 ] = "Ph莕 thng v� l﹎ i h閕 b竛 k誸/wl_matchaward"
			tbOpp[ getn( tbOpp ) + 1 ] = "Ph莕 thng tuy觧 th� tham gia thi u khu v鵦/wl_joinaward"
			tbOpp[ getn( tbOpp ) + 1 ] = "Nh薾 danh hi謚 v� l﹎ i h閕 b竛 k誸/wl_taketitle"
		end
	end
		
	if (nowday >= WL_ZONEAWARD_TIME[1] and nowday <= WL_ZONEAWARD_TIME[2]) then
		if (count > 0 ) then --区服中有获得冠、亚、季军，则
			tbOpp[ getn( tbOpp ) + 1 ] = "Ph莕 thng khu v鵦/#wl_awardall("..firstcount..","..secondcount..","..thirdcount..")"
		end
	end
	
	if( getn( tbOpp ) < 1 ) then	--没有奖励
		Say("V� l﹎ i h閕  k誸 th骳, k誸 qu� chi ti誸 li猲 h� trang ch�.", 0)
		return
	end
	
	tbOpp[ getn( tbOpp ) + 1 ] = "Ta ch� n ch琲/OnCancel"
	Say( "V� l﹎ i h閕  k誸 th骳, c� th� n ch� ta l穘h thng.", getn(tbOpp), tbOpp )
end;

--------------------------------------------------------------------------------------------

function wl_matchaward()
	local nClientID = GetGateWayClientID();
	local zonename = wl_get_zonename( nClientID )
	local zonesection = tostring( nClientID )
	--WL_TAB_MATCHAWARD_INFO
	--WL_FILE_MATCHAWARD
	local playeraccount = GetAccount()
	local playername = GetName()

	biwu_loadfile( WL_FILE_MATCHAWARD )
	local rolename = biwu_getdata( WL_FILE_MATCHAWARD, playeraccount, "Key" )
	
	biwu_loadfile( WL_FILE_ACTORAWARD )
	local zonematch = tonumber(biwu_getdata( WL_FILE_ACTORAWARD, zonesection, "ZoneMatch" ))
	
	if( (rolename == nil or playername ~= rolename) and zonematch == 0 ) then
		Say("ngi kh玭g nh薾 頲 th� h筺g n祇 qua c竎 gi秈 u, c� g緉g r蘮 luy謓 h琻 nh�! K誸 qu� chi ti誸 xin li猲 h� trang ch�.", 0)
		return
	end
	
	local tbOpp = {}
	
	biwu_loadfile( WL_FILE_ACTORAWARD )
	if( zonematch ~= 0 and GetTask( ZONEAWARD_TASKID_ZONE ) ~= -1 ) then
		tbOpp[ getn( tbOpp ) + 1 ] = "Ph莕 thng thi u t藀 th� khu v鵦___"..WL_TAB_MATCHAWARD_INFO[ "ZoneMatch" ][zonematch][1].."/#wl_want2takematch('ZoneMatch',"..zonematch..","..ZONEAWARD_TASKID_ZONE..")"
	end
	
	biwu_loadfile( WL_FILE_MATCHAWARD )
	local singlematch = 0
	local doublematch = 0
	local fivematch = 0
	local tenmatch = 0
	local sixteenmatch = 0
	if( rolename ~= nil and playername == rolename ) then
		singlematch	=	tonumber(biwu_getdata( WL_FILE_MATCHAWARD, playeraccount, "SingleMatch" ))
		doublematch	=	tonumber(biwu_getdata( WL_FILE_MATCHAWARD, playeraccount, "DoubleMatch" ))
		fivematch 	=	tonumber(biwu_getdata( WL_FILE_MATCHAWARD, playeraccount, "FiveMatch" ))
		tenmatch	=	tonumber(biwu_getdata( WL_FILE_MATCHAWARD, playeraccount, "TenMatch" ))
		sixteenmatch	=	tonumber(biwu_getdata( WL_FILE_MATCHAWARD, playeraccount, "SixteenMatch" ))
		
		if( singlematch ~= 0 and GetTask( ZONEAWARD_TASKID_SINGLE ) ~= -1 ) then
			tbOpp[ getn( tbOpp ) + 1 ] = "Ph莕 thng Кn u m玭 ph竔___"..WL_TAB_MATCHAWARD_INFO[ "SingleMatch" ][singlematch][1].."/#wl_want2takematch('SingleMatch',"..singlematch..","..ZONEAWARD_TASKID_SINGLE..")"
		end
		if( doublematch ~= 0 and GetTask( ZONEAWARD_TASKID_DOUBLE ) ~= -1 ) then
			tbOpp[ getn( tbOpp ) + 1 ] = "Ph莕 thng Song u___"..WL_TAB_MATCHAWARD_INFO[ "DoubleMatch" ][doublematch][1].."/#wl_want2takematch('DoubleMatch',"..doublematch..","..ZONEAWARD_TASKID_DOUBLE..")"
		end
		if( fivematch ~= 0 and GetTask( ZONEAWARD_TASKID_FIVE ) ~= -1 ) then
			tbOpp[ getn( tbOpp ) + 1 ] = "Ph莕 thng Ng� h祅h u___"..WL_TAB_MATCHAWARD_INFO[ "FiveMatch" ][fivematch][1].."/#wl_want2takematch('FiveMatch',"..fivematch..","..ZONEAWARD_TASKID_FIVE..")"
		end
		if( tenmatch ~= 0 and GetTask( ZONEAWARD_TASKID_TEN ) ~= -1 ) then
			tbOpp[ getn( tbOpp ) + 1 ] = "Ph莕 thng Th藀 ph竔 u___"..WL_TAB_MATCHAWARD_INFO[ "TenMatch" ][tenmatch][1].."/#wl_want2takematch('TenMatch',"..tenmatch..","..ZONEAWARD_TASKID_TEN..")"
		end
		if( sixteenmatch ~= 0 and GetTask( ZONEAWARD_TASKID_SIXTEEN ) ~= -1 ) then
			tbOpp[ getn( tbOpp ) + 1 ] = "Ph莕 thng Th藀 l鬰 s竧 u___"..WL_TAB_MATCHAWARD_INFO[ "SixteenMatch" ][sixteenmatch][1].."/#wl_want2takematch('SixteenMatch',"..sixteenmatch..","..ZONEAWARD_TASKID_SIXTEEN..")"
		end
	end
	
	if( getn( tbOpp ) == 0 ) then
		Say( "Ngi  nh薾 qua ph莕 thng ho芻 kh玭g c� ph莕 thng, k誸 qu� chi ti誸 xin v祇 trang ch�.", 0 )
		return
	end
	tbOpp[ getn( tbOpp ) + 1 ] = "L竧 n鱝 ta quay l筰/OnCancel"
	Say("Ngi c� th� nh薾 ph莕 thng m閠 l骳, trc khi nh薾 xin s緋 x誴 l筰 h祅h trang!", getn( tbOpp ), tbOpp)
end

function wl_want2takematch( sectionname ,awardtype, taskid )
	local room = 0
	room = CalcFreeItemCellCount()
	if( room < 12 ) then
		Say("H祅h trang  h誸 ch�! S緋 x誴 l筰 r錳 h穣 n y!", 0)
		return
	end
	Say( "Hi謓 t筰 ngi c莕 l穘h l� "..WL_TAB_MATCHAWARD_INFO[ sectionname ][awardtype][1]..", l穘h ngay b﹜ gi� ch�?", 2, "Лa cho ta nhanh 甶!/#wl_FinalTakeMatch("..taskid..")", "в ta suy ngh� l筰/OnCancel" )
end

function wl_awardgolditem( fact, taskid )
	if ( fact == 0 ) then
		print("c馻 Thi誹 L﹎ nh璶g kh玭g c� gi秈 Qu竛 qu﹏ Thi誹 L﹎")
		return nil
	end
	
	if( fact == 1 ) then
		AddGoldItem(0,19)
		Msg2Player("Ch骳 m鮪g b筺 nh薾 頲 1 H竚 Thi猲 H� u Kh萵 Th骳 Uy觧")
		WriteLog(date("%y-%m-%d,%H:%M").."Account==["..GetAccount().."] RoleName=="..GetName()..", nh薾 頲 gi秈 nh蕋 n u Thi猲 Vng, ph莕 thng l� 1 Kh萵 Th骳 Uy觧")
		return 1
	elseif ( fact == 2 ) then
		AddGoldItem(0,80)
		Msg2Player("Ch骳 m鮪g b筺 nh薾 頲 1 Thi猲 Quang Th骳 Thi猲 Phc мa Ho祅")
		WriteLog(date("%y-%m-%d,%H:%M").."Account==["..GetAccount().."] RoleName=="..GetName()..", nh薾 頲 gi秈 nh蕋 n u Л阯g M玭, ph莕 thng l� 1 Phc мa Ho祅")
		return 1
	elseif( fact == 3 ) then
		AddGoldItem(0,59)
		Msg2Player("Ch骳 m鮪g, nh薾 頲 m閠 U Lung Ng﹏ Thi襪 H� Th� ")
		WriteLog(date("%y-%m-%d,%H:%M").."Account==["..GetAccount().."] RoleName=="..GetName()..", nh薾 頲 gi秈 nh蕋 n u Ng� чc, ph莕 thng l� 1 Ng﹏ Thi襪 H� Th� ")
		return 1
	elseif( fact == 6 ) then
		AddGoldItem(0,100)
		Msg2Player("Ch骳 m鮪g b筺 nh薾 頲 1 мch Kh竔 Th秓 Gian Th筩h Gi韎")
		WriteLog(date("%y-%m-%d,%H:%M").."Account==["..GetAccount().."] RoleName=="..GetName()..", nh薾 頲 gi秈 nh蕋 n u C竔 Bang, ph莕 thng l� 1 Gian Th筩h Gi韎")
		return 1
	elseif( fact == 7 ) then
		AddGoldItem(0,113)
		Msg2Player("Ch骳 m鮪g b筺 nh薾 頲 ph莕 thng Ma Th� Nghi謕 H醓 U Minh Gi韎")
		WriteLog(date("%y-%m-%d,%H:%M").."Account==["..GetAccount().."] RoleName=="..GetName()..", nh薾 頲 gi秈 nh蕋 n u Thi猲 Nh蒼, ph莕 thng l� 1 U Minh Gi韎")
		return 1
	elseif( fact == 4 ) then
		AddGoldItem(0,35)
		Msg2Player("Ch骳 m鮪g b筺 nh薾 頲 1 V� Gian B筩h Ng鋍 B祅 Ch� ")
		WriteLog(date("%y-%m-%d,%H:%M").."Account==["..GetAccount().."] RoleName=="..GetName()..", nh薾 頲 gi秈 nh蕋 n u Nga My, ph莕 thng l� 1 V� Gian B筩h Ng鋍 B祅 Ch� ")
		return 1
	elseif( fact == 5 ) then
		AddGoldItem(0,50)
		Msg2Player("Ch骳 m鮪g b筺 nh薾 頲 1 T� Ho祅 Th髖 Ng鋍 Ch� Ho祅")
		WriteLog(date("%y-%m-%d,%H:%M").."Account==["..GetAccount().."] RoleName=="..GetName()..", nh薾 頲 gi秈 nh蕋 n u Th髖 Y猽, ph莕 thng l� 1 Ng鋍 Ch� Ho祅")
		return 1
	elseif( fact == 8 ) then
		AddGoldItem(0,125)
		Msg2Player("Ch骳 m鮪g b筺 nh薾 頲 1 C藀 Phong Thanh T飊g Ph竝 Gi韎")
		WriteLog(date("%y-%m-%d,%H:%M").."Account==["..GetAccount().."] RoleName=="..GetName()..", nh薾 頲 gi秈 nh蕋 n u V� ng, ph莕 thng l� 1 Thanh T飊g Ph竝 Gi韎")
		return 1
	elseif( fact == 9 ) then
		AddGoldItem(0,130)
		Msg2Player("Ch骳 m鮪g b筺 nh薾 頲 1 Sng Tinh Phong B筼 ch� ho祅")
		WriteLog(date("%y-%m-%d,%H:%M").."Account==["..GetAccount().."] RoleName=="..GetName()..", nh薾 頲 gi秈 nh蕋 n u C玭 L玭, ph莕 thng l� 1 Sng Tinh Phong B筼 ch� ho祅")
		return 1
	else
		print("wl_awardgolditem faction wrong!!!!error!!!!")
		return nil
	end
end;

---------------------------------------------------------------------------------------------

function wl_joinaward()		--区服参赛得奖
	local nClientID = GetGateWayClientID();
	local zonename = wl_get_zonename( nClientID )
	local zonesection = tostring( nClientID )
	local tabTitle = {}
	local leader = 0
	local awardtype = tonumber(biwu_getdata( WL_FILE_ACTORAWARD, zonesection, "ZoneAwardType" ))
	
	local leader = 0
	leader = champ_checktitle()		--leader == 7为总领队
	if( leader == 7 ) then
		local tbOpp = {}
		if ( GetTask( ZONEAWARD_TASKID_LEADAWARD ) == -1 and GetTask( ZONEAWARD_TASKID_ACTORAWARD ) == -1 ) then
			Say( "Ngi  nh薾 qua ph莕 thng. K誸 qu� thi u chi ti誸 xin xem trang ch�.", 0 )
			return
		end;
		if ( GetTask( ZONEAWARD_TASKID_LEADAWARD ) ~= -1 ) then
			tbOpp[ getn( tbOpp ) + 1 ] = "Nh薾 ph莕 thng T鎛g l穘h i/#wl_FinalTakeMatch("..ZONEAWARD_TASKID_LEADAWARD..")"
		end;
		if ( GetTask( ZONEAWARD_TASKID_ACTORAWARD ) ~= -1 ) then
			tbOpp[ getn( tbOpp ) + 1 ] = "Nh薾 ph莕 thng tuy觧 th� /#wl_FinalTakeMatch("..ZONEAWARD_TASKID_ACTORAWARD..")"
		end;
		tbOpp[ getn( tbOpp ) + 1 ] = "ьi m閠 l竧 甶!/OnCancel" 
		if( awardtype == 5 ) then
			Say("T鎛g l穘h i nh� ngi c� th� nh薾"..WL_TAB_LEADERAWARD_INFO[ awardtype ][ 1 ]..", v� tuy觧 th� "..WL_TAB_ACTORAWARD_INFO[ awardtype ][ 1 ]..", nh薾 ngay b﹜ gi� ch�? Trc khi nh薾 xin s緋 x誴 l筰 h祅h trang!", getn( tbOpp ), tbOpp )
		else
			Say("Quan vi猲 V� l﹎ ki謙 xu蕋:"..zonename.."Trong b秐g th祅h t輈h x誴 h筺g th� "..awardtype.."h筺g, do l� T鎛g l穘h i, b筺 nh薾 頲"..WL_TAB_LEADERAWARD_INFO[ awardtype ][ 1 ]..", v� ph萵 thng tuy觧 th� tham gia"..WL_TAB_ACTORAWARD_INFO[ awardtype ][ 1 ]..", nh薾 ngay b﹜ gi� ch�? Trc khi nh薾 xin s緋 x誴 l筰 h祅h trang!", getn( tbOpp ), tbOpp )
		end
	else
		if ( GetTask( ZONEAWARD_TASKID_ACTORAWARD ) == -1 ) then
			Say( "Ngi  nh薾 qua ph莕 thng. K誸 qu� thi u chi ti誸 xin xem trang ch�.", 0 )
			return
		end;
		if( awardtype == 5 ) then
			Say("L� "..zonename.."tuy觧 th� trong khu v鵦, ngi c� th� nh薾 頲"..WL_TAB_ACTORAWARD_INFO[ awardtype ][ 1 ]..", nh薾 ngay b﹜ gi� ch�? Trc khi nh薾 xin s緋 x誴 l筰 h祅h trang!", 2, "Nh薾 ngay y!/#wl_FinalTakeMatch("..ZONEAWARD_TASKID_ACTORAWARD..")", "ьi m閠 l竧 甶!/OnCancel" )
		else
			Say("Quan vi猲 V� l﹎ ki謙 xu蕋:"..zonename.."Trong b秐g th祅h t輈h x誴 h筺g th� "..awardtype..", tuy觧 th� trong khu v鵦, ngi c� th� nh薾 頲 "..WL_TAB_ACTORAWARD_INFO[ awardtype ][ 1 ]..", nh薾 ngay b﹜ gi� ch�? Trc khi nh薾 xin s緋 x誴 l筰 h祅h trang!", 2, "Nh薾 ngay y!/#wl_FinalTakeMatch("..ZONEAWARD_TASKID_ACTORAWARD..")", "ьi m閠 l竧 甶!/OnCancel" )
		end
	end
	
end;

function wl_addgolditem_random()
	local serial = random( WL_GOLDITEMCOUNT )
	AddGoldItem(WL_TAB_MATCHAWARD[serial][3][1], WL_TAB_MATCHAWARD[serial][3][2])
	Msg2Player("Ch骳 m鮪g, b筺 nh薾 頲 m閠 "..WL_TAB_MATCHAWARD[serial][1])
	WriteLog(date("%y-%m-%d,%H:%M").."Account==["..GetAccount().."] RoleName=="..GetName()..", ph莕 thng trang b� Ho祅g Kim "..WL_TAB_MATCHAWARD[serial][1])
end;

function wl_addownexp( awardexp )
	tl_addPlayerExp(awardexp)
end;


---------------------------------------------------------------------------------------------
function wl_awardall( firstcnt, secondcnt, thirdcnt )	--领取区服奖励
	local awardfst = 0
	local awardsec = 0
	local awardthd = 0
	local tbOpp = {}
	awardfst = wl_get_awardcount( firstcnt, ZONEAWARD_TASKID_FIRST )
	awardsec = wl_get_awardcount( secondcnt, ZONEAWARD_TASKID_SECOND )
	awardthd = wl_get_awardcount( thirdcnt, ZONEAWARD_TASKID_THIRD )
	
	local nClientID = GetGateWayClientID();
	local zonename = wl_get_zonename( nClientID )
	local str = "Quan vi猲 V� l﹎ ki謙 xu蕋:"..zonename.."trong khu v鵦 l�: "
	
	if ( firstcnt ~= 0 ) then
		str = str.."Qu竛 qu﹏"..firstcnt..", "
	end
	
	if ( secondcnt ~= 0 ) then
		str = str.."� qu﹏"..secondcnt..", "
	end
	
	if ( thirdcnt ~= 0 ) then
		str = str.."H筺g 3"..thirdcnt..", "
	end
	
	if ( awardfst == 0 and awardsec == 0 and awardthd == 0 ) then
		str = str.."ngi  nh薾 t蕋 c� ph莕 thng � khu v鵦."
		Say(str, 0)
		return
	end
	
	str = str.."ngi c遪 c� th� nh薾:"
	if( awardfst > 0 ) then
		tbOpp[ getn( tbOpp ) + 1 ] = tostring(awardfst).."Ph莕 thng Qu竛 Qu﹏___Ti猲 Th秓 l� /#wl_want2takeaward(1,"..awardfst..")"
	end
	
	if( awardsec > 0 ) then
		tbOpp[ getn( tbOpp ) + 1 ] = tostring(awardsec).."Ph莕 thng � Qu﹏___T╪g i 甶觤 kinh nghi謒 trong 30 ph髏/#wl_want2takeaward(2,"..awardsec..")"
	end
	
	if ( awardthd > 0 ) then
		tbOpp[ getn( tbOpp ) + 1 ] = tostring(awardthd).."Ph莕 thng h筺g 3___T╪g i 甶觤 kinh nghi謒 trong 15 ph髏/#wl_want2takeaward(3,"..awardthd..")"
	end
	tbOpp[ getn( tbOpp ) + 1 ] = "ьi m閠 l竧 甶!/OnCancel"
	Say( str, getn( tbOpp ), tbOpp )
end

function wl_want2takeaward(title,awardcount)
	local str = ""
	local cbFunc = ""
	local taskid = 0
	local tbOpp = {}
	if ( title == 1) then
		str = "ngi c� th� nh薾 頲"..awardcount.."1 Ti猲 Th秓 l�, nh薾 b﹜ gi� ch�?"
		cbFunc = "c竔/#wl_FinalTakeMatch"
		taskid = ZONEAWARD_TASKID_FIRST
	elseif ( title == 2 ) then
		str = "ngi c� th� nh薾 頲"..awardcount.."l莕 t╪g i 甶觤 kinh nghi謒 trong 30 ph髏, nh薾 b﹜ gi� ch�?"
		cbFunc = "l莕/#wl_want2doubleexp_30"
		taskid = ZONEAWARD_TASKID_SECOND
	elseif( title == 3 ) then
		str = "ngi c� th� nh薾 頲"..awardcount.."l莕 t╪g i kinh nghi謒 trong 15 ph髏, nh薾 b﹜ gi� ch�?"
		cbFunc = "l莕/#wl_want2doubleexp_15"
		taskid = ZONEAWARD_TASKID_THIRD
	end
	
	for i = 1, awardcount do
		tbOpp[ getn( tbOpp ) + 1 ] = "Nh薾!"..tostring(i)..cbFunc.."("..taskid..","..i..")"
	end
	tbOpp[ getn( tbOpp ) + 1 ] = "ьi l竧 quay l筰 nh薾/OnCancel"
	Say(str, getn(tbOpp), tbOpp)
end;

function wl_want2doubleexp_30( taskid, count )	--领取亚军奖励
	if( count == 0 or count == nil ) then
		print("wl_want2doubleexp_30(count) error!! count == 0 or count == nil")
		return
	end;
	
	if( GetTask( taskid ) < count ) then
		Say("S� lng nh薾 頲 h譶h nh� kh玭g ng!", 0)
		print( GetTask( taskid ).."== doubleexp30 :::: count=="..count.."not equal" )
		return
	end;
	
	local doubletime = 30 * count
	Say("Ngi mu鑞 nh薾 l� "..count.."ph莕 thng � Qu﹏ + "..doubletime.."ph髏 t╪g i 甶觤 kinh nghi謒 ng kh玭g?", 2, "Mu鑞/#wl_FinalTakeMatch("..taskid..","..count..")", "ьi m閠 l竧 ta quay l筰 nh薾!/OnCancel")
end

function wl_want2doubleexp_15( taskid, count )	--领取季军奖励
	if( count == 0 or count == nil ) then
		print("wl_want2doubleexp_30(count) error!! count == 0 or count == nil")
		return
	end;
	
	if( GetTask( taskid ) < count ) then
		Say("S� lng nh薾 頲 h譶h nh� kh玭g ng!", 0)
		print( GetTask( taskid ).."== doubleexp30 :::: count=="..count.."not equal" )
		return
	end;
	
	local doubletime = 15 * count
	Say("Ngi mu鑞 nh薾 l� "..count.."ph莕 thng � Qu﹏ + "..doubletime.."ph髏 t╪g i 甶觤 kinh nghi謒 ng kh玭g?", 2, "Mu鑞/#wl_FinalTakeMatch("..taskid..","..count..")", "ьi m閠 l竧 ta quay l筰 nh薾!/OnCancel")
end

----------------------------------------------------------------------------------------------


function wl_taketitle()
--	WL_FILE_MATCHAWARD = wl_get_zonefile_match( zonesection )
--	WL_FILE_ACTORAWARD = wl_get_zonefile_actor( zonesection )
	local tbOpp = {}
	local zonesection = tostring(GetGateWayClientID())
	local playeraccount = GetAccount()
	biwu_loadfile( WL_FILE_MATCHAWARD)
	local playername = GetName()
	local rolename = biwu_getdata( WL_FILE_MATCHAWARD, playeraccount, "Key" )
	
	biwu_loadfile( WL_FILE_ACTORAWARD )
	local zonematch = tonumber(biwu_getdata( WL_FILE_ACTORAWARD, zonesection, "ZoneMatch" ))
	
	if( (rolename == nil or playername ~= rolename) and zonematch == 0 ) then
		Say("Ngi kh玭g c� th� h筺g n祇 qua c竎 lo箃 tr薾 u, ta kh玭g c� danh hi謚 cho ngi.", 0)
		return
	end

	biwu_loadfile( WL_FILE_ACTORAWARD )
	if( zonematch > 0 and zonematch <= 3 ) then
		tbOpp[ getn( tbOpp ) + 1 ] = "Nh薾 頲 danh hi謚 u t藀 th� khu v鵦/#wl_sure2taketitle('ZoneMatch',"..zonematch..")"
	end
	
	biwu_loadfile( WL_FILE_MATCHAWARD )
	local singlematch = 0
	local doublematch = 0
	local fivematch = 0
	local tenmatch = 0
	local sixteenmatch = 0
	if( rolename ~= nil and playername == rolename ) then
		singlematch	=	tonumber(biwu_getdata( WL_FILE_MATCHAWARD, playeraccount, "SingleMatch" ))
		doublematch	=	tonumber(biwu_getdata( WL_FILE_MATCHAWARD, playeraccount, "DoubleMatch" ))
		fivematch 	=	tonumber(biwu_getdata( WL_FILE_MATCHAWARD, playeraccount, "FiveMatch" ))
		tenmatch	=	tonumber(biwu_getdata( WL_FILE_MATCHAWARD, playeraccount, "TenMatch" ))
		sixteenmatch	=	tonumber(biwu_getdata( WL_FILE_MATCHAWARD, playeraccount, "SixteenMatch" ))
		
		if( singlematch > 0 and singlematch <= 3 ) then
			tbOpp[ getn( tbOpp ) + 1 ] = "Nh薾 頲 danh hi謚 n u m玭 ph竔/#wl_sure2taketitle('SingleMatch',"..singlematch..")"
		end
		if( doublematch > 0 and doublematch <= 3 ) then
			tbOpp[ getn( tbOpp ) + 1 ] = "Nh薾 頲 danh hi謚 Song u/#wl_sure2taketitle('DoubleMatch',"..doublematch..")"
		end
		if( fivematch > 0 and fivematch <= 3 ) then
			tbOpp[ getn( tbOpp ) + 1 ] = "Nh薾 頲 danh hi謚 ng� h祅h u/#wl_sure2taketitle('FiveMatch',"..fivematch..")"
		end
		if( tenmatch > 0 and tenmatch <= 3 ) then
			tbOpp[ getn( tbOpp ) + 1 ] = "Nh薾 頲 danh hi謚 Th藀 ph竔 u/#wl_sure2taketitle('TenMatch',"..tenmatch..")"
		end
		if( sixteenmatch > 0 and sixteenmatch <= 3 ) then
			tbOpp[ getn( tbOpp ) + 1 ] = "Nh薾 頲 danh hi謚 Th藀 l鬰 s竧 u/#wl_sure2taketitle('SixteenMatch',"..sixteenmatch..")"
		end
	end
	
	if( getn( tbOpp ) == 0 ) then
		Say("Ngi kh玭g c� th� h筺g n祇 qua c竎 lo箃 tr薾 u, ta kh玭g c� danh hi謚 cho ngi.", 0)
		return
	end
	
	tbOpp[ getn( tbOpp ) + 1 ] = "ьi l竧  ta suy ngh� /OnCancel"
	
	Say("Ngi c� th� nh薾 頲 danh hi謚 sau y, suy ngh� xem sao:", getn( tbOpp ), tbOpp)
end

function wl_sure2taketitle( sectionname , awardtype)
	if( awardtype < 0 or awardtype > 3 ) then
		return
	end
	
	local title = 0
	local str = ""
	if ( sectionname == "SingleMatch" ) then
		local faction = GetLastFactionNumber()
		if( faction == -1 ) then
			return
		end
		str = "Danh s竎h m玭 ph竔 thi u"
		if( awardtype == 1 ) then
			title = 32 + faction
		elseif( awardtype == 2 ) then
			title = 42 + faction
		else
			title = 52 + faction
		end
	end
	
	if( sectionname == "DoubleMatch" ) then
		title = 61 + awardtype
		str = "Song u"
	end
	
	if( sectionname == "FiveMatch" ) then
		title = 64 + awardtype
		str = "Ng� h祅h u"
	end
	
	if( sectionname == "TenMatch" ) then
		title = 67 + awardtype
		str = "Th藀 ph竔 u"
	end
	
	if( sectionname == "SixteenMatch" ) then
		title = 70 + awardtype
		str = "Th藀 l鬰 s竧 u"
	end
	
	if( sectionname == "ZoneMatch" ) then
		title = 73 + awardtype
		str = "祅 i khu v鵦 u"
	end

	Title_AddTitle(title, 1, 30 * 24 * 60 * 60 * 18)
	Title_ActiveTitle( title )
	SetTask( ZONEAWARD_TASKID_TITLEID, title )
	if ( awardtype == 1 ) then
		str = str.."Qu竛 qu﹏"
	elseif ( awardtype == 2 ) then
		str = str.."� qu﹏"
	else
		str = str.."H筺g 3"
	end
	Msg2Player( "Ch骳 m鮪g b筺 t 頲"..str.."Danh hi謚" )
end

