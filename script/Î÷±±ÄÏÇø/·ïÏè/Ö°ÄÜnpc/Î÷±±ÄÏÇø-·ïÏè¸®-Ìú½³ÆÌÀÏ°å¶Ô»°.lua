--西北南区 凤翔府 铁匠铺老板对话

Include("\\script\\global\\global_tiejiang.lua")

TIEJIANG_DIALOG = "<dec><npc>Mu鑞 mua lo筰 v� kh� n祇? Xin m阨 xem v� ch鋘 t� nhi猲."
function main(sel)
	tiejiang_city(TIEJIANG_DIALOG);
end;


function yes()
	Sale(19);  			--弹出交易框
end;

