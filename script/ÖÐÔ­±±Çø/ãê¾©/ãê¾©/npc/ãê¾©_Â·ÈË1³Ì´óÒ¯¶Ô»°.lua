--中原北区 汴京府 路人1程大爷对话
-----------------------------------------------------------------------
function main(sel)

if(GetItemCount(351) >= 1)then
	Say("Ngi Kim t苙g cho ch髇g ta m閠 s� b秓 b鑙, giao cho ch髇g ta nhi謒 v� 甶 t譵 t蕀 a  'S琻 h� x� t綾' g� . Kh玭g bi誸 l� n� c� c玭g d鬾g g�?",4,"Ta t譵 頲 1 mi課g To竔 phi課 /gift1","Ta t譵 頲 2 mi課g To竔 phi課 /gift2","Ta t譵 頲 1 mi課g To竔 phi課 /gift3","Ta kh玭g i u /no")
else
	default()
end

end;

-----------------------------------------------------------------------

function default()
	i = random(0,2)
	if (i == 0) then
		Talk(1,"","Bi謓 Kinh n祔 n鎖 ti課g l� nh� c� t遖 Thi誸 Th竝, nh璶g trong  l筰 c� nhi襲 b� 萵...")
	elseif (i == 1) then
		Talk(1,"","B﹜ gi� Bi謓 Kinh n祔  b� ngi Kim chi誱 r錳! Ch髇g ta s� ph秈 s鑞g nh鱪g th竛g ng祔 c鵦 kh�!")
	else
		Talk(1,""," Ho祅g thng ch� bi誸 hng ph骳 m閠 m譶h � phng Nam, l祄 g� bi誸 quan t﹎ n s� th鑞g kh� c馻 b� t竛h! ")
	end
end

-----------------------------------------------------------------------

function gift1()
if(GetItemCount(351) >= 3)then
	DelItem(351)
	DelItem(351)
	DelItem(351)
	for i = 1, 3 do
		x = 238 + random(0,2)
		AddEventItem(x)			-- 随机给宝石
		AddEventItem(353)			-- 猩红宝石
--		AddItem(6, 1, 21, 1, 0, 0, 0)			-- 猩红宝石
	end
	Say("T蕀 b秐  c馻 ngi ta  l蕐 r錳, t苙g cho ngi nh鱪g th� n祔, ngi h穣 gi� l蕐. M蕐 n╩ nay kh玭g 頲 y猲 鎛 l緈! ",0)
else
	Say("Ngi b筺 tr� kh玭g n猲 khinh thng ngi gi�! Ngi l祄 g� c� 3 m秐h b秐 ?",0)
end
end

-----------------------------------------------------------------------

function gift2()
if(GetItemCount(351) >= 2)then
	DelItem(351)
	DelItem(351)
	x = 238 + random(0,2)
	AddEventItem(x)
	AddEventItem(353)			-- 猩红宝石
--	AddItem(6, 1, 21, 1, 0, 0, 0)			-- 猩红宝石
	Say("T蕀 b秐  c馻 ngi ta  l蕐 r錳, t苙g cho ngi nh鱪g th� n祔, ngi h穣 gi� l蕐. M蕐 n╩ nay kh玭g 頲 y猲 鎛 l緈! ",0)
else
	Say("Ngi b筺 tr� kh玭g n猲 khinh thng ngi gi�! Ngi l祄 g� c� 3 m秐h b秐 ?",0)
end
end

-----------------------------------------------------------------------

function gift3()
if(GetItemCount(351) >= 1)then
	DelItem(351)
	AddEventItem(353)			-- 猩红宝石
--	AddItem(6, 1, 21, 1, 0, 0, 0)			-- 猩红宝石
	Say("T蕀 b秐  c馻 ngi ta  l蕐 r錳, t苙g cho ngi nh鱪g th� n祔, ngi h穣 gi� l蕐. M蕐 n╩ nay kh玭g 頲 y猲 鎛 l緈! ",0)
else
	Talk(1,"","Ngi b筺 tr� kh玭g n猲 khinh thng ngi gi�! Ngi l祄 g� c� 3 m秐h b秐 ?")
end
end

-----------------------------------------------------------------------

function no()
end

-----------------------------------------------------------------------
