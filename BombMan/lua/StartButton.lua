--require "ImageClass"

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
	SetViewIamgePath(self.ImagePath);
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
	LuaDrawImage(self.StartX, self.StartY, 
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


--程序框大小设定，改变无用！
ButtonImagePath  = "Image/ButtonImage.png"
ButtonImageWidth = 706
ButtonImageHeight= 947
ButtonWidth      = 353
ButtonHeight     = 158


local ksButton = ImageClass:new();
ksButton:LoadImage(ButtonImagePath);
ksButton:setImageFileSize(ButtonImageWidth, ButtonImageHeight);
ksButton:setscaling_ratio(0.5);

local tzButton = ImageClass:new();
tzButton:LoadImage(ButtonImagePath);
tzButton:setImageFileSize(ButtonImageWidth, ButtonImageHeight);
tzButton:setscaling_ratio(0.5);

local djButton = ImageClass:new();
djButton:LoadImage(ButtonImagePath);
djButton:setImageFileSize(ButtonImageWidth, ButtonImageHeight);
djButton:setscaling_ratio(0.5);

local cdButton = ImageClass:new();
cdButton:LoadImage(ButtonImagePath);
cdButton:setImageFileSize(ButtonImageWidth, ButtonImageHeight);
cdButton:setscaling_ratio(0.5);

local bzButton = ImageClass:new();
bzButton:LoadImage(ButtonImagePath);
bzButton:setImageFileSize(ButtonImageWidth, ButtonImageHeight);
bzButton:setscaling_ratio(0.5);

local tcButton = ImageClass:new();
tcButton:LoadImage(ButtonImagePath);
tcButton:setImageFileSize(ButtonImageWidth, ButtonImageHeight);
tcButton:setscaling_ratio(0.5);

ksButton:setImage(80, 550-1*ButtonHeight*0.5, ButtonWidth, ButtonHeight, 0,           ButtonWidth,   0,              ButtonHeight,   0.3);
tzButton:setImage(80, 550-2*ButtonHeight*0.5, ButtonWidth, ButtonHeight, ButtonWidth, ButtonWidth*2, 0,              ButtonHeight,   0.3);
djButton:setImage(80, 550-3*ButtonHeight*0.5, ButtonWidth, ButtonHeight, 0,           ButtonWidth,   ButtonHeight*2, ButtonHeight*3, 0.3);
cdButton:setImage(80, 550-4*ButtonHeight*0.5, ButtonWidth, ButtonHeight, ButtonWidth, ButtonWidth*2, ButtonHeight*2, ButtonHeight*3, 0.3);
bzButton:setImage(80, 550-5*ButtonHeight*0.5, ButtonWidth, ButtonHeight, 0,           ButtonWidth,   ButtonHeight*4, ButtonHeight*5, 0.3);
tcButton:setImage(80, 550-6*ButtonHeight*0.5, ButtonWidth, ButtonHeight, ButtonWidth, ButtonWidth*2, ButtonHeight*4, ButtonHeight*5, 0.3);

function DrawButtonFunc()
	ksButton:DrawImage();
	tzButton:DrawImage();
	djButton:DrawImage();
	cdButton:DrawImage();
	bzButton:DrawImage();
	tcButton:DrawImage();
end

CharacterRate = 0.5

--按键值设定，改变无用！
KeyUpLua    = 0x11
KeyDownLua  = 0x1F
KeyRightLua = 0x1E
KeyLeftLua  = 0x20

function FirstButtonMove()

	if(KeyDetect(KeyUpLua) == 1)then
		ksButton:setRelativelyStartPos(0.0,CharacterRate);
	end
	--[[if(key == KeyUpLua) then
		ksButton:setRelativelyStartPos(0.0,CharacterRate);
	elseif (key == KeyDownLua) then
		ksButton:setRelativelyStartPos(0.0,-CharacterRate);
	elseif (key == KeyLeftLua) then
		ksButton:setRelativelyStartPos(-CharacterRate,0.0);
	elseif (key == KeyRightLua) then
		ksButton:setRelativelyStartPos(CharacterRate,0.0);
	end--]]
end


--[[WindowsWidth     =      1000.0
WindowsHeight    =      600.0

--按钮大小设定，不可改变
ButtonWidth      =      353.0
ButtonHeight     =      158.0
ButtonWidthF     =      ( ButtonWidth / WindowsWidth )
ButtonHeightF    =      ( ButtonHeight / WindowsHeight )
ButtonImageWidth =      706.0
ButtonImageHeight=      947.0
tuWidth          =      ( ButtonWidth / ButtonImageWidth )
tuHeight         =      ( ButtonHeight / ButtonImageHeight )
ButtonDefaultX   =      -0.95
ButtonDefaultY   =      0.5
--零时变量
FirstButtonLeftOrRightMove = 0.0;
FirstButtonUpOrDownMove = 0.0;


--按键值设定，改变无用！
KeyUpLua    = 0x11
KeyDownLua  = 0x1F
KeyRightLua = 0x1E
KeyLeftLua  = 0x20

CharacterRate = 0.005

function DrawButtonFunc()
	LuaDrawButton(ButtonDefaultX + FirstButtonLeftOrRightMove, FirstButtonUpOrDownMove + ButtonDefaultY - 0 * ButtonHeightF,   0.0,     0 * tuHeight);
	LuaDrawButton(ButtonDefaultX, ButtonDefaultY - 1.0 * ButtonHeightF, 0.0,     2 * tuHeight);
	LuaDrawButton(ButtonDefaultX, ButtonDefaultY - 2.0 * ButtonHeightF, 0.0,     4 * tuHeight);
	LuaDrawButton(ButtonDefaultX, ButtonDefaultY - 3.0 * ButtonHeightF, tuWidth, 0 * tuHeight);
	LuaDrawButton(ButtonDefaultX, ButtonDefaultY - 4.0 * ButtonHeightF, tuWidth, 2 * tuHeight);
	LuaDrawButton(ButtonDefaultX, ButtonDefaultY - 5.0 * ButtonHeightF, tuWidth, 4 * tuHeight);
end

function FirstButtonMove(key)

	if(key == KeyUpLua) then
		FirstButtonUpOrDownMove = FirstButtonUpOrDownMove + CharacterRate;
	elseif (key == KeyDownLua) then
		FirstButtonUpOrDownMove = FirstButtonUpOrDownMove - CharacterRate;
	elseif (key == KeyLeftLua) then
		FirstButtonLeftOrRightMove = FirstButtonLeftOrRightMove + CharacterRate;
	elseif (key == KeyRightLua) then
		FirstButtonLeftOrRightMove = FirstButtonLeftOrRightMove - CharacterRate;
	end
end

--DrawButtonFunc();
function SetButtonImagePath()
	LuaInitStartViewIamgePath("Image/ButtonImage.png","Image/BackGround.png");
end
--]]