ActorClass = 
{
		--	actorBlock ={AcStPosX,AcStPosY,BombNumAva,FireLevel};
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

--[[function ActorClass:moveTOSOME(mx,my)
	self.AcStPosX = self.AcStPosX+mx;
	self.AcStPosY = self.AcStPosY+my;		
end--]]


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