--两湖区 巴陵县 路人6俞九州对话
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
	i = random(0,2)

	if (i == 0) then
		Say("Ng祔 trc Чi Th竛h Thi猲 Vng kh雐 binh t筰 чng ёnh h�,th� thi猲 h祅h o, di謙 b筼 c鴘 ch髇g sinh,頲 d﹏ y猽 m課, l祄 tri襲 nh r蕋 lo s�, ph竔 binh ti猽 di謙. Thi猲 Vng qu﹏ 輙 ch ng, b� b総 sau   hy sinh ",0)
		return
	end

	if (i == 1) then
		Say("Khi Thi猲 Vng b� gi誸, Dng c玭g t� c馻 ng礽 產ng t筰 ngo筰 h鋍 ngh�, kh玭g th� v� nh譶 m苩. Khi quay l筰 чng ёnh H�, t藀 h頿 anh em ngh躠 qu﹏, l藀 ra Thi猲 Vng Bang. ",0)
		return
	end

	if (i == 2) then
		Say("Dng c玭g t� v� ngh� cao cng, t礽 tr� h琻 ngi, Thi猲 Vng Bang di b祅 tay l穘h o c馻 anh ta, ng祔 c祅g ph竧 tri觧, r蕋 頲 l遪g c馻 l穙 b� t竛h. Nh璶g t� trc n gi� ta ch璦 t鮪g 頲 th蕐 m苩 t藅 c馻 Dng c玭g t�,nghe n鉯  l� m閠 thi誹 ni猲 kh玦 ng� tu蕁 t�. ",0)
		return
	end;

end;

