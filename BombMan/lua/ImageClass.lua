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
	Priority = 0,      --��ʾ�㼶����С0.2��ԽСԽ����
	scaling_ratio = 1.0  -- ���ű���
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
--���ò㼶
function ImageClass:setPriority(p)
	self.Priority = p;
end
--�������ű�
function ImageClass:setscaling_ratio(sr)
	self.scaling_ratio = sr;
end
function ImageClass:LoadImage(path)
	self.ImagePath = path;
	LuaInitStartViewIamgePath(self.ImagePath);
end
--��������Ϊ��X��λ�á�Y��λ�á�ͼƬ��ͼƬ�ߡ�ͼƬ��ʼX�ᡢͼƬ����X�ᡢͼƬ��ʼY�ᡢͼƬ����Y�ᡢ���Ȳ㼶
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