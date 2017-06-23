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
	AcStPosY = 1200;
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
  --[[  AssistantMoveDirection = 0;	--�����ƶ�����
	AssistantAlgorithms();
	if AssistantMoveDirection == 1 then		--1��ʾ���ң�2��ʾ���ϣ�3��ʾ����4��ʾ����
	
	elseif AssistantMoveDirection == 2 then
		
	elseif	AssistantMoveDirection == 3 then
		
	elseif	AssistantMoveDirection == 4 then
		
	elseif	AssistantMoveDirection == 0 then
		
	else
	end--]]
	
	
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
    AvoidBlaze();
	
	
	if AvoidMark == 1 then	--ִ�з�ը���㷨
		
	end
	
	SkillRelease();		--ִ�зż����㷨
	
end


function AvoidBlaze()
	AvoidMark = 0;
	InitDistanceArray();
	
	

end

function InitDistanceArray(DistanceNum)	--DistanceNum��ʾ��������
	local i;
	local j;
	--DistanceArraySet�������鼯����ά���飩��DistanceArraySet[i][j][k] ,i:��������ľ����� j:����������Ԫ�ص��±� k:Ԫ���еķ����±�
	DistanceArraySet = {};
	DistanceLength = {};
	for i=1,DistanceNum do
		DistanceArraySet[i] = {};
		DistanceLength[i] = 0;
	end
	DistanceArraySet[1][1] = {};
	DistanceArraySet[1][1][1] = AssistantRow1;
	DistanceArraySet[1][1][2] = AssistantColumn1;
	DistanceLength[1] = 1;
	if AssistantHaveUnitStatus > 1 then
		DistanceArraySet[1][2] = {};
		DistanceLength[1] = DistanceLength[1]+1;
		if AssistantHaveUnitStatus == 2 then			
			DistanceArraySet[1][2][1] = AssistantRow1;
			DistanceArraySet[1][2][2] = ActorColumn2;			
		else
			DistanceArraySet[1][2][1] = AssistantRow2;
			DistanceArraySet[1][2][2] = ActorColumn1;
		end
	end
	for i=1,DistanceNum-1 do
		for j=1,DistanceLength[i] do
			
		end
	end
	
end
--OriginBlockIndex��ʾ����ש�������ھ��������е����� OriginBlockRow��ʾ����ש����ڵ�ͼ�������� 
--OriginBlockColumn��ʾ����ש����ڵ�ͼ�������� SetDistance��ʾ����ש��ľ��루�������֣�
function DistanceDiffusion(OriginBlockIndex,OriginBlockRow,OriginBlockColumn,SetDistance)
	
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