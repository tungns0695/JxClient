--中原南区 襄阳府 路人16郭员外对话
-- edit by 小浪多多

Include("\\script\\event\\zhongqiu2007\\picture_head.lua")
Include ("\\script\\event\\springfestival08\\allbrother\\findnpctask.lua")
function main(sel)
	if allbrother_0801_CheckIsDialog(183) == 1 then
		allbrother_0801_FindNpcTaskDialog(183)
		return 0;
	end
	local ndate = tonumber(GetLocalDate("%y%m%d%H%M"))
	if ndate > 0709220000 and ndate < 0710312400 then
		SetTaskTemp(TSK_TEMP,2)
		Describe("Qu竎h vi猲 ngo筰: Trung thu  n, ch� c莕 thu th藀  6 <color=red>m秐h tranh Ti猲 V�<color>  h頿 th祅h 1 b鴆 tranh ho祅 ch豱h mang n cho ta, ta s� t苙g l筰 i hi謕 1 b竛h <color=red>Ph鬾g Nguy謙 Qu� Dung<color>.",2,"фi b竛h Ph鬾g Nguy謙 Qu� Dung/makeItemUI","Nh﹏ ti謓 gh� qua th玦/NoChoice")
	else
		Describe("Ta  甧m to祅 b� gia s秐 quy猲 g鉷 cho tri襲 nh. Nc nh� g苝 n筺, m鋓 ngi d﹏  c� tr竎h nhi謒. Ta ch� g鉷 ch鴆 s鴆 m鋘 n祔 m� c� x� g�! So v韎 c竎 chi課 s� ng� xu鑞g tr猲 sa trng, ch髏 ng g鉷 nh� nh苩 n祔 n祇 c� ng chi!",1,"Bi誸 r錳/NoChoice")
	end
end;
