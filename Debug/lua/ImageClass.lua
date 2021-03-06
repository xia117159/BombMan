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
	Angle = 0.0,
	AxisX = 0,
	AxisY = 0,
	RotateStatus = false;
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
	Priority = 0,      --显示层级，最小0.2，越小越顶层
	scaling_ratio = 1.0  -- 缩放比例
	
}
function ImageClass:setRelativelyStartPos(sx, sy)
	self.StartX = self.StartX + sx;
	self.StartY = self.StartY + sy;
	
	self.EndX =  self.StartX + self.Width;
	self.pStartY = self.WindowsHeight - self.StartY - self.Height;
	self.EndY = self.WindowsHeight - self.StartY;
end


function ImageClass:setAbsoluteStartPos(sx, sy)
	self.StartX = sx;
	self.EndX =  sx + self.Width;
	self.StartY =  sy;
	self.pStartY = self.WindowsHeight - sy - self.Height;
	self.EndY = self.WindowsHeight - self.StartY;
end
function ImageClass:setImageShowSize(w, h)
	self.Width = w*self.scaling_ratio;
	self.Height = h*self.scaling_ratio;
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
--设置层级
function ImageClass:setPriority(p)
	self.Priority = p;
end
--设置缩放比
function ImageClass:setscaling_ratio(sr)
	self.scaling_ratio = sr;

end
function ImageClass:LoadImage(View,path, funcName, ShaderName)
	self.ImagePath = path;
	SetViewIamgePath(View,self.ImagePath, funcName, ShaderName);
end
--旋转数据：角度，参考位置，以图片左下角为原点
function ImageClass:SetRotateData(angle,x,y)
	self.Angle = angle;
	self.AxisX = x;
	self.AxisY = y;
	self.RotateStatus = true;
end
--设置旋转为中心点旋转
function ImageClass:SetCenterRotate()
	self.AxisX = self.Width/2;
	self.AxisY = self.Height/2;
	self.RotateStatus = true;
end
--恢复为最初始的位置
function ImageClass:RestoreRotate()
	self.Angle = 0.0;
	self.AxisX = 0.0;
	self.AxisY = 0.0;
end

--关闭旋转功能
function ImageClass:CloseRotate()
	self.RotateStatus = false;
end


function ImageClass:SetRelativelyRA(angle)
	if self.Angle >= 360 then
		self.Angle = self.Angle % 360;
	end
	self.Angle = self.Angle + angle;
end

--参数依次为：X轴位置、Y轴位置、图片宽、图片高、图片开始X轴、图片结束X轴、图片开始Y轴、图片结束Y轴、优先层级
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
	if  self.RotateStatus then
		LuaSetRotationData(self.Angle,self.AxisX,self.AxisY);
	end
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