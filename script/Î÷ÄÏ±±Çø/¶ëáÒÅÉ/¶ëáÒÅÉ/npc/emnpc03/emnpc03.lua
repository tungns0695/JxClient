--description: 峨嵋派秦倚风
--author: yuanlan	
--date: 2003/3/3
-- Update: Dan_Deng(2003-08-12)

function main()
	UTask_em = GetTask(1);
	Uworld36 = GetByte(GetTask(36),1)
	if (Uworld36 == 20) then					--入门任务
		Msg2Player("Ti誴 nh薾 th� th竎h th� hai c馻 T莕 � Phong  l� tr� l阨 3 c﹗ h醝 v� 'Nh筩' ")
		Say("Mu閕 c� bi誸 c莔 k� thi h鋋? в ta th� mu閕 xem sao! Mu閕 c� bi誸 ca kh骳 n祇 sau y ph秈 d飊g n T� B�  di詎 t蕌?", 3, "T� V� M鬰 Dng /False4", "Cao S琻 L璾 Th駓 /False4", "Th藀 Di謓 Mai Ph鬰 /True4")
	elseif (Uworld36 == 40) then 					--入门任务：已完成前两关
		Talk(1,"","Xem ra mu閕 ch� l� m閠 k� t莔 thng. Nh璶g  S� mu閕 <color=Red>H� Linh Phi猽<color> th� mu閕 xem sao! C� ta 產ng � <color=Red>B竛 S琻 Ph� <color>!")
--	elseif ((UTask_em > 5*256) and (UTask_em < 10*256)) then 					--尚未入门
--		Talk(1,"","秦倚风：要想加入本派，必须先通过茶琴书的考验，然后再闯钻天坡得到白玉如意，你都做到了吗？")
	elseif (GetFaction() == "emei") then   				--已经入门，尚未出师
		Talk(1,"","S� mu閕! R秐h r鏸 ta c飊g trao i c莔 ngh�!")
	else							-- 其它对话
		Talk(1,"","Mu鑞 g鰅 g緈 t﹎ s� v祇 ng鉵 n Dao C莔. Thi誹 kh竎h tri ﹎, huy襫 畂筺 c� m蕐 ai nghe?")
	end
end;

function False4()
	Say("Kh玭g ng!", 3, "T� V� M鬰 Dng /False4", "Cao S琻 L璾 Th駓 /False4", "Th藀 Di謓 Mai Ph鬰 /True4");
end;

function True4()
	Say("Tr� l阨 ng r錳! C﹗ h醝 th� 2: C竔 n祇 di y kh玭g thu閏 t� i danh c莔?", 3, "Ho祅g Chung /True5", "L鬰 Kh雐 /False5", "Ti猽 V� /False5");
end;

function False5()
	Say("Kh玭g tr� l阨 頲 �?", 3, "Ho祅g Chung /True5", "L鬰 Kh雐 /False5", "Ti猽 V� /False5");
end;

function True5()
	Say("Kh玭g kh� kh╪ v韎 mu閕 ch�? Gi醝 l緈! Mu閕 c� bi誸 kh骳 'Qu秐g L╪g T竛' l� ai vi誸 kh玭g?", 3, "L穙 T� /False6", "K� Ki謓 /True6", "Khu蕋 Nguy猲 /False6");
end;

function False6()
	Say("Kh玭g bi誸 �? Hay l� mu閕 th蕐 kh� kh╪ m� l飅 bc?!", 3, "L穙 T� /False6", "K� Ki謓 /True6", "Khu蕋 Nguy猲 /False6");
end;

function True6()
	Talk(1,"","Xem ra mu閕 ch� l� m閠 k� t莔 thng. Nh璶g  S� mu閕 <color=Red>H� Linh Phi猽<color> th� mu閕 xem sao! C� ta 產ng � <color=Red>B竛 S琻 Ph� <color>!")
	Uworld36 = SetByte(GetTask(36),1,40)
	SetTask(36,Uworld36)
	AddNote("T筰 Ngh猲h Kh竎h Th筩h g苝 T莕 � Phong, tr� l阨 ch輓h x竎 ba c﹗ h醝 v� Nh筩, qua 秈 th� hai ")
	Msg2Player("T筰 Ngh猲h Kh竎h Th筩h g苝 T莕 � Phong, tr� l阨 ch輓h x竎 3 v蕁  v� Kh骳 nh筩, qua 秈 th� hai, n B竛 s琻 Pha ti誴 nh薾 s� th� th竎h c馻 H� Linh Phi猽. ")
end;
