--æä¾›ç¦ç¼˜é¢†å–çš„NPC
--2004.8.5

Include( "\\script\\global\\fuyuan.lua" )
Include("\\script\\task\\newtask\\education\\jiaoyutasknpc.lua") 
Include("\\script\\task\\newtask\\newtask_head.lua")
--Include("\\script\\event\\storm\\award_npc.lua")	--Storm
Include("\\script\\event\\mid_autumn\\autumn_portal.lua")
Include("\\script\\event\\tongwar\\head.lua")
Include("\\script\\task\\system\\task_string.lua")
Include([[\script\missions\chrismas\ch_head.lua]]);--
--	2007å¹´æ˜¥èŠ‚æ´»åŠ¨
Include([[\script\event\springfestival07\head.lua]]);
--æ­¦æž—ä»¤æ´»åŠ¨
Include( "\\script\\event\\wulinling\\wulinling.lua" )
Include( "\\script\\event\\nanfangjiefangri\\event.lua" )
Include("\\script\\event\\tongwar\\head.lua");
--dinhhq_20110124:Vip acc 2011
Include("\\script\\vng_event\\vip_account_2011\\npc\\volamtruyennhan.lua")

function main()
	
	-- å‡¡æ˜¯æ¶‰åŠåˆ°æ´»åŠ¨çš„æ­¦æž—ç›Ÿä¼ äººå¯¹è¯çš†æ’å…¥åˆ°æ­¤æ•°ç»„ -- ä½©é›·æ–¯ 2006/03/20
	local aryTalk  = {};
	local ndate = tonumber(GetLocalDate("%Y%m%d%H"));
	local Uworld1000 = nt_getTask(1000);
	
	tinsert(aryTalk, "<dec><npc>Thé˜¨ th?loç­º lç­©, ch?v?nçŒ² gi?î†o chè¼“h phç«”, tç­¼ phéª³ ché«‡g sinh. C?th?méŸŽ hi vé‹˜g tr?thç¥…h mé–  î†i hiè¬• î†„é ² mé‹“ ngî…£i ngî…¥ng m?");
	--dinhhq_20110124:Vip acc 2011
	tbVNG_VipAcc2011_VLTN:addDialog(aryTalk)
	
	if ndate >= 2007042800 and ndate <= 2007051324 then
	tinsert(aryTalk,"Hoç®ƒ î‡€ng 30-4 v?Qué‘“ t?lao î‡€ng/nanfangjiefangri_main");
	end
	if (not FALSE(tongwar_checkinphase())) then
		tinsert(aryTalk, "V?Lï¹Ž Ðµ Nhè•‹ Bang/tongWar_Start");
	end;
	
	--tinsert(aryTalk, "îœ¯ danh nhï¹ î†„é˜¯g/honor_hall_enter");
	
	--tinsert(aryTalk, "îœ¯ Minh Nguyè¬™ trè•/autumn_enter");
	
	tinsert(aryTalk, "Nhè–¾ ç”¶è§¤ phéª³ duyçŒ² cé¦»  bç­º/OnGain_Self");

	if( GetTeamSize() > 1 ) then
		tinsert(aryTalk, "Nhè–¾ ç”¶è§¤ phéª³ duyçŒ² cé¦» tè•‹ c?thç¥…h viçŒ² trong nhé‰³/OnGain_Team");
	end;
	
	tinsert(aryTalk, "Nhè–¾ ç”¶è§¤ danh vé‹˜g (chç² nhiè¥² gi? /W33_prise");
	
	tinsert(aryTalk, "Thé˜¨ gian tè¼ˆh lé¨³ î†½i ç”¶è§¤ phéª³ duyçŒ²/OnQueryTime");
	
	tinsert(aryTalk, "LiçŒ² quan î†¬n phéª³ duyçŒ²/OnAbout");
	
	tinsert(aryTalk, "Hé§“ b?/OnCancel");
	
	if ( Uworld1000 ==340 ) or ( Uworld1000 == 350 ) then
		education_wulinmengchuanren();
		return
	end;
	
	CreateTaskSay(aryTalk);
	
	
end

--é¢†å–çŽ©å®¶æœ¬äººçš„ç¦ç¼˜ç‚¹æ•°
function OnGain_Self()
	if( IsCharged() ~= 1 ) then
		Say( "Ngî„¥i chç’¦ nç­½ th? nç­½ xong  hç©£ î†¬n tè­µ ta!", 0 );
		return
	end
	if (GetTiredDegree() == 2) then
		Say( "Bç­º î†Ž bî…¦c vç¥‡ giai ç•‚ç­º mè¬™ mé†! khçŽ­g th?nhè–¾ ç”¶è§¤ phéª³ duyçŒ². Xin hç©£ ngh?ngç², gi?gè­¶ sé´† khé†—!", 0 );
		return
	end;
	if( GetTask( TASKID_FY_START_ONLINE_TIME ) == 0 ) then
		Say( "Cç«Ž h?méŸŽ ra giang h? ta c?ché« l?vè—…, xin nhè–¾ lè•!", 0 );
		FuYuan_Start();
		FuYuan_Add( 2 );
		return
	end
	local nResult = FuYuan_Gain();
	if( nResult == 0 ) then
		Say( "Ngî„¥i phiçŒ½ bç®ƒ giang h?céª chç’¦ î‡ˆ, hé‹ hé† nhiè¥² thçŒ° réŒ³ î†¬n tè­µ ta!", 0 );
	elseif( nResult == 1 ) then
		Say( "Ngî„¥i phiçŒ½ bç®ƒ giang h?î†Ž lï¹—, cçŽ­g lao î†Ž nhiè¥², î†€y l?phèŽ• thî…¤ng ngî„¥i î†ng î†„é ² nhè–¾! îž²ng b?l?", 0 );
	end
end

--é¢†å–çŽ©å®¶é˜Ÿä¼æ‰€æœ‰æˆå‘˜çš„ç¦ç¼˜ç‚¹æ•°
function OnGain_Team()
	if( IsCharged() ~= 1 ) then
		Say( "Ngî„¥i chç’¦ nç­½ th? nç­½ xong  hç©£ î†¬n tè­µ ta!", 0 );
		return
	end
	if (GetTiredDegree() == 2) then
		Say( "Bç­º î†Ž bî…¦c vç¥‡ giai ç•‚ç­º mè¬™ mé†! khçŽ­g th?nhè–¾ ç”¶è§¤ phéª³ duyçŒ². Xin hç©£ ngh?ngç², gi?gè­¶ sé´† khé†—!", 0 );
		return
	end;
	if( GetTask( TASKID_FY_START_ONLINE_TIME ) == 0 ) then
		Say( "Cç«Ž h?méŸŽ ra giang h? ta c?ché« l?vè—…, xin nhè–¾ lè•!", 0 );
		FuYuan_Start();
		FuYuan_Add( 2 );
		return
	end
	local nPreservedPlayerIndex = PlayerIndex;
	local nMemCount = GetTeamSize();
	local bAllUnavailable = 1;
	for i = 1, nMemCount do
		PlayerIndex = GetTeamMember( i );
		if( FuYuan_Gain() == 1 ) then
			bAllUnavailable = 0;
		end		
	end
	PlayerIndex = nPreservedPlayerIndex;
	if( bAllUnavailable == 0 ) then
		Say( "Ngî„¥i phiçŒ½ bç®ƒ giang h?î†Ž lï¹—, cçŽ­g lao î†Ž nhiè¥², î†€y l?phèŽ• thî…¤ng ngî„¥i î†ng î†„é ² nhè–¾! îž²ng b?l?", 0 );
	else
		Say( "Ngî„¥i phiçŒ½ bç®ƒ giang h?céª chç’¦ î‡ˆ, hé‹ hé† nhiè¥² thçŒ° réŒ³ î†¬n tè­µ ta!", 0 );
	end
end

--æŸ¥è¯¢å½“å‰å¯æ¢å–ç¦ç¼˜çš„ç´¯ç§¯åœ¨çº¿æ—¶é—´
function OnQueryTime()
	if( IsCharged() ~= 1 ) then
		Say( "Ngî„¥i chç’¦ nç­½ th? nç­½ xong  hç©£ î†¬n tè­µ ta!", 0 );
		return
	end
	if( GetTask( TASKID_FY_START_ONLINE_TIME ) == 0 ) then
		Say( "Cç«Ž h?méŸŽ ra giang h? ta c?ché« l?vè—…, xin nhè–¾ lè•!", 0 );
		FuYuan_Start();
		FuYuan_Add( 2 );
		return
	end
	local nFYTotalTime, FYValidTime = FuYuan_GetDepositTime();
	Say( "<#> T?ç”¶è§¤ phéª³ duyçŒ² lèŽ• trî…¦c nhè–¾ î†„é ², téŽ›g cé–šg bç­º tè¼ˆh lé¨³ î†„é ² <color=yellow>"..timeToString( nFYTotalTime ).."<#> <color> thé˜¨ gian Online", 0 );
end

--å…³äºŽç¦ç¼˜
function OnAbout()
	Talk( 3, "", "S?ç”¶è§¤ phéª³ duyçŒ²: ThçŽ­g qua tè¼ˆh lé¨³ thé˜¨ gian Online s?î†½i lè• mé–  s?ç”¶è§¤ ç§“, c?th?dé£Šg î†ª î†½i cç«Ž loç­° vè—… phè´ î†c biè¬™  ?ThèŽ• b?Thî„¥ng Nhï¹ Liè©• è•‹(Tî„¥ng Dî„¥ng) .", "Ñ„i phéª³ duyçŒ²: Sau khi online > 2 gi? î†¬n V?Lï¹Ž Truyè¥« Nhï¹ ?cç«Ž Ð§i thç¥…h th?î†ª î†½i. Nèª¹ 1 ngç¥” î†½i phéª³ duyçŒ² thç¥…h cçŽ­g 2 lèŽ•, s?nhè–¾ î†„é ² phèŽ• thî…¤ng. Nèª¹ Online < 4 gi? mé¸ gi?î†½i î†„é ² 1 ç”¶è§¤. Sau î†º, mé¸ 2 gi?î†½i î†„é ² 1 ç”¶è§¤. Thç¥…h viçŒ² trong î‡€i c?th?nhè–¾ ç”¶è§¤ gié«‰ cho c?î‡€i.", "Hç­º ch? khi ngéŒ³ t?v?luyè¬“ cçŽ­g trçŒ² Ð£o hoa î†o s?khçŽ­g tè¼“h vç¥‡ thé˜¨ gian tè¼ˆh lé¨³ î†½i ç”¶è§¤ phéª³ duyçŒ². ?gian ç•‚ç­º mè¬™ mé† khçŽ­g th?nhè–¾ ç”¶è§¤ phéª³ duyçŒ²." );
end


function W33_prise()				-- åœ¨çº¿æ—¶é—´é€å£°æœ›ä»»åŠ¡

Uworld33 = GetTask(33)

if (GetGameTime() - Uworld33 >= 43200) then

	SetTask(33,GetGameTime())
	Talk(1,"","V?lï¹Ž truyè¥« nhï¹: N?léµ¦ cé¦» ngî„¥i ta î†©u nhè­¶ thè•! Tiè¥« î†¼ sç«›g lç­º khçŽ­g xa! Tièª´ té¬° c?gç·‰g nh?")
	i = random(0,99)
	if (i < 19) then			-- 19%
		AddRepute(1)
		Msg2Player("Bç­º î†„é ² tâ•ªg 1 ç”¶è§¤ danh vé‹˜g.")
	elseif (i < 36) then		-- 17%
		AddRepute(2)
		Msg2Player("Bç­º î†„é ² tâ•ªg 2 ç”¶è§¤ danh vé‹˜g.")
	elseif (i < 51) then		-- 15%
		AddRepute(3)
		Msg2Player("Bç­º î†„é ² tâ•ªg 3 ç”¶è§¤ danh vé‹˜g.")
	elseif (i < 64) then		-- 13%
		AddRepute(4)
		Msg2Player("Bç­º î†„é ² tâ•ªg 4 ç”¶è§¤ danh vé‹˜g.")
	elseif (i < 75) then		-- 11%
		AddRepute(5)
		Msg2Player("Bç­º î†„é ² tâ•ªg 5 ç”¶è§¤ danh vé‹˜g.")
	elseif (i < 84) then		-- 9%
		AddRepute(6)
		Msg2Player("Bç­º î†„é ² tâ•ªg 6 ç”¶è§¤ danh vé‹˜g.")
	elseif (i < 91) then		-- 7%
		AddRepute(7)
		Msg2Player("Bç­º î†„é ² tâ•ªg 7 ç”¶è§¤ danh vé‹˜g.")
	elseif (i < 96) then		-- 5%
		AddRepute(8)
		Msg2Player("Bç­º î†„é ² tâ•ªg 8 ç”¶è§¤ danh vé‹˜g.")
	elseif (i < 99) then		-- 3%
		AddRepute(9)
		Msg2Player("Bç­º î†„é ² tâ•ªg 9 ç”¶è§¤ danh vé‹˜g.")
	else							-- 1% (i = 99)
		AddRepute(10)
		Msg2Player("Bç­º î†„é ² tâ•ªg 10 ç”¶è§¤ danh vé‹˜g.")
	end

else

	Say("V?lï¹Ž truyè¥« nhï¹: îœ¯è¥² kiè¬“ cé¦» ngî„¥i hiè¬“ nay khçŽ­g î‡ˆ î†ª nhè–¾ ç”¶è§¤ danh vé‹˜g. V?l?tî…¤ng cé¦» mè­¶h, hç©£ c?lçŒ²!",0)

end

end



--å–æ¶ˆ
function OnCancel()
end

function timeToString( time )
	local nHour = floor( time / 3600 );
	local nMinute = mod( floor( time / 60 ), 60 );
	local nSecond = mod( time, 60 );
	return nHour.."<#> gi?"..nMinute.."<#> phé« "..nSecond.."<#> giï¹œ ";	
end

function honor_hall_enter()
    NewWorld(897, 1553, 3329);
end