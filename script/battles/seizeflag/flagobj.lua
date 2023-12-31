IncludeLib("BATTLE");
IncludeLib("SETTING");
Include("\\script\\battles\\battlehead.lua")
Include("\\script\\battles\\seizeflag\\head.lua")

function main()
npcidx = GetLastDiagNpc();

--该旗同时被另一个人拿走了，则不再操作
if (GetNpcParam(npcidx, 4) == 0 ) then
	return
end;

if (GetMissionV(MS_STATE) ~= 2) then
	delnpcsafe(npcidx);
	print("flagobj Event error, because Mission no Start, yet");
	return 
end;

--固定模式时，不能拿敌方的棋
if (GetMissionV(MS_FLAGMODE) == 1) then
	if (GetNpcParam(npcidx, 3) ~= GetCurCamp()) then
		Msg2Player("B筺 ch� c� th� di chuy觧 So竔 K� c馻 phe m譶h!")
		return
	end
end

	if (BT_GetData(PL_PARAM1) ~= 0 or BT_GetData(PL_PARAM2) ~= 0) then
		Msg2Player("Trong tay c遪 c�, kh玭g th� 畂箃 th猰 c� kh竎!");
		return
	end

	x = GetNpcParam(npcidx, 1);
	y = GetNpcParam(npcidx, 2);
	
	ChangeOwnFeature(0,0,643);
	
	BT_SetData(PL_PARAM1, x)
	BT_SetData(PL_PARAM2, y)


	Msg2Player("B筺  畂箃 So竔 K�, h穣 mau chuy觧 n <color=yellow>"..floor(x/(32*8))..","..floor(y/(32*16)));
	W,X1,Y1 = GetWorldPos();
	if (GetCurCamp() == 1) then
		Msg2MSAll(MISSIONID, "<color=0x00FFFF> phe T鑞g <color=yellow>"..GetName().."<color=0x00FFFF> t筰 <color=yellow>"..floor(X1/8)..","..floor(Y1/16).."<color=0x00FFFF> 畂箃 頲 So竔 K�, hi謓 產ng chuy觧 n <color=yellow>"..floor(x/(32*8))..","..floor(y/(32*16)))
		AddSkillState(460, 1, 0, 1000000 ) --颜色光环，分辩敌我
		AddSkillState(656,30,0,100000) --降玩家的速度
		ST_SyncMiniMapObj(x, y);
		sf_setflagplayer(1, PlayerIndex)
	else
		Msg2MSAll(MISSIONID, "<color=0x9BFF9B> phe Kim <color=yellow>"..GetName().."<color=0x9BFF9B> t筰 <color=yellow>"..floor(X1/8)..","..floor(Y1/16).."<color=0x9BFF9B>  畂箃 頲 So竔 K�, hi謓 產ng chuy觧 n <color=yellow>"..floor(x/(32*8))..","..floor(y/(32*16)))
		AddSkillState(461, 1, 0, 1000000 ) --颜色光环，分辩敌我
		AddSkillState(656,30,0,100000) --降玩家的速度
		ST_SyncMiniMapObj(x, y);
		sf_setflagplayer(2, PlayerIndex)
	end
	SetNpcParam(npcidx,4,0)
	delnpcsafe(npcidx);
end;
