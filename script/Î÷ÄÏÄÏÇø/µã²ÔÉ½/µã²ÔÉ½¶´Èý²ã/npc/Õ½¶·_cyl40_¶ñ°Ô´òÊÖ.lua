-- 点苍山恶霸洞 战斗NPC ？？？03（翠烟门40级任务）
-- by：Dan_Deng(2003-07-26)

function OnDeath()
	UTask_cy = GetTask(6)
	if (UTask_cy == 40*256+20) and (HaveItem(198) == 0) and (random(0,100) < 30) then				-- 30%的机率成功
		AddEventItem(198)
		Msg2Player("L蕐 頲 ch譨 kho� B筩 ")
		AddNote("T譵 頲 ch譨 kho� B筩 ")
	end
end;
