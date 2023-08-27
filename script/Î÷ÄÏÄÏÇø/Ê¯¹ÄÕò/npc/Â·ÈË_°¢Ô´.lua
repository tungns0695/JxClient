-- 石鼓镇　路人　阿源
-- by：Dan_Deng(2003-09-16)
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
	Talk(1,"","H�! Уn 玭g b猲 ngo礽 u cho con g竔 r籲g Th髖 Y猲 p. ng l� b鋘 h� p th藅, nh璶g hoa n祇 m� kh玭g c� c? ng n b鋘 h� ngi c� ch誸 c騨g kh玭g bi誸 t筰 sao! ")
end;
