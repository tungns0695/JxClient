-- 临安　职能　皇宫卫兵（两名）（丐帮50级任务）
-- by：Dan_Deng(2003-09-16)

function main()
		UTask_gb = GetTask(8)
	if ((UTask_gb >= 50*256+30) and (UTask_gb <60)) then		-- （第三次）
		Talk(3,"","T祇 c玭g c玭g c� l謓h! Kh玭g c� ph薾 s� kh玭g 頲 nh藀 cung!  甶!",":Ta c� L謓h b礽 th玭g h祅h","C� l謓h b礽 th玭g h祅h c騨g kh玭g 頲 v祇! ")
--		SetTask(8,50*256+40)
	elseif (UTask_gb == 50*256+20) and (HaveItem(139) == 1) then	-- （第二次）
		Msg2Player("Ki觤 tra l謓h b礽 kh玭g sai, ti課 v祇 Ho祅g cung. ")
		NewWorld(177, 1569, 3169)
	elseif (UTask_gb == 50*256+10) then		--带着50级任务（第一步）
		Talk(3,"","ng l筰! ng l筰! Ngi ch竛 s鑞g hay sau m� ch箉 lung tung n琲 y?","T筰 h� l�  t� C竔 Bang, c� m閠 th� c鵦 k� quan tr鋘g ph秈 d﹏g cho Ho祅g thng","C� ph秈 ai c騨g 頲 g苝 Ho祅g thng u? Kh玭g c� l謓h b礽 th玭g h祅h c馻 Khu m藅 s� Trng i nh﹏, ai c騨g kh玭g 頲 v祇! ")
		SetTask(8,50*256+20)
	else
		i = random(0,2)
		if (i == 0) then
			Talk(1,"","ng l筰! ng l筰! Ngi ch竛 s鑞g hay sau m� ch箉 lung tung n琲 y?")
		elseif (i == 1) then
			Talk(1,"","Ho祅g cung c蕀 a! Mau 甶 甶! ")
		else
			Talk(1,"","ng l筰! ng l筰! Ngi ch竛 s鑞g hay sau m� ch箉 lung tung n琲 y?")
		end
	end
end;
