----------------------------------------------------------------
--FileName:	chefu.lua
--Creater:	firefox
--Date:		2005-
--Comment:	周末活动：卫国战争之烽火连城
--			功能：报名点车夫，可以去往7大城市
-----------------------------------------------------------------
Include("\\script\\missions\\newcitydefence\\headinfo.lua")
function main()
	Say("Xa phu: Chi課 tranh li猲 mi猲, l穙 b� t竛h s鑞g r蕋 c� c鵦! Kh玭g bi誸 l骳 n祇 m韎 ng鉩 u 頲? Ngi mu鑞 n th祅h n祇?", 8, tbDEFENCE_RETURN[1][3].."/#cd_transtocity(1)", tbDEFENCE_RETURN[11][3].."/#cd_transtocity(11)", tbDEFENCE_RETURN[37][3].."/#cd_transtocity(37)", tbDEFENCE_RETURN[78][3].."/#cd_transtocity(78)", tbDEFENCE_RETURN[80][3].."/#cd_transtocity(80)", tbDEFENCE_RETURN[162][3].."/#cd_transtocity(162)", tbDEFENCE_RETURN[176][3].."/#cd_transtocity(176)", "Kh玭g c莕/OnCancel" )
end

function OnCancel()
end

function cd_transtocity(cityid)
	Msg2Player("Ng錳 y猲! Chu萵 b� kh雐 h祅h!"..tbDEFENCE_RETURN[cityid][3])
	NewWorld( cityid, tbDEFENCE_RETURN[cityid][1], tbDEFENCE_RETURN[cityid][2] )
end