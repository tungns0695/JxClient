-- 用铜钱出售易容物品的NPC
-- Fanghao Wu
-- 2004.11.1

function main()

	Say("Kh竎h quan mu鑞 b秓 v藅 g� c� th� tr鵦 ti誴 n <color=yellow>K� Tr﹏ C竎<color> ch鋘 mua l� 頲, l穙 phu cu鑙 c飊g c騨g 頲 ngh� ng琲 r錳! Sao? Kh玭g bi誸 阯g n <color=yellow>K� Tr﹏ C竎<color> �?   Nh蕁 tr鵦 ti誴 <color=green>v祇 h譶h tr遪 � di b猲 tay ph秈<color> l� 頲 r錳.", 0);
	return
	
	-- Say ( "易容术士：想学易容术？其实很简单，在我这买一个特制的易容面具我就可以教你。不同的面具可以易容成不同的样子，大侠要不要看一看？", 3, "购买/OnBuy", "暂时不买了/OnCancel", "关于易容面具/OnAbout" );
end

function OnBuy()
	Sale( 95, 3 );
end

function OnCancel()
end

function OnAbout()
	Say( "m trang b� M苩 n� b蕋 k� t v祇 n琲 trang b�<color=yellow> M苩 n� <color>, nh﹏ v藅  khi mang v祇 l藀 t鴆 bi課 th祅h NPC, t猲 nh﹏ v藅 v� t蕋 c� thu閏 t輓h u<color=yellow> kh玭g thay i <color>, c騨g<color=yellow> kh玭g 秐h hng <color>n c竎 d鬾g c� trang b� v� c玭g n╪g c馻 nh﹏ v藅 thng d飊g. L骳 ta c雐 b� M苩 n� trong � trang b� ra, nh﹏ v藅 s� tr� l筰 ban u, s� l莕 s� d鬾g M苩 n�<color=yellow> gi秏 甶 m閠 l莕<color>.", 0 );
end