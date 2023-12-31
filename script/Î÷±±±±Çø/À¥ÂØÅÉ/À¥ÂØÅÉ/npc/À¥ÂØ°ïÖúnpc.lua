--昆仑派帮助NPC
-- 记住需要加入GetTask(9) == 127的容错（尚未加）
-- By: Dan_Deng(2003-12-01)

function main(sel)
	UTask_kl = GetTask(9)
	player_faction = GetFaction()
	if (player_faction == "kunlun") then		-- 本门弟子
		RestoreLife()		-- 本门免费治疗
		RestoreMana()
		RestoreStamina()
		Say("L穙 phu  � b鎛 m玭 m蕐 mi n╩, ch鴑g ki課 bao nhi猽 s� thay i, bi誸 r� 甶襲 n猲 n鉯 s� n鉯, 甶襲 g� kh玭g n鉯 頲 th� ng bao gi� truy t譵 c╪ c閕",4,"T譵 hi觰 甶觧 c� b鎛 m玭/faction","T譵 hi觰 c竎 v� t玭 trng/member","T譵 hi觰 nhi謒 v� /task_get","Kh玭g h醝 n鱝!/nothing")
	elseif (UTask_kl >= 70*256) then				-- 本门出师
		Say("Hi誱 khi g苝 頲 nh鱪g ng m玭  th祅h ngh� quay l筰 n琲 y. Nh譶 c竎 ngi nh藀 m玭, r錳 l筰 th蕐 c竎 ngi th祅h ngh� h祅h t萿 giang h�, kh玭g th� kh玭g c秏 th蕐 th阨 gian tr玦 nhanh nh� t猲",4," l筰 chuy謓 n╩ x璦 b鎛 m玭/faction","Nh譶 l筰 o h鱱 n╩ x璦/member","Ta c遪 c� th� gi髉 g� kh玭g/task_get","Kh玭g h醝 n鱝!/nothing")
	elseif (player_faction ~= "") then			-- 非本门出师、其它门派（门派不为空即指非新手）
		Say("Hoan ngh猲h  n C玭 L玭 ph竔, 阯g xa v蕋 v� n y, kh玭g bi誸 c� 甶襲 g� ch� gi竜?",3,"T譵 hi觰 qu� ph竔/faction","T譵 hi觰 c竎 v� o trng/member","Kh玭g h醝 n鱝!/nothing")
	else													-- 新手
		Say("C玭 L玭 ph竔 Чo ph竝 t� ti猲, r蕋 hoan ngh猲h qu� v� tham quan h鋍 ngh� ",4,"T譵 hi觰 qu� ph竔/faction","T譵 hi觰 c竎 v� o trng/member","T譵 hi觰 甶襲 ki謓 nh藀 m玭/task_get","Kh玭g h醝 n鱝!/nothing")
	end
end

----------------- 门派介绍部份 ----------------------------
function faction()
	Say("V藋 th� ngi mu鑞 頲 gi韎 thi謚 phng di謓 n祇 c馻 b鎛 m玭? ",5,"Kh雐 nguy猲 m玭 ph竔/F1","V� tr� a l� /F2","мa v� giang h� /F3","c s綾 m玭 ph竔/F4","Kh玭g h醝 n鱝!/nothing")
end

function F1()
	Say("C玭 L玭 ph竔 � t薾 T﹜ V鵦, tuy 頲 s竛g l藀  l﹗ nh璶g sau khi S� T� khai ph竔 qua i, trong ph竔 kh玭g c� ai l� xu蕋 ch髇g. M穒 cho n h琻 tr╩ n╩ trc, C玭 Lu﹏ ph竔 xu蕋 hi謓 m閠 v� k� nh﹏. Ngi n祔 kh玭g nh鱪g t筼 頲 uy danh l鮪g l蓎 trong v� l﹎ Trung Nguy猲 m� c遪 gi髉 t猲 tu鎖 c馻 C玭 Lu﹏ b総 u lan r閚g kh緋 v� l﹎.",2,"T譵 hi觰 nh鱪g v蕁  kh竎/main","Kh玭g h醝 n鱝!/nothing")
end

function F2()
	Say("C玭 L玭 S琻 to� l筩 t筰 T﹏ Cng, giao gi韎 c馻 Thanh H秈, l筰 c� 頲 a v� huy ho祅g c馻 'V筺 S琻 Chi T�', 頲 xem l� 'Trung Qu鑓  nh蕋 s琻'",2,"T譵 hi觰 nh鱪g v蕁  kh竎/main","Kh玭g h醝 n鱝!/nothing")
end

function F3()
	Say("B鎛 ph竔 tuy xa t薾 T﹜ V鵦, nh璶g v蒼 hy v鋘g c� th� t 頲 a v� tng x鴑g t筰 Trung Nguy猲, hi謓 t筰  d莕 b譶h ng a v� v韎 Thi誹 L﹎, V� ng v� Nga Mi",2,"T譵 hi觰 nh鱪g v蕁  kh竎/main","Kh玭g h醝 n鱝!/nothing")
end

function F4()
	Say("B鎛 ph竔  t� c� c� nam n�,t輓 ph鬰 o gi竜. е t� 頲 ph衟 h玭 ph鑙, kh玭g c蕀 ╪ m苙. c 甶觤 l韓 nh蕋 c馻 b鎛 ph竔 c� 2 甶襲: 1 l� d� t﹎, 2 l� b� ngo礽 c� v� ch輓h nh﹏ qu﹏ t�, nh璶g b猲 trong c鵦 k� nham hi觤 x秓 tr�, n閕 b� ng m玭 c騨g kh玭g t輓 nhi謒 l蒼 nhau, lo筰 tr� l蒼 nhau, tranh quy襫 tc v�. Ngit筰 b鎛 m玭 n鉯 n╪g ph秈 lu玭 c萵 th薾, b蕋 c� chuy謓 g� c騨g kh玭g n猲 nhi襲 l阨",2,"T譵 hi觰 nh鱪g v蕁  kh竎/main","Kh玭g h醝 n鱝!/nothing")
end

----------------- 成员介绍部份 ----------------------------
function member()
	Say("V藋 ngi mu鑞 頲 gi韎 thi謚 v� n祇 c馻 b鎛 m玭?",11,"Chng m玭 Tuy襫 C� T� /Mxuan","Thanh Li猲 T� /Mqing","Ng鋍 Ho祅h T� /Myu","Chu Khuy誸/Mzhu","уng T辌h Nhan/Mtong","Ti觰 H祅/Mxiao","Th竛 T鴆 L穙 Nh﹏/Mtan","Tr莕 T﹎/Mxin","Tr莕 Duy猲/Myuan","Tr莕 Ni謒/Mnian","Kh玭g h醝 n鱝!/nothing")
end

function Mxuan()
	Say("Chng m玭 Tuy襫 C� T�   V� tr�: Ch輓h 甶謓   T鋋 : 190,196<enter> y r綾 d� t﹎, ngo礽 m苩 ra v� qu﹏ t� nh騨 nh苙, th鵦 t� t﹎ hi觤 c 竎, ch璦 t m鬰 ch kh玭g t� m鋓 th� 畂筺. ",2,"T譵 hi觰 nh鱪g v蕁  kh竎/main","Kh玭g h醝 n鱝!/nothing")
end

function Mqing()
	Say("Thanh Li猲 T�   V� tr�: T� Vi 甶謓   T鋋 : 186/199<enter>L� ngi 輈h k�, m鬰 ch l韓 nh蕋 mu鑞 l祄 chng m玭 C玭 L玭 Ph竔, v� t m鬰 ch, kh玭g ti誧 l頸 d鬾g l蒼 nhau v韎 Ng鋍 Ho祅h T� ",2,"T譵 hi觰 nh鱪g v蕁  kh竎/main","Kh玭g h醝 n鱝!/nothing")
end

function Myu()
	Say("Ng鋍 Ho祅h T�  V� tr�: Thi猲 Vi 甶謓   T鋋 : 195/195<enter>L� ngi c� l遪g  k� cao, bao g錷 c�  t� c馻 m譶h. V� mu鑞 t 頲 ch鴆 chng m玭 c馻 C玭 L玭 Ph竔 n猲 l頸 d鬾g  l蒼 nhau v韎 Thanh Li猲 T�, th鵦 ch蕋 ai c騨g mang d� t﹎.",2,"T譵 hi觰 nh鱪g v蕁  kh竎/main","Kh玭g h醝 n鱝!/nothing")
end

function Mzhu()
	Say("Chu Khuy誸    V� tr�:  B猲 trong Чi m玭        T鋋 : 198/200<enter>Чi е T� c馻 Tuy襫 C� T�, t輓h t譶h l穘h m, nham hi觤  k�. B� B筩h Doanh Doanh c馻 Ng� чc gi竜 l頸 d鬾g",2,"T譵 hi觰 nh鱪g v蕁  kh竎/main","Kh玭g h醝 n鱝!/nothing")
end

function Mtong()
	Say("уng T辌h Nhan   V� tr�: h藆 Hoa vi猲   T鋋 : 178,195<enter> con g竔 Tuy襫 C� T�, ngi trong tr緉g ng﹜ th�, t﹎ t輓h lng thi謓",2,"T譵 hi觰 nh鱪g v蕁  kh竎/main","Kh玭g h醝 n鱝!/nothing")
end

function Mxiao()
	Say("Ti觰 H祅   V� tr�: T辌h Nhan nh   T鋋 : 184,196<enter> a ho祅 c馻 уng T辌h Nhan, l� m閠 c� g竔 nh� nh緉, th玭g minh lanh l頸. ",2,"T譵 hi觰 nh鱪g v蕁  kh竎/main","Kh玭g h醝 n鱝!/nothing")
end

function Mtan()
	Say("Th竛 T鴆 L穙 Nh﹏   V� tr�: ph遪g е t�   T鋋 : 191,201<enter> Chng m玭 c馻 i trc, s� ph� c馻 3 ngi Tuy襫 C� T�, Thanh Li猲 T� v� Ng鋍 Ho祅h T�. Ng祔 trc l骳 琻g nhi謒 Chng m玭, b秐 t輓h t祅 nh蒼, i i m玭  th� b筼 v� 琻, khi課 3   u蕋 h薾 r緋 k� h穖 h筰 ra n玭g n鎖 n祔. Nh璶g v� 3   nghi s� l蒼 nhau, n猲 kh玭g d竚 h筰 ch誸 l穙",2,"T譵 hi觰 nh鱪g v蕁  kh竎/main","Kh玭g h醝 n鱝!/nothing")
end

function Mxin()
	Say("Tr莕 T﹎   V� tr�: Qu穘g trng   T鋋 : 189,197   Ph� tr竎h: Giao d辌h binh kh� ",2,"T譵 hi觰 nh鱪g v蕁  kh竎/main","Kh玭g h醝 n鱝!/nothing")
end

function Myuan()
	Say("Tr莕 Duy猲   V� tr�: Qu穘g trng   T鋋 : 193,195   Ph� tr竎h: Giao d辌h trang b� ",2,"T譵 hi觰 nh鱪g v蕁  kh竎/main","Kh玭g h醝 n鱝!/nothing")
end

function Mnian()
	Say("Tr莕 Ni謒   V� tr�: Qu穘g trng   T鋋 : 193,197   Ph� tr竎h: Giao d辌h Dc ph萴",2,"T譵 hi觰 nh鱪g v蕁  kh竎/main","Kh玭g h醝 n鱝!/nothing")
end

----------------- 任务介绍部份 ----------------------------
function task_get()
	UTask_kl = GetTask(9)
	if (UTask_kl < 10*256) then	-- 未入门
		Say("Ngi hi謓 ch璦 nh藀 m玭, mu鑞 nh藀 m玭 n c竎 T﹏ Th� th玭 g苝 е t� ti誴 d蒼 c馻 b鎛 ph竔 l� 頲",4,"Ti誴 t鬰 t譵 hi觰 nhi謒 v� hi謓 t筰/T_enroll","T譵 hi觰 nh鱪g nhi謒 v� kh竎/T_all","T譵 hi觰 nh鱪g v蕁  kh竎/main","Kh玭g h醝 n鱝!/nothing")
	elseif (UTask_kl >= 10*256) and (UTask_kl < 20*256) then
		Say("Ngi hi謓 產ng ti課 h祅h l� nhi謒 v� h竔 thu鑓.",4,"Ti誴 t鬰 t譵 hi觰 nhi謒 v� hi謓 t筰/T_L10","T譵 hi觰 nh鱪g nhi謒 v� kh竎/T_all","T譵 hi觰 nh鱪g v蕁  kh竎/main","Kh玭g h醝 n鱝!/nothing")
	elseif (UTask_kl >= 20*256) and (UTask_kl < 30*256) then
		Say("Ngi hi謓 產ng ti課 h祅h l� nhi謒 v� xng u con l筩 .",4,"Ti誴 t鬰 t譵 hi觰 nhi謒 v� hi謓 t筰/T_L20","T譵 hi觰 nh鱪g nhi謒 v� kh竎/T_all","T譵 hi觰 nh鱪g v蕁  kh竎/main","Kh玭g h醝 n鱝!/nothing")
	elseif (UTask_kl >= 30*256) and (UTask_kl < 40*256) then
		Say("Ngi hi謓 產ng ti課 h祅h l� nhi謒 v� d� minh ch﹗.",4,"Ti誴 t鬰 t譵 hi觰 nhi謒 v� hi謓 t筰/T_L30","T譵 hi觰 nh鱪g nhi謒 v� kh竎/T_all","T譵 hi觰 nh鱪g v蕁  kh竎/main","Kh玭g h醝 n鱝!/nothing")
	elseif (UTask_kl >= 40*256) and (UTask_kl < 50*256) then
		Say("Ngi hi謓 產ng ti課 h祅h l� nhi謒 v� huy誸 h錸 th莕 ki誱.",4,"Ti誴 t鬰 t譵 hi觰 nhi謒 v� hi謓 t筰/T_L40","T譵 hi觰 nh鱪g nhi謒 v� kh竎/T_all","T譵 hi觰 nh鱪g v蕁  kh竎/main","Kh玭g h醝 n鱝!/nothing")
	elseif (UTask_kl >= 50*256) and (UTask_kl < 60*256) then
		Say("Ngi hi謓 產ng ti課 h祅h l� nhi謒 v� huy謙 qu竔 nh﹏.",4,"Ti誴 t鬰 t譵 hi觰 nhi謒 v� hi謓 t筰/T_L50","T譵 hi觰 nh鱪g nhi謒 v� kh竎/T_all","T譵 hi觰 nh鱪g v蕁  kh竎/main","Kh玭g h醝 n鱝!/nothing")
	elseif (UTask_kl >= 60*256) and (UTask_kl < 70*256) then
		Say("Ngi hi謓 產ng ti課 h祅h l� nhi謒 v� ng� s綾 th筩h.",4,"Ti誴 t鬰 t譵 hi觰 nhi謒 v� hi謓 t筰/T_L60","T譵 hi觰 nh鱪g nhi謒 v� kh竎/T_all","T譵 hi觰 nh鱪g v蕁  kh竎/main","Kh玭g h醝 n鱝!/nothing")
	elseif (UTask_kl >= 70*256) and (UTask_kl < 80*256) then
		Say("Ngi hi謓 產ng ti課 h祅h l� nhi謒 v� tr飊g ph秐 s� m玭.",4,"Ti誴 t鬰 t譵 hi觰 nhi謒 v� hi謓 t筰/T_return","T譵 hi觰 nh鱪g nhi謒 v� kh竎/T_all","T譵 hi觰 nh鱪g v蕁  kh竎/main","Kh玭g h醝 n鱝!/nothing")
	else
		Say("Hi謓 t筰 ngi c� th� t� do ra v祇 m玭 ph竔, t筸 th阨 ch璦 c� nhi謒 v� m韎!",3,"T譵 hi觰 nh鱪g nhi謒 v� kh竎/T_all","T譵 hi觰 nh鱪g v蕁  kh竎/main","Kh玭g h醝 n鱝!/nothing")
	end
end

function T_all()
	Say("Mu鑞 t譵 hi觰 nhi謒 v� g�?",10,"Nhi謒 v� nh藀 m玭/T_enroll","Nhi謒 v� h竔 thu鑓/T_L10","Nhi謒 v� xng u con l筩 /T_L20","Nhi謒 v� d� minh ch﹗/T_L30","Nhi謒 v� b╪g huy謙/T_L40","Nhi謒 v� huy誸 h錸 th莕 ki誱/T_L50","Nhi謒 v� ng� s綾 th筩h/T_L60","Nhi謒 v� tr飊g ph秐 s� m玭/T_return","T譵 hi觰 nh鱪g v蕁  kh竎/main","Kh玭g h醝 n鱝!/nothing")
end

function T_enroll()
	Talk(1,"t_all","Mu鑞 nh藀 m玭 h鋍 ngh�, ch� v莕 thu閏 h� Th�, ng c蕄 n 10, ch璦 gia nh藀 m玭 ph竔 n祇. дn i tha鋓 v韎  t� b鎛 m玭 � c竎 T﹏ th� th玭 l� 頲. Sau khi nh藀 m玭, l莕 lt ho祅 th祅h 5 nhi謒 v� c馻 m玭 ph竔, s� h鋍 頲 v� c玭g, 頲 phong danh hi謚. Ho祅 th祅h nhi謒 v� xu蕋 s� th� c� th� xu蕋 s� ")
end

function T_L10()
	Talk(4,"t_all","Sau khi nh藀 m玭 v� ng c蕄  t n 10, ngi c� th� ti誴 nh薾 nhi謒 v� h竔 thu鑓. Th玭g qua ho祅 th祅h nhi謒 v� n祔, ngi 頲 phong l� Ph鬾g Ki誱 е t�, h鋍 頲 v� c玭g C玭 L玭 o ph竝, C玭 L玭 Ki誱 ph竝, Th骳 Phc Ch�, Thanh Phong ph� ","Bc 1: дn T辌h Nhan nh g苝 Ti觰 H祅, ti誴 nh薾 nhi謒 v�. дn Dc Vng c鑓 h竔  5 lo筰 T� M鬰 T骳, мa C萴 Th秓, Thi課 Th秓, H� Nh� th秓 v� Linh Chi","Bc 2: дn Dc Vng C鑓 nh qu竔, s� l蕐  dc li謚","Bc 3: Mang 5 lo筰 dc li謚 v� giao cho Ti觰 H祅, ho祅 th祅h nhi謒 v�.")
end

function T_L20()
	Talk(4,"t_all","Sau khi ho祅 th祅h nhi謒 v� h竔 thu鑓 v� ng c蕄 t n 20, ngi c� th� ti誴 nh薾 nhi謒 v� Xng u L筩 . Th玭g qua ho祅 th祅h nhi謒 v� n祔, ngi 頲 phong l� T� Vi H� Ph竝, h鋍 頲 v� c玭g Ki B竛 Ph� ","Bc 1: дn trc ph遪g е t� g苝 Th竛 T鴆 L穙 Nh﹏, ti誴 nh薾 nhi謒 v�, 甶 l蕐 v� Xng u L筩 .","Bc 2: дn t莕g 1 Dc Vng ng, nh b筰 Th� ph�, l蕐 頲 Xng u L筩 .","Bc 3: Tr� v� ph遪g е t�, giao Xng u L筩  cho Th竛 T鴆 L穙 Nh﹏, ho祅 th祅h nhi謒 v�.")
end

function T_L30()
	Talk(4,"t_all","Sau khi ho祅 th祅h nhi謒 Xng u L筩  v� ng c蕄 t n 30, ngi c� th� ti誴 nh薾 nhi謒 v� D� Minh Ch﹗. Th玭g qua ho祅 th祅h nhi謒 v� n祔, ngi 頲 phong l� Th竔 Vi H� ph竝, h鋍 頲 v� c玭g: Nh蕋 Kh� Tam Thanh, B綾 Minh Цo H秈, Thi猲 T� T蕁 L玦, Thi猲 Thanh мa Tr鋍","Bc 1: дn i m玭 g苝 Chu Khuy誸, ti誴 nh薾 nhi謒 v�. дn Dc Vng c鑓, v祇 Tuy誸 B竜 ng t譵 D� Minh Ch﹗.","Bc 2: дn t莕g 1 Tuy誸 B竜 ng, nh b筰 Tuy誸 B竜, l蕐 頲 3 vi猲 D� Minh Ch﹗","Bc 3: Tr� v� C玭 L玭 ph竔, giao 3 vi猲 D� Minh Ch﹗ cho Chu Khuy誸, ho祅 th祅h nhi謒 v�.")
end

function T_L40()
	Talk(4,"t_all","Sau khi ho祅 th祅h nhi謒 D� Minh Ch﹗ v� ng c蕄 t n 40, ngi c� th� ti誴 nh薾 nhi謒 v� Huy誸 H錸 Th莕 Ki誱. Th玭g qua ho祅 th祅h nhi謒 v� n祔, ngi 頲 phong l� Thi猲 Vi H� ph竝, h鋍 頲 v� c玭g Khi H祅 Ng筼 Tuy誸, Kh� T﹎ ph� ","Bc 1: дn T� Vi 甶謓 g苝 Thanh Li猲 T�, ti誴 nh薾 nhi謒 v�, n Ki課 T輓h phong t譵 Huy誸 H錸 Th莕 Ki誱.","Bc 2: дn Ki課 T輓h phong s琻 ng nh b筰 s琻 t芻 Ti襲 u m鬰 v� s琻 t芻 u l躰h, l蕐 頲 ch譨 kh鉧 m� b秓 rng l蕐 Huy誸 H錸 Th莕 Ki誱","Bc 3: Tr� v� T� Vi 甶謓, giao Huy誸 H錸 Th莕 Ki誱 cho Thanh Li猲 T�, ho祅 th祅h nhi謒 v�.")
end

function T_L50()
	Talk(5,"t_all","Sau khi ho祅 th祅h nhi謒 v� Huy誸 H錸 Th莕 Ki誱 v� ng c蕄 t n 50, ngi c� th� ti誴 nh薾 nhi謒 v� b╪g huy謙 Qu竔 nh﹏. Th玭g qua ho祅 th祅h nhi謒 v� n祔, ngi 頲 phong l� Th� Ph� Thi猲 Tng, h鋍 頲 v� c玭g Cu錸g Phong S﹗ 謓, M� Tung 秓 秐h","Bc 1: дn Thi猲 Vi 甶謓 g苝 Ng鋍 Ho祅h T�, ti誴 nh薾 nhi謒 v�, n B╪g lao thu ph鬰 Qu竔 nh﹏.","Bc 2: дn B╪g huy謙 ng, nh b筰 5 t猲 Tuy誸 Qu竔, t譵 th蕐 B╪g lao","Bc 3: Цnh b筰 Qu竔 nh﹏ trong B╪g lao, l蕐 頲 1 n骯 t鉩","Bc 4: Tr� v� Thi猲 Vi 甶謓, g苝 Ng鋍 Ho祅h T� ph鬰 m謓h, ho祅 th祅h nhi謒 v�.")
end

function T_L60()
	Talk(6,"t_all","Sau khi ho祅 th祅h nhi謒 v� Qu竔 nh﹏ v� ng c蕄 t n 50, ngi c� th� ti誴 nh薾 nhi謒 v� Ng� S綾 th筩h. Th玭g qua ho祅 th祅h nhi謒 v� n祔, ngi 頲 phong l� Ti猲 Ph� Ch﹏ Qu﹏, thu薾 l頸 xu蕋 s�.","Bc 1: дn Ch輓h 甶謓 g苝 Chng m玭 Tuy襫 C� T�, ti誴 nh薾 nhi謒 v�, 甶 t譵 Ng� S綾 th筩h.","Bc 2: дn Ho祅g H� Nguy猲 u, g苝1 l穙 gi�, bi誸 頲 Ng� S綾 th筩h 頲 gi蕌 trong L璾 Ti猲 ng, c莕 t譵 5 chi誧 'Thi猲 t醓'","Bc 3: V祇 L璾 Ti猲 ng, t筰 m鏸 t莕g nh b筰 1 t猲 gi� ch譨 kh鉧, l蕐 頲  chi誧 ch譨 kh鉧","Bc 4: дn m藅 th蕋 � t莕g cu鑙 c飊g d飊g 5 chi誧 ch譨 kh鉧 m� B秓 rng, l蕐 頲 Ng� S綾 th筩h.","Bc 5: Tr� v� Ch輓h 甶謓, giao Ng� S綾 th筩h cho Chng m玭, ho祅 th祅h nhi謒 v�.")
end

function T_return()
	Talk(3,"t_all","Th玭g qua tr飊g ph秐 s� m玭, ngi 頲 phong l� H� Ph竔 Ch﹏ Qu﹏, h鋍 頲 tuy謙 h鋍 tr蕁 ph竔 Ng� L玦 Ch竛h Ph竝, Sng Ng筼 C玭 L玭","Bc 1: Sau khi ng c蕄 t n 60, n Ch輓h 甶謓 g苝 Tuy襫 C� T�, xin tr飊g ph秐 C玭 L玭.","Bc 2: giao n筽 50000 ng﹏ lng, tr飊g ph秐 C玭 L玭 ph竔.")
end

----------------- 结束 ---------------------------
function nothing()
end
