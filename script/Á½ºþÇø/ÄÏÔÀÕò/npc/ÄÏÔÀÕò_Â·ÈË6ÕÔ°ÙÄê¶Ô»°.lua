--两湖区 南岳镇 路人6赵百年对话

function main(sel)

	if ( GetTask(1256) == 1 ) then
		 SetTaskTemp(111,GetTaskTemp(111)+1)
		 
		 if ( GetTaskTemp(111) > 3 ) then
		 	Talk(1,"","Nghe n鉯 c� m閠 v� s� th竔 kh玭g bi誸 t� mi誹 n祇 n, ph竝 l鵦 v� bi猲 ngi 甶 h醝 th� xem sao.")
		 	SetTask(1256, 2);
		 	return
		 else
		 	Talk(1,"","ta卼a卻� ta sao kh� th�, c竔 d辌h b謓h 蕐  cp m蕋 ngi v� c馻 ta r錳. T� nay v� sau ai n鑙 d鈏 t玭g 阯g cho h� Tri謚 y.")
		 	return
		 end
		 return
	elseif ( GetTask(1256) == 2 ) then
		Talk(1,"","Nghe n鉯 c� m閠 v� s� th竔 kh玭g bi誸 t� mi誹 n祇 n, ph竝 l鵦 v� bi猲 ngi 甶 h醝 th� xem sao.")
		return
	end

Say("Ta th藅 xui x蝟, n b﹜ gi� c騨g ch璦 c� con trai, ch糿g l� Tri謚 Gia ta th藅 t 畂筺 hng ho� r錳 sao?",0)

end;

