--zhongchaolong

--存在5分钟的灯笼


function main()	--对话入口
	
	local tbSay = 
	{
		"L錸g n n祔 p qu�.",
		"L錸g n n祔 l蕄 l竛h p qu�",
		"Trung thu ng緈 l錸g n th藅 l� vui.",
		"Trung thu th藅 l穘g m筺, l祄 ta nh� n祅g qu�."
	}
	
	Say(tbSay[random(1,getn(tbSay))], 0)
end;

function OnTimer(nNpcIdx, nTimeOut)
	if (nTimeOut == nil or nTimeOut > 0 ) then
		DelNpc(nNpcIdx)
		return 0;
	end;
	DelNpc(nNpcIdx)
end;