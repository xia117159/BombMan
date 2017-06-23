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
  --[[  AssistantMoveDirection = 0;	--助手移动方向
	AssistantAlgorithms();
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
	--[[local AssistantRow1;	--助手所占第一个位置的地图X坐标
	local AssistantRow2;	--助手所占第二个位置的地图X坐标(AssistantRow1下面一行)
	local AssistantColumn1;	--助手所占第一个位置的地图Y坐标
	local AssistantColumn2;	--助手所占第二个位置的地图Y坐标(AssistantColumn1右面一列)
	-- 2代表所占水平方向两格且位置为mapTable[ActorRow1][ActorColumn1]，mapTable[ActorRow1][ActorColumn2]
	-- 3代表所占竖直方向两格且位置为mapTable[ActorRow1][ActorColumn1]，mapTable[ActorRow2][ActorColumn1]
	local AssistantHaveUnitStatus;	--助手所占格数状况 1代表所占一格 2代表所占水平方向两格 3代表所占竖直方向两格
	local AssistantMoveDirection;	--助手移动方向
	local ISPutBomb = false;	--助手是否放置炸弹
	local AvoidMark = 0; --退避标注位 0代表不退避(主动) 1代表火焰退避 2代表怪物退避 
	AssistantHaveUnitStatus,AssistantRow1,AssistantColumn1,AssistantRow2,AssistantColumn2 = GetObjectHaveBlock(assistantinf:getAbsolutePosX(),assistantinf:getAbsolutePosY());--]]
	
	-- AssistantRow1;	助手所占第一个位置的地图X坐标
	-- AssistantRow2;	助手所占第二个位置的地图X坐标(AssistantRow1下面一行)
	-- AssistantColumn1;	助手所占第一个位置的地图Y坐标
	-- AssistantColumn2;	助手所占第二个位置的地图Y坐标(AssistantColumn1右面一列)
	-- 2代表所占水平方向两格且位置为mapTable[ActorRow1][ActorColumn1]，mapTable[ActorRow1][ActorColumn2]
	-- 3代表所占竖直方向两格且位置为mapTable[ActorRow1][ActorColumn1]，mapTable[ActorRow2][ActorColumn1]
	-- AssistantHaveUnitStatus;	助手所占格数状况 1代表所占一格 2代表所占水平方向两格 3代表所占竖直方向两格
	
    AvoidMark = 0; --退避标注位 0代表不退避(主动) 1代表火焰退避 2代表怪物退避 
	AssistantHaveUnitStatus,AssistantRow1,AssistantColumn1,AssistantRow2,AssistantColumn2 = GetObjectHaveBlock(assistantinf:getAbsolutePosX(),assistantinf:getAbsolutePosY());
    AvoidBlaze();
	
	
	if AvoidMark == 1 then	--执行放炸弹算法
		
	end
	
	SkillRelease();		--执行放技能算法
	
end


function AvoidBlaze()
	AvoidMark = 0;
	InitDistanceArray();
	
	

end

function InitDistanceArray(DistanceNum)	--DistanceNum表示最大距离数
	local i;
	local j;
	--DistanceArraySet距离数组集（三维数组），DistanceArraySet[i][j][k] ,i:距离数组的距离数 j:距离数组中元素的下标 k:元素中的分量下标
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
--OriginBlockIndex表示基点砖块在所在距离数组中的索引 OriginBlockRow表示基点砖块的在地图的行坐标 
--OriginBlockColumn表示基点砖块的在地图的列坐标 SetDistance表示基点砖块的距离（距离助手）
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