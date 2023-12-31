--接任务的Npc
--·参与的玩家等级必须大于40级；
--·宋方的玩家必须要到衡山独孤剑处报名；
--·金方的玩家必须要到汴京衙门口金国武将处报名；
--·报名时需要交纳一定的金钱；

Include("\\script\\missions\\宋金战场PK战\\宋金战场头文件.lua");

function main()

local State = GetMissionV(1) 

--未开始
if (State == 0 ) then 
	Say("Чi qu﹏ c馻 ta v蒼 ch璦 xu蕋 ph竧! H穣 t筸 th阨 ngh� ng琲 i tin nh�!",0);
	NewWorld(78,1768,3098)
	SetFightState(1)
	return
end;

--异常情况直接退出
if (State > 2) then
	NewWorld(78,1768,3098)
	SetFightState(1)
	return
end;


local GroupV = GetTask(SJTASKVLAUE);
--如果该玩家是已经报名过的，断线重连进来的，则扔进去
result = CheckLastBattle(1, State);
if (result == 1) then
	return
end

if (result == 2) then
	--此句话是敌方玩家与对方的报名Npc的对话
	Say("Ngi Kim b鋘 ngi, x﹎ lc giang s琻, gi誸 h筰 ng b祇 ta! Ta th� quy誸 c飊g b鋘 ngi m閠 m蕋 m閠 c遪!",0)
end


--报名时期
if (State == 1 or State == 2) then 
	MSDIdx = PIdx2MSDIdx(1, PlayerIndex);
	if (MSDIdx > 0) then 
		nGroup = GetMSIdxGroup(1, MSDIdx);
 		
	if ( nGroup == 1) then 
    		Say("Qu鑓 gia h璶g vong, h蕋 phu h鱱 tr竎h! B﹜ gi� l� l骳 ta v� c竎 ngi b竜 琻 t nc!",0)
  		else
    		Say("Ngi Kim b鋘 ngi, x﹎ lc giang s琻, gi誸 h筰 ng b祇 ta! Ta th� quy誸 c飊g b鋘 ngi m閠 m蕋 m閠 c遪!",0)
  		end
	
		return
	end;
end;

if (State == 1) then
	if (GetMSPlayerCount(1,1) >= MAX_S_COUNT) then
		Say("Qu﹏ l鵦 c馻 ta hi謓 gi�  d� s鴆 ti猽 di謙 Kim qu﹏. Tr竛g s� xin i tr薾 sau nh�!", 0)
	return
	end;
	
	Say("Qu鑓 gia h璶g vong, h蕋 phu h鱱 tr竎h! B﹜ gi� l� l骳 ta v� c竎 ngi b竜 琻 t nc! Ch� c莕 ng c蕄 tr猲 40, 駈g h� 3000 lng l� c� th� x玭g pha gi誸 ch!",2,"Ta tham gia. /Yes", "в ta suy ngh� l筰!/No");
end;

--交战时期
if (State == 2) then 
	Say("Ti襫 phng 產ng di詎 ra chi課 tranh, c竎 v� hng th﹏ xin t譵 n琲 kh竎 l竛h n筺 ",0);
	return 
end;

end;

function Yes()
if (GetMissionV(1) ~= 1) then
	return
end
if (GetLevel() >= 40) then 
  if (Pay(MS_SIGN_MONEY) == 1) then
  Msg2Player("Hoan ngh猲h ngi gia nh藀. c竎 Anh h飊g Чi T鑞g, h穣 nhanh ch鉵g ti課 ra chi課 trng. ");
  V = GetMissionV(5);
  SetMissionV(5, V + 1);
  AddMSPlayer(1,1);
  SJ_JoinS();
  SetTask(SJKILLNPC,0);
  SetTask(SJKILLPK,0);
  --CheckGoFight()
  return 
  end;
end;

Say("B筺 ch璦  40 c蕄 ho芻 kh玭g mang  ti襫! ",0);

end;

function No()
Say("Mau v� suy ngh� 甶! Th阨 gian c遪 l筰 kh玭g nhi襲 u!",0);
end;
