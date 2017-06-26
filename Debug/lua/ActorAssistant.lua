ActorClass = 
{
	AcStPosX = 0;
	AcStPosY = 1200;
	actorWindowPosX = 0;
	actorWindowPosY = 600;
}

function ActorClass:moveTOALL(mx,my)
	self.AcStPosX = self.AcStPosX+mx;
	self.AcStPosY = self.AcStPosY+my;
	self.actorWindowPosX = self.actorWindowPosX+mx;	
	self.actorWindowPosY = self.actorWindowPosY+my;		
end

function ActorClass:getWindowPosX()
	return self.actorWindowPosX;
end

function ActorClass:getWindowPosY()
	return self.actorWindowPosY;
end

function ActorClass:getAbsolutePosX()
	return self.AcStPosX;
end

function ActorClass:getAbsolutePosY()
	return self.AcStPosY;
end

function ActorClass:setAbsolutePos(ax,ay)
	self.AcStPosX = ax;
	self.AcStPosY = ay;
end

function ActorClass:setAbsoluteWindowPos(wx,wy)
	self.actorWindowPosX = wx;
	self.actorWindowPosY = wy;
end

function ActorClass:setRelativeWindowPos(wx,wy)
	self.actorWindowPosX = self.actorWindowPosX+wx;
	self.actorWindowPosY = self.actorWindowPosY+wy;
end

function ActorClass:setRelativePos(rx,ry)
	self.AcStPosX = self.AcStPosX+rx;
	self.AcStPosY = self.AcStPosY+ry;
end

function ActorClass:new()
	lk = {};
	setmetatable(lk, {__index = self});
	return lk;
end


AssistantClass = 
{
	AcStPosX = 500,
	AcStPosY = 1000,
	assistantDeath = true
}

function AssistantClass:moveTOALL(mx,my)
	self.AcStPosX = self.AcStPosX+mx;
	self.AcStPosY = self.AcStPosY+my;
	self.actorWindowPosX = self.actorWindowPosX+mx;	
	self.actorWindowPosY = self.actorWindowPosY+my;		
end


function AssistantClass:getAbsolutePosX()
	return self.AcStPosX;
end

function AssistantClass:getAbsolutePosY()
	return self.AcStPosY;
end

function AssistantClass:setAbsolutePos(ax,ay)
	self.AcStPosX = ax;
	self.AcStPosY = ay;
end


function AssistantClass:setRelativePos(rx,ry)
	self.AcStPosX = self.AcStPosX+rx;
	self.AcStPosY = self.AcStPosY+ry;
end

function DrawAssistant()
    
    if AssistantSwitch then
        if ISGameNotPause then
            AssistantMoveDirection = 0;	--�����ƶ�����	
	        AssistantAlgorithms();  --�����㷨
	
	        if AssistantMoveDirection == 1 then		--1��ʾ���ң�2��ʾ���ϣ�3��ʾ����4��ʾ����
		        if WindowMoveChecking(1) then	
			        DrawActorGesture(0, 0, Actor2:TimerGo(), 1, Assistantimg);				
		        else 	
			        DrawActorGesture(AssistantUnitXOffset, 0, Actor2:TimerGo(), 1, Assistantimg);			
		        end	
	        --	Assistantimg:setRelativelyStartPos(UnitXOffset,0);
		        assistantinf:setRelativePos(AssistantUnitXOffset,0);	
	        elseif AssistantMoveDirection == 2 then
		        if WindowMoveChecking(2) then	
			        DrawActorGesture(0, 0, Actor2:TimerGo(), 2, Assistantimg);				
		        else 	
			        DrawActorGesture(0, AssistantUnitYOffset, Actor2:TimerGo(), 2, Assistantimg);			
		        end	
		        assistantinf:setRelativePos(0,AssistantUnitYOffset);	
	        elseif	AssistantMoveDirection == 3 then
		        if WindowMoveChecking(3) then	
			        DrawActorGesture(0, 0, Actor2:TimerGo(), 3, Assistantimg);				
		        else 	
			        DrawActorGesture(-AssistantUnitXOffset, 0, Actor2:TimerGo(), 3, Assistantimg);			
		        end	
		        assistantinf:setRelativePos(-AssistantUnitXOffset,0);	
	        elseif	AssistantMoveDirection == 4 then
		        if WindowMoveChecking(4) then	
			        DrawActorGesture(0, 0, Actor2:TimerGo(), 4, Assistantimg);				
		        else 	
			        DrawActorGesture(0, -AssistantUnitYOffset, Actor2:TimerGo(), 4, Assistantimg);			
		        end	
		        assistantinf:setRelativePos(0,-AssistantUnitYOffset);	
	        elseif	AssistantMoveDirection == 0 then
		        if AssistantLastDirection == 1 then
			        Assistantimg:setImagePos(ActorWidth*0, ActorWidth*1, ActorHeight*5, ActorHeight*6);
		        elseif 	AssistantLastDirection == 2 then
			        Assistantimg:setImagePos(ActorWidth*0, ActorWidth*1, ActorHeight*1, ActorHeight*2);
		        elseif	AssistantLastDirection == 3 then
			        Assistantimg:setImagePos(ActorWidth*0, ActorWidth*1, ActorHeight*2, ActorHeight*3);
		        elseif	AssistantLastDirection == 4 then	
			        Assistantimg:setImagePos(ActorWidth*0, ActorWidth*1, ActorHeight*0, ActorHeight*1);
		        end	
              --  DrawActorGesture(0, 0, Actor2:TimerGo(false), 6, Assistantimg);
	        end
	        if AssistantMoveDirection ~= 0 then
		        AssistantLastDirection = AssistantMoveDirection;
	        end		
	        Assistantimg:setAbsoluteStartPos(assistantinf:getAbsolutePosX()+originX,assistantinf:getAbsolutePosY()+originY-BlockSize);	
        end       
	    Assistantimg:DrawImage();
    end
   
end

function AssistantPutBomb()
    local BombX = 0
	local BombY = 0
	while(BombX <= TotalWidthPixels) do
		if(BombX <= assistantinf["AcStPosX"] + 25 and assistantinf["AcStPosX"] + 25 < BombX + 50) then
			break
		end
		BombX = BombX + 50
	end
	while(BombY <= TotalHeightPixels) do
		if(BombY <= assistantinf["AcStPosY"] - 25 and assistantinf["AcStPosY"] - 25 < BombY + 50) then
			break
		end
		BombY = BombY + 50
	end
	if(mapTable[BombY/BlockSize + 1][BombX/BlockSize + 1][7] ~= 1) then
		if(UserBomb[7]["IsWrite"] == 0) then
			UserBomb[7]:Init(BombX,BombY)
			UserBomb[7]["IsWrite"] = 1
			mapTable[BombY/BlockSize + 1][BombX/BlockSize + 1][7] = 1
            for j = 17,24 do
                if(BombBlaze[j]["IsWrite"] == 2) then
				    if(BombBlaze[j]["UpImpact"] > 0) then
                        for k = 1,BombBlaze[j]["UpImpact"] do
                            mapTable[(BombBlaze[j]["Blaze"]["StartY"] + k * 50) / 50 + 1][BombBlaze[j]["Blaze"]["StartX"] / 50 +1][9] = mapTable[(BombBlaze[j]["Blaze"]["StartY"] + k * 50) / 50 + 1][BombBlaze[j]["Blaze"]["StartX"] / 50 +1][9] - 1
                        end
                    end
                    if(BombBlaze[j]["LeftImpact"] > 0) then
                        for k = 1,BombBlaze[j]["LeftImpact"] do
                            mapTable[BombBlaze[j]["Blaze"]["StartY"] / 50 + 1][(BombBlaze[j]["Blaze"]["StartX"] - k * 50) / 50 +1][9] = mapTable[BombBlaze[j]["Blaze"]["StartY"] / 50 + 1][(BombBlaze[j]["Blaze"]["StartX"] - k * 50) / 50 +1][9] - 1
                        end
                    end
                    if(BombBlaze[j]["RightImpact"] > 0) then
                        for k = 1,BombBlaze[j]["RightImpact"] do
                            mapTable[BombBlaze[j]["Blaze"]["StartY"] / 50 + 1][(BombBlaze[j]["Blaze"]["StartX"] + k * 50) / 50 +1][9] = mapTable[BombBlaze[j]["Blaze"]["StartY"] / 50 + 1][(BombBlaze[j]["Blaze"]["StartX"] + k * 50) / 50 +1][9] - 1
                        end
                    end
                    if(BombBlaze[j]["DownImpact"] > 0) then
                        for k = 1,BombBlaze[j]["DownImpact"] do
                            mapTable[(BombBlaze[j]["Blaze"]["StartY"] - k * 50) / 50 + 1][BombBlaze[j]["Blaze"]["StartX"] / 50 +1][9] = mapTable[(BombBlaze[j]["Blaze"]["StartY"] - k * 50) / 50 + 1][BombBlaze[j]["Blaze"]["StartX"] / 50 +1][9] - 1
                        end
                    end
			    end
            end
		    for j = 17,24 do
		        if(BombBlaze[j]["IsWrite"] == 0) then
				    BombBlaze[j]:Init(BombX,BombY)
                    BombBlaze[j]["IsWrite"] = 2
                    break
			    end
		    end
            for j = 17,24 do
			    if(BombBlaze[j]["IsWrite"] == 2) then
                    TestBlazeImpact(j,0)
			    end
		    end
	    end
    end
end




function OneBoxChecking(CheckBlockRow,CheckBlockColumn)
    if CheckBlockRow <= TotalRows and CheckBlockRow > 0 and CheckBlockColumn <= TotalLines and CheckBlockColumn > 0 then
        if (0 == mapTable[CheckBlockRow][CheckBlockColumn][4] or mapTable[CheckBlockRow][CheckBlockColumn][4] > BoxRandRate) and mapTable[CheckBlockRow][CheckBlockColumn][10] == 0 and mapTable[CheckBlockRow][CheckBlockColumn][7] == 0 then
            assistantinf:setAbsolutePos((CheckBlockColumn-1)*BlockSize,CheckBlockRow*BlockSize);
            Assistantimg:setAbsoluteStartPos(assistantinf:getAbsolutePosX()+originX,assistantinf:getAbsolutePosY()+originY-BlockSize);
            return true;
        end
    end
    return false;
end

function OneRoundSearch(CenterRow,CenterColumn,CheckBlockRow,CheckBlockColumn,t)
            --���Ϸ��ĵ�
            CheckBlockRow  = CenterRow+1+t;
            CheckBlockColumn  = CenterColumn+1+t;
            if OneBoxChecking(CheckBlockRow,CheckBlockColumn) then  --�ҵ�����ŵ�
                return true;              
            end
            --���·��ĵ�
            CheckBlockRow  = CenterRow-1-t;
            CheckBlockColumn  = CenterColumn+1+t;                 
            if OneBoxChecking(CheckBlockRow,CheckBlockColumn) then  --�ҵ�����ŵ�
                return true;
            end
            --���Ϸ��ĵ�
            CheckBlockRow  = CenterRow+1+t;
            CheckBlockColumn  = CenterColumn-1-t;  
            if OneBoxChecking(CheckBlockRow,CheckBlockColumn) then  --�ҵ�����ŵ�
                return true;                     
            end
            --���·��ĵ�
            CheckBlockRow  = CenterRow-1-t;
            CheckBlockColumn  = CenterColumn-1-t;  
            if OneBoxChecking(CheckBlockRow,CheckBlockColumn) then  --�ҵ�����ŵ�
                return true;
            end

            return false;
end


-- CenterRow��ʾ��ɢ������ CenterColumn��ʾ��ɢ������ SetType��ʾ��ɢ���ͣ�1��ʾб������2Ϊ������ɢ 0��ʾб������1Ϊ������ɢ RoundNumber��ʾ��ɢ����
function  CheckingAvaliableAssistantPos(CenterRow,CenterColumn,SetType,RoundNumber)
    local i;
    local j;
    local CheckBlockRow;
    local CheckBlockColumn;
    if SetType == 0 then
        for j=1,RoundNumber do    
            if OneRoundSearch(CenterRow,CenterColumn,CheckBlockRow,CheckBlockColumn,j) then
                return;
            end
        end
       
    else 
        for j=1,RoundNumber do    
            if OneRoundSearch(CenterRow,CenterColumn,CheckBlockRow,CheckBlockColumn,j*2-1) then
                return;
            end
        end
    end
end

function InitAssistantPos(RoundNumber) --��ʼ������λ��RoundNumber������ɢ����
    if ActorHaveUnitStatus == 1 then
      if ActorHOneBoxNoIronCaculate(ActorRow1,ActorColumn1) == 3 then
         CheckingAvaliableAssistantPos(ActorRow1,ActorColumn1,1,RoundNumber);
      else
         CheckingAvaliableAssistantPos(ActorRow1,ActorColumn1,0,RoundNumber);
      end     
    elseif  ActorHaveUnitStatus == 2 then
        if ActorColumn1 % 2 == 0 then
            CheckingAvaliableAssistantPos(ActorRow1,ActorColumn1,0,RoundNumber);
        else
            CheckingAvaliableAssistantPos(ActorRow1,ActorColumn2,0,RoundNumber);
        end
    elseif  ActorHaveUnitStatus == 3 then
        if ActorRow1 % 2 == 0 then
            CheckingAvaliableAssistantPos(ActorRow1,ActorColumn1,0,RoundNumber);
        else
            CheckingAvaliableAssistantPos(ActorRow2,ActorColumn1,0,RoundNumber);
        end
    end
    AssistantSwitch = true;

end


function AssistantAlgorithms()
	--[[local AssistantRow1;	--������ռ��һ��λ�õĵ�ͼX����
	local AssistantRow2;	--������ռ�ڶ���λ�õĵ�ͼX����(AssistantRow1����һ��)
	local AssistantColumn1;	--������ռ��һ��λ�õĵ�ͼY����
	local AssistantColumn2;	--������ռ�ڶ���λ�õĵ�ͼY����(AssistantColumn1����һ��)
	-- 2������ռˮƽ����������λ��ΪmapTable[ActorRow1][ActorColumn1]��mapTable[ActorRow1][ActorColumn2]
	-- 3������ռ��ֱ����������λ��ΪmapTable[ActorRow1][ActorColumn1]��mapTable[ActorRow2][ActorColumn1]
	local AssistantHaveUnitStatus;	--������ռ����״�� 1������ռһ�� 2������ռˮƽ�������� 3������ռ��ֱ��������
	local AssistantMoveDirection;	--�����ƶ�����
	local ISPutBomb = false;	--�����Ƿ����ը��
	local AvoidMark = 0; --�˱ܱ�עλ 0�����˱�(����) 1��������˱� 2��������˱� 
	AssistantHaveUnitStatus,AssistantRow1,AssistantColumn1,AssistantRow2,AssistantColumn2 = GetObjectHaveBlock(assistantinf:getAbsolutePosX(),assistantinf:getAbsolutePosY());--]]
	
	-- AssistantRow1;	������ռ��һ��λ�õĵ�ͼX����
	-- AssistantRow2;	������ռ�ڶ���λ�õĵ�ͼX����(AssistantRow1����һ��)
	-- AssistantColumn1;	������ռ��һ��λ�õĵ�ͼY����
	-- AssistantColumn2;	������ռ�ڶ���λ�õĵ�ͼY����(AssistantColumn1����һ��)
	-- 2������ռˮƽ����������λ��ΪmapTable[ActorRow1][ActorColumn1]��mapTable[ActorRow1][ActorColumn2]
	-- 3������ռ��ֱ����������λ��ΪmapTable[ActorRow1][ActorColumn1]��mapTable[ActorRow2][ActorColumn1]
	-- AssistantHaveUnitStatus;	������ռ����״�� 1������ռһ�� 2������ռˮƽ�������� 3������ռ��ֱ��������
	local TempRandRate;
    local AssistantWillMoveDirection;
    AvoidMark = 0; --�˱ܱ�עλ 0�����˱�(����) 1��������˱� 2��������˱� 
	AssistantHaveUnitStatus,AssistantRow1,AssistantColumn1,AssistantRow2,AssistantColumn2 = GetObjectHaveBlock(assistantinf:getAbsolutePosX(),assistantinf:getAbsolutePosY());
    AvoidBlaze(8);
	
	if AvoidMark == 1 then	--��Ҫ���л����˱�
		if AssistantHaveUnitStatus == 1 then 
			if AssistantRow1 == DestinationBlockRow then --��Ŀ�ĸ����������ڸ�����ͬ
				if AssistantColumn1 < DestinationBlockColumn then	--������������С��Ŀ�ĸ�������
					AssistantMoveDirection = 1; --���������ƶ�
				else    AssistantMoveDirection = 3; --���������ƶ�
				end
			elseif AssistantColumn1 == DestinationBlockColumn then --��Ŀ�ĸ����������ڸ�����ͬ
				if 	AssistantRow1 < DestinationBlockRow then  --������������С��Ŀ�ĸ�������
					AssistantMoveDirection = 2;
				else	AssistantMoveDirection = 4;
				end
			end
		elseif 	AssistantHaveUnitStatus == 2 then --������ռλ��ˮƽ����
			if AssistantColumn1 == DestinationBlockColumn then --���������ڵĵ�һ�о�ΪĿ���У���˵�����ָ�����
				AssistantMoveDirection = 3; 
			else	AssistantMoveDirection = 1;
			end
		elseif	AssistantHaveUnitStatus == 3 then --������ռλ����ֱ����
			if AssistantRow1 == DestinationBlockRow then --���������ڵĵ�һ�о�ΪĿ���У���˵�����ָ�����
				AssistantMoveDirection = 2; 
			else	AssistantMoveDirection = 4;
			end
		end
	end
	
    if AvoidMark == 0 then  --����Ҫ���л����˱ܣ����ֽ�������״̬
        if AssistantHaveUnitStatus ~= 1 then --����λ������������ԭ�����ƶ�
           AssistantMoveDirection =  AssistantLastDirection;
        else    --����λ��һ������
            AssistantWillMoveDirection = math.random(1,2);	--1�������������ƶ��������ƶ���2���������ƶ��������ƶ�
            if ActorHOneBoxNoIronCaculate(AssistantRow1,AssistantColumn1) == 1 then  --����ֻ����ֱ�ƶ�            
                    if AssistantWillMoveDirection == 1 and AssistantRow1+1 <= TotalRows then
                         if   mapTable[AssistantRow1+1][AssistantColumn1][3] == 0 and (mapTable[AssistantRow1+1][AssistantColumn1][4] > BoxRandRate or mapTable[AssistantRow1+1][AssistantColumn1][4] == 0)
                         and mapTable[AssistantRow1+1][AssistantColumn1][7] == 0 and mapTable[AssistantRow1+1][AssistantColumn1][10] == 0 and mapTable[AssistantRow1+1][AssistantColumn1][9] == 0 then --����ϣ�������ƶ��������Ϸ��ƶ�
                             AssistantMoveDirection = 2;    
                         end
                    end
                    if AssistantWillMoveDirection == 2 and AssistantRow1-1 > 0 then
                         if  mapTable[AssistantRow1-1][AssistantColumn1][3] == 0 and (mapTable[AssistantRow1-1][AssistantColumn1][4] > BoxRandRate or mapTable[AssistantRow1-1][AssistantColumn1][4] == 0)
                         and mapTable[AssistantRow1-1][AssistantColumn1][7] == 0 and mapTable[AssistantRow1-1][AssistantColumn1][10] == 0 and mapTable[AssistantRow1-1][AssistantColumn1][9] == 0 then --����ϣ�������ƶ��������·��ƶ�
                              AssistantMoveDirection = 4;
                         end
                    end    
            elseif ActorHOneBoxNoIronCaculate(AssistantRow1,AssistantColumn1) == 2 then  --����ֻ��ˮƽ�ƶ�
                if AssistantWillMoveDirection == 1 and AssistantColumn1+1 <= TotalLines then
                         if   mapTable[AssistantRow1][AssistantColumn1+1][3] == 0 and (mapTable[AssistantRow1][AssistantColumn1+1][4] > BoxRandRate or mapTable[AssistantRow1][AssistantColumn1+1][4] == 0)
                         and mapTable[AssistantRow1][AssistantColumn1+1][7] == 0 and mapTable[AssistantRow1][AssistantColumn1+1][10] == 0 and mapTable[AssistantRow1][AssistantColumn1+1][9] == 0 then --����ϣ�������ƶ��������ҷ��ƶ�
                             AssistantMoveDirection = 1;    
                         end
                end
                if AssistantWillMoveDirection == 2 and AssistantColumn1-1 > 0 then
                         if  mapTable[AssistantRow1][AssistantColumn1-1][3] == 0 and (mapTable[AssistantRow1][AssistantColumn1-1][4] > BoxRandRate or mapTable[AssistantRow1][AssistantColumn1-1][4] == 0)
                         and mapTable[AssistantRow1][AssistantColumn1-1][7] == 0 and mapTable[AssistantRow1][AssistantColumn1-1][10] == 0 and mapTable[AssistantRow1][AssistantColumn1-1][9] == 0 then --����ϣ�������ƶ����������ƶ�
                              AssistantMoveDirection = 3;
                         end
                end 
            else 
                AssistantWillMoveDirection = math.random(1,4);
                if AssistantWillMoveDirection == 1 and AssistantColumn1+1 <= TotalLines then
                    if mapTable[AssistantRow1][AssistantColumn1+1][3] == 0 and (mapTable[AssistantRow1][AssistantColumn1+1][4] > BoxRandRate or mapTable[AssistantRow1][AssistantColumn1+1][4] == 0)
                       and mapTable[AssistantRow1][AssistantColumn1+1][7] == 0 and mapTable[AssistantRow1][AssistantColumn1+1][10] == 0 and mapTable[AssistantRow1][AssistantColumn1+1][9] == 0 then --����ϣ�������ƶ��������ҷ��ƶ�
                          AssistantMoveDirection = 1;    
                    end
                elseif  AssistantWillMoveDirection == 2 and AssistantRow1+1 <= TotalRows then
                    if mapTable[AssistantRow1+1][AssistantColumn1][3] == 0 and (mapTable[AssistantRow1+1][AssistantColumn1][4] > BoxRandRate or mapTable[AssistantRow1+1][AssistantColumn1][4] == 0)
                       and mapTable[AssistantRow1+1][AssistantColumn1][7] == 0 and mapTable[AssistantRow1+1][AssistantColumn1][10] == 0 and mapTable[AssistantRow1+1][AssistantColumn1][9] == 0 then --����ϣ�������ƶ��������Ϸ��ƶ�
                          AssistantMoveDirection = 2;    
                    end
                elseif  AssistantWillMoveDirection == 3 and AssistantColumn1-1 > 0 then
                   if mapTable[AssistantRow1][AssistantColumn1-1][3] == 0 and (mapTable[AssistantRow1][AssistantColumn1-1][4] > BoxRandRate or mapTable[AssistantRow1][AssistantColumn1-1][4] == 0)
                      and mapTable[AssistantRow1][AssistantColumn1-1][7] == 0 and mapTable[AssistantRow1][AssistantColumn1-1][10] == 0 and mapTable[AssistantRow1][AssistantColumn1-1][9] == 0 then --����ϣ�������ƶ����������ƶ�
                          AssistantMoveDirection = 3;
                   end
                elseif  AssistantWillMoveDirection == 4 and AssistantRow1-1 > 0 then
                    if  mapTable[AssistantRow1-1][AssistantColumn1][3] == 0 and (mapTable[AssistantRow1-1][AssistantColumn1][4] > BoxRandRate or mapTable[AssistantRow1-1][AssistantColumn1][4] == 0)
                    and mapTable[AssistantRow1-1][AssistantColumn1][7] == 0 and mapTable[AssistantRow1-1][AssistantColumn1][10] == 0 and mapTable[AssistantRow1-1][AssistantColumn1][9] == 0 then --����ϣ�������ƶ��������·��ƶ�
                          AssistantMoveDirection = 4;
                    end
                end
            end
        end
        
        TempRandRate = math.random(1,100);
        if TempRandRate <= AssistantPutBombRate then
            AssistantPutBomb();
        end
    end

	
end


function AvoidBlaze(DistanceMaxNum)	--���ֿɵ���������
	InitDistanceArraySet(DistanceMaxNum);
	DistanceArraySetTraversal(DistanceMaxNum);	
	ResetMapTableDistanceNum(DistanceMaxNum);
	DistanceArraySet = nil;
	DistanceLength = nil;
end

function ResetMapTableDistanceNum(DistanceMaxNum)	
	local i;
	local j;
	for i=1,DistanceMaxNum+1 do
		for j=1,DistanceLength[i] do
			mapTable[DistanceArraySet[i][j][2]][DistanceArraySet[i][j][3]][11] = 100;
		end
	end	
end


function DistanceArraySetTraversal(DistanceMaxNum)	--�������鼯�ı�������ȡ�����������·���� DistanceMaxNum��ʾ��������
	local i;
	local j;  
	local IsSafe = false; --��ʱ����DistanceArraySet����Ϊ0���������Ƿ���Ԫ�ؿ��Բ��������յ�
	for j=1,DistanceLength[1] do	--����Ϊ0����������������������Ϊ��Ҫ�ж�Ԫ���Ƿ������ֵ�ǰͶ����ը����
		if	mapTable[DistanceArraySet[1][j][2]][DistanceArraySet[1][j][3]][9] == 0 and mapTable[DistanceArraySet[1][j][2]][DistanceArraySet[1][j][3]][7] == 0 then
			DestinationBlockRow  = DistanceArraySet[1][j][2];		--DestinationBlockRow��ʾĿ�Ŀ��ڵ�ͼ����
			DestinationBlockColumn  = DistanceArraySet[1][j][3];	--DestinationBlockColumn��ʾĿ�Ŀ��ڵ�ͼ����
			if j == 2 and IsSafe or j == 1 and DistanceLength[1] == 1 then	--��������ռ������λ�ö����ᱻ�����յ���������ֻռһ��λ�ã� ��ʱ���ﲻ��
			--	MessageBox(1, 1, MB_OK);
				AvoidMark = 0;
				return
			else	
				AvoidMark = 1;
				IsSafe = true;	
			end		
		end
		if j == 2 and IsSafe then	--������Ϊ0�����飨�������������ӣ�����һ�����Ӱ�ȫ���򷵻أ���������ִ��
			return 
		end
	end
	for i=2,DistanceMaxNum+1 do	--��ʱ��������ƶ��Ų��Ὣ�������յ�
		for j=1,DistanceLength[i] do
			if	mapTable[DistanceArraySet[i][j][2]][DistanceArraySet[i][j][3]][9] == 0 then
				GetAvoidBlazeDestinationBlock(i-1,j);
				AvoidMark = 1;
				return  
			end
		end
	end
	AvoidMark = 0;
	return 
end

function GetAvoidBlazeDestinationBlock(DistanceNum,TempIndex) --DistanceNum��ʾ��ǰĿ�ĸ�ľ����� --TempIndex��ʾĿ�ĸ������
	local LoopCondition;
	if AssistantHaveUnitStatus == 1 then
		LoopCondition = 1;
	else	LoopCondition = 0;
	end
	while DistanceNum > LoopCondition do	--��ĳһ�ڵ㿪ʼ���ϻ�ȡĿ�Ľڵ�(������ռ�����ʱ���ȡ���е�ĳһ��ΪĿ�ĸ�����ռһ���ʱ���ȡ���ڵ�һ��ΪĿ�ĸ�)
		TempIndex = DistanceArraySet[DistanceNum+1][TempIndex][1]; --��������ڵ������	
		DistanceNum = DistanceNum-1;
	end
	DestinationBlockRow  = DistanceArraySet[DistanceNum+1][TempIndex][2];
	DestinationBlockColumn  = DistanceArraySet[DistanceNum+1][TempIndex][3];
end

function InitDistanceArraySet(DistanceMaxNum)	--DistanceMaxNum��ʾ��������
	local i;
	local j;
	--DistanceArraySet�������鼯����ά���飩��DistanceArraySet[i][j][k] ,i:��������ľ����� j:����������Ԫ�ص��±� k:Ԫ���еķ����±�
	--DistanceArraySet[i][j][1]�������־���Ϊi-1�ĵ�j������ĸ��ڵ��������Ϊi-2�����е��±꣨λ�ã�������Ϊ0��������Ԫ�صĸ��ڵ�Ϊ�Լ���
	--DistanceArraySet[i][j][2]�������־���Ϊi-1�ĵ�j�������ڵ�ͼ����λ�õ�������
	--DistanceArraySet[i][j][3]�������־���Ϊi-1�ĵ�j�������ڵ�ͼ����λ�õ�������
	DistanceArraySet = {};
	DistanceLength = {};
	for i=1,DistanceMaxNum+1 do
		DistanceArraySet[i] = {};
		DistanceLength[i] = 0;
	end
	DistanceArraySet[1][1] = {};
	DistanceArraySet[1][1][1] = 1;	--���ڵ�Ϊ�Լ�,�ڵ�һ��λ��
	DistanceArraySet[1][1][2] = AssistantRow1;
	DistanceArraySet[1][1][3] = AssistantColumn1;
	DistanceLength[1] = 1;
	mapTable[AssistantRow1][AssistantColumn1][11] = 0;
	if AssistantHaveUnitStatus > 1 then
		DistanceArraySet[1][2] = {};
		DistanceArraySet[1][2][1] = 2;	--���ڵ�Ϊ�Լ�,�ڵڶ���λ��
		DistanceLength[1] = DistanceLength[1]+1;
		if AssistantHaveUnitStatus == 2 then			
			DistanceArraySet[1][2][2] = AssistantRow1;
			DistanceArraySet[1][2][3] = AssistantColumn2;
			mapTable[AssistantRow1][AssistantColumn2][11] = 0;
		else
			DistanceArraySet[1][2][2] = AssistantRow2;
			DistanceArraySet[1][2][3] = AssistantColumn1;
			mapTable[AssistantRow2][AssistantColumn1][11] = 0;
		end
	end
	for i=1,DistanceMaxNum do	--�������ɾ�������
		for j=1,DistanceLength[i] do
			DistanceDiffusion(j,DistanceArraySet[i][j][2],DistanceArraySet[i][j][3],i);
		end
	end
	
end
--OriginBlockIndex��ʾ����ש�������ھ��������е����� OriginBlockRow��ʾ����ש����ڵ�ͼ�������� 
--OriginBlockColumn��ʾ����ש����ڵ�ͼ�������� SetDistance��ʾ��Ҫ���õ�ש����� ���������֣�
function DistanceDiffusion(OriginBlockIndex,OriginBlockRow,OriginBlockColumn,SetDistance)
	local RightBlockColumn = OriginBlockColumn+1;
	local UpBlockRow = OriginBlockRow+1;
	local LeftBlockColumn = OriginBlockColumn-1;
	local DownBlockRow = OriginBlockRow-1;
    local RandNumberDir = math.random(1,4);
	if RandNumberDir == 1 and RightBlockColumn <= TotalLines then	--����Ҳ���Ƿ񳬹��߽� �ø��ͼ����ΪmapTable[OriginBlockRow][RightBlockColumn]
		if mapTable[OriginBlockRow][RightBlockColumn][3] == 0 and (mapTable[OriginBlockRow][RightBlockColumn][4] == 0 or mapTable[OriginBlockRow][RightBlockColumn][4] > BoxRandRate) 
		and mapTable[OriginBlockRow][RightBlockColumn][7] == 0 and mapTable[OriginBlockRow][RightBlockColumn][10] == 0 and  mapTable[OriginBlockRow][RightBlockColumn][11] > SetDistance then
			CreateDistanceElement(OriginBlockIndex,OriginBlockRow,RightBlockColumn,SetDistance);
		end
	end
	if RandNumberDir == 2 and UpBlockRow <= TotalRows then	--����ϲ���Ƿ񳬹��߽� �ø��ͼ����ΪmapTable[UpBlockRow][OriginBlockColumn]
		if mapTable[UpBlockRow][OriginBlockColumn][3] == 0 and (mapTable[UpBlockRow][OriginBlockColumn][4] == 0 or mapTable[UpBlockRow][OriginBlockColumn][4] > BoxRandRate) 
		and mapTable[UpBlockRow][OriginBlockColumn][7] == 0 and mapTable[UpBlockRow][OriginBlockColumn][10] == 0 and  mapTable[UpBlockRow][OriginBlockColumn][11] > SetDistance then
			CreateDistanceElement(OriginBlockIndex,UpBlockRow,OriginBlockColumn,SetDistance);			
		end	
	end	
	if RandNumberDir == 3 and LeftBlockColumn > 0 then	--��������Ƿ񳬹��߽� �ø��ͼ����ΪmapTable[OriginBlockRow][LeftBlockColumn]
		if mapTable[OriginBlockRow][LeftBlockColumn][3] == 0 and (mapTable[OriginBlockRow][LeftBlockColumn][4] == 0 or mapTable[OriginBlockRow][LeftBlockColumn][4] > BoxRandRate) 
		and mapTable[OriginBlockRow][LeftBlockColumn][7] == 0 and mapTable[OriginBlockRow][LeftBlockColumn][10] == 0 and  mapTable[OriginBlockRow][LeftBlockColumn][11] > SetDistance then
			CreateDistanceElement(OriginBlockIndex,OriginBlockRow,LeftBlockColumn,SetDistance);			
		end	
	end	
	if RandNumberDir == 4 and DownBlockRow > 0 then	--����²���Ƿ񳬹��߽� �ø��ͼ����ΪmapTable[DownBlockRow][OriginBlockColumn]
		if mapTable[DownBlockRow][OriginBlockColumn][3] == 0 and (mapTable[DownBlockRow][OriginBlockColumn][4] == 0 or mapTable[DownBlockRow][OriginBlockColumn][4] > BoxRandRate) 
		and mapTable[DownBlockRow][OriginBlockColumn][7] == 0 and mapTable[DownBlockRow][OriginBlockColumn][10] == 0 and  mapTable[DownBlockRow][OriginBlockColumn][11] > SetDistance then
			CreateDistanceElement(OriginBlockIndex,DownBlockRow,OriginBlockColumn,SetDistance);			
		end	
	end	
	
end
--OriginBlockIndex��ʾ��Ҫ�����Ľڵ�ĸ��ڵ����������е��±� 
--CreateBlockRow��ʾ��Ҫ�����Ľڵ�ĵ�ͼ������
--CreateBlockColumn��ʾ��Ҫ�����Ľڵ�ĵ�ͼ������
--SetDistance��ʾ��Ҫ�����Ľڵ�ľ��루���֣�
function CreateDistanceElement(OriginBlockIndex,CreateBlockRow,CreateBlockColumn,SetDistance)	--��������Ԫ��
	mapTable[CreateBlockRow][CreateBlockColumn][11] = SetDistance;
	DistanceArraySet[SetDistance+1][DistanceLength[SetDistance+1]+1] = {};
	DistanceArraySet[SetDistance+1][DistanceLength[SetDistance+1]+1][1] = OriginBlockIndex;	--���游�ڵ�λ��
	--MessageBox(SetDistance,1 , MB_OK);
	DistanceArraySet[SetDistance+1][DistanceLength[SetDistance+1]+1][2] = CreateBlockRow;
	DistanceArraySet[SetDistance+1][DistanceLength[SetDistance+1]+1][3] = CreateBlockColumn;
	DistanceLength[SetDistance+1] = DistanceLength[SetDistance+1]+1;
end


function AssistantClass:new()
	pk = {};
	setmetatable(pk, {__index = self});
	return pk;
end