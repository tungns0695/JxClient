-- 西山村npc加载脚本
-- 李欣 2005-01-26

xishancunnpc = {
{306,1,4,175,1641,3191,0,"T躰h S� ",0,"\\script\\江南区\\西山村\\npc\\npc_buxingrenshi.lua"},
{242,1,4,175,1716,3124,0,"T﹜ s琻 Ti觰 Nh� ",0,"\\script\\江南区\\西山村\\npc\\npc_xishanxiaoer.lua"},
{750,1,4,175,1624,3138,0,"Nguy謙 Th� ",0,"\\script\\江南区\\西山村\\npc\\npc_yueliangtu.lua"},
{749,1,4,175,1623,3139,0,"K� K� ",0,"\\script\\江南区\\西山村\\npc\\npc_tuziqiqi.lua"},
{307,1,4,175,1620,3149,0,"誹 T薾 Thi猲 H� C� чc kh竎h",0,"\\script\\江南区\\西山村\\npc\\npc_diaosou.lua"},
{77,1,4,175,1701,3190,0,"Bi猲 th祅h L穘g T� ",0,"\\script\\江南区\\西山村\\npc\\npc_bianchenglangzi.lua"},
{662,1,4,175,1698,3205,0,"Gi竜 luy謓 Tr莕 L� Sanh",0,"\\script\\江南区\\西山村\\npc\\npc_jiaolian.lua"},
{181,1,4,175,1697,3110,0,"V� Ch� C莔 Ma",0,"\\script\\江南区\\西山村\\npc\\npc_weizhiqinmo.lua"},
{135,1,4,175,1657,3208,0,"Kh玭g ph秈 ta l� Phong",0,"\\script\\江南区\\西山村\\npc\\npc_bushiwoshifeng.lua"},
{133,1,4,175,1665,3214,0,"T竜 th駓 tinh",0,"\\script\\江南区\\西山村\\npc\\npc_pingguo.lua"},
}

function add_xishancunnpc(Tab2)
	for i = 1 , getn(Tab2) do
		Mid = SubWorldID2Idx(Tab2[i][4]);
		if (Mid >= 0 ) then
			TabValue5 = Tab2[i][5] * 32
			TabValue6 = Tab2[i][6] * 32
			newtasknpcindex = AddNpcEx(Tab2[i][1],Tab2[i][2],Tab2[i][3],Mid,TabValue5,TabValue6,Tab2[i][7],Tab2[i][8],Tab2[i][9]);
			SetNpcScript(newtasknpcindex, Tab2[i][10]);
		end;
	end;
end;