



--��ʼ������λ��




--�˺��������ɸ��ģ�������Ч
function MousePosSet(CurX, CurY)
	MousePosX = CurX;
	MousePosY = CurY;
	
end

--�˺��������ɸ��ģ�������Ч
function KeyFunc()

	if WinFocus == WM_SETFOCUS and DialogStatus == false and FrontGroundSS == false then
		ISGameNotPause = true;
	elseif WinFocus == WM_KILLFOCUS then
		ISGameNotPause = false;
	end
	if WinFocus == WM_SETFOCUS then
		if NowView == LoadV then
			LoadVKeyFunc();
		elseif NowView == StartV then
			StartViewKC();
		elseif NowView == ChallengeV then
			NoFunc();
		elseif 	NowView == ShopV then
			ShopViewKC();
		elseif 	NowView == PlotV then
			ActorKey();
		elseif 	NowView == BackpackV then
			bpViewKC();
		elseif 	NowView == HelpV then
			HelpKeyControlFunc();
		end
	end
	Gamebgm:Play(EndSwitch);
end

function NoFunc()
	
end

--���λ�ü��
function DetectMousePos(Pos)
	if Pos["StartX"] < MousePosX and  MousePosX < Pos["EndX"] and Pos["pStartY"] < MousePosY and  MousePosY < Pos["EndY"] then
		return 1
	else 
		return 0
	end
end