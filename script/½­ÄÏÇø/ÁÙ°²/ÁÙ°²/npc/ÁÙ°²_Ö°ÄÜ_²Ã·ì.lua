-- 临安的裁缝，可以买婚礼吉服
-- By: Dan_Deng(2003-12-29)
-- GetTask(67): 第24字位为婚否标记，第1字位为是否已买吉服

function main(sel)
	Uworld67 = GetTask(67)
	if (GetBit(Uworld67,24) == 1) then			-- 已婚
		if (GetBit(Uworld67,1) == 0) then		-- 尚未买过，可以买婚礼服
			if (GetSex() == 0) then					-- 男对话，买男装
				Talk(1,"buy_sale","g ch�! Nghe v� ta n鉯 l� ph鬰 m ci nh� 玭g tr� danh thi猲 h�, b﹜ gi� c� b竛 kh玭g? ")
			else
				Talk(1,"buy_sale","g ch�! V竬 ci nh� 玭g c鵦 k� p,l莕 n祔 c� h祅g kh玭g v藋? ")
			end
		else
			Talk(1,"","Qu莕 竜 l莕 trc mua � b鎛 ti謒 m芻 v蒼 v鮝 v苙 ch�! Nh� n鉯 v韎 b筺 b� th﹏ th輈h c馻 ngi nh�!")
		end
	else
		Talk(1,"","Kh玭g ph秈 ta n鉯 qu� u, c竎 lo筰 l� ph鬰 c馻 nh� ta l� t鑤 nh蕋 tr猲 th� gian, l骳 n祇 c莕 nh� gh� n nh�! ")
	end
end

function buy_sale()
	Say("� y ta chuy猲 may qu莕 竜 l� ph鬰, 琻g nhi猲 lo筰 n祇 c騨g c�, ch� l� gi� ti襫 h琲 t m閠 ch髏, c莕 88888 lng. ",2,"Ng祔 i h�, 琻g nhi猲 Ta mu鑞 mua m閠 b�. /buy_yes","Kh玭g c莕 u, ta ch璦 l祄 m ci /no")
end

function buy_yes()
	if (GetCash() >= 88888) then
		Pay(88888)
		if (GetSex() == 0) then
			AddItem(0,2,28,1,random(0,4),0,0)
		else
			AddItem(0,2,28,4,random(0,4),0,0)
		end
		Uworld67 = GetTask(67)
		Uworld67 = SetBit(Uworld67,1,1)
		SetTask(67,Uworld67)
		Talk(1,"","Kh玭g th祅h v蕁 , s� g鉯 l筰 cho kh竎 quan ngay, nh﹏ th� ch骳 kh竎h quan tr╩ n╩ h筺h ph骳!")
	else
		Talk(1,"","Kh玭g ph秈 l� ngi gi祏 c�, th� ng i h醝 m蕐 th� l� nghi n祔. Mu鑞 g�, ki誱  ti襫  r錳 h絥g n mua!")
	end
end

function no()
end
