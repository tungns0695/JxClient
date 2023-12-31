--IncludeLib("ITEM");
--IncludeLib("TIMER");
--IncludeLib("FILESYS");
--IncludeLib("SETTING");
--IncludeLib("TASKSYS")
--IncludeLib("PARTNER");
--IncludeLib("BATTLE");
--IncludeLib("RELAYLADDER");
--IncludeLib("TONG");
--IncludeLib("LEAGUE");
--Include( "\\script\\task\\system\\task_string.lua" );
--Include("\\script\\task\\newtask\\newtask_head.lua")
--Include("\\script\\lib\\awardtemplet.lua")
--Include("\\script\\lib\\log.lua");
--Include("\\script\\dailogsys\\dailogsay.lua")
--Include("\\script\\dailogsys\\g_dialog.lua")
--Include("\\script\\activitysys\\functionlib.lua")
--Include("\\script\\global\\translife.lua")
--Include("\\script\\global\\fantasygoldequip\\fantasygoldequip_npc.lua");
--Include("\\script\\global\\gm\\ex_lib_head.lua");
--Include("\\script\\global\\gm\\lib_data_table.lua");
--Include("\\script\\global\\gm\\lib_data_table_filelua.lua");

--Include("\\script\\global\\特殊用地\\梦境\\npc\\路人_叛僧.lua"); -- t葃 t駓, c閚g 甶觤 nhanh
 Include("\\script\\global\\fuyuan.lua")
tbFunction = {
		{"N﹏g c蕄 ","level",0,200,"Nh藀 C蕄 ч:"},
		{"Danh v鋘g v� ph骳 duy猲","danhvong",0,100000,"Nh藀 S� Lng:"},
		{"Ti襫 v筺","tienvan",0,1000,"Nh藀 S� Lng:"},
		{"Ti襫 ng","tiendong",0,2000,"Nh藀 S� Lng:"},
		{"KNB","knb",0,60,"Nh藀 S� Lng:"},
		{"觤 Ch﹏ Nguy猲 v� H� M筩h Кn","channguyen",0,100000,"Nh藀 S� Lng:"},
		{"觤 Ti襪 N╪g","pointtiemnang",0,30000,"Nh藀 S� Lng:"},
		{"觤 K� N╪g","pointkynang",0,1000,"Nh藀 S� Lng:"},
		{"T礽 l穘h o","tailanhdao",0,1000000000,"Nh藀 S� Lng:"},
		{"觤 c鑞g hi課","conghien",0,1000000,"Nh藀 S� Lng:"},
 }
---------- L蕐 c竎 lo筰 甶觤----------------
function laydiem()
	dofile("script/global/gm/function_points.lua")
	local szTitle = "Xin ch祇 ! Чi hi謕 mu鑞 nh薾 lo筰 甶觤 n祇1?"
	local tbOpt= {}
	for i = 1 , getn(tbFunction) do
		tinsert(tbOpt, {tbFunction[i][1],askNunber, {tbFunction[i][2], tbFunction[i][3], tbFunction[i][4], tbFunction[i][5]}})
	end
	tinsert(tbOpt, {"L竧 n鱝 quay l筰"});
	CreateNewSayEx(szTitle, tbOpt)
end
-------------------------------------------------------------------------
function askNunber(nIndex, nIndex1, nIndex2, nIndex3)
	AskClientForNumber(nIndex, nIndex1, nIndex2, nIndex3) 
end
------------C蕄-------------------
function askNunber1()
	AskClientForNumber("change_phai", 0, 10, "Nh藀 S� Lng111:") 
end

function level(nIndex)
	local nCurLevel = GetLevel()
	local nAddLevel = nIndex - nCurLevel
	ST_LevelUp(nAddLevel)
	Msg2Player("B筺 nh薾 頲 c蕄  <color=yellow>"..nIndex.."<color>.") 
end

function danhvong(nIndex)
	AddRepute(nIndex)
	FuYuan_Start()
	FuYuan_Add(nIndex)
	Msg2Player("B筺 nh薾 頲 "..nIndex.." 甶觤 Danh V鋘g v� Ph骳 Duy猲.")
end

function tienvan(nIndex)
	local money= nIndex*10000
	Earn(money)
	Msg2Player(format("B筺 nh薾 頲 <color=yellow>%d v筺<color>.", nIndex))
end

----------------觤 K� N╪g----------------------------------------
function pointkynang(nIndex)
	AddMagicPoint(nIndex)		---Nh薾 甶觤 k� n╪g
	Msg2Player("B筺 nh薾 頲 <color=yellow>"..nIndex.."<color> 甶觤 K� N╪g.")
end
------------------觤 Ti襪 N╪g--------------------------------------
function pointtiemnang(nIndex)
	AddProp(nIndex)		---Nh薾 甶觤 ti襪 n╪g
	Msg2Player("B筺 nh薾 頲 <color=yellow>"..nIndex.."<color> 甶觤 Ti襪 N╪g.")
end

---Tien Dong---
function tiendong(nIndex)
	for i = 1, nIndex do
		--AddStackItem(1,4,417,1,1,0,0,0)
		AddItem(4,417,1,1,0,0,0)
	end
	Msg2Player("B筺 nh薾 頲 <color=yellow>"..nIndex.." <color>ti襫 ng.")
end
------------T礽 L穘h Чo----------------------------
function tailanhdao(nIndex)
	for i = 1, 250 do
		AddLeadExp(nIndex)
	end
	Msg2Player("B筺 nh薾 頲  <color=yellow>"..nIndex.." <color> 甶觤 exp t礽 l穘h o");
end
------------觤 C鑞g Hi課----------------------------
function conghien(nIndex)
	AddContribution(nIndex);
	Msg2Player("B筺 nh薾 頲  <color=yellow>"..nIndex.." <color> 甶觤 c鑞g hi課")
end
----KNB------
function knb(nIndex)
	for i=1, nIndex do
		AddEventItem(343)
	end
Msg2Player("B筺 nh薾 頲 <color=yellow>"..nIndex.." <color>KNB.")
end
------------Ch﹏ Nguy猲----------------------------
function channguyen(nIndex)
	SetTask(4000, GetTask(4000) + nIndex)	
	for i = 1,nIndex do
		AddItem(6, 1, 3203, 0, 0, 0)
	end
	Msg2Player("Nh薾 頲 <color=yellow>"..nIndex.." Ch﹏ Nguy猲 v� "..nIndex.." H� M筩h Кn")
end