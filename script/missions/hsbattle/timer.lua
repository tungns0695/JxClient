Include("\\script\\missions\\hsbattle\\hshead.lua");

function OnTimer()
	timestate = GetMissionV(MS_STATE);
	V = GetMissionV(MS_NEWSVALUE);
	SetMissionV(MS_NEWSVALUE, V+1);

	if (V == GO_TIME) then
		RunMission(MISSIONID)
		return
	end

	--报名阶段
	if (timestate == 1) then 
		ReportMemberState(V);
	elseif (timestate == 2) then --开战了
		ReportBattle(V);
	elseif (timestate == 3) then  --战斗结束了
		Msg2MSAll(MISSIONID, "Chi課 d辌h k誸 th骳 ");
		StopMissionTimer(MISSIONID, 14);
		StopMissionTimer(MISSIONID, 15);
	end;
end;

function ReportMemberState(V)
	--在报名期间，系统定期通知玩家当前的报名情况
	if (V == GO_TIME) then
		Msg2MSAll(MSSIONID, "S� ngi v祇 trong  , cu閏 thi u ch輓h th鴆 b総 u ");
		RunMission(MISSIONID);
		return
	end;
		RestTime = (GO_TIME - V) * 20;
		RestMin, RestSec = GetMinAndSec(RestTime);
		local str1 = "Th阨 gian v祇 u trng <#> c遪 "..RestMin.."<#> ph髏, i khi猽 chi課 xin l藀 t鴆 v祇 u trng."
		str1 = "Tr薾 khi猽 chi課 th祅h <#> 產ng trong giai 畂筺 v祇 u trng, hai b猲 nhanh ch鉵g v祇 u trng. S� ngi hai b猲 "..GetMSPlayerCount(MISSIONID, 1).."<#>:"..GetMSPlayerCount(MISSIONID, 2).."<#>. Th阨 gian v祇 u trng c遪: "..RestMin.."<#> ph髏 "..RestSec.."<#> gi﹜ ";
		Msg2MSAll(MISSIONID, str1);	
end;

function ReportBattle(V)
--战斗进行过程中，系统定期通知各方的阵亡情况
	if (GetMSPlayerCount(MISSIONID, 1) <= 0 ) then 
		Msg2MSAll(MISSIONID, "<#>. Thi u k誸 th骳,"..GetMissionS(2).."<#> gi祅h 頲 th緉g l頸 chung cu閏!");
		WinBonus(2)
		CloseMission(MISSIONID);
		return
	end;
	
	if (GetMSPlayerCount(MISSIONID, 2) <= 0 ) then 
		Msg2MSAll(MISSIONID, "<#>. Thi u k誸 th骳,"..GetMissionS(1).."<#> gi祅h 頲 th緉g l頸 chung cu閏!");
		WinBonus(1)
		CloseMission(MISSIONID);
		return
	end;
		
	s_value = GetMissionV(MS_TONG1VALUE);
	j_value = GetMissionV(MS_TONG2VALUE);
	
	gametime = (floor(GetMSRestTime(MISSIONID,15)/18));
	RestMin, RestSec = GetMinAndSec(gametime);
	str1 = "<#> giai 畂筺 chi課 u. T輈h l騳 hi謓 t筰 l�: phe V祅g:"..s_value.."<#>, b猲 m祏 T輒"..j_value.."<#>. Th阨 gian c遪 d� "..RestMin.."<#> ph髏 "..RestSec.."<#> gi﹜ ";
	Msg2MSAll(MISSIONID, str1);
end;
