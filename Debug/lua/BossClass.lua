BossClass = 
{
	AcStPosX = 500;
	AcStPosY = 1100;
}

function BossClass:Bossmove(mx,my)
	self.AcStPosX = self.AcStPosX+mx;
	self.AcStPosY = self.AcStPosY+my;
end

function BossClass:getBossAbsolutePosX()
	return self.AcStPosX;
end

function BossClass:getBossAbsolutePosY()
	return self.AcStPosY;
end

function BossClass:setBossAbsolutePos(ax,ay)
	self.AcStPosX = ax;
	self.AcStPosY = ay;
end

function BossClass:setBossRelativePos(sx,sy)
	self.AcStPosX = self.AcStPosX+sx;
	self.AcStPosY = self.AcStPosY+sy;
end

function BossClass:new()
	op = {};
	setmetatable(op, {__index = self});
	return op;
end