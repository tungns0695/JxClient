Include("\\script\\global\\autoexec_head.lua")
Include("\\script\\missions\\basemission\\lib.lua")
ELangGuWorld = {}

ELangGuWorld.szMapType = "羉 Lang C鑓" --改变地图表示

ELangGuWorld.tbMapList = {950, 951, 952, 953, 954, 955, 956,}

ELangGuWorld.tbNpcTypeList = --npc的类型
{
	["竎 Lang T� S�"] = 
	{
		nNpcId = 1693,
		szName = "竎 Lang T� S�",
		nLevel = 95,
		bNoRevive = 0, --重生
		nIsboss = 1, --对话npc可以不需要这个
		szPosPath = "\\settings\\maps\\elanggu\\elangshizhe.txt",
	},
	["D蒼 Gi� 竎 Lang C鑓"] = 
	{
		nNpcId = 108,
		szName = "D蒼 Gi� 竎 Lang C鑓",
		nLevel = 95,
		bNoRevive = 1,
		szPosPath = "\\settings\\maps\\elanggu\\yinshigaoren.txt",
		szScriptPath = "\\script\\missions\\elanggu\\yinshigaoren.lua",
	},
}

function ELangGuWorld:IsInMap(nMapId)
	for i = 1, getn(self.tbMapList) do
		if nMapId == self.tbMapList[i] then
			return 1
		end
	end
end

function ELangGuWorld:GetNearestNpc(nX, nY)
	local tbNpc, nCount = GetAroundNpcList(15, 8)
	local nDis, nSignIndex = -1, -1

	for i = 1, nCount do 
		local nX32, nY32, nMapIndex = GetNpcPos(tbNpc[i])
		local nTmpDis = (nX-nX32/32)^2+(nY-nY32/32)^2
		if nDis < 0 or nDis > nTmpDis then
			nDis = nTmpDis
			nSignIndex = tbNpc[i]
		end
	end
	return nSignIndex
end

function ELangGuWorld:UseItemKillNpc()
	
	local nMapId, nX, nY = GetWorldPos()
	if not self:IsInMap(nMapId) then
		Talk(1, "", "Чo c� n祔 ch� c� th� s� d鬾g t筰 竎 Lang C鑓!")
		return 
	end	
	
	local nSignIndex = self:GetNearestNpc(nX, nY)
	if nSignIndex <= 0 then
		Msg2Player("C� ly c竎h qu� xa 竎 Lang T� S�, xin h穣 n g莕 r錳 h穣 s� d鬾g!")
		return
	end
	local nX32, nY32, nMapIndex = GetNpcPos(nSignIndex)
	CastSkill(362, 20, nX32, nY32)
	KillNpcWithIdx(nSignIndex, PIdx2NpcIdx(PlayerIndex))
	return 1
end

function ELangGuWorld:AddAllNpc()
	for i = 1, getn(self.tbMapList) do
		for key, value in self.tbNpcTypeList do
			self:AddANpc(key, self.tbMapList[i], value.szPosPath)
		end	
	end
end


function ELangGuWorld:AddANpc(szName, nMapId, szPosPath)
	local tbNpc = self.tbNpcTypeList[szName]
	
	if (TabFile_Load(szPosPath, szPosPath) == 0) then
		print("Load TabFile Error!"..szPosPath)
		return 0
	end
	if not tbNpc then
		return 
	end
	local nRowCount = TabFile_GetRowCount(szPosPath)
	for nRow=2, nRowCount do
		local nX = TabFile_GetCell(szPosPath, nRow, 1)
		local nY = TabFile_GetCell(szPosPath, nRow, 2)		
		basemission_CallNpc(tbNpc, nMapId, nX, nY)	
	end
end

AutoFunctions:Add(ELangGuWorld.AddAllNpc, ELangGuWorld)



