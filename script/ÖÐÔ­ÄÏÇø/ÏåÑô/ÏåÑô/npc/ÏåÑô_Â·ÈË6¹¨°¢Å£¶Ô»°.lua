--中原南区 襄阳府 路人6龚阿牛对话


Include("\\script\\task\\newtask\\branch\\zhengpai\\branch_zhengpaitasknpc.lua")
Include("\\script\\task\\newtask\\newtask_head.lua")


function main(sel)

i = random(0,2)
	Uworld1051 = nt_getTask(1051)
	if ( Uworld1051 ~= 0 ) then
		branch_taokan()
	else
		if (i == 0) then
			Say("Ra kh醝 th祅h, 甶 v� hng B綾 kh玭g xa ch輓h l� V� ng s琻.",0)
		return
		end;
		
		if (i == 1) then
			Say("Nghe n鉯 Chng m玭 V� ng Ph竔 l� 1 ch﹏ nh﹏ c o. Kh玭g bi誸 c� ph秈 sau khi c o s� 頲 trng sinh b蕋 l穙?",0)
		return
		end;
		
		if (i == 2) then
			Say("N誹 kh玭g ph秈 v� ta c遪 m� gi�  80 tu鎖, ta  s韒 l猲 V� ng s琻 b竔 s� h鋍 v� t� l﹗!",0)
		end;
	end
end;

