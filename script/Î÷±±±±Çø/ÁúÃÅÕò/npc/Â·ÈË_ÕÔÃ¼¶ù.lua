--龙门镇 路人 赵眉儿 新手任务：捎口信
-- By: Dan_Deng(2003-09-04)

function main(sel)
	UTask_world26 = GetTask(26)
	if (UTask_world26 == 3) then		-- 任务中
		Talk(8,"W26_step2","Mi Nhi c� nng! C� ngi nh� ta b竜 tin cho c� ","Tin g� v藋?","Ti猽 D辌h 秐h  ch誸.","C竔 g�?","Ti猽 D辌h 秐h  ch誸 r錳.","Kh玭g th� n祇...Ngi g箃 ta! Ta kh玭g tin!"," (R鑤 cu閏 l� th� n祇?) "," L� ai n鉯 v韎 ngi?")
	else				-- 非任务对话
		Talk(1,"","Ta ng祔 th竛g � y ch� mong, cu鑙 c飊g th� i n khi n祇 y?")
	end
end;

function W26_step2()
	Talk(1,"","Ta 卼a kh玭g th� n鉯 頲! C竜 t�!")
	SetTask(26,6)
	AddNote("Mang tin n祔 n鉯 v韎 Tri謚 Mi Nhi, kh玭g ng� ph秐 鴑g c馻 n祅g ta m筺h m� nh� v藋. Hay l� ta quay l筰 h醝 l穙 ╪ m祔. ")
	Msg2Player("Mang tin n祔 n鉯 v韎 Tri謚 Mi Nhi, kh玭g ng� ph秐 鴑g c馻 n祅g ta m筺h m� nh� v藋. Hay l� ta quay l筰 h醝 l穙 ╪ m祔. ")
end;
