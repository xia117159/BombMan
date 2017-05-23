ImageClass = 
{
	ImagePath = "",
	WindowsWidth  =   1000.0,
	WindowsHeight =   600.0,
	StartX = 0,
	StartY = 0,
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
end
function ImageClass:setAbsoluteStartPos(sx, sy)
	self.StartX = sx;
	self.StartY = sy;
end
function ImageClass:setImageShowSize(w, h)
	self.Width = w;
	self.Height = h;
end
function ImageClass:setImageFileSize(iw, ih)
	self.ImageWidth = iw;
	self.ImageHeight = ih;
end
function ImageClass:setImagePos(ix, iy)
	self.ImageX = ix/iw;
	self.ImageY = iy/ih;
end
--设置层级
function ImageClass:setPriority(p)
	self.Priority = p;
end
--设置缩放比
function ImageClass:setscaling_ratio(sr)
	self.scaling_ratio = sr;
end
function ImageClass:LoadImage(path)
	self.ImagePath = path;
	LuaInitStartViewIamgePath(self.ImagePath);
end
--参数依次为：X轴位置、Y轴位置、图片宽、图片高、图片开始X轴、图片结束X轴、图片开始Y轴、图片结束Y轴、优先层级
function ImageClass:setImage(sx, sy, w, h, isx, iex, isy, iey, p)
	self.StartX = sx;
	self.StartY = sy;
	
	self.Width = w;
	self.Height = h;
	
	self.ImageStartX = isx/self.ImageWidth;
	self.ImageStartY = isy/self.ImageHeight;
	self.ImageEndX = iex/self.ImageWidth;
	self.ImageEndY = iey/self.ImageHeight;
	self.Priority = p;
end
function ImageClass:DrawImage()
	LuaDrawButton(self.StartX, self.StartY, 
	self.Width*self.scaling_ratio, self.Height*self.scaling_ratio, 
	self.ImageStartX, self.ImageEndX,
	self.ImageStartY, self.ImageEndY,
	self.Priority);
end
function ImageClass:new()
	o = {}
	setmetatable(o, {__index = self});
	return o;
end