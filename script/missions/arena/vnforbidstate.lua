tbForbidPKState = {
	{"B�t ��ng Minh V��ng ",	15},
	{"Nh� Lai Thi�n Di�p ",	273},
	{"T�nh T�m Quy�t",	33},
	{"Kim Chung Tr�o",	42},
	{"C�u Thi�n Cu�ng L�i ",	67},
	{"X�ch Di�m Th�c Thi�n",	70},
	{"B�ng Lam Huy�n Tinh",	64},
	{"Xuy�n Y Ph� Gi�p ",	356},
	{"V�n ��c Th�c T�m",	73},
	{"Xuy�n T�m ��c Th�ch",	72},
	{"�o�n C�n H� C�t ",	390},
	{"B�ng T�m Tr�i �nh",	269},
	{"H� Th� H�n B�ng ",	100},
	{"Tuy�t �nh",	109},	
	{"Ho�t B�t L�u Th� ",	277},
	{"T�y �i�p Cu�ng V� ",	130},
	{"H�a Li�n Ph�n Hoa",	136},
	{"�o �nh Phi H� ",	137},
	{"Thi�n Ma Gi�i Th� ",	150},
	{"T�a V�ng V� Ng� ",	157},
	{"Thanh Phong ph� ",	171},
	{"Ki B�n ph� ",	174},
	{"Nh�t Kh� Tam Thanh",	178},
	{"B�c Minh ��o H�i",	393},
	{"Thi�n Thanh ��a Tr�c",	173},
	{"Khi H�n Ng�o Tuy�t",	175},
	{"T�y Ti�n T� C�t",	394},
	{"l�nh b�i k� n�ng 1",	631},
	{"l�nh b�i k� n�ng 2",	632},
	{"l�nh b�i k� n�ng 3",	633},
	{"l�nh b�i k� n�ng 4",	634},
	{"l�nh b�i k� n�ng 5",	635},	
	{"K� n�ng Ti�n Phong",	958},
	{"K� n�ng Nguy�n So�i",959},		
	{"K� n�ng Th�a T��ng",	960},
	{"K� n�ng Ho�ng ��",	961},
	{"K� n�ng Thi�n T�",	962},
	{"Ho�n H�n ��n k� n�ng",	462},
	{"Ti�u Di�u T�n k� n�ng",	1052},
	{"K�ch C�ng Tr� L�c Ho�n",	1120},
	{"K�ch C�ng Tr� L�c Ho�n",261},		
	{"K�ch C�ng Tr� L�c Ho�n",	258},
	{"K�ch C�ng Tr� L�c Ho�n",	260},
	{"�m D��ng Ho�t Huy�t ��n",	1121},
	{"�m D��ng Ho�t Huy�t ��n",	256},
	{"�m D��ng Ho�t Huy�t ��n",	259},
	{"�m D��ng Ho�t Huy�t ��n",	257},	
	--Item
	{"C�ng T�c ho�n", 511},
	{"B�o T�c ho�n", 512},
	{"Ph� Ph�ng ho�n", 513},
	{"��c Ph�ng ho�n", 514},
	{"B�ng Ph�ng ho�n", 515},
	{"H�a Ph�ng ho�n", 516},
	{"L�i Ph�ng ho�n", 517},
	{"Gi�m Th��ng ho�n", 518},
	{"Gi�m H�n ho�n", 519},
	{"Gi�m ��c ho�n", 520},
	{"Gi�m B�ng ho�n", 521},
	{"Ph� C�ng ho�n", 522},
	{"��c C�ng ho�n", 523},
	{"B�ng C�ng ho�n", 524},
	{"H�a C�ng ho�n", 525},
	{"L�i C�ng ho�n", 526},
	{"Tr��ng M�nh ho�n", 527},
	{"Tr��ng N�i ho�n", 528},
	{"Y�n H�ng �an", 450},
	{"X� Lam �an", 451},
	{"N�i Ph� ho�n", 453},
	{"N�i ��c ho�n", 454},
	{"N�i B�ng ho�n", 455},
	{"N�i H�a ho�n", 456},
	{"N�i �i�n ho�n", 457},
	{"Tr��ng M�nh ho�n", 256},
	{"Gia B�o ho�n", 257},
	{"��i L�c ho�n", 258},
	{"Cao Thi�m ho�n", 259},
	{"Cao Trung ho�n", 260},
	{"Phi T�c ho�n", 261},
	{"B�ng Ph�ng ho�n", 262},
	{"L�i Ph�ng ho�n", 263},
	{"H�a Ph�ng ho�n", 264},
	{"��c Ph�ng ho�n", 265},
	{"B�nh ch�ng H�t d�", 401},
	{"B�nh ch�ng Th�t heo", 402},
	{"B�nh ch�ng Th�t b�", 403},
	{"B�ch Qu� L�", 442},
	{"T�n S� M�c y�u b�i", 542},
	{"T�n S� ��ng y�u b�i", 543},
	{"T�n S� Ng�n y�u b�i", 544},
	{"T�n S� Kim y�u b�i", 545},
	{"Ng� T� T�n S� y�u b�i", 546},
	{"Bao D��c ho�n", 635},
}

function VnRemoveForbidState()
	for i = 1 , getn(tbForbidPKState) do
		RemoveSkillState(tbForbidPKState[i][2])
	end
end