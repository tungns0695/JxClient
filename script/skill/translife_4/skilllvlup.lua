-- 文件名　：skilllvlup.lua
-- 创建者　：wangjingjun
-- 内容　　：四转相关技能的 8 个技能的升级
-- 创建时间：2011-07-30 17:50:05

Include("\\script\\task\\metempsychosis\\npc_saodiseng.lua")

tbZhuansheng_4_Skill = {}

function tbZhuansheng_4_Skill.skilllvelup(nSkillId)
	local mlvl = HaveMagic(nSkillId)
	local nMaxLevel = GetSkillMaxLevel(nSkillId)
	local szSkillName = GetSkillName(nSkillId)
	if mlvl > nMaxLevel then
		Msg2Player(format(" [%s] c馻 b筺  n t鑙 產, kh玭g th� ti誴 t鬰 th╪g c蕄 頲!", szSkillName))
		return 0
	end 
	
	updataSkillPoint_4()		-- 更新剩余可用的技能点
	
	local nLeaveSkillPoint = GetTask(TSK_LEAVE_SKILL_POINT_4)
	if nLeaveSkillPoint < 1 then
		Msg2Player("Ngi kh玭g c� 甶觤 k� n╪g tr飊g sinh 4, k� n╪g kh玭g th� n﹏g l猲.")
		return 0
	end
	
	nLeaveSkillPoint = nLeaveSkillPoint - 1
	SetTask(TSK_LEAVE_SKILL_POINT_4, nLeaveSkillPoint) -- 减少可使用的技能点量
	SetTask(TSK_USED_SKILL_POINT_4, (GetTask(TSK_USED_SKILL_POINT_4) + 1))	-- 增加已使用的技能点值
	AddMagic(nSkillId, mlvl + 1)
	Msg2Player(format("Tu luy謓 [%s]c馻 ngi  頲 th╪g c蕄, V蒼 c� th� s� d鬾g 甶觤 k� n╪g tr飊g sinh 4 l� %d.", szSkillName, nLeaveSkillPoint))
	return 1
end
