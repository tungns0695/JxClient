--中原南区 扬州府 路人17乐清秋对话
Include("\\script\\task\\newtask\\branch\\zhongli\\branch_zhonglitasknpc.lua")
Include("\\script\\task\\newtask\\newtask_head.lua")

function main(sel)
	Uworld1054 = nt_getTask(1054)
	if ( Uworld1054 ~= 0 ) then
		branch_leqingqiu()
	else
		Say("Ta ch秐g c� b秐 l躰h g�, ch� bi誸 d鵤 v祇 t礽 v� tranh m� s鑞g qua ng祔", 0);
	end
end;




