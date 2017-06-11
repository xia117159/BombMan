--Õ¨µ¯
BombClass = {
	IsWrite = 0,
	IsBlast = 0,
	Bomb = {},
	BombAnimation = {}
}

function BombClass:new()
	o = {}
	setmetatable(o, {__index = self});
	return o;
end

function BombClass:Init(NowX,NowY)
	self.Bomb = AnimationRecord:new();
	self.Bomb:SetValue(NowX, NowY, 100, 6);
	
	self.BombAnimation = ImageClass:new();
	self.BombAnimation :setImageFileSize(200, 600);
end

--»ðÑæ
BlazeClass = {
	IsWrite = 0,
	IsEnd = 0,
	depth = 0,
	Blaze = {},
	leftBlazeAnimation = {},
	rightBlazeAnimation = {},
	centreBlazeAnimation = {},
	UpBlazeAnimation = {},
	DownBlazeAnimation = {}
}

function BlazeClass:new()
	o = {}
	setmetatable(o, {__index = self});
	return o;
end

function BlazeClass:Init(NowX,NowY)
	self.Blaze = AnimationRecord:new();
	self.Blaze:SetValue(NowX, NowY, 150, 4);
	
	self.leftBlazeAnimation = ImageClass:new();
	self.leftBlazeAnimation :setImageFileSize(352, 512);
	
	self.rightBlazeAnimation = ImageClass:new();
	self.rightBlazeAnimation :setImageFileSize(352, 512);
	
	self.centreBlazeAnimation = ImageClass:new();
	self.centreBlazeAnimation :setImageFileSize(352, 512);
	
	self.UpBlazeAnimation = ImageClass:new();
	self.UpBlazeAnimation :setImageFileSize(352, 512);
	
	self.DownBlazeAnimation = ImageClass:new();
	self.DownBlazeAnimation :setImageFileSize(352, 512);
end

AllBombClass=
{
	BombClass1 = {},
	BombClass2 = {},
	BombClass3 = {},
	BombClass4 = {},
	BombClass5 = {},
	BombClass6 = {}
}

function AllBombClass:new()
	o = {}
	setmetatable(o, {__index = self});
	return o;
end

AllBlazeClass=
{
	BlazeClass1 = {},
	BlazeClass2 = {},
	BlazeClass3 = {},
	BlazeClass4 = {},
	BlazeClass5 = {},
	BlazeClass6 = {}
}

function AllBlazeClass:new()
	o = {}
	setmetatable(o, {__index = self});
	return o;
end

--³õÊ¼»¯
function Init()
	UserBomb[1] = BombClass:new()
	UserBomb[2] = BombClass:new()
	UserBomb[3] = BombClass:new()
	UserBomb[4] = BombClass:new()
	UserBomb[5] = BombClass:new()
	UserBomb[6] = BombClass:new()
	
	BombBlaze[1] = BlazeClass:new()
	BombBlaze[1]["depth"] = 1.5
	BombBlaze[2] = BlazeClass:new()
	BombBlaze[2]["depth"] = 1.4
	BombBlaze[3] = BlazeClass:new()
	BombBlaze[3]["depth"] = 1.3
	BombBlaze[4] = BlazeClass:new()
	BombBlaze[4]["depth"] = 1.2
	BombBlaze[5] = BlazeClass:new()
	BombBlaze[5]["depth"] = 1.1
	BombBlaze[6] = BlazeClass:new()
	BombBlaze[6]["depth"] = 1.0
end

--ÅÐ¶ÏÌõ¼þµ÷ÓÃ»­Õ¨µ¯º¯Êý
function DrawBomb()
	local i = 1
	while(i <= UserData["HaveBombNumber"]) do
		if UserBomb[i]["IsWrite"] == 1 then
			DrawBombFunc(i);
		end
		i = i + 1
	end
end

--ÅÐ¶ÏÌõ¼þµ÷ÓÃ»­»ðÑæº¯Êý
function DrawBlaze()
	local i = 1
	while(i <= UserData["HaveBombNumber"]) do
		if BombBlaze[i]["IsWrite"] == 1 then
			DrawBlazeFunc(i);
		end
		i = i + 1
	end
end

--»­Õ¨µ¯
function DrawBombFunc(i)
	local startX = UserBomb[i]["Bomb"]["StartX"] + originX
	local startY = UserBomb[i]["Bomb"]["StartY"] + originY
	local b = 1
	local fr = UserBomb[i]["Bomb"]:TimerGo()
	if UserBomb[i]["IsBlast"] == 1 and fr == 1 then	
		while(b <= UserData["HaveBombNumber"]) do
			if BombBlaze[b]["IsWrite"] == 0 then
				BombBlaze[b]:Init(UserBomb[i]["Bomb"]["StartX"],UserBomb[i]["Bomb"]["StartY"])
				BombBlaze[b]["IsWrite"] = 1
				break
			end
			b = b + 1
		end
		UserBomb[i]["IsBlast"] = 0
		UserBomb[i]["IsWrite"] = 0
		return
	end
	if fr == 1 then
		UserBomb[i]["BombAnimation"]:setImage(startX  , startY  , 50 , 50 , 0 , 200, 0   , 200 ,  8);
	elseif fr == 2 then
		UserBomb[i]["BombAnimation"]:setImage(startX-1, startY-1, 52 , 52 , 0 , 200, 0   , 200 ,  8);
	elseif fr == 3 then
		UserBomb[i]["BombAnimation"]:setImage(startX  , startY  , 50 , 50 , 0 , 200, 200 , 400 ,  8);
	elseif fr == 4 then
		UserBomb[i]["BombAnimation"]:setImage(startX-1, startY-1, 52 , 52 , 0 , 200, 200 , 400 ,  8);
	elseif fr == 5 then
		UserBomb[i]["BombAnimation"]:setImage(startX  , startY  , 50 , 50 , 0 , 200, 400 , 600 ,  8);
	elseif fr == 6 then
		UserBomb[i]["BombAnimation"]:setImage(startX-1, startY-1, 52 , 52 , 0 , 200, 400 , 600 ,  8);
		UserBomb[i]["IsBlast"] = 1
	end
	UserBomb[i]["BombAnimation"]:DrawImage();
end

--»­»ðÑæ
function DrawBlazeFunc(i)
	local startX = BombBlaze[i]["Blaze"]["StartX"] + originX
	local startY = BombBlaze[i]["Blaze"]["StartY"] + originY
	local fr = BombBlaze[i]["Blaze"]:TimerGo()
	local power = UserData["Power"]
	if BombBlaze[i]["IsEnd"] == 1 and fr == 1 then
		BombBlaze[i]["IsWrite"] = 0
		BombBlaze[i]["IsEnd"] = 0
		return
	end
	if fr == 1 then
		BombBlaze[i]["leftBlazeAnimation"]:setImage(  startX - 50*power , startY            , 50*power , 50       , 0            , 32*power , 0            , 32             ,  BombBlaze[i]["depth"]);
		BombBlaze[i]["rightBlazeAnimation"]:setImage( startX +50        , startY            , 50*power , 50       , 352-32*power , 352      , 0            , 32             ,  BombBlaze[i]["depth"]);
		BombBlaze[i]["centreBlazeAnimation"]:setImage(startX            , startY            , 50       , 50       , 0            , 32       , 480          , 512            ,  BombBlaze[i]["depth"]);
		BombBlaze[i]["UpBlazeAnimation"]:setImage(    startX            , startY + 50       , 50       , 50*power , 0            , 32       , 128          , 128 + 32*power ,  BombBlaze[i]["depth"]);
		BombBlaze[i]["DownBlazeAnimation"]:setImage(  startX            , startY - 50*power , 50       , 50*power , 0            , 32       , 480-32*power , 480            ,  BombBlaze[i]["depth"]);
	elseif fr == 2 then
		BombBlaze[i]["leftBlazeAnimation"]:setImage(  startX - 50*power , startY            , 50*power , 50       , 0            , 32*power , 32           , 64             ,  BombBlaze[i]["depth"]);
		BombBlaze[i]["rightBlazeAnimation"]:setImage( startX + 50       , startY            , 50*power , 50       , 352-32*power , 352      , 32           , 64             ,  BombBlaze[i]["depth"]);
		BombBlaze[i]["centreBlazeAnimation"]:setImage(startX            , startY            , 50       , 50       , 32           , 64       , 480          , 512            ,  BombBlaze[i]["depth"]);
		BombBlaze[i]["UpBlazeAnimation"]:setImage(    startX            , startY + 50       , 50       , 50*power , 32           , 64       , 128          , 128 + 32*power ,  BombBlaze[i]["depth"]);
		BombBlaze[i]["DownBlazeAnimation"]:setImage(  startX            , startY - 50*power , 50       , 50*power , 32           , 64       , 480-32*power , 480            ,  BombBlaze[i]["depth"]);
	elseif fr == 3 then
		BombBlaze[i]["leftBlazeAnimation"]:setImage(  startX - 50*power , startY            , 50*power , 50       , 0            , 32*power , 64           , 96             ,  BombBlaze[i]["depth"]);
		BombBlaze[i]["rightBlazeAnimation"]:setImage( startX + 50       , startY            , 50*power , 50       , 352-32*power , 352      , 64           , 96             ,  BombBlaze[i]["depth"]);
		BombBlaze[i]["centreBlazeAnimation"]:setImage(startX            , startY            , 50       , 50       , 64           , 96       , 480          , 512            ,  BombBlaze[i]["depth"]);
		BombBlaze[i]["UpBlazeAnimation"]:setImage(    startX            , startY + 50       , 50       , 50*power , 64           , 96       , 128          , 128 + 32*power ,  BombBlaze[i]["depth"]);
		BombBlaze[i]["DownBlazeAnimation"]:setImage(  startX            , startY - 50*power , 50       , 50*power , 64           , 96       , 480-32*power , 480            ,  BombBlaze[i]["depth"]);
	elseif fr == 4 then
		BombBlaze[i]["leftBlazeAnimation"]:setImage(  startX - 50*power , startY            , 50*power , 50       , 0            , 32*power , 96           , 128            ,  BombBlaze[i]["depth"]);
		BombBlaze[i]["rightBlazeAnimation"]:setImage( startX + 50       , startY            , 50*power , 50       , 352-32*power , 352      , 96           , 128            ,  BombBlaze[i]["depth"]);
		BombBlaze[i]["centreBlazeAnimation"]:setImage(startX            , startY            , 50       , 50       , 96           , 128      , 480          , 512            ,  BombBlaze[i]["depth"]);
		BombBlaze[i]["UpBlazeAnimation"]:setImage(    startX            , startY + 50       , 50       , 50*power , 96           , 128      , 128          , 128 + 32*power ,  BombBlaze[i]["depth"]);
		BombBlaze[i]["DownBlazeAnimation"]:setImage(  startX            , startY - 50*power , 50       , 50*power , 96           , 128      , 480-32*power , 480            ,  BombBlaze[i]["depth"]);
		BombBlaze[i]["IsEnd"] = 1
	end
	BombBlaze[i]["leftBlazeAnimation"]:DrawImage();
	BombBlaze[i]["rightBlazeAnimation"]:DrawImage();
	BombBlaze[i]["centreBlazeAnimation"]:DrawImage();
	BombBlaze[i]["UpBlazeAnimation"]:DrawImage();
	BombBlaze[i]["DownBlazeAnimation"]:DrawImage();
end