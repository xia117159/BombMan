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
	if AssistantMoveDirection == 1 then		--1表示向右，2表示向上，3表示向左，4表示向下
	
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
	local AssistantRow1;	--助手所占第一个位置的地图X坐标
	local AssistantRow2;	--助手所占第二个位置的地图X坐标(AssistantRow1下面一行)
	local AssistantColumn1;	--助手所占第一个位置的地图Y坐标
	local AssistantColumn2;	--助手所占第二个位置的地图Y坐标(AssistantColumn1右面一列)
	-- 2代表所占水平方向两格且位置为mapTable[ActorRow1][ActorColumn1]，mapTable[ActorRow1][ActorColumn2]
	-- 3代表所占竖直方向两格且位置为mapTable[ActorRow1][ActorColumn1]，mapTable[ActorRow2][ActorColumn1]
	local AssistantHaveUnitStatus;	--助手所占格数状况 1代表所占一格 2代表所占水平方向两格 3代表所占竖直方向两格
	local AssistantMoveDirection;
	local ISPutBomb;
	local AvoidMark = 0; --退避标注位 0代表不退避(主动) 1代表火焰退避 2代表怪物退避 
	local MustMoveDirection; --助手需要移动方向
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
	
	if AvoidMark == 1 then	--执行放炸弹算法
		
	end
	
	SkillRelease();		--执行放技能算法
	
	return AssistantMoveDirection,ISPutBomb;
end

function AvoidBlaze(...)
	local MustMoveDirection; --助手需要移动方向
	if arg.n == 2 then	--传递两个参数，表示助手只占一格
		
		
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