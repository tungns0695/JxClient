--中原南区 扬州府 嫖客1对话
Include("\\script\\task\\newtask\\branch\\xiepai\\branch_xiepaitasknpc.lua")
Include("\\script\\task\\newtask\\newtask_head.lua")
function main(sel)
	Uworld1058 = nt_getTask(1058)
	if ( Uworld1058 ~= 0 ) then
		branch_shenfeng()
	else
		Say("х M鬰 nh� Л阯g c� c﹗ th� 'Th藀 Ni猲 Nh蕋 Gi竎 Dng Ch﹗ M閚g, Doanh Ьc Thanh L莡 B筩 H筺h Danh', h� t蕋 ph秈 ch衜 gi誸 l蒼 nhau ch�?",0)
	end
end;


