--description: 峨嵋派妙隐 
--author: yuanlan	
--date: 2003/3/4
--update: Dan_Deng(2003-07-22), 加入门派任务的等级要求
-- Update: Dan_Deng(2003-08-12)

Include("\\script\\global\\skills_table.lua")

function main()
	UTask_em = GetTask(1)
--	player_Faction = GetFaction()
	if (GetSeries() == 2) and (GetFaction() == "emei") then
		if (UTask_em == 10*256) and (GetLevel() >= 10) then		--10级任务启动
			Talk(5,"L10_talk2", "Ph藅 T�! е t� c� t閕, xin h穣 tr鮪g ph箃  t�, ng gi竛g t閕 cho huynh 蕐....", "S� t�, xem t� 畊閙 n衪 u s莡, c� chuy謓 g� kh玭g?", "N鉯 ra d礽 l緈 -- Trc khi ta xu蕋 gia u Ph藅,  t鮪g c� m閠 gia nh h筺h ph骳 ng藀 tr祅. N祇 ng� cu閏 chi課 T鑞g Kim n� ra, tng c玭g ta b� l玦 ra chi課 trng l祄 Tr竛g nh. Ch祅g ra 甶 nhi襲 n╩ nh璶g kh玭g c� tin t鴆 g�!", "V� sau c� tin ch祅g  t� tr薾 n琲 chi課 trng. Ta v� c飊g 產u kh�, xu鑞g t鉩 l祄 ni c�, nh s鑞g cu閏 s鑞g m b筩 trong qu穘g i t祅. N祇 ng�, tng c玭g ta v蒼 c遪 s鑞g!", "Sau khi ch祅g tr� v�, 產u kh� kh萵 thi誸 mong ta ho祅 t鬰. Nh璶g, ta  ph竧 nguy謓 nng nh� c鯽 Ph藅, sao c� th� v� chuy謓 luy課 竔 h錸g tr莕 m� quay l璶g l筰 v韎 Ph藅 T�? Ta th藅 c� t閕! ")
		elseif (UTask_em == 10*256+20) and (HaveItem(18) == 0) then			-- 铜镜丢了
			AddEventItem(18)
			Talk(1,"","竔 da! C竔 t猲 ti觰 qu� n祔, n鯽 m苩 gng ng ta ch璦 l蕐  ch箉 m蕋!")
			Msg2Player("Nh薾 頲 n鯽 m秐h gng ng. ")
		elseif ((UTask_em == 10*256+60) and (HaveItem(20) == 1)) then					--得到修复好的完整铜镜
			Talk(2, "", "S� t�, nh譶 xem! Gng ng  s鯽 xong! Gng v� l筰 l祅h, n誹 Ph藅 T� bi誸 t蕀 ch﹏ t譶h c馻 phu ph� t�, nh蕋 nh s� kh玭g tr竎h t� u!", " t� s� mu閕! H穣 gi髉 ta mang t蕀 gng ng trao cho tng c玭g. Nh緉 v韎 ch祅g n誹 b籲g l遪g i ta 3 n╩. 3 n╩ sau ta nh蕋 nh tr� v� b猲 ch祅g. Trong 3 n╩ ta ph秈 chuy猲 t﹎ tu h祅h  c莡 xin Ph藅 T� tha th�.")
			SetTask(1,10*256+70)
			AddNote("Quay v� Nga Mi nh薾 nhi謒 v� c馻 Di謚 萵 ph� th竎, 甧m gng ng trao cho tng c玭g b� ta. ")
			Msg2Player("Quay v� Nga Mi nh薾 nhi謒 v� c馻 Di謚 萵 ph� th竎, 甧m gng ng trao cho tng c玭g b� ta. ")
		elseif ((UTask_em == 10*256+70) and (HaveItem(20) == 0)) then		-- 任务中，铜镜“又”丢了
			AddEventItem(20)
			Talk(1,"","Di謚 萵:Ti觰 qu� �! Qu猲 c莔 gng ng r錳!")
		elseif (UTask_em == 10*256+80) then
			Talk(2,"L10_prise","Gng ng  giao cho tng c玭g t�, i ca n鉯 s� m穒 m穒 i t� tr� v�!", "S� mu閕! Ta th藅 kh玭g bi誸 ph秈 c秏 琻 mu閕 th� n祇!")
		else   					--已经完成10级任务（缺省对话）
			Talk(1,"","S� mu閕! Ta th藅 kh玭g bi誸 ph秈 c秏 琻 mu閕 th� n祇!")
		end
	elseif (UTask_em >= 70*256) then								--已经出师
		Talk(1,"","Mu閕 ph秈 h� s琻 sao? H穣 ch� � b秓 tr鋘g.")
	else
		Talk(1,"","Ph藅 T�! е t� c� t閕, xin h穣 tr鮪g ph箃  t�, ng gi竛g t閕 cho huynh 蕐....")
	end
end;

function L10_talk2()
	Talk(3,"L10_get","S� t�! ng t� tr竎h m譶h! C� tr竎h h穣 tr竎h chuy謓 i ngang tr竔, t筼 h鉧 tr猽 ngi.", "N誹 ta kh玭g ho祅 t鬰, ch祅g s� kh玭g ch辵 r阨 kh醝 Nga Mi. Ch祅g n鉯 ng祔 ng祔 s� ng di n骾 i ta, mong ta h錳 t﹎ chuy觧 �. Ta ph秈 l祄 sao y? L遪g ta r鑙 nh� t� v�!", "S� t�, t﹎ � s� t� r鑤 cu閏 l� th� n祇? T� c遪 y猽 tng c玭g kh玭g?")
end;

function L10_get()
	Say("N誹 t譶h duy猲 ki誴 n祔  nh s絥 nh� th�, ta l祄 sao d竚 cng l筰? N╩ x璦 khi ch祅g t遪g qu﹏,  t鮪g chia m秐h gng l祄 2 m秐h  l祄 t輓 v藅 cho ng祔 sau g苝 l筰, l� n祇 gng v� l筰 l祅h sao?", 2, "в ta th� xem. /L10_get_yes", "Kh玭g c� c竎h/L10_get_no")
end;

function L10_get_yes()
	Talk(1, "select1", "Gng v� ch璦 n鑙 kh玭g th� n祇 l祅h 頲! T� h穣 a <color=Red>n鯽 m秐h gng ng <color> cho mu閕. Mu閕 n <color=Red>Th祅h Й<color> t譵 <color=Red> Th� r蘮<color> th� xem c� c竎h n祇 kh玭g!")
end;

function select1()
	Talk(1,"","C� th藅 頲 kh玭g? T鑤 l緈!<color=Red>n鯽 m秐h gng kia<color> � ch� <color=Red>tng c玭g<color> ta. Ch祅g 產ng � <color=Red>trong r鮪g c﹜<color> di ch﹏ n骾.")
	AddEventItem(18)
	Msg2Player("Nh薾 nhi謒 v� c馻 Di謚 萵 Nga Mi ph竔, nh薾 頲 n鯽 m秐h gng ng. ")
	SetTask(1,10*256+20)
	AddNote("G苝 ni c� Di謚 萵 � ch竛h 甶謓 (273, 311) , ti誴 nh薾 <color=Red>nhi謒 v� gng ng<color>. Nh薾 n鯽 m秐h gng ng. ")
end;

function L10_get_no()
end;

function L10_prise()
	SetRank(14)
	SetTask(1,20*256)
--	AddMagic(77)
--	AddMagic(79)
	add_em(20)			-- 调用skills_table.lua中的函数，参数为学到多少级技能。
	Msg2Player("Ch骳 m鮪g b筺! B筺 頲 th╪g l祄 V� Y Ni, h鋍 頲 Nga Mi ki誱 ph竝, Nga Mi chng ph竝. ")
	AddNote("Quay v� Nga Mi ph竔, ph鬰 m謓h Di謚 萵, ho祅 th祅h nhi謒 v� gng ng. ")
end;
