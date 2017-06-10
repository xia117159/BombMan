BossClass = 
{
	AcStPosX = 500;
	AcStPosY = 400;
}

function BossClass:move(mx,my)
	self.AcStPosX = self.AcStPosX+mx;
	self.AcStPosY = self.AcStPosY+my;
end

function BossClass:getAbsolutePosX()
	return self.AcStPosX;
end

function BossClass:getAbsolutePosY()
	return self.AcStPosY;
end

function BossClass:setAbsolutePos(ax,ay)
	self.AcStPosX = ax;
	self.AcStPosY = ay;
end

function BossClass:new()
	op = {};
	setmetatable(op, {__index = self});
	return op;
end