-- 扬州 路人NPC 醉半仙（丐帮10级任务）
-- by：Dan_Deng(2003-07-28)

function main()
	UTask_gb = GetTask(8)
	if (UTask_gb == 10*256+20) then		--10级任务中
		SetTask(8,10*256+30)
		Talk(5,"L10_question_1","H秓 t鰑 y! Nu鑤 r錳 v蒼 c遪 ti誧 y!...","Huynh l� T髖 B竛 Ti猲? Зy ch糿g ph秈 l� Hu� Tuy襫 t鰑 sao?","Kh玭g sai! Ta ch輓h l� T髖 B竛 Ti猲, y l� m� t鰑 Hu� Tuy襫 t鰑!","T筰 h� l�  t� C竔 Bang, ngng m閠 t玭 huynh  l﹗! Kh玭g bi誸 c� th� nhng cho t筰 h� Hu� Tuy襫 T鰑 頲 kh玭g?","N誹 ngi tr� l阨 ng c竎 c﹗  c馻 ta, th� b譶h ru n祔 xin t苙g cho ngi!")
	elseif (UTask_gb == 10*256+30) then		--重新尝试
		Talk(1,"L10_question_1","C遪 ch璦 ph鬰? V藋 ta s� th� ti誴!")
	elseif ((UTask_gb == 10*256+40) and (HaveItem(76) == 0)) then		--如果玩家把酒弄丢了
		Talk(3,"","C竔 g�! Ngi l祄 m蕋 b譶h ru r錳 �!","! M� t鰑 c馻 ta!","T鑤 l緈! Xem ra ngi c騨g c� ch髏 ki課 th鴆 v� ru! T苙g ngi y!")
		AddEventItem(76)
		Msg2Player("C� ru Hu� tuy襫 ")
	else
		Talk(1,"","C筺 v韎 ta 1 ly n祇! zd�!")
	end
end;

function L10_question_1()
	Say("C﹗ th� nh蕋: ch� 'Hu� Tuy襫' trong hu� Tuy襫 t鰑 l� ch� c竔 g�?",4,"T猲 ngi /L10_wrong","T猲 a danh /L10_wrong","Nc su鑙 /L10_question_2","T猲 h� /L10_wrong")
end;

function L10_question_2()
	Say("C﹗ th� 2: 'C� u k輈h minh nguy謙, i 秐h th祅h k� nh﹏' l� c竔 g�?",4,"Nhi襲 ngi /L10_wrong","3 ngi /L10_question_3","2 ngi /L10_wrong","1 ngi /L10_wrong")
end;

function L10_question_3()
	Say("C﹗ th� 3: di y ch� n祇 l� ch� t猲 ru:",4,"Ng鋍 D辌h /L10_wrong","Qu鷑h nhng /L10_wrong","L鬰 ngh� /L10_wrong","Ph� th髖 /L10_correct")
end;

function L10_wrong()
	Talk(1,"","sai r錳! Xem ra ngi kh玭g c� duy猲 v韎 b譶h ru n祔 r錳!")
end;

function L10_correct()
	Talk(1,"","T鑤 l緈! Xem ra ngi c騨g c� ch髏 ki課 th鴆 v� ru! T苙g ngi y!")
	AddEventItem(76)
	SetTask(8,10*256+40)
	AddNote("C� ru Hu� tuy襫 ")
	Msg2Player("C� ru Hu� tuy襫 ")
end;
