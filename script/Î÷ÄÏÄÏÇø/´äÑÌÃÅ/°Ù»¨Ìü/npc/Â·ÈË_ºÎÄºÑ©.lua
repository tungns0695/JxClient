-- 翠烟门 何暮雪 30级任务
-- by：Dan_Deng(2003-07-26)
-- update: Dan_Deng(2003-08-07)
-- update by xiaoyang (2004\4\20)

Include("\\script\\global\\skills_table.lua")
Include ("\\script\\event\\springfestival08\\allbrother\\findnpctask.lua")
function main()
	if allbrother_0801_CheckIsDialog(5) == 1 then
		allbrother_0801_FindNpcTaskDialog(5)
		return 0;
	end
	UTask_cy = GetTask(6)
   Uworld121 = GetTask(121)
	if (GetSeries() == 2) and (GetFaction() == "cuiyan") then
		if (UTask_cy == 30*256+40) and (HaveItem(2) == 1) and (HaveItem(3) == 1) and (HaveItem(4) == 1) then
			L30_prise()
		elseif ((UTask_cy == 30*256) and (GetLevel() >= 30)) then		--30级任务启动
			Talk(1,"L30_get","Trc y kh玭g l﹗ ta c� duy猲 may g苝 m閠 lo筰 hoa tr� g鋓 l� ' V� Y Ngh� Thng', lo筰 hoa tr� n祔 v� c飊g qu� hi誱 v� kh� tr錸g. N誹 nh� kh玭g n緈 v鱪g 頲 b� quy誸, th� r蕋 kh� th祅h c玭g, ta b﹜ gi� 產ng lo l緉g y! ")
		elseif (UTask_cy > 30*256) and (UTask_cy < 40*256) then
			Talk(1,"","Th� n祇? g ta  n鉯 v韎 ngi c竎h tr錸g 'V� Y Ngh� Thng' ch璦?")
		elseif (UTask_cy >= 40*256) then
			Talk(1,"","V� Y Ngh� Thng r蕋 mau ra hoa, n l骳  c飊g nhau xem hoa tr�! ")
		else
			Talk(1,"","g 蕐 c騨g th輈h xem hoa tr� sao?")
		end
	elseif(Uworld121 == 10) and (HaveItem(373) == 1) then		--判断任务是否启动以及背包中时候有周小泉剪刀
		Talk(8,"Uworld121_lose","H� Ti猲 T�! � y c� 1 c﹜ k衞 Trng Ti觰 Tuy襫.","C竚 琻!","ng kh竎h s竜! Л頲 th蕐 di謓 m筼 c馻 Ti猲 T� l� vinh h筺h c馻 t筰 h�."," (B筺 v蒼 ph秈 ti誴 t鬰 n鉯, th蕐 M� Tuy誸 vung k衞 l猲, gi鑞g nh� V﹏ T� ph竧 k衞 nhi襲 l莕) ","H� c� nng! C� � y l祄 g�?"," Ta v� ngi v鑞 kh玭g quen bi誸 nhau, ngi l筰 b籲g l遪g nh薾 l阨 甶 xa ng祅 d苖 甧m k衞 t苙g ta, c遪 玭g 蕐 th� sao?","g ta l� ai?",".....C� th� gi髉 M� Tuy誸 th猰 m閠 chuy謓 頲 kh玭g?")
	elseif(Uworld121 == 10 ) then										--如果接受了任务但没有任务道具剪刀
		Talk(1,"","C﹜ k衞 n祔 l� ta nh� Trng Ti觰 Tuy襫 s� b� ch辵 kh� r蘮 cho ta, ngi xem c� ph秈   � ch� 玭g ta hay kh玭g?.")
	elseif (Uworld121 == 20) and (HaveItem(10) == 0) then		-- 头发丢了
		AddEventItem(10)
		Msg2Player("L筰 t譵 頲 m閠 ch飉 t鉩 ")
		Talk(1,"","Qu猲 mang theo t鉩 r錳.")
	elseif (Uworld121 >= 20) and (Uworld121 < 30) then			--在与杨湖对话前
		Talk(1,"","Hy v鋘g ngi chuy觧 l阨 gi飉 M� Tuy誸. Xin 產 t�!")
	elseif(Uworld121 == 30) then
		Talk(8,"Uworld121_Step4","H� c� nng!","Kh玭g c莕 n鉯 n鱝! Ta hi觰 r錳.","H� c� nng  hi觰 l莔 r錳, C玭 L玭 m璾  b� vng, Dng H鱱 s� i m鋓 vi謈 k誸 th骳 r錳 s� l猲 Thu� Y猲 M玭 g苝 n祅g.","H緉 th藅 s� c� p 鴑g y猽 c莡 c馻 ta kh玭g?",".....Vi謈 n祔 th� 玭g ta kh玭g n鉯.","Ha ha ha! H� M� Tuy誸 琲 H� M� Tuy誸, t筰 sao ngi l筰 m� m閚g h穙 huy襫 nh� v藋?","H� c� nng.....","Ngi ta sinh ra th� ch璦 c� ta, n l骳 c� ta th� ngi  gi�! !.....")
	elseif(Uworld121 == 40) and (HaveItem(376) == 0) then
		Talk(1,"","Ch璦 c� l蕐 kh╪ th猽, Kh﹗ Anh ch綾 l� kh玭g  � n c� nng r錳.")
		AddEventItem(376)
		Msg2Player("箃 l筰 kh╪ th猽. ")
	else
		Talk(1,"","T﹎ nguy謓 l韓 nh蕋 c馻 ta l� tr錸g 頲 hoa tr� p nh蕋 thi猲 h�.")
	end
end;

function L30_get()
	Say(" Nghe n鉯 � th祅h Чi L� c� m閠 ngi tr錸g hoa h� 祅, bi誸 tr錸g hoa tr�. Nh璶g m� t輓h t譶h h緉 k� l�, c� r蕋 nhi襲 ngi n th豱h gi竜, nh璶g u ph秈 u鎛g c玭g quay v�.",2,"в ta ngh� c竎h gi髉 ngi t譵 c竎h /L30_get_yes","M鋓 ngi u 產ng g苝 tr� ng筰, e r籲g ta c騨g kh玭g c� c竎h n祇 kh竎. /L30_get_no")
end;

function L30_get_yes()
	Talk(1,"","Th藅 c竚 琻 ngi!")
	SetTask(6,30*256+10)
	AddNote("G苝 祅 l穙 n玭g � th祅h Чi L�  th豱h gi竜 phng ph竝 nu玦 dng V� Y Ngh� Thng. ")
	Msg2Player("G苝 祅 l穙 n玭g � th祅h Чi L�  th豱h gi竜 phng ph竝 nu玦 dng V� Y Ngh� Thng. ")
end;

function L30_get_no()
end;

function L30_prise()
	Talk(1,"","Ho� ra v蒼 c遪 b� quy誸 nh� v藋, 產 t� ti觰 mu閕! Ta phong mu閕 l� Nh蕋 Ph萴 Hoa S�.")
	SetTask(6,40*256)
	SetRank(34)
	DelItem(2)
	DelItem(3)
	DelItem(4)
--	AddMagic(105)
--	AddMagic(113)
	add_cy(40)			-- 调用skills_table.lua中的函数，参数为学到多少级技能。
	Msg2Player("Ch骳 m鮪g b筺! Х 頲 phong th祅h Nh蕋 Ph萴 Hoa S�! H鋍 xong v� c玭g V� Ф L� Hoa, Ph� V﹏ T竛 Tuy誸. ")
	AddNote("箃 頲 b� quy誸 tr錸g hoa V� Y Ngh� Thng, ho祅 th祅h nhi謒 v�, 頲 phong l�: Nh蕋 Ph萴 Hoa S�. ")
end;

function Uworld121_lose()
	Talk(5,"","C� nng c� n鉯.","Xin ngi h穣 a m� t鉩 n祔 cho H鱱 S� Dng H� c馻 Thi猲 Vng Bang, n鉯 v韎 玭g 蕐 r籲g n誹 trc th竛g 7 玭g 蕐 kh玭g n Thu� Y猲 m玭 th� t� y v� sau ta v� h緉 xem nh� kh玭g c遪 c� h閕 g苝 l筰.","Qu� nhi猲 l� Dng H�! Dng H鱱 S� v╪ t礽 v� c ch� l� s� l鵤 ch鋘 nh蕋 th阨, l� nh﹏ trung long ph鬾g. H� c� nng xin ngh� l筰.","Ngi c騨g kh玭g mu鑞 gi髉 ta? Hu hu...."," Л頲 r錳! Ta 甶.")
	DelItem(373)
	AddEventItem(10)
	Msg2Player("Nh薾 l阨 H� M� Tuy誸, gi髉 c� 蕐 chuy觧 l阨 n Dng H�, nh薾 頲 m閠 kh骳 l鬭 c馻 H� M� Tuy誸. ")
	AddNote("Nh薾 l阨 H� M� Tuy誸, gi髉 c� 蕐 chuy觧 l阨 n Dng H�. ")
	SetTask(121,20) --任务变量设置为20
end

function Uworld121_Step4()
	Talk(4,"Uworld121_sijin",".....�.","Tuy h緉 b蕋 nh﹏ nh璶g ta c騨g kh玭g th� b蕋 ngh躠. � y c� m閠 c竔 kh╪ th猽, ngi h穣 d総 h緉 甶 t譵 Kh﹗ Anh C玭 L玭 ph竔. Xem nh� ta gi髉 h緉 l莕 cu鑙 c飊g.","V藋 ta 甶.....mong Ti猲 c� ngh� l筰."," ng nhi襲 l阨!")
end

function Uworld121_sijin()
	AddEventItem(376)
	Msg2Player("Nh薾 chi誧 kh╪ th猽. ")
	AddNote("Nh薾 頲 chi誧 kh╪ th猽 c馻 H� M� Tuy誸, 甧m 甶 t譵 Kh﹗ Anh c馻 C玭 L玭 ph竔. ")
	SetTask(121,40) --任务变量设置为40
end
