--description: 武当派出师任务 武当山宝箱2
--author: yuanlan	
--date: 2003/5/17
-- Update: Dan_Deng(2003-08-17)

function main()
	UTask_wd = GetTask(5)
	UTask_wd60sub = GetByte(GetTask(17),2)
	if (UTask_wd == 60*256+20) then
		if (UTask_wd60sub == 0) then
			Talk(1,"","B秓 rng: G莕 y <color=Red>binh kh�<color> c馻 T鑞g qu﹏ kh玭g , <color=Red>thng vong<color> tr莔 tr鋘g, h穣 n <color=Red>Tng Dng<color> t譵 <color=Red>th� r蘮 <color> gi髉 .")
			Msg2Player("G莕 y kh� gi韎 ch鑞g Kim kh玭g , <color=Red>binh s� thng vong tr莔 tr鋘g<color>, c莕 n th祅h Tng Dng nh� Th� r蘮 gi髉  gi秈 quy誸. ")
			SetTask(17, SetByte(GetTask(17),2,2))
			AddNote("L� b颽 tr猲 b秓 rng � Th竔 T� nham vi誸: дn th祅h Tng Dng t譵 Th� r蘮 t譵 c竎h gi秈 quy誸 v蕁  s鴆 m筺h ch鑞g qu﹏ Kim kh玭g . ")
		elseif (UTask_wd60sub > 0) and (UTask_wd60sub < 8) then
			Talk(1,"","B秓 rng: Do thi誹 <color=Red>kh� gi韎<color>, T鑞g qu﹏ thng t鎛 tr莔 tr鋘g� ")
			Msg2Player("Do s鴆 m筺h kh玭g , t筼 n猲 thng vong kh玭g tr竛h kh醝 khi ch鑞g qu﹏ Kim... ")
		elseif (UTask_wd60sub == 8) then
			AddEventItem(70)
			Say("C� binh kh� k辮 th阨, s鴆 chi課 u c馻 quan binh ti襫 tuy課 t╪g m筺h! M� B秓 rng, l蕐 頲 1 quy觧 <color=Red>'Thng Thanh Ch﹏ Kinh'<color>.", 0)
			Msg2Player("C莕 ph秈 b� sung binh kh� g蕄, s鴆 m筺h chi課 u c馻 quan binh nh� Kim r蕋 m筺h. M� B秓 rng, c� 頲 b� Thng Thanh Ch﹏ Kinh. ")
			SetTask(17, SetByte(GetTask(17),2,10))
			AddNote("M� B秓 rng, c� 頲 b� Thng Thanh Ch﹏ Kinh. ")
		elseif (UTask_wd60sub == 10) then
			if (HaveItem(70) == 0) then
				AddEventItem(70)
			else
				Talk(1,"","B秓 rng  r鏽g")
			end
		end
	else
		Talk(1,"","Ch璦 nh薾 nhi謒 v�! B筺 kh玭g th� m� B秓 rng n祔!")
	end
end;
