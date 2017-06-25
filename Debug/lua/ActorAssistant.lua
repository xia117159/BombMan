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
	AcStPosX = 500;
	AcStPosY = 1000;
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
    AssistantMoveDirection = 0;	--�����ƶ�����	
	AssistantAlgorithms();
	
	if AssistantMoveDirection == 1 then		--1��ʾ���ң�2��ʾ���ϣ�3��ʾ����4��ʾ����
		if WindowMoveChecking(1) then	
			DrawActorGesture(0, 0, Actor2:TimerGo(), 1, Assistantimg);				
		else 	
			DrawActorGesture(UnitXOffset, 0, Actor2:TimerGo(), 1, Assistantimg);			
		end	
	--	Assistantimg:setRelativelyStartPos(UnitXOffset,0);
		assistantinf:setRelativePos(UnitXOffset,0);	
	elseif AssistantMoveDirection == 2 then
		if WindowMoveChecking(2) then	
			DrawActorGesture(0, 0, Actor2:TimerGo(), 2, Assistantimg);				
		else 	
			DrawActorGesture(0, UnitYOffset, Actor2:TimerGo(), 2, Assistantimg);			
		end	
		assistantinf:setRelativePos(0,UnitYOffset);	
	elseif	AssistantMoveDirection == 3 then
		if WindowMoveChecking(3) then	
			DrawActorGesture(0, 0, Actor2:TimerGo(), 3, Assistantimg);				
		else 	
			DrawActorGesture(-UnitXOffset, 0, Actor2:TimerGo(), 3, Assistantimg);			
		end	
		assistantinf:setRelativePos(-UnitXOffset,0);	
	elseif	AssistantMoveDirection == 4 then
		if WindowMoveChecking(4) then	
			DrawActorGesture(0, 0, Actor2:TimerGo(), 4, Assistantimg);				
		else 	
			DrawActorGesture(0, -UnitYOffset, Actor2:TimerGo(), 4, Assistantimg);			
		end	
		assistantinf:setRelativePos(0,-UnitYOffset);	
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
	end
	if AssistantMoveDirection ~= 0 then
		AssistantLastDirection = AssistantMoveDirection;
	end
	
	
	Assistantimg:setAbsoluteStartPos(assistantinf:getAbsolutePosX()+originX,assistantinf:getAbsolutePosY()+originY-BlockSize);	
	Assistantimg:DrawImage();
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
	
    AvoidMark = 0; --�˱ܱ�עλ 0�����˱�(����) 1��������˱� 2��������˱� 
	AssistantHaveUnitStatus,AssistantRow1,AssistantColumn1,AssistantRow2,AssistantColumn2 = GetObjectHaveBlock(assistantinf:getAbsolutePosX(),assistantinf:getAbsolutePosY());
    AvoidBlaze(8);
	
	
	-- if AvoidMark == 1 then	--ִ�з�ը���㷨
		
	-- end
	
	-- SkillRelease();		--ִ�зż����㷨
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
	while DistanceNum > LoopCondition do	--��ĳһ�ڵ㿪ʼ���ϻ�ȡĿ�Ľڵ�(������ռ�����ʱ���ȡ���е�ĳһ��ΪĿ�ĸ�����ռһ���ʱ���ȡ�����һ��ΪĿ�ĸ�)
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
	if RightBlockColumn <= TotalLines then	--����Ҳ���Ƿ񳬹��߽� �ø��ͼ����ΪmapTable[OriginBlockRow][RightBlockColumn]
		if mapTable[OriginBlockRow][RightBlockColumn][3] == 0 and (mapTable[OriginBlockRow][RightBlockColumn][4] == 0 or mapTable[OriginBlockRow][RightBlockColumn][4] > BoxRandRate) 
		and mapTable[OriginBlockRow][RightBlockColumn][7] == 0 and mapTable[OriginBlockRow][RightBlockColumn][10] == 0 and  mapTable[OriginBlockRow][RightBlockColumn][11] > SetDistance then
			CreateDistanceElement(OriginBlockIndex,OriginBlockRow,RightBlockColumn,SetDistance);
		end
	end
	if UpBlockRow <= TotalRows then	--����ϲ���Ƿ񳬹��߽� �ø��ͼ����ΪmapTable[UpBlockRow][OriginBlockColumn]
		if mapTable[UpBlockRow][OriginBlockColumn][3] == 0 and (mapTable[UpBlockRow][OriginBlockColumn][4] == 0 or mapTable[UpBlockRow][OriginBlockColumn][4] > BoxRandRate) 
		and mapTable[UpBlockRow][OriginBlockColumn][7] == 0 and mapTable[UpBlockRow][OriginBlockColumn][10] == 0 and  mapTable[UpBlockRow][OriginBlockColumn][11] > SetDistance then
			CreateDistanceElement(OriginBlockIndex,UpBlockRow,OriginBlockColumn,SetDistance);			
		end	
	end	
	if LeftBlockColumn > 0 then	--��������Ƿ񳬹��߽� �ø��ͼ����ΪmapTable[OriginBlockRow][LeftBlockColumn]
		if mapTable[OriginBlockRow][LeftBlockColumn][3] == 0 and (mapTable[OriginBlockRow][LeftBlockColumn][4] == 0 or mapTable[OriginBlockRow][LeftBlockColumn][4] > BoxRandRate) 
		and mapTable[OriginBlockRow][LeftBlockColumn][7] == 0 and mapTable[OriginBlockRow][LeftBlockColumn][10] == 0 and  mapTable[OriginBlockRow][LeftBlockColumn][11] > SetDistance then
			CreateDistanceElement(OriginBlockIndex,OriginBlockRow,LeftBlockColumn,SetDistance);			
		end	
	end	
	if DownBlockRow > 0 then	--����²���Ƿ񳬹��߽� �ø��ͼ����ΪmapTable[DownBlockRow][OriginBlockColumn]
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

function AvoidMonster()

end

function SkillRelease()

end

function AssistantClass:new()
	pk = {};
	setmetatable(pk, {__index = self});
	return pk;
end