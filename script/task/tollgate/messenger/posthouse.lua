-------------------------------------------------------------------------
-- FileName		:	posthouse.lua
-- Author		:	xiaoyang
-- CreateTime	:	2005-04-04 15:30:14
-- Desc			:	送信任务驿官脚本
-------------------------------------------------------------------------
Include("\\script\\task\\newtask\\newtask_head.lua")
Include("\\script\\task\\tollgate\\messenger\\messenger_timeer.lua")    --调用计时器
Include("\\script\\task\\tollgate\\messenger\\messenger_losetask.lua")  --取消任务
Include("\\script\\task\\task_addplayerexp.lua")  --给玩家累加经验的公共函数
Include("\\script\\task\\tollgate\\killbosshead.lua") --包含了图象调用
Include("\\script\\activitysys\\g_activity.lua")
Include("\\script\\task\\tollgate\\messenger\\qianbaoku\\messenger_baoxiangtask.lua")--开宝箱工具函数
Include("\\script\\activitysys\\playerfunlib.lua")
Include("\\script\\lib\\log.lua")
--Include("\\script\\lib\\awardtemplet.lua")--给奖励接口

IncludeLib("RELAYLADDER");	--排行榜


--构造各城市去其他城市的任务变量对应表        60-89级，90-119级，120以上三种
--citygo 的构造方式
--到各城市的任务变量，对应值，当前城市名字，去到城市名字，系对任务id，当前城市id，去到城市地图id，x，y
--1201 a tin nhi謒 v� phong chi k� nhi謒 v� thay i lng 
--1202 a tin nhi謒 v� mi誹 s琻 th莕 nhi謒 v� thay i lng 
--1203 a tin nhi謒 v� thi猲 b秓 kho nhi謒 v� thay i lng

citygo = {
---- Dng Ch﹗ 甶 nh鱪g th祅h th� kh竎 (mapid:80) 
{1204,1,"Dng Ch﹗","Bi謓 Kinh",1201,80,37,1601,3001}, 
{1204,2,"Dng Ch﹗","Phng Tng ",1201,80,1,1561,3114}, 
{1204,3,"Dng Ch﹗","L﹎ An",1201,80,176,1592,2925}, 
{1204,4,"Dng Ch﹗","Th祅h Й",1201,80,11,3021,5090}, 
{1204,5,"Dng Ch﹗","Tng Dng",1201,80,78,1596,3379}, 
{1204,6,"Dng Ch﹗","Чi L�",1201,80,162,1674,3132}, 

---- bi謓 kinh 甶 nh鱪g th祅h th� kh竎 (mapid:37) 
{1204,7,"Bi謓 Kinh","Dng Ch﹗",1201,37,80,1676,3000}, 
{1204,8,"Bi謓 Kinh","Phng Tng ",1201,37,1,1561,3114}, 
{1204,9,"Bi謓 Kinh","L﹎ An",1201,37,176,1592,2925}, 
{1204,10,"Bi謓 Kinh","Th祅h Й",1201,37,11,3021,5090}, 
{1204,11,"Bi謓 Kinh","Tng Dng",1201,37,78,1596,3379}, 
{1204,12,"Bi謓 Kinh","Чi L�",1201,37,162,1674,3132},

---- phng tng 甶 nh鱪g th祅h th� kh竎 (mapid:1) 
{1204,13,"Phng Tng","Dng Ch﹗",1202,1,80,1676,3000}, 
{1204,14,"Phng Tng","Bi謓 Kinh",1202,1,37,1601,3001}, 
{1204,15,"Phng Tng","L﹎ An",1202,1,176,1592,2925}, 
{1204,16,"Phng Tng","Th祅h Й",1202,1,11,3021,5090}, 
{1204,17,"Phng Tng","Tng Dng",1202,1,78,1596,3379}, 
{1204,18,"Phng Tng","Чi L�",1202,1,162,1674,3132}, 
-- 
---- trc khi an 甶 nh鱪g th祅h th� kh竎 (mapid:176) 
{1204,19,"L﹎ An","Dng Ch﹗",1202,176,80,1676,3000}, 
{1204,20,"L﹎ An","Phng Tng",1202,176,1,1561,3114}, 
{1204,21,"L﹎ An","Bi謓 Kinh",1202,176,37,1601,3001}, 
{1204,22,"L﹎ An","Th祅h Й",1202,176,11,3021,5090}, 
{1204,23,"L﹎ An","Tng Dng",1202,176,78,1596,3379}, 
{1204,24,"L﹎ An"," Чi L� ",1202,176,162,1674,3132}, 
-- 
---- th祅h  甶 nh鱪g th祅h th� kh竎 (mapid:11) 
{1204,25,"Th祅h Й","Dng Ch﹗",1203,11,80,1676,3000}, 
{1204,26,"Th祅h Й","Phng Tng",1203,11,1,1561,3114}, 
{1204,27,"Th祅h Й","Bi謓 Kinh",1203,11,37,1601,3001}, 
{1204,28,"Th祅h Й","L﹎ An",1203,11,176,1592,2925}, 
{1204,29,"Th祅h Й","Tng Dng",1203,11,78,1596,3379}, 
{1204,30,"Th祅h Й","Чi L�",1203,11,162,1674,3132},

---- tng dng 甶 nh鱪g th祅h th� kh竎 (mapid:78) 
{1204,31,"Tng Dng","Dng Ch﹗",1203,78,80,1676,3000}, 
{1204,32,"Tng Dng","Phng Tng",1203,78,1,1561,3114}, 
{1204,33,"Tng Dng","Bi謓 Kinh",1203,78,37,1601,3001}, 
{1204,34,"Tng Dng","L﹎ An",1203,78,176,1592,2925}, 
{1204,35,"Tng Dng","Th祅h Й",1203,78,11,3021,5090}, 
{1204,36,"Tng Dng","Чi L�",1203,78,162,1674,3132}, 
-- 
---- Чi L� 甶 nh鱪g th祅h th� kh竎 (mapid:162) 
{1204,37,"Чi L�","Dng Ch﹗",1201,162,80,1676,3000}, 
{1204,38,"Чi L�","Phng tng",1201,162,1,1561,3114}, 
{1204,39,"Чi L�","Bi謓 kinh",1202,162,37,1601,3001}, 
{1204,40,"Чi L�","L﹎ An",1202,162,176,1592,2925}, 
{1204,41,"Чi L�","Tng Dng",1203,162,78,1596,3379}, 
{1204,42,"Чi L�","Th祅h Й",1203,162,11,3021,5090}, 

--成都去其他城市(mapid:11)
{1204,1,"Th祅h Й","Чi L�",1203,11,162,1674,3132}, 

-- Чi L� 甶 nh鱪g th祅h th� kh竎 (mapid:162) 
{1204,2,"Чi L�","Th祅h Й",1203,162,11,3021,5090},

}

-------------------------------------------特殊信使任务的主界面-------------------------------------------------
function especiallymessenger()
	if ( nt_getTask(1270) == 0 ) then
		nt_setTask(1270,1)
		nt_setTask(1205,0)
		Msg2Player("Xin l鏸, ngi nh薾 nhi謒 v� t輓 s�  qu� h筺.")
	end

	--七大主城驿官只有成都和大理有任务
	local _, _, nMapIndex = GetPos()
	--local MapId = SubWorldIdx2ID( nMapIndex )
	--if MapId ~= 11 and MapId ~= 162 then
		--Talk(1,"","Tham gia nhi謒 v� t輓 s�, xin m阨 甶 t譵 D辌h Quan <color=red> Th祅h Й <color> ho芻 l� <color=red> Чi L� <color>!")
		--return
	--end
	nt_setTask(1211,0)
	Ladder_NewLadder(10187, GetName(),nt_getTask(1205),1);--积分排名
	Describe(DescLink_YiGuan..": tri襲 nh qu﹏ c� g莕 nh蕋 t鎛g b� kim t芻 bi誸 trc, ta ho礽 nghi c� n閕 gian. Nh璶g l�, � ph竧 hi謓 nh鱪g b筰 ho筰 n祔 trc, ta mu鑞  cho th� nh﹏ c騨g bi誸, ngi ngh� v� qu鑓 gia t蒼 m閠 ph莕 l鵦 sao?",7,
	"Ta ng �!/messenger_ido",
	"Ta mu鑞 giao nhi謒 v� t輓 s�/messenger_finishtask", 
        "Ta mu鑞 h駓 nhi謒 v� t輓 s�/messenger_losemytask", 
        "Ta mu鑞 th╪g c蕄 nhi謒 v� t輓 s� danh hi謚/messenger_getlevel", 
        "Ta mu鑞 l蕐 甶觤 t輓 s�  i ph莕 thng/messenger_duihuanprize", 
        "Ta mu鑞 t譵 hi觰 nhi謒 v� t輓 s�/messenger_what", 
        "G莕 y ta c� chuy謓 b薾 r閚/no")
end


-------------------------------------------接受特殊信使任务的主界面-----------------------------------------------


function messenger_ido()
	local _, _, nMapIndex = GetPos()
	
	local Uworld1204 = nt_getTask(1204)  --记⒓玩家的任务变量，每次任务结束时清空
	local Uworld1028 = nt_getTask(1028)  --任务链任务变量
	local MapId = SubWorldIdx2ID( nMapIndex )
	if ( GetLevel() < 120 ) then
		Describe(DescLink_YiGuan..": Th藅 xin l鏸, trc m総 c蕄 b薱 c馻 ngi kh玭g  120 c蕄. Ti誴 t鬰 luy謓 t藀 sau  t韎 th蕐 ta.",1,"K誸 th骳 i tho筰/no")	
	elseif ( Uworld1204 ~= 0 )  then
		Describe(DescLink_YiGuan..": Th藅 xin l鏸 ! Ngi nhi謒 v� t輓 s� kh玭g ho祅 th祅h, kh玭g th� nh薾 gi鑞g nhau nhi謒 v�, xin m阨 ho祅 th祅h nhi謒 v� trc, c竚 琻!",1,"K誸 th骳 i tho筰/no")
	elseif (  messenger_givetime() == 10 ) then  --查看今日是否还有关卡时间
		Describe(DescLink_YiGuan.."Th藅 xin l鏸 , ng礽 h玬 nay � nhi謒 v� t輓 s�, th阨 gian  hao h誸, xin m阨 ng祔 mai tr� l筰",1,"K誸 th骳 i tho筰/no")
	else
    	        local nTaskFlag = check_daily_task_count()--检查还有没有任务机会
    	if nTaskFlag == 0 then
    		Describe(DescLink_YiGuan..":Th藅 xin l鏸, h玬 nay ngi  r蕋 m謙 m醝, ng祔 mai tr� l筰 甶",1,"K誸 th骳 i tho筰/no")
    		return
    	elseif nTaskFlag == -1 then
    		Describe(DescLink_YiGuan..": h玬 nay ngi  r蕋 m謙 m醝. N誹 nh� ngi c� <color=yellow> thi猲 b秓 kho l祄 <color>, ta 甧m ph� l� cho ngi tham gia n鱝 m閠 l莕.",1,"K誸 th骳 i tho筰/no")
    		return
    	elseif nTaskFlag == 2 then
    		Msg2Player("Ngi ch�  � c莔 thi猲 b秓 kho l祄 tham gia nhi謒 v� <color=yellow> nhi謒 v� ho祅 th祅h <color> ta 甧m thu h錳 l謓h b礽")
    	end
    	
    	WriteLog(format("Account:%s[Name:%s] Nh薾 nhi謒 v� t輓 s�, h玬 nay  ho祅 th祅h [%d] l莕",
				GetAccount(),
				GetName(),
				nTaskFlag
				)
			);
	if nTaskFlag == 2 then
		tbLog:PlayerActionLog("TinhNangKey","NhanNhiemVuTinSuSuDungThienBaoKhoLenh")		
	else
		tbLog:PlayerActionLog("TinhNangKey","NhanNhiemVuTinSu")
	end
		if ( MapId == 80 ) then
			local CityId = random(1,6)
			for i=1,6 do
				if ( messenger_choice(CityId,i) == 10 ) then
					break
				end
			end
		elseif ( MapId == 37 ) then
			local CityId = random(7,12)
			for i=7,12 do
				if ( messenger_choice(CityId,i) == 10 ) then
					break
				end
			end
		elseif ( MapId == 1 ) then
			local CityId = random(13,18)
			for i=13,18 do
				if ( messenger_choice(CityId,i) == 10 ) then
					break
				end
			end	
		elseif ( MapId == 176 ) then
			local CityId = random(19,24)
			for i=19,24 do
				if ( messenger_choice(CityId,i) == 10 ) then
					break
				end
			end		
		elseif ( MapId == 11 ) then
			

			local CityId = random(25,30)
			for i=25,30 do
				if ( messenger_choice(CityId,i) == 10 ) then
					break
				end
			end		
		elseif ( MapId == 78 ) then
			local CityId = random(31,36)
			for i=31,36 do
				if ( messenger_choice(CityId,i) == 10 ) then
					break
				end
			end
		elseif ( MapId == 162 ) then
			
			local CityId = random(37,42)
			for i=37,42 do
				if ( messenger_choice(CityId,i) == 10 ) then
					break
				end
			end
		else
			Msg2Player("Th藅 xin l鏸 ! Kh玭g hi觰 t筰 sao ngi kh玭g th� nh薾 nhi謒 v� t輓 s�, xin li猲 l筩 GM!")
		end
	end
end

--前往千宝库
function messenger_storewagoner()
	SetRevPos(11,10)
	
	NewWorld(395,1417,3207)
end

-----------------------------------------------给符合要求的玩家一个特殊信使任务，并改变其信使任务变量和到达关卡变量------------------------
function messenger_choice(CityIdTwo,j)
	if ( CityIdTwo == citygo[j][2] ) then	
		--设置由此地去彼地的任务变量	
		nt_setTask( 1204,citygo[j][2] )
		--设置去到哪个关卡的任务变量   
		nt_setTask( citygo[j][5],10) --设置信使任务的步骤
		local name = GetName()
		Talk(1,"","Чi nh﹏  nh薾 頲 nhi謒 v� T輓 S� t� "..citygo[j][3].." n "..citygo[j][4]..", h穣 kh雐 h祅h t筰 D辌h Tr筸 "..citygo[j][3]..". Xin b秓 tr鋘g "..name.." i nh﹏!")		
		return 10
	end
end


---------------------------------------------------升级信使称号----------------------------------------------------------------------
function messenger_getlevel()
	local Uworld1205 = nt_getTask(1205)
	local Uworld1206 = nt_getTask(1206)
	local messenger_reallevelname = ""
	if ( Uworld1206 == 1 ) then
		messenger_reallevelname = "M閏 b礽 t輓 s�"
	elseif ( Uworld1206 == 2 ) then
		messenger_reallevelname = "уng b礽 t輓 s�"
	elseif ( Uworld1206 == 3 ) then
		messenger_reallevelname = "Ng﹏ b礽 t輓 s�"
	elseif ( Uworld1206 == 4 ) then
		messenger_reallevelname = "Kim b礽 t輓 s�"
	elseif ( Uworld1206 == 5 ) then
		messenger_reallevelname = "Ng� t� kim b礽 t輓 s�"
	else	
		messenger_reallevelname = "Kh玭g c� b蕋 k� t輓 s� n祇"
	end 
	Describe(DescLink_YiGuan.."Ng礽 trc m総 l� "..messenger_reallevelname.." , ng礽 t輈h l騳 甶觤 t輓 s� v� "..Uworld1205.." 甶觤, ng礽 mu鑞 th╪g c蕄 l祄 lo筰 n祇 t輓 s� khi課 cho y",6,
		"M閏 b礽 t輓 s鯷50点]/messenger_levelmu",
		"уng b礽 t輓 s鯷150点]/messenger_leveltong",
		"Ng﹏ b礽 t輓 s鯷450点]/messenger_levelyin",
		"Kim b礽 t輓 s鯷800点]/messenger_leveljin",
		"Ng� t� kim b礽 t輓 s鯷1500点]/messenger_levelyuci",
		"Ta ch糿g qua l� t飝 ti謓 xem m閠 ch髏/no")
end

function messenger_levelmu()
	local Uworld1205 = nt_getTask(1205)
	local Uworld1206 = nt_getTask(1206)
	local name = GetName()
	if ( Uworld1205 >= 50 ) then
		if ( Uworld1206 < 1 ) then
			nt_setTask(1206,1)
			nt_setTask(1205,Uworld1205-50)
			Describe(DescLink_YiGuan..": Ch骳 m鮪g "..name.." i nh﹏ tr� th祅h t輓 s� cho - m閏 !",1,"K誸 th骳 i tho筰/no")
		elseif ( Uworld1206 == 1 ) then
			Describe(DescLink_YiGuan..":"..name.."! Ngi  l� t輓 s� - m閏, kh玭g c莕 th╪g c蕄 , xin c� g緉g!",1,"K誸 th骳 i tho筰/no")		
		else
			Describe(DescLink_YiGuan..":"..name.."! C蕄 b薱 c馻 ngi vt qua t輓 s� - m閏 , xin/m阨 l鵤 ch鋘 nh鱪g kh竎 tin/th� khi課 cho.",2,"Tr� v�/messenger_getlevel","K誸 th骳 i tho筰/no")				
		end
	else
		Describe(DescLink_YiGuan..":Th藅 xin l鏸 ! Ngi kh玭g ph� h頿 th╪g c蕄 t輓 s� - m閏  甶襲 ki謓, xin c� g緉g, c竚 琻 !!",2,"Tr� v�/messenger_getlevel","K誸 th骳 i tho筰/no")
	end
end

function messenger_leveltong()
	local Uworld1205 = nt_getTask(1205)
	local Uworld1206 = nt_getTask(1206)
	local name = GetName()
	if ( Uworld1205 >= 150 )  then
		if ( Uworld1206 < 2 ) then
			nt_setTask(1206,2)
			nt_setTask(1205,Uworld1205-150)
			Describe(DescLink_YiGuan..": Ch骳 m鮪g "..name.." i nh﹏  l� t輓 s� - ng !!",1,"K誸 th骳 i tho筰/no")
		elseif ( Uworld1206 == 2 ) then
			Describe(DescLink_YiGuan..":"..name.."! Ngi  l� t輓 s� - ng, kh玭g c莕 th╪g c蕄, xin ti誴 t鬰 c� g緉g !",1,"K誸 th骳 i tho筰/no")				
		else
			Describe(DescLink_YiGuan..":"..name.."! C蕄 b薱 c馻 ngi vt qua t輓 s� - ng, xin m阨 l鵤 ch鋘 nh鱪g lo筰 t輓 s� kh竎.",2,"Tr� v�/messenger_getlevel","K誸 th骳 i tho筰/no")				
		end
	else
		Describe(DescLink_YiGuan..":Th藅 xin l鏸 ! Ngi kh玭g   甶襲 ki謓 ph� h頿 th╪g c蕄 t輓 s� - ng, xin ti誴 t鬰 c� g緉g, c竚 琻!",2,"Tr� v�/messenger_getlevel","K誸 th骳 i tho筰/no")
	end
end

function messenger_levelyin()
	local Uworld1205 = nt_getTask(1205)
	local Uworld1206 = nt_getTask(1206)
	local name = GetName()
	if ( Uworld1205 >= 450 ) then
		if ( Uworld1206 < 3 ) then
			nt_setTask(1206,3)
			nt_setTask(1205,Uworld1205-450)
			Describe(DescLink_YiGuan..": Ch骳 m鮪g "..name.." ngi c馻 th╪g c蕄 l祄 ng﹏ t輓 s�",1,"K誸 th骳 i tho筰/no")
		elseif ( Uworld1206 == 3 ) then
			Describe(DescLink_YiGuan..":"..name.."! Ngi  l� ng﹏ t輓 s�, kh玭g c莕 th╪g c蕄, xin ti誴 t鬰 c� g緉g !!",1,"K誸 th骳 i tho筰/no")				
		else
			Describe(DescLink_YiGuan..":"..name.."! C蕄 b薱 c馻 ngi  qua ng﹏ t輓 s�, xin m阨 l鵤 ch鋘 nh鱪g t輓 s� kh竎 !",2,"Tr� v�/messenger_getlevel","K誸 th骳 i tho筰/no")				
		end
	else
		Describe(DescLink_YiGuan..":Th藅 xin l鏸 ! Ngi kh玭g  甶襲 ki謓 ph� h頿 th╪g c蕄 ng﹏ t輓 s�, xin ti誴 t鬰 c� g緉g !",2,"Tr� v�/messenger_getlevel","K誸 th骳 i tho筰/no")
	end
end

function messenger_leveljin()
	local Uworld1205 = nt_getTask(1205)
	local Uworld1206 = nt_getTask(1206)
	local name = GetName()
	if ( Uworld1205 >= 800 ) then
		if ( Uworld1206 < 4 ) then
			nt_setTask(1206,4)
			nt_setTask(1205,Uworld1205-800)
			Describe(DescLink_YiGuan..": Ch骳 m鮪g "..name.." i nh﹏  l� t輓 s� - kim !",1,"K誸 th骳 i tho筰/no")
		elseif ( Uworld1206 == 4 ) then
			Describe(DescLink_YiGuan..":"..name.."! Ngi  l� t輓 s� - kim, kh玭g c莕 th╪g c蕄, xin ti誴 t鬰 c� g緉g !",1,"K誸 th骳 i tho筰/no")		
		else
			Describe(DescLink_YiGuan..":"..name.."! C蕄 b薱 c馻 ngi  qua t輓 s� - kim, xin m阨 l鵤 ch鋘 nh鱪g t輓 s� kh竎 !",2,"Tr� v�/messenger_getlevel","K誸 th骳 i tho筰/no")				
		end
	else
		Describe(DescLink_YiGuan..":Th藅 xin l鏸 ! Ngi kh玭g  甶襲 ki謓 ph� h頿 th╪g c蕄 t輓 s� - kim, xin ti誴 t鬰 c� g緉g !",2,"Tr� v�/messenger_getlevel","K誸 th骳 i tho筰/no")
	end
end

function messenger_levelyuci()
	local Uworld1205 = nt_getTask(1205)
	local Uworld1206 = nt_getTask(1206)
	local name = GetName()
	if ( Uworld1205 >= 1500 ) then
		if ( Uworld1206 < 5 ) then
			nt_setTask(1206,5)
			nt_setTask(1205,Uworld1205-1500)
			Describe(DescLink_YiGuan..": Ch骳 m鮪g "..name.." i nh﹏ th╪g c蕄 vi ng� t� t輓 s� y猽 b礽!",1,"K誸 th骳 i tho筰/no")
		elseif ( Uworld1206 == 5 ) then
			Describe(DescLink_YiGuan..":"..name.."Ngi  l� ng� t� t輓 s� y猽 b礽, kh玭g c莕 th╪g c蕄, xin ti誴 t鬰 c� g緉g!",1,"K誸 th骳 i tho筰/no")				
		end
	else
		Describe(DescLink_YiGuan..":Th藅 xin l鏸 ! Ngi kh玭g  甶襲 ki謓 ph� h頿 th╪g c蕄 ng� t� t輓 s� y猽 b礽, xin ti誴 t鬰 c� g緉g !",2,"Tr� v�/messenger_getlevel","K誸 th骳 i tho筰/no")
	end
end

--------------------------------------------交信使任务------------------------------------------------------
function messenger_finishtask()
	local Uworld1201= nt_getTask(1201)	--送信任务风之骑任务变量
	local Uworld1202= nt_getTask(1202)	--送信任务山神庙任务变量
	local Uworld1203= nt_getTask(1203)	--送信任务千宝库任务变量
	local Uworld1204= nt_getTask(1204)	--送信任务所到地点任务变量
	local Uworld1205= nt_getTask(1205)	--信使积分
	local Uworld1206= nt_getTask(1206)	--信使称号
	local Uworld1208= nt_getTask(1208)	--风之骑杀怪记数器
	local Uworld1209= nt_getTask(1209)	--山神庙杀怪记数器
	local Uworld1210= nt_getTask(1210)	--千宝库杀怪记数器
	local Uworld1218= nt_getTask(1218)  --信使任务完成次数记数器

	if ( Uworld1201 == 30 ) then
		if ( messenger_gettime() == 10 ) then
			Describe(DescLink_YiGuan.."Th藅 xin l鏸, ngi kh玭g c� � ho祅 th祅h t輓 s� t韎 nh薾 l蕐 ph莕 thng, nhi謒 v� n祔 xem th蕋 b筰 !",1,"K誸 th骳 i tho筰/no")
		else
			nt_setTask(1218,Uworld1218+1)
			Describe(DescLink_YiGuan.."Ch骳 m鮪g ng礽  ho祅 th祅h nhi謒 v� hi謓 t筰 !",1,"Nh薾 l蕐 ph莕 thng/messenger_flyprize")
		end
	elseif ( Uworld1202 == 30 ) then
		if ( messenger_gettime() == 10 ) then
			Describe(DescLink_YiGuan.."Th藅 xin l鏸, ngi kh玭g c� � ho祅 th祅h t輓 s� t韎 nh薾 l蕐 ph莕 thng, nhi謒 v� n祔 xem th蕋 b筰 ",1,"K誸 th骳 i tho筰/no")
		else
			nt_setTask(1218,Uworld1218+1)
			Describe(DescLink_YiGuan.."Ch骳 m鮪g ng礽  ho祅 th祅h nhi謒 v� hi謓 t筰",1,"Nh薾 l蕐 ph莕 thng/messenger_templeprize")
		end
	elseif ( Uworld1203 == 30 or Uworld1203 == 25 ) then
		if ( messenger_gettime() == 10 ) then
			Describe(DescLink_YiGuan..":Th藅 xin l鏸, ngi kh玭g c� � ho祅 th祅h t輓 s� t韎 nh薾 l蕐 ph莕 thng, nhi謒 v� n祔 xem th蕋 b筰!",1,"K誸 th骳 i tho筰/no")
		else
			nt_setTask(1218,Uworld1218+1)
			Describe(DescLink_YiGuan..": Ch骳 m鮪g ng礽  ho祅 th祅h nhi謒 v� hi謓 t筰",1,"Nh薾 l蕐 ph莕 thng/messenger_treasureprize")
		end
	elseif ( Uworld1201 == 25 ) or ( Uworld1202 == 25 ) or ( Uworld1203 == 25 ) then   --完成了简单信使任务
		if ( messenger_gettime() == 10 ) then
			Describe(DescLink_YiGuan.."Th藅 xin l鏸, ngi kh玭g c� � ho祅 th祅h t輓 s� t韎 nh薾 l蕐 ph莕 thng, nhi謒 v� n祔 xem th蕋 b筰",1,"K誸 th骳 i tho筰/no")
		else
			nt_setTask(1218,Uworld1218+1)
			Describe(DescLink_YiGuan.." Ch骳 m鮪g ng礽  ho祅 th祅h nhi謒 v� hi謓 t筰",1,"Nh薾 l蕐 ph莕 thng/messenger_simpleprize")	
		end
	elseif ( Uworld1201 ~= 0 or Uworld1202 ~= 0 or Uworld1203 ~= 0 ) then
		Describe(DescLink_YiGuan..": Nhi謒 v� t輓 s� c馻 ng礽 ch璦 ho祅 th祅h, xin h穣 ti誴 t鬰 c� g緉g",1,"K誸 th骳 i tho筰/no")
	elseif Uworld1203 ~= 0 then
		Describe(DescLink_YiGuan..": Th藅 xin l鏸, ngi c遪 ch璦 ho祅 th祅h nhi謒 v�. B猲 c筺h ta c� l穙 phu xe c� th� gi髉 ngi n nhi謒 v� b秐  !",1,"K誸 th骳 i tho筰/no")
	else
		Describe(DescLink_YiGuan..": Kh玭g ti誴 nh薾 v�, ngi c遪 t韎 h駓 nhi謒 v� ! ngi t韎, 甧m ngi n莥 cho ta l祄 th祅h th辴 ngi b竛h bao !",1,"K誸 th骳 i tho筰/no")
	end
end

function messenger_flyprize()
tbAwardTemplet:GiveAwardByList({tbProp = {6,1,4092,0,0,0}, nExpiredTime=43200, nBindState=-2}, "test", 1);
	Ladder_NewLadder(10187, GetName(),nt_getTask(1205),1);
	local Uworld1207 = nt_getTask(1207)
	local i = random(1,5)
	AddRepute(i)
	Msg2Player("Ch骳 m鮪g ngi thu 頲 "..i.." 甶觤 danh v鋘g. ")
	if ( nt_getTask(1224) ~= 1 ) then
		if ( GetLevel()>=60 and GetLevel()<=89 ) then
			if ( nt_getTask(1223) >= 150 ) then
				messenger_giveplayerexp(1500000)
			end
		elseif ( GetLevel()>=90 and GetLevel()<=119 ) then
			if ( nt_getTask(1223) >= 200 ) then
				messenger_giveplayerexp(2000000)
			end			
		elseif ( GetLevel()>=120 and GetLevel()<=129 ) then
			if ( nt_getTask(1223) >= 300 ) then
				messenger_giveplayerexp(3000000)
			end		
		elseif ( GetLevel()>=130 ) then
			if ( nt_getTask(1223) >= 600 ) then
				messenger_giveplayerexp(6000000)
			end		
		end
	end
	
	nt_setTask(1201,0)	--送信任务风之骑任务变量
	nt_setTask(1204,0)	--送信任务所到地点任务变量
	nt_setTask(1207,0)	--送信任务当前杀怪记数
	nt_setTask(1211,0)
end

function messenger_templeprize()

tbAwardTemplet:GiveAwardByList({tbProp = {6,1,4092,0,0,0}, nExpiredTime=43200, nBindState=-2}, "test", 1);
 	Ladder_NewLadder(10187, GetName(),nt_getTask(1205),1);
	local Uworld1207 = nt_getTask(1207)
	local i = random(1,5)
	AddRepute(i)
	Msg2Player("Ch骳 m鮪g ngi thu 頲 "..i.." 甶觤 danh v鋘g. ")
	if ( nt_getTask(1224) ~= 1 ) then
		if ( GetLevel()>=60 and GetLevel()<=89 ) then
			if ( nt_getTask(1223) >= 150 ) then
				messenger_giveplayerexp(1500000)
			end
		elseif ( GetLevel()>=90 and GetLevel()<=119 ) then
			if ( nt_getTask(1223) >= 200 ) then
				messenger_giveplayerexp(2000000)
			end			
		elseif ( GetLevel()>=120 and GetLevel()<=129 ) then
			if ( nt_getTask(1223) >= 300 ) then
				messenger_giveplayerexp(3000000)
			end		
		elseif ( GetLevel()>=130 ) then
			if ( nt_getTask(1223) >= 600 ) then
				messenger_giveplayerexp(6000000)
			end		
		end
	end
	
	nt_setTask(1202,0)	--送信任务山神庙任务变量
	nt_setTask(1204,0)	--送信任务所到地点任务变量
	nt_setTask(1207,0)	--送信任务当前杀怪记数
	nt_setTask(1211,0)
end

function messenger_treasureprize()
  local nTaskFlag = check_daily_task_count()--检查还有没有任务机会
  if nTaskFlag == 0 then
  	Describe(DescLink_YiGuan..": Th藅 xin l鏸, h玬 nay ngi  r蕋 m謙 m醝. Ng祔 mai tr� l筰 i nhi謒 v� 甶",1,"K誸 th骳 i tho筰/no")
  	return
  elseif nTaskFlag == -1 then
  	Describe(DescLink_YiGuan..": Ngi c� ph秈 hay kh玭g c莔 <color=yellow> thi猲 b秓 kh� l猲h <color> b� m蕋 ? T譵 v� l謓h b礽 m韎 c� th� cho ngi nh薾 thng",1,"K誸 th骳 i tho筰/no")
  	return
  end
  
  --检查背包空间
  local nTodayTaskCount = %get_task_daily(1205)
  local nBagCellNeed = 1
  if nTodayTaskCount == 0 then
  	nBagCellNeed = 2
  end
  if (CalcFreeItemCellCount() < nBagCellNeed) then
		Talk(1, "", format("<#>H祅h trang c馻 ngi ch璦  ch� tr鑞g, xin s緋 x誴 l筰 trang b� l璾 l筰 %d ch� tr鑞g, sau  t韎 nh薾 thng",nBagCellNeed))
		return
	end
	local n_level = GetLevel();
	G_ACTIVITY:OnMessage("FinishMail", 1, n_level);	
	--扣除千宝库令
	if nTaskFlag == 2 then
	--Fix bug 不能在帮会箱子内扣除千宝库令- Modifiec by DinhHQ - 20110502
	    	if ConsumeEquiproomItem(1, 6, 1, 2813, -1) == 1 then--扣除千宝库令
	    		Msg2Player("Ngi  n閜 l猲 thi猲 b秓 kh� l謓h")
	    	else
	    		Talk(1, "", "Ngi thi猲 b秓 kh� l猲h 甶 n琲 n祇, th� n祇 ta kh玭g th蕐?")
	    		return
	    	end
    end
    
   	%add_task_daily(1205, 1)
	nt_setTask(1201,0)	--
	nt_setTask(1202,0)
	nt_setTask(1203,0)
	nt_setTask(1204,0)
	
	nTodayTaskCount = %get_task_daily(1205)--获取交任务后的计数值
	WriteLog(format("Account:%s[Name:%s] Nh薾 l蕐 ph莕 thng nhi謒 v� t輓 s�, h玬 nay  ho祅 th祅h [%d] l莕.",
			GetAccount(),
			GetName(),
			nTodayTaskCount
			)
		);
		
	--每天第一次完成任务奖励3个行侠令
	if nTodayTaskCount == 1 then
		for i = 1, 3 do
			--Fix bug sai level 行侠令- Modified by DinhHQ - 20110921
			AddItem(6,1,2566,1,0,0)--获取的行侠令为不绑定状态
		end;
		Msg2Player("Ngi t 頲 3 c竔 h祅h hi謕 l謓h")
	end
	
	--每次交任务奖励2个信使宝箱
	for i = 1, 2 do
		AddItem(6,1,2812,0,0,0)
tbAwardTemplet:GiveAwardByList({tbProp = {6,1,4092,0,0,0}, nExpiredTime=43200, nBindState=-2}, "test", 1);
	end;
	Msg2Player("Ngi t 頲 2 c竔 t輓 s� b秓 rng")
end

function messenger_simpleprize()
tbAwardTemplet:GiveAwardByList({tbProp = {6,1,4092,0,0,0}, nExpiredTime=43200, nBindState=-2}, "test", 1);

	Ladder_NewLadder(10187, GetName(),nt_getTask(1205),1);
	local i = random(1,5)
	AddRepute(i)
	Msg2Player("Ch骳 m鮪g ngi thu 頲 "..i.." 甶觤 danh v鋘g.")
	nt_setTask(1201,0)	
	nt_setTask(1202,0)	
	nt_setTask(1203,0)	
	nt_setTask(1204,0)
	nt_setTask(1207,0)
	nt_setTask(1211,0)
		
end

--------------------------------------------积分换奖励-----------------------------------------------------
function messenger_duihuanprize()
	Describe(DescLink_YiGuan..": Ph莕 thng bao g錷 : t輓 s� y猽 b礽 c飊g trang b� ho祅g kim. Y猽 b礽 c� th� gia t╪g nh﹏ v藅 kh竛g t輓h, ho祅g kim trang b� c� th� gia t╪g kinh nghi謒. Ngi ngh� ch鋘 lo筰 n祇 ?",3,
		"T輓 s� y猽 b礽 /messenger_prize_yaopai",
		"Ho祅g kim trang b�/messenger_prize_huangjin",
		"уng b筺 tng quan/messenger_prize_partner",
		"Nh鱪g v藅 ph萴 kh竎/messenger_prize_other",
		"в ta suy ngh� l筰!/no")
end

function messenger_prize_partner()
	Describe(DescLink_YiGuan..": Th� l躰h Long N╩ m韎 v鮝 mang v� m閠 輙 <color=red> th莕 b� ng h祅h m苩 n� <color>, ngi ngh� d飊g th� sao?",5,
		"уng h祅h k� n╪g/no",
		"уng h祅h m苩 n�/messenger_prize_mianju",
		"уng h祅h v藅 ph萴/no",
		"Tr� v�/messenger_duihuanprize",
		"в ta suy ngh� l筰!/no")
end

function messenger_prize_mianju()
	Describe(DescLink_YiGuan..": уng h祅h m苩 n� chia l祄 2 lo筰 : 1 l莕 s� d鬾g c飊g 10 l莕 s� d鬾g. mu鑞 i c竔 ?",4,
	"фi m苩 n� 1 l莕/prize_mianju_dan",
	"фi m苩 n� 10 l莕/prize_mianju_shi",
	"Tr� v�/messenger_prize_partner",
	"K誸 th骳 i tho筰 !/no")

end

function prize_mianju_shi()
	Describe(DescLink_YiGuan..": Ngi ngh� i m苩 n� (10 l莕) thi誹 ni猲 v� s� l玦 ki誱 c遪 l� thanh ni猲 v� s� l玦 ki誱 ? th蕐 r� r祅g li評 sao ??",4,
	"фi m苩 n� thi誹 ni猲 v� s� /prize_mianju_shi_shaonian", 
        "фi m苩 n� thanh ni猲 v� /prize_mianju_shi_qingnian", 
        "Tr� v� /messenger_prize_mianju", 
        "T筸 th阨 kh玭g th� i !/no")
end

function prize_mianju_shi_shaonian()
	Describe(DescLink_YiGuan..": b総 u i !",7, 
       "M苩 n� (10 l莕 ) - thi誹 ni猲 l玦 ki誱 [40000 ph髏 ]/prize_mianju_shi_shaolin_leijian", 
       "M苩 n� (10 l莕 ) - thi誹 ni猲 ci sng [40000 ph髏 ]/prize_mianju_shi_shaolin_xiaoshuang", 
       "M苩 n� (10 l莕 ) - ng祅 n╩ l鯽 nh蒼 [40000 ph髏 ]/prize_mianju_shi_shaolin_huoren", 
       "M苩 n� (10 l莕 ) - thi誹 ni猲 h秈 阯g [40000 ph髏 ]/prize_mianju_shi_shaolin_haitang", 
       "M苩 n� (10 l莕 ) - thi誹 ni猲 kim phong [40000 ph髏 ]/prize_mianju_shi_shaolin_jinfeng", 
       "Tr� v� /prize_mianju_shi", 
       "T筸 th阨 kh玭g th� i !/no")
end

function prize_mianju_shi_qingnian()
	Describe(DescLink_YiGuan..": b総 u i !",7, 
        "M苩 n� (10 l莕 ) - thanh ni猲 l玦 ki誱 [40000 ph髏 ]/prize_mianju_shi_qinglin_leijian", 
        "M苩 n� (10 l莕 ) - thanh ni猲 ci sng [40000 ph髏 ]/prize_mianju_shi_qinglin_xiaoshuang", 
        "M苩 n� (10 l莕 ) - thanh ni猲 l鯽 nh蒼 [40000 ph髏 ]/prize_mianju_shi_qinglin_huoren", 
        "M苩 n� (10 l莕 ) - thanh ni猲 h秈 阯g [40000 ph髏 ]/prize_mianju_shi_qinglin_haitang", 
        "M苩 n� (10 l莕 ) - thanh ni猲 kim phong [40000 ph髏 ]/prize_mianju_shi_qinglin_jinfeng", 
        "Tr� v� /prize_mianju_shi", 
        "T筸 th阨 kh玭g  th� i!/no")
end

function prize_mianju_shi_qinglin_leijian()
	if ( nt_getTask(1205) >= 40000 ) then
		AddItem(0,11,112,0,0,0,0)
		local Uworld1205 = nt_getTask(1205) - 40000
		nt_setTask(1205,Uworld1205)
		Msg2Player("Ngi t 頲 1 ng h祅h m苩 n�.")
	else
		Describe(DescLink_YiGuan..": Th藅 xin l鏸 ! 觤 ngi t輈h l騳 kh玭g .",1,"K誸 th骳! /no")
	end 
end

function prize_mianju_shi_qinglin_xiaoshuang()
	if ( nt_getTask(1205) >= 40000 ) then
		AddItem(0,11,113,0,0,0,0)
		local Uworld1205 = nt_getTask(1205) - 40000
		nt_setTask(1205,Uworld1205)
		Msg2Player("B筺 nh薾 頲 m閠 m苩 n� th﹏ thi謓")
	else
		Describe(DescLink_YiGuan..": Th藅 xin l鏸 ! 觤 ngi t輈h l騳 kh玭g .",1,"K誸 th骳! /no")
	end 
end

function prize_mianju_shi_qinglin_huoren()
	if ( nt_getTask(1205) >= 40000 ) then
		AddItem(0,11,114,0,0,0,0)
		local Uworld1205 = nt_getTask(1205) - 40000
		nt_setTask(1205,Uworld1205)
		Msg2Player("Ngi t 頲 1 ng h祅h m苩 n�")
	else
		Describe(DescLink_YiGuan..": Th藅 xin l鏸 ! 觤 ngi t輈h l騳 kh玭g .",1,"K誸 th骳! /no")
	end 
end

function prize_mianju_shi_qinglin_haitang()
	if ( nt_getTask(1205) >= 40000 ) then
		AddItem(0,11,115,0,0,0,0)
		local Uworld1205 = nt_getTask(1205) - 40000
		nt_setTask(1205,Uworld1205)
		Msg2Player("Ngi t 頲 1 ng h祅h m苩 n�")
	else
		Describe(DescLink_YiGuan..": Th藅 xin l鏸 ! 觤 ngi t輈h l騳 kh玭g .",1,"K誸 th骳! /no")
	end 
end

function prize_mianju_shi_qinglin_jinfeng()
	if ( nt_getTask(1205) >= 40000 ) then
		AddItem(0,11,116,0,0,0,0)
		local Uworld1205 = nt_getTask(1205) - 40000
		nt_setTask(1205,Uworld1205)
		Msg2Player("Ngi t 頲 1 ng h祅h m苩 n�")
	else
		Describe(DescLink_YiGuan..": Th藅 xin l鏸 ! 觤 ngi t輈h l騳 kh玭g .",1,"K誸 th骳! /no")
	end 
end

function prize_mianju_shi_shaolin_leijian()
	if ( nt_getTask(1205) >= 40000 ) then
		AddItem(0,11,102,0,0,0,0)
		local Uworld1205 = nt_getTask(1205) - 40000
		nt_setTask(1205,Uworld1205)
		Msg2Player("Ngi t 頲 1 ng h祅h m苩 n�")
	else
		Describe(DescLink_YiGuan..": Th藅 xin l鏸 ! 觤 ngi t輈h l騳 kh玭g .",1,"K誸 th骳! /no")
	end 
end

function prize_mianju_shi_shaolin_xiaoshuang()
	if ( nt_getTask(1205) >= 40000 ) then
		AddItem(0,11,103,0,0,0,0)
		local Uworld1205 = nt_getTask(1205) - 40000
		nt_setTask(1205,Uworld1205)
		Msg2Player("Ngi t 頲 1 ng h祅h m苩 n�")
	else
		Describe(DescLink_YiGuan..": Th藅 xin l鏸 ! 觤 ngi t輈h l騳 kh玭g .",1,"K誸 th骳! /no")
	end 
end

function prize_mianju_shi_shaolin_huoren()
	if ( nt_getTask(1205) >= 40000 ) then
		AddItem(0,11,104,0,0,0,0)
		local Uworld1205 = nt_getTask(1205) - 40000
		nt_setTask(1205,Uworld1205)
		Msg2Player("Ngi t 頲 1 ng h祅h m苩 n�")
	else
		Describe(DescLink_YiGuan..": Th藅 xin l鏸 ! 觤 ngi t輈h l騳 kh玭g .",1,"K誸 th骳! /no")
	end 
end

function prize_mianju_shi_shaolin_haitang()
	if ( nt_getTask(1205) >= 40000 ) then
		AddItem(0,11,105,0,0,0,0)
		local Uworld1205 = nt_getTask(1205) - 40000
		nt_setTask(1205,Uworld1205)
		Msg2Player("Ngi t 頲 1 ng h祅h m苩 n�")
	else
		Describe(DescLink_YiGuan..": Th藅 xin l鏸 ! 觤 ngi t輈h l騳 kh玭g .",1,"K誸 th骳! /no")
	end 
end

function prize_mianju_shi_shaolin_jinfeng()
	if ( nt_getTask(1205) >= 40000 ) then
		AddItem(0,11,106,0,0,0,0)
		local Uworld1205 = nt_getTask(1205) - 40000
		nt_setTask(1205,Uworld1205)
		Msg2Player("Ngi t 頲 1 ng h祅h m苩 n�")
	else
		Describe(DescLink_YiGuan..": Th藅 xin l鏸 ! 觤 ngi t輈h l騳 kh玭g .",1,"K誸 th骳! /no")
	end 
end

function prize_mianju_dan()
	Describe(DescLink_YiGuan..": Ngi ngh� i m苩 n� (1 l莕 ) thi誹 ni猲 v� s� l玦 ki誱 c遪 l� thanh ni猲 v� s� l玦 ki誱 ? th蕐 r� r祅g nh薾 sao?",4,
	"фi m苩 n� thi誹 ni猲 v� s� /prize_mianju_dan_shaonian", 
        "фi m苩 n� thanh ni猲 V� s�/prize_mianju_dan_qingnian", 
        "Tr� v� /messenger_prize_mianju", 
        "T筸 th阨 kh玭g th� i !/no")
end

function prize_mianju_dan_qingnian()
	Describe(DescLink_YiGuan..": b総 u i.",7, 
        "M苩 n� (1 l莕 ) - thanh ni猲 l玦 ki誱 [10000 ph髏 ]/prize_mianju_dan_qinglin_leijian", 
        "M苩 n� (1 l莕 ) - thanh ni猲 ci sng [10000 ph髏 ]/prize_mianju_dan_qinglin_xiaoshuang", 
        "M苩 n� (1 l莕 ) - thanh ni猲 l鯽 nh蒼 [10000 ph髏 ]/prize_mianju_dan_qinglin_huoren", 
        "M苩 n� (1 l莕 ) - thanh ni猲 h秈 阯g [10000 ph髏 ]/prize_mianju_dan_qinglin_haitang", 
        "M苩 n� (1 l莕 ) - thanh ni猲 kim phong [10000 ph髏 ]/prize_mianju_dan_qinglin_jinfeng", 
        "Tr� v� /prize_mianju_dan", 
        "T筸 th阨 kh玭g th� i !/no")
end

function prize_mianju_dan_shaonian()
	Describe(DescLink_YiGuan..": b総 u i.",7, 
        "M苩 n� (1 l莕 ) - thi誹 ni猲 l玦 ki誱 [10000 ph髏 ]/prize_mianju_dan_shaolin_leijian", 
        "M苩 n� (1 l莕 ) - thi誹 ni猲 ci sng [10000 ph髏 ]/prize_mianju_dan_shaolin_xiaoshuang", 
        "M苩 n� (1 l莕 ) - ng祅 n╩ l鯽 nh蒼 [10000 ph髏 ]/prize_mianju_dan_shaolin_huoren", 
        "M苩 n� (1 l莕 ) - ng祅 n╩ h秈 阯g [10000 ph髏 ]/prize_mianju_dan_shaolin_haitang", 
        "M苩 n� (1 l莕 ) - ng祅 n╩ kim phong [10000 ph髏 ]/prize_mianju_dan_shaolin_jinfeng", 
        "Tr� v� /prize_mianju_dan", 
        "T筸 th阨 kh玭g th� i !/no")
end

function prize_mianju_dan_shaolin_leijian()
	if ( nt_getTask(1205) >= 10000 ) then
		AddItem(0,11,97,0,0,0,0)
		local Uworld1205 = nt_getTask(1205) - 10000
		nt_setTask(1205,Uworld1205)
		Msg2Player("Ngi t 頲 1 m苩 n� ng h祅h")
	else
		Describe(DescLink_YiGuan..": Th藅 xin l鏸 ! 觤 t輈h l騳 kh玭g .",1,"K誸 th骳! /no")
	end 
end

function prize_mianju_dan_shaolin_xiaoshuang()
	if ( nt_getTask(1205) >= 10000 ) then
		AddItem(0,11,98,0,0,0,0)
		local Uworld1205 = nt_getTask(1205) - 10000
		nt_setTask(1205,Uworld1205)
		Msg2Player("Ngi t 頲 1 m苩 n� ng h祅h")
	else
		Describe(DescLink_YiGuan..": Th藅 xin l鏸 ! 觤 t輈h l騳 kh玭g .",1,"K誸 th骳! /no")
	end 
end

function prize_mianju_dan_shaolin_huoren()
	if ( nt_getTask(1205) >= 10000 ) then
		AddItem(0,11,99,0,0,0,0)
		local Uworld1205 = nt_getTask(1205) - 10000
		nt_setTask(1205,Uworld1205)
		Msg2Player("Ngi t 頲 1 m苩 n� ng h祅h")
	else
		Describe(DescLink_YiGuan..": Th藅 xin l鏸 ! 觤 t輈h l騳 kh玭g .",1,"K誸 th骳! /no")
	end 
end

function prize_mianju_dan_shaolin_haitang()
	if ( nt_getTask(1205) >= 10000 ) then
		AddItem(0,11,100,0,0,0,0)
		local Uworld1205 = nt_getTask(1205) - 10000
		nt_setTask(1205,Uworld1205)
		Msg2Player("Ngi t 頲 1 m苩 n� ng h祅h")
	else
		Describe(DescLink_YiGuan..": Th藅 xin l鏸 ! 觤 t輈h l騳 kh玭g .",1,"K誸 th骳! /no")
	end 
end

function prize_mianju_dan_shaolin_jinfeng()
	if ( nt_getTask(1205) >= 10000 ) then
		AddItem(0,11,101,0,0,0,0)
		local Uworld1205 = nt_getTask(1205) - 10000
		nt_setTask(1205,Uworld1205)
		Msg2Player("Ngi t 頲 1 m苩 n� ng h祅h")
	else
		Describe(DescLink_YiGuan..": Th藅 xin l鏸 ! 觤 t輈h l騳 kh玭g .",1,"K誸 th骳! /no")
	end 
end

function prize_mianju_dan_qinglin_leijian()
	if ( nt_getTask(1205) >= 10000 ) then
		AddItem(0,11,107,0,0,0,0)
		local Uworld1205 = nt_getTask(1205) - 10000
		nt_setTask(1205,Uworld1205)
		Msg2Player("Ngi t 頲 1 m苩 n� ng h祅h")
	else
		Describe(DescLink_YiGuan..": Th藅 xin l鏸 ! 觤 t輈h l騳 kh玭g .",1,"K誸 th骳! /no")
	end 
end

function prize_mianju_dan_qinglin_xiaoshuang()
	if ( nt_getTask(1205) >= 10000 ) then
		AddItem(0,11,108,0,0,0,0)
		local Uworld1205 = nt_getTask(1205) - 10000
		nt_setTask(1205,Uworld1205)
		Msg2Player("Ngi t 頲 1 m苩 n� ng h祅h")
	else
		Describe(DescLink_YiGuan..": Th藅 xin l鏸 ! 觤 t輈h l騳 kh玭g .",1,"K誸 th骳! /no")
	end 
end

function prize_mianju_dan_qinglin_huoren()
	if ( nt_getTask(1205) >= 10000 ) then
		AddItem(0,11,109,0,0,0,0)
		local Uworld1205 = nt_getTask(1205) - 10000
		nt_setTask(1205,Uworld1205)
		Msg2Player("Ngi t 頲 1 m苩 n� ng h祅h")
	else
		Describe(DescLink_YiGuan..": Th藅 xin l鏸 ! 觤 t輈h l騳 kh玭g .",1,"K誸 th骳! /no")
	end 
end

function prize_mianju_dan_qinglin_haitang()
	if ( nt_getTask(1205) >= 10000 ) then
		AddItem(0,11,110,0,0,0,0)
		local Uworld1205 = nt_getTask(1205) - 10000
		nt_setTask(1205,Uworld1205)
		Msg2Player("Ngi t 頲 1 m苩 n� ng h祅h")
	else
		Describe(DescLink_YiGuan..": Th藅 xin l鏸 ! 觤 t輈h l騳 kh玭g .",1,"K誸 th骳! /no")
	end 
end

function prize_mianju_dan_qinglin_jinfeng()
	if ( nt_getTask(1205) >= 10000 ) then
		AddItem(0,11,111,0,0,0,0)
		local Uworld1205 = nt_getTask(1205) - 10000
		nt_setTask(1205,Uworld1205)
		Msg2Player("Ngi t 頲 1 m苩 n� ng h祅h")
	else
		Describe(DescLink_YiGuan..": Th藅 xin l鏸 ! 觤 t輈h l騳 kh玭g .",1,"K誸 th骳! /no")
	end 
end


function messenger_prize_yaopai()
	Describe(DescLink_YiGuan..": T輓 s� y猽 b礽 c飊g ngi t t韎 t輓 s� cho danh hi謚 tng i 鴑g. T� nh� ngi l� kim t輓 s�, 甧m c� th� i b蕋 k� t輓 s�, n誹 nh� ngi l� m閏 t輓 s�, th� kh玭g th� i kim t輓 s�. Hi觰 kh玭g ? b総 u i 甶 . .",7, 
        "T輓 s� l謓h - m閏 [50 甶觤 ]/prize_yaopai_mu", 
        "T輓 s� l謓h - ng [150 甶觤 ]/prize_yaopai_tong", 
        "T輓 s� l謓h - ng﹏ [450 甶觤 ]/prize_yaopai_yin", 
        "T輓 s� l謓h b礽 [800 甶觤 ]/prize_yaopai_jin", 
        "Ng� t� l謓h b礽 - kim [1500 甶觤 ]/prize_yaopai_yuci", 
        "Tr� v� /messenger_duihuanprize", 
        "T筸 th阨 kh玭g th� i !/no")
end

function prize_yaopai_mu()
	if ( nt_getTask(1205) >= 50 ) then
		AddItem(6,1,885,1,0,0)
		local Uworld1205 = nt_getTask(1205) - 50
		nt_setTask(1205,Uworld1205)
		Msg2Player("Ngi t 頲 t輓 s� - m閏.")
	else
		Describe(DescLink_YiGuan..": Th藅 xin l鏸 ! Ngi kh玭g  甶觤 t輈h l騳.",1,"K誸 th骳! /no")
	end 
end

function prize_yaopai_tong()
	if ( nt_getTask(1205) >= 150 ) then
		AddItem(6,1,886,2,0,0)
		local Uworld1205 = nt_getTask(1205) - 150
		nt_setTask(1205,Uworld1205)
		Msg2Player("Ngi t 頲 t輓 s� - ng.")
	else
		Describe(DescLink_YiGuan..": Th藅 xin l鏸 ! Ngi kh玭g  甶觤 t輈h l騳.",1,"K誸 th骳! /no")
	end 
end

function prize_yaopai_yin()
	if ( nt_getTask(1205) >= 450 ) then
		AddItem(6,1,887,3,0,0)
		local Uworld1205 = nt_getTask(1205) - 450
		nt_setTask(1205,Uworld1205)
		Msg2Player("Ngi t 頲 t輓 s� - ng﹏.")
	else
		Describe(DescLink_YiGuan..": Th藅 xin l鏸 ! Ngi kh玭g  甶觤 t輈h l騳.",1,"K誸 th骳! /no")
	end
end

function prize_yaopai_jin()
	if ( nt_getTask(1205) >= 800 ) then
		AddItem(6,1,888,4,0,0)
		local Uworld1205 = nt_getTask(1205) - 800
		nt_setTask(1205,Uworld1205)
		Msg2Player("Ngi t 頲 t輓 s� - kim.")
	else
		Describe(DescLink_YiGuan..": Th藅 xin l鏸 ! Ngi kh玭g  甶觤 t輈h l騳.",1,"K誸 th骳! /no")
	end 
end

function prize_yaopai_yuci()
	if ( nt_getTask(1205) >= 1500 ) then
		AddItem(6,1,889,5,0,0)
		local Uworld1205 = nt_getTask(1205) - 1500
		nt_setTask(1205,Uworld1205)
		Msg2Player("Ngi t 頲 1 t輓 s� l謓h b礽")
	else
		Describe(DescLink_YiGuan..": Th藅 xin l鏸 ! Ngi kh玭g  甶觤 t輈h l騳.",1,"K誸 th骳! /no")
	end 
end

function messenger_prize_huangjin()
	Describe(DescLink_YiGuan..": Tri襲 nh mu鑞 nh薾 thng ngi, cho n猲 cho ngi chu萵 b� m閠 b� trang b� ho祅g kim, khi ngi gi誸 ch l骳 甧m t 頲 g蕄 i kinh nghi謒. Ngi ngh� i c竔  ?",6, 
        "H錸g 秐h tr莔 vi猲 v穘 t髖 [100000 甶觤]/prize_huangjin_shenyuan", 
        "H錸g 秐h ki誱 qu秈 t﹜ phng [70000 甶觤]/prize_huangjin_guajian", 
        "H錸g 秐h m鬰 t骳 tng vong [70000 甶觤]/prize_huangjin_muxu", 
        "H錸g 秐h h錸g t� chi猽 [50000 甶觤]/prize_huangjin_hongxiu", 
        "Tr� v�/messenger_duihuanprize", 
        "T筸 th阨 kh玭g i /no")
end

function messenger_prize_other()
	Describe(DescLink_YiGuan..": Tri襲 nh c� r蕋 nhi襲 nh薾 thng, trc m総 ngi v藅 ph萴 c� th� i :",3, 
       "Th莕 b� i h錸g bao [2000 ph髏]/prize_other_hongbao", 
       "Tr� v�/messenger_duihuanprize", 
       "T筸 th阨 kh玭g i /no")
end

function prize_other_hongbao()
	if ( nt_getTask(1205) >= 2000 ) then
		local Uworld1205 = nt_getTask(1205) - 2000 
		nt_setTask(1205,Uworld1205)
		AddItem(6,1,402,0,0,0)
		Msg2Player("Ngi  i 1 th莕 b� i h錸g bao.")
	else
		Describe(DescLink_YiGuan..": Th藅 xin l鏸 ! 觤 t輈h l騳 kh玭g .",1,"K誸 th骳! /no")
	end 
end

function prize_huangjin_shenyuan()
	if ( nt_getTask(1205) >= 100000 ) then
		AddGoldItem(0,204)
		local Uworld1205 = nt_getTask(1205) - 100000
		nt_setTask(1205,Uworld1205)
		Msg2Player("Ngi t 琧 1 trang b� ho祅g kim h錸g 秐h.")
	else
		Describe(DescLink_YiGuan..": Th藅 xin l鏸 ! 觤 t輈h l騳 kh玭g .",1,"K誸 th骳! /no")
	end 
end

function prize_huangjin_guajian()
	if ( nt_getTask(1205) >= 70000 ) then
		AddGoldItem(0,205)
		local Uworld1205 = nt_getTask(1205) - 70000
		nt_setTask(1205,Uworld1205)
		Msg2Player("Ngi t 琧 1 trang b� ho祅g kim h錸g 秐h.")
	else
		Describe(DescLink_YiGuan..": Th藅 xin l鏸 ! 觤 t輈h l騳 kh玭g .",1,"K誸 th骳! /no")
	end 
end

function prize_huangjin_muxu()
	if ( nt_getTask(1205) >= 70000 ) then
		AddGoldItem(0,206)
		local Uworld1205 = nt_getTask(1205) - 70000
		nt_setTask(1205,Uworld1205)
		Msg2Player("Ngi t 琧 1 trang b� ho祅g kim h錸g 秐h.")
	else
		Describe(DescLink_YiGuan..": Th藅 xin l鏸 ! 觤 t輈h l騳 kh玭g .",1,"K誸 th骳! /no")
	end 
end

function prize_huangjin_hongxiu()
	if ( nt_getTask(1205) >= 50000 ) then
		AddGoldItem(0,207)
		local Uworld1205 = nt_getTask(1205) - 50000
		nt_setTask(1205,Uworld1205)
		Msg2Player("Ngi t 琧 1 trang b� ho祅g kim h錸g 秐h.")
	else
		Describe(DescLink_YiGuan..": Th藅 xin l鏸 ! 觤 t輈h l騳 kh玭g .",1,"K誸 th骳! /no")
	end 
end
-------------------------------------------取消信使任务----------------------------------------------------
function messenger_losemytask()
	if ( GetTask(1204) == 0 ) then
		Describe(DescLink_YiGuan..": Ngi kh玭g ti誴 nh薾 nhi謒 v� t輓 s� kh玭g th� h駓",1,"K誸 th骳 i tho筰/no")
	else
		Describe(DescLink_YiGuan..": Ngi mu鑞 h駓 nhi謒 v� ",2,"H駓 !/messenger_lostall","K誸 th骳 i tho筰!/no")
	end
end
--------------------------------------------解释什么是信使任务----------------------------------------------
function messenger_what()
	Describe(DescLink_YiGuan..": Nhi謒 v� t輓 s� l� tr� gi髉 tri襲 nh a tin cho c竎 th祅h ph� ch d辌h quan nhi謒 v�, b雐 v� g莕 nh蕋 t筰 tri襲 nh xu蕋 hi謓 ph秐 t芻, cho n猲, � a tin ch th阨 甶觤 g苝 ph秈 kh玭g 輙 nguy hi觤. Kh玭g c� tr� d騨g song to祅 ngi c飊g v韎 畂祅 k誸 h頿 t竎 tinh th莕 ngi 甧m r蕋 kh� ho祅 th祅h nhi謒 v�. Ch� c� t t韎 <color=red> 120 c蕄 tr� l猲 <color> m韎 c� th� tham gia. Trc m総 ngi g苝 n nh� sau c鯽 kh萿 ch tr� ng筰 : <color=red> thi猲 b秓 kho <color>. ? n琲 n祔 ch髏 quan b猲 trong , c� v� s� gi鑞g nhau ch nh﹏ v� k� qu竔 c� quan, ngi c莕 d飊g th玭g minh c飊g tr� kh玭 甶 ch輓h x竎 l鵤 ch鋘 . ta ch� c� th� ch骳 ngi th祅h c玭g, c� g緉g , chi課 h鱱 !!",4, 
       "Gi韎 thi謚 c蕄 b薱 b秐  /messenger_levelmap", 
       "Gi韎 thi謚 phong chi k� quan/messenger_flyhorse", 
       "Gi韎 thi謚 S琻 th莕 mi誹 quan t筽 /messenger_mountaindeity", 
       "Gi韎 thi謚 thi猲 b秓 kh�/messenger_storehouse", 
       "Gi韎 thi謚 t輓 s� y猽 b礽/messenger_orderlevel", 
       "Gi韎 thi謚 nhi謒 v� h筺 l骳/messenger_limittotask", 
       "K誸 th骳 i tho筰 /no")
end

function messenger_levelmap()
	Describe(DescLink_YiGuan..": D鵤 theo c蕄 b薱 ngi ch琲, ch髇g ta ph﹏ chia ba lo筰 b蕋 ng cng  ch b秐  cho ng礽. C蕄 b薱 khu ph﹏ l� <color=red>60-89 c蕄, 90-119 c蕄, 120<color> tr� l猲 ba lo筰. ",2,"Tr� v�/messenger_what","K誸 th骳 i tho筰 /no")
	--Describe(DescLink_YiGuan..": Trc m総 ch� c� <color=red> 120 c蕄 tr� l猲 <color> nhi謒 v� tr譶h  ",2," tr� v� /messenger_what"," k誸 th骳 i tho筰 /no")
end

function messenger_flyhorse()
	Describe(DescLink_YiGuan..": ? phong k� quan b猲 trong, ngi c� th� k� ti誴 n xu蕋 kh萿, nh� v藋 coi nh� l� ho祅 th祅h nhi謒 v�, nh璶g l�, ch� tng thng danh v鋘g tr� gi�. ? quan b猲 trong, ch髇g ta c� m閠 輙 n gi秐 nhi謒 v� : d鋍 theo 阯g 甶, ngi 甧m th蕐 r蕋 nhi襲 qu﹏ ta l璾 l筰 k� hi謚, ng th阨 c� r蕋 nhi襲 kim qu鑓 gi竛 甶謕. Ngi ch� c莕 ti誴 x骳 5 c� t鋋  li襫 c� th� n xu蕋 kh萿 t譵 b筩h d鵦 tng qu﹏ vt qua ki觤 tra. Nh璶g l� bi觰 hi謓 c馻 ngi u t筰 ta c鯽 ph竔 甶 ch 甶襲 tra vi猲 trong m総. цi v韎 ngi ch y猽 b礽 th╪g c蕄 r蕋 c� l頸 . .",2,"Tr� v� /messenger_what","K誸 th骳 i tho筰 /no")
end

function messenger_mountaindeity()
	Describe(DescLink_YiGuan..": ? mi誹 s琻 th莕 quan b猲 trong, ngi c� th� k� ti誴 tr鵦 ti誴 n i m玭, nh� v藋 coi xong th祅h nhi謒 v�, nh璶g l�, ch� tng thng danh v鋘g tr� gi�. ? quan b猲 trong, ch髇g ta c� m閠 輙 n gi秐 nhi謒 v� : � trong n骾 xu蕋 hi謓 th莕 產o doanh kinh s� ph秐  b鋘 h� � trong n骾 ng╪ tr� tin/th� khi課 cho. B鋘 h� u l躰h g鋓 l� 產o y猽 . ngi ch� c莕 nh b筰 2 c� 產o y猽 l� c� th� n l韓 c鯽 t譵 kia lang khuynh th祅h vt qua ki觤 tra. N誹 nh� ho祅 th祅h nhi謒 v�, i v韎 ngi th╪g c蕄 r蕋 c� tr� gi髉.",2,"Tr� v�/messenger_what","K誸 th骳 i tho筰 /no")
end

function messenger_storehouse()
	Describe(DescLink_YiGuan..": Ngi s鑞g ngi i trng nh薾 thi猲 b秓 kho x玭g quan nhi謒 v� l骳, h� th鑞g 甧m ng蓇 nhi猲 ph﹏ ph鑙, t 頲 5 c竔 s� m , c╪ c� <color-red> d鵤 theo s� m tr藅 t� <color> m� ra <color=red> b秓 rng <color> li襫 c� th� x玭g quan. D� nhi猲, c莕 m� ra b秓 rng, ngi mu鑞 nh b筰 <color=red> b秓 rng b猲 c筺h thi猲 b秓 kho ngi b秓 v� boss<color>. <color=red> Ng� h祅h ph� <color> � k� tr﹏ c竎 c� b竛, m� ra c� th� t 頲 r髏 lui kim ph�, r髏 lui m閏 ph�, r髏 lui nc ph�, r髏 lui l鯽 ph� , r髏 lui t ph�, s� d鬾g sau c� th� gi髉 ngi d� d祅g nh b筰 thi猲 b秓 kho ngi b秓 v� boss",2," Tr� v� /messenger_what","K誸 th骳 i tho筰 /no")
end

function messenger_orderlevel()
	Describe(DescLink_YiGuan..": C╪ c� ngi � y quan b猲 trong ch bi觰 hi謓, ch髇g ta 甧m phong cho ngi m閠 輙 quan h祄, ngi 甧m t 頲 r蕋 nhi襲 ph莕 thng. Trc m総 , y猽 b礽 chia l祄 t輓 s� l謓h - m閏, t輓 s� l謓h - ng, t輓 s� l謓h - ng﹏, t輓 s� l謓h - kim c飊g v韎 t輓 s� l謓h - kim. уng th阨, ngi theo nh� <color=red>F12<color>, nh譶 b秐g b猲 trong <color=red> t輈h l騳 <color> t輓 s� l謓h cho nhi謒 v� , bi誸 m譶h ch鴆 n╪g v� tr�. Ngi c� th� d飊g t輈h ph﹏ i th� t輓 khi課 cho danh hi謚. Sau , c� th� d飊g t輓 s� l謓h cho t輈h 甶觤 i l蕐 l謓h b礽. Nh鱪g th� n祔 y猽 b礽 甧m gia t╪g n╪g l鵦 <color=red> kh玦 ph鬰 <color> ngi, t竎 d鬾g c馻 n� v� <color=red>1 gi� <color>, s� d鬾g s� l莕 v� <color=red>5 l莕 <color>.",2,"Tr� v� /messenger_what","K誸 th骳 i tho筰 /no")
end

function messenger_limittotask()
	Describe(DescLink_YiGuan..": Nh薾 nhi謒 v� t輓 s�, ngi c� l骳 產ng l骳 <color=red>2 gi� <color>  ho祅 th祅h. M鏸 ng祔 l祄 nhi謒 v� th阨 gian l� <color=red>2 gi� <color>. Ch� �, khi � quan b猲 trong l骳, ngi b� gi誸 ho芻 l� tang c鯽 coi nh� l� <color=red> nhi謒 v� th蕋 b筰 <color>!",2,"Tr� v� /messenger_what","K誸 th骳 i tho筰 /no")
end

function messenger_giveplayerexp(playerexp)

	local j =random(1,3)

	if ( j == 1 ) then
		tl_addPlayerExp(playerexp-500000)
	elseif ( j == 2 ) then
		tl_addPlayerExp(playerexp)
	elseif ( j == 3 ) then
		tl_addPlayerExp(playerexp+500000)
	end
	Msg2Player("B雐 v� ngi l祄 nhi謒 v� t輓 s� bi觰 hi謓 ho祅 h秓, d辌h tr筸 cho ngi m閠 kinh nghi謒 nh薾 thng!")
	nt_setTask(1224,1)  --设置当天奖励开关为开  
	nt_setTask(1223,0)
end

function messenger_lostall()
	nt_setTask(1201,0)
	nt_setTask(1202,0)
	nt_setTask(1203,0)
	nt_setTask(1204,0)
	nt_setTask(1207,0)
	nt_setTask(1212,0)
	nt_setTask(1213,0)
	nt_setTask(1214,0)
	nt_setTask(1215,0)
	Msg2Player("B筺 b� m閠 nhi謒 v� t輓 s� th祅h c玭g")
	WriteLog(format("Account:%s[Name:%s] T� b� nhi謒 v�",
			GetAccount(),
			GetName()
			)
		);
end

function no()
end

function check_daily_task_count()
	local nNormalTaskLimit = 2--一天最兜只允许两次普通任务
	local nIBTaskLimit = 1--一天最兜只允许1次IB任务
	local nTodayCnt = %get_task_daily(1205)
	if nTodayCnt < nNormalTaskLimit then
		return 1--还有普通任务机会
	elseif  nTodayCnt < (nNormalTaskLimit + nIBTaskLimit) then
		local nCountIb = CalcItemCount(-1, 6, 1, 2813, -1)
		if nCountIb >= 1 then
			return 2--可以使用道具报名
		else
			return -1--可以使用道具但是身上没有
		end
	end
	return 0--没有任务机会了
end
