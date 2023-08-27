-- 昆仑 弟子 玉衡子 50级任务
-- by：Dan_Deng(2003-07-31)

Include("\\script\\global\\skills_table.lua")

function main()
	UTask_kl = GetTask(9);
	if (GetSeries() == 4) and (GetFaction() == "kunlun") then
		if ((UTask_kl >= 50*256+64) and (UTask_kl < 60*256) and (HaveItem(10) == 1)) then		--50级任务完成
			L50_prise()
		elseif ((UTask_kl == 50*256) and (GetLevel() >= 50)) then		--50级任务
			Say("Ph輆 sau n骾 C玭 L玭 c� m閠 huy謙 ng, b猲 trong c� giam m閠 qu竔 nh﹏. T猲 qu竔 nh﹏ n祔 lu玭 mi謓g n鉯 r籲g h緉 s� san b籲g C玭 L玭 ph竔 n祔, k誸 qu� l� b� Chng M玭 nh b筰, nh鑤 v祇 trong ng. B鎛 ph竔 c� m閠 quy lu藅  t� n祇 頲 th╪g c蕄 50 総 s� nh b筰 頲 h緉, nh璶g ph秈 l蕐 頲 t鉩 c馻 h緉  ch鴑g minh ",2,"Xin cho  t� 甶 th� xem /L50_get_yes","е t� v� ngh� ch璦 cao, e r籲g kh玭g th緉g n鎖 /L50_get_no")
		else
			Talk(1,"","Ngi h穣 ph竧 huy nh鱪g s� trng c馻 m譶h, t飝 c� 鴑g bi課!")
		end
	else
		Talk(1,"","Ta y xem tr鋘g nh蕋 l� t譶h b筺, ngi nh﹏ t� th� v� ch m�. Ha! Ha! Ha!")
	end
end;

function L50_get_yes()
	Talk(1,"","C� ch� kh�, th� th� ta s� cho ngi c� h閕 n祔!")
	SetTask(9,50*256+64)
	AddNote("Nh薾 頲 nhi謒 v� c蕄 50 c馻 C玭 L玭 ph竔: Цnh b筰 B╪g Huy謓 Qu竔 Nh﹏, ng th阨 b鴗 l蕐 1 t髆 t鉩 l祄 b籲g ch鴑g. ")
	Msg2Player("Nh薾 頲 nhi謒 v� c蕄 50 c馻 C玭 L玭 ph竔: Цnh b筰 B╪g Huy謓 Qu竔 Nh﹏, ng th阨 b鴗 l蕐 1 t髆 t鉩 l祄 b籲g ch鴑g. ")
end;

function L50_get_no()
end;

function L50_prise()
	Talk(2,"","H� ph竝! е t� may m緉 kh玭g b� m筺g!","Л頲 l緈! Ngi 頲 th╪g ti課 tr� th祅h Th� Ph� Thi猲 tng. H穣 nh� k�! Ch� c莕 trung th祅h v韎 ta, c� b蕋 c� 輈h l頸 g� ta u kh玭g qu猲 ngi!")
	DelItem(10)
	SetTask(9,60*256)
	SetRank(24)
--	AddMagic(176)
--	AddMagic(90)
	add_kl(60)			-- 调用skills_table.lua中的函数，参数为学到多少级技能。
	Msg2Player("Ch骳 m鮪g B筺! Х tr� th祅h Th� Ph� Thi猲 tng! H鋍 頲 Cu錸g Phong S藆 謓, M� Tung 秓 秐h ")
	AddNote("L蕐 頲 t鉩 c馻 B╪g Huy謙 qu竔 nh﹏, ho祅 th祅h nhi謒 v� c蕄 50 c馻 C玭 L玭 ph竔. Л頲 phong Th� Ph� Thi猲 Tng. ")
end;
