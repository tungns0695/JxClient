--两湖区 天王帮 卖装备的帮众对话
-- Update: Dan_Deng(2003-08-21) 加入卖道具只卖给本帮

function main(sel)
	Uworld38 = GetByte(GetTask(38),1)
	if (GetFaction() == "tianwang") or (Uworld38 == 127) then
		Say("C竎 huynh  b鎛 bang c� ng祔 ch箉 ng ch箉 t﹜ kh玭g th� kh玭g c� m閠 b� trang b� t鑤", 2, "Giao d辌h/yes", "Kh玭g giao d辌h/no")
	else
		Talk(1,"","Bang ch� c� l謓h: trang b� c馻 b鎛 bang ch� b竛 cho huynh  ng m玭")
	end
end;

function yes()
Sale(58);  			
end;

function no()
end;






