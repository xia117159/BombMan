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
	--[[local AssistantMoveDirection;
	local ISPutBomb = false;
	AssistantMoveDirection,ISPutBomb = AssistantAlgorithms();
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
	local AssistantRow1;	--������ռ��һ��λ�õĵ�ͼX����
	local AssistantRow2;	--������ռ�ڶ���λ�õĵ�ͼX����(AssistantRow1����һ��)
	local AssistantColumn1;	--������ռ��һ��λ�õĵ�ͼY����
	local AssistantColumn2;	--������ռ�ڶ���λ�õĵ�ͼY����(AssistantColumn1����һ��)
	-- 2������ռˮƽ����������λ��ΪmapTable[ActorRow1][ActorColumn1]��mapTable[ActorRow1][ActorColumn2]
	-- 3������ռ��ֱ����������λ��ΪmapTable[ActorRow1][ActorColumn1]��mapTable[ActorRow2][ActorColumn1]
	local AssistantHaveUnitStatus;	--������ռ����״�� 1������ռһ�� 2������ռˮƽ�������� 3������ռ��ֱ��������
	local AssistantMoveDirection;
	local ISPutBomb;
	local AvoidMark = 0; --�˱ܱ�עλ 0�����˱�(����) 1��������˱� 2��������˱� 
	local MustMoveDirection; --������Ҫ�ƶ�����
	local ISPutBomb = false;
	AssistantHaveUnitStatus,AssistantRow1,AssistantColumn1,AssistantRow2,AssistantColumn2 = GetObjectHaveBlock(assistantinf:getAbsolutePosX(),assistantinf:getAbsolutePosY());
	if AssistantHaveUnitStatus == 1 then		
		--MustMoveDirection,AvoidMark = AvoidBlaze(AssistantRow1,AssistantColumn1);
	elseif AssistantHaveUnitStatus == 2 then
		--[[if  then
		
		end--]]
	elseif AssistantHaveUnitStatus == 3 then
			
		--MustMoveDirection,AvoidMark = AvoidBlaze(AssistantRow1,AssistantColumn1,AssistantRow2,AssistantColumn2);
	end
	
	if AvoidMark == 1 then	--ִ�з�ը���㷨
		
	end
	
	SkillRelease();		--ִ�зż����㷨
	
	return AssistantMoveDirection,ISPutBomb;
end

function AvoidBlaze(...)
	local MustMoveDirection; --������Ҫ�ƶ�����
	if arg.n == 2 then	--����������������ʾ����ֻռһ��
		
		
	end
	return MustMoveDirection,AvoidMark;
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