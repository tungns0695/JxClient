-- 西山屿 职能 铁匠
-- By: li_xin(2005-01-27)
--update:zhaowenyi(2005-02-20)增加紫色及黄金装备铸造

Include("\\script\\global\\紫色及黄金装备铸造.lua")
function main(sel)
	--Say("Mu鑞 s鑞g 頲 tr猲 T﹜ S琻 T� 礹, kh玭g c� binh kh� l頸 h筰 c馻 ta e r籲g ngi ch辵 nhi襲 thi謙 th遡 . Ngi c� mu鑞 mua g� kh玭g? C遪 mu鑞 ch� t筼 Trang b� Huy襫 Tinh ho芻 trang b� Ho祅g Kim th� c� n t譵 ta gi� c� ph秈 ch╪g th玦!", 3, "Giao d辌h/yes", "ch� t筼/onFoundry", "Nh﹏ ti謓 gh� qua th玦/no")
	Say("Mu鑞 s鑞g 頲 tr猲 T﹜ S琻 T� 礹, kh玭g c� binh kh� l頸 h筰 c馻 ta e r籲g ngi ch辵 nhi襲 thi謙 th遡 . Ngi c� mu鑞 mua g� kh玭g? C遪 mu鑞 ch� t筼 Trang b� Huy襫 Tinh ho芻 trang b� Ho祅g Kim th� c� n t譵 ta gi� c� ph秈 ch╪g th玦!", 
			2, "Giao d辌h/yes", 			
			"Nh﹏ ti謓 gh� qua th玦/no")
end;

function yes()
	Sale(13);  				
end;

function no()
end;
