-- 见性峰山洞迷宫 战斗NPC 山贼首领 昆仑40级任务
-- by：Dan_Deng(2003-07-30)

function OnDeath()
	UTask_kl = GetTask(9);
	if (UTask_kl == 40*256+20) and (HaveItem(212) == 0) and (random(0,99) < 30) then
		AddEventItem(212)
		Msg2Player("L蕐 頲 1 chi誧 ch譨 kh鉧 ")
		AddNote("B筺 l蕐 trong ngi t猲 th� l躰h c馻 s琻 t芻 ra 1 chi誧 ch譨 kh鉧 ")
	end
end;
