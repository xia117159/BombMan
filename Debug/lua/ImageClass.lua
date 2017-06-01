ImageClass = 
{
	Event = 0,
	Hover = 0,
	DrawStatus = 1,

	ImagePath = "",
	WindowsWidth  =   1000.0,
	WindowsHeight =   600.0,
	StartX = 0,
	StartY = 0,
	pStartY = 0,
	EndX = 0,
	EndY = 0,
	Width  = 0,
	Height = 0,
	ImageWidth  = 0,
	ImageHeight = 0,
	ImageStartX = 0,
	ImageStartY = 0, 
	ImageEndX = 0,
	ImageEndY = 0,   
	Priority = 0,      --��ʾ�㼶����С0.2��ԽСԽ����
	scaling_ratio = 1.0  -- ���ű���
	
}
function ImageClass:setRelativelyStartPos(sx, sy)
	self.StartX = self.StartX + sx;
	self.StartY = self.StartY + sy;
end


function ImageClass:setAbsoluteStartPos(sx, sy)
	self.StartX = sx;
	self.EndX =  sx + self.Width;
	self.StartY =  sy;
	self.pStartY = self.WindowsHeight - sy;
	self.EndY = self.WindowsHeight - self.StartY;
end
function ImageClass:setImageShowSize(w, h)
	self.Width = w;
	self.Height = h;
end
function ImageClass:setImageFileSize(iw, ih)
	self.ImageWidth = iw;
	self.ImageHeight = ih;
end
function ImageClass:setImagePos(isx, iex, isy, iey)
	self.ImageStartX = isx/self.ImageWidth;
	self.ImageStartY = isy/self.ImageHeight;
	self.ImageEndX = iex/self.ImageWidth;
	self.ImageEndY = iey/self.ImageHeight;
end
--���ò㼶
function ImageClass:setPriority(p)
	self.Priority = p;
end
--�������ű�
function ImageClass:setscaling_ratio(sr)
	self.scaling_ratio = sr;

end
function ImageClass:LoadImage(path, funcName, ShaderName)
	self.ImagePath = path;
	SetViewIamgePath(self.ImagePath, funcName, ShaderName);
end
--��������Ϊ��X��λ�á�Y��λ�á�ͼƬ��ͼƬ�ߡ�ͼƬ��ʼX�ᡢͼƬ����X�ᡢͼƬ��ʼY�ᡢͼƬ����Y�ᡢ���Ȳ㼶
function ImageClass:setImage(sx, sy, w, h, isx, iex, isy, iey, p)
	self.Width = w*self.scaling_ratio;
	self.Height = h*self.scaling_ratio;
	
	self.StartX = sx;
	self.EndX = sx + self.Width;
	self.StartY = sy;
	self.pStartY = self.WindowsHeight - self.StartY - self.Height;
	self.EndY =self.WindowsHeight - self.StartY;
	
	self.ImageStartX = isx/self.ImageWidth;
	self.ImageStartY = isy/self.ImageHeight;
	self.ImageEndX = iex/self.ImageWidth;
	self.ImageEndY = iey/self.ImageHeight;
	self.Priority = p;
end
function ImageClass:DrawImage()
	if self.DrawStatus == 1  then
		LuaDrawImage(self.StartX, self.StartY, 
		self.Width, self.Height, 
		self.ImageStartX, self.ImageEndX,
		self.ImageStartY, self.ImageEndY,
		self.Priority);
	end
end

function ImageClass:GetStartX()
	return self.StartX;
end

function ImageClass:GetStartY()
	return self.StartY;
end

function ImageClass:new()
	o = {}
	setmetatable(o, {__index = self});
	return o;
end

AnimationRecord = {
	StartX = 0,
	StartY = 0, 
	Timer = 0, 
	NowTimer = 0,
	FrameRate = 1,
	NowFrameRate = 1
}
function AnimationRecord:SetValue(sx, sy, t, fr)
	self.StartX = sx;
	self.StartY = sy;
	self.Timer = t;
	self.NowTimer = self.Timer;
	self.FrameRate = fr;
end

function AnimationRecord:TimerGo(fr)
	self.NowTimer = self.NowTimer - 1;
	if self.NowTimer  <= 0 then
		self.NowFrameRate = self.NowFrameRate + 1;
		if self.NowFrameRate > self.FrameRate then
			self.NowFrameRate = 1;
		end
		self.NowTimer = self.Timer;
	end
	return self.NowFrameRate;
end


function AnimationRecord:new()
	o = {}
	setmetatable(o, {__index = self});
	return o;
end