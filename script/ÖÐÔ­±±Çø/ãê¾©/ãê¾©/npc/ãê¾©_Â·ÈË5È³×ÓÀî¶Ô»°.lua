--中原北区 汴京府 路人5瘸子李对话
Include("\\script\\misc\\eventsys\\eventsys.lua")
Include("\\script\\dailogsys\\dailog.lua")

function main()
	local nNpcIndex = GetLastDiagNpc()
	local szNpcName = GetNpcName(nNpcIndex)
	if NpcName2Replace then
		szNpcName = NpcName2Replace(szNpcName)
	end
	local tbDailog = DailogClass:new(szNpcName)
	EventSys:GetType("AddNpcOption"):OnEvent(szNpcName,tbDailog , nNpcIndex)
	if getn(tbDailog.tbOptionList) > 0 then
		tbDailog:AddOptEntry("Ta n t譵 玭g c� vi謈 kh竎", old_main)
		tbDailog:Show()
	else
		old_main()
	end
end
function old_main()
	Say("C竔 ch﹏ qu� n祔 c馻 ta l� do nh tr薾 v韎 b鋘 gi芻 Kim. C騨g v� c竔 ch﹏ n祔 m� cho n gi� ta v蒼 ch璦 th祅h th﹏. C� nh� n祇 ch辵 g� con cho m閠 anh qu� nh� ta?",0)
end

