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
	self.Bomb:SetValue(NowX, NowY, 50, 6);
	
	self.BombAnimation = ImageClass:new();
	self.BombAnimation :setImageFileSize(200, 600);
end

--»ðÑæ
BlazeClass = {
	IsWrite = 0,
	IsEnd = 0,
	Depth = 0,
	Blaze = {},
	UpImpact = 1,
	LeftImpact = 1,
	RightImpact = 1,
	DownImpact = 1,
	LeftBlazeAnimation = {},
	RightBlazeAnimation = {},
	CentreBlazeAnimation = {},
	UpBlazeAnimation = {},
	DownBlazeAnimation = {}
}

function BlazeClass:new()
	o = {}
	setmetatable(o, {__index = self});
	return o;
end

function BlazeClass:Init(NowX,NowY)
	self.UpImpact = 1
	self.LeftImpact = 1
	self.RightImpact = 1
	self.DownImpact = 1
	
	self.Blaze = AnimationRecord:new();
	self.Blaze:SetValue(NowX, NowY, 20, 4);
	
	self.LeftBlazeAnimation = ImageClass:new();
	self.LeftBlazeAnimation :setImageFileSize(352, 512);
	
	self.RightBlazeAnimation = ImageClass:new();
	self.RightBlazeAnimation :setImageFileSize(352, 512);
	
	self.CentreBlazeAnimation = ImageClass:new();
	self.CentreBlazeAnimation :setImageFileSize(352, 512);
	
	self.UpBlazeAnimation = ImageClass:new();
	self.UpBlazeAnimation :setImageFileSize(352, 512);
	
	self.DownBlazeAnimation = ImageClass:new();
	self.DownBlazeAnimation :setImageFileSize(352, 512);
end

--Ç½
WallClass = {
	IsWrite = 0,
	IsEnd = 0,
	Wall = {},
	WallAnimation = {}
}

function WallClass:new()
	o = {}
	setmetatable(o, {__index = self});
	return o;
end

function WallClass:Init(NowX,NowY)
	self.Wall = AnimationRecord:new();
	self.Wall:SetValue(NowX, NowY, 20, 3);
	
	self.WallAnimation = ImageClass:new();
	self.WallAnimation :setImageFileSize(150, 50);
end

AllBombClass={n = 6}

function AllBombClass:new()
	o = {}
	setmetatable(o, {__index = self});
	return o;
end

AllBlazeClass={n = 6}

function AllBlazeClass:new()
	o = {}
	setmetatable(o, {__index = self});
	return o;
end

AllWallClass={n = 24}

function AllWallClass:new()
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
	BombBlaze[1]["Depth"] = 1.5
	BombBlaze[2] = BlazeClass:new()
	BombBlaze[2]["Depth"] = 1.4
	BombBlaze[3] = BlazeClass:new()
	BombBlaze[3]["Depth"] = 1.3
	BombBlaze[4] = BlazeClass:new()
	BombBlaze[4]["Depth"] = 1.2
	BombBlaze[5] = BlazeClass:new()
	BombBlaze[5]["Depth"] = 1.1
	BombBlaze[6] = BlazeClass:new()
	BombBlaze[6]["Depth"] = 1.0
	
	for i = 1, 24 do
		DynamiteWall[i] = WallClass:new()
	end
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

--ÅÐ¶ÏÌõ¼þµ÷ÓÃ»­Ç½±»Õ¨»Ù¶¯»­º¯Êý
function DrawDynamite()
	for i = 1,24 do
		if(DynamiteWall[i]["IsWrite"] == 1) then
			DrawDynamiteFunc(i)
		end
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
				TestBlazeImpact(b)
				BombBlaze[b]["IsWrite"] = 1
				mapTable[UserBomb[i]["Bomb"]["StartY"]/BlockSize + 1][UserBomb[i]["Bomb"]["StartX"]/BlockSize + 1][7] = 0
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
	local UpLength = BombBlaze[i]["UpImpact"]
	local LeftLength  = BombBlaze[i]["LeftImpact"]
	local RightLength  = BombBlaze[i]["RightImpact"]
	local DownLength  = BombBlaze[i]["DownImpact"]
	if BombBlaze[i]["IsEnd"] == 1 and fr == 1 then
		BombBlaze[i]["IsWrite"] = 0
		BombBlaze[i]["IsEnd"] = 0
		return
	end
	if fr == 1 then
		BombBlaze[i]["LeftBlazeAnimation"]:setImage(  startX - 50*LeftLength , startY            , 50*LeftLength , 50       , 0 + 32*(power - LeftLength)          , 32*power , 0            , 32             ,  BombBlaze[i]["Depth"]);
		BombBlaze[i]["RightBlazeAnimation"]:setImage( startX +50        , startY            , 50*RightLength , 50       , 352-32*power , 352-32*(power - RightLength)      , 0            , 32             ,  BombBlaze[i]["Depth"]);
		BombBlaze[i]["CentreBlazeAnimation"]:setImage(startX            , startY            , 50       , 50       , 0            , 32       , 480          , 512            ,  BombBlaze[i]["Depth"]);
		BombBlaze[i]["UpBlazeAnimation"]:setImage(    startX            , startY + 50       , 50       , 50*UpLength , 0            , 32       , 128 + 32*(power - UpLength)          , 128 + 32*power ,  BombBlaze[i]["Depth"]);
		BombBlaze[i]["DownBlazeAnimation"]:setImage(  startX            , startY - 50*DownLength , 50       , 50*DownLength , 0            , 32       , 480-32*power , 480-32*(power - DownLength)            ,  BombBlaze[i]["Depth"]);
	elseif fr == 2 then
		BombBlaze[i]["LeftBlazeAnimation"]:setImage(  startX - 50*LeftLength , startY            , 50*LeftLength , 50       , 0 + 32*(power - LeftLength)            , 32*power , 32           , 64             ,  BombBlaze[i]["Depth"]);
		BombBlaze[i]["RightBlazeAnimation"]:setImage( startX + 50       , startY            , 50*RightLength , 50       , 352-32*power , 352-32*(power - RightLength)      , 32           , 64             ,  BombBlaze[i]["Depth"]);
		BombBlaze[i]["CentreBlazeAnimation"]:setImage(startX            , startY            , 50       , 50       , 32           , 64       , 480          , 512            ,  BombBlaze[i]["Depth"]);
		BombBlaze[i]["UpBlazeAnimation"]:setImage(    startX            , startY + 50       , 50       , 50*UpLength , 32           , 64       , 128 + 32*(power - UpLength)          , 128 + 32*power ,  BombBlaze[i]["Depth"]);
		BombBlaze[i]["DownBlazeAnimation"]:setImage(  startX            , startY - 50*DownLength , 50       , 50*DownLength , 32           , 64       , 480-32*power , 480-32*(power - DownLength)            ,  BombBlaze[i]["Depth"]);
	elseif fr == 3 then
		BombBlaze[i]["LeftBlazeAnimation"]:setImage(  startX - 50*LeftLength , startY            , 50*LeftLength , 50       , 0 + 32*(power - LeftLength)            , 32*power , 64           , 96             ,  BombBlaze[i]["Depth"]);
		BombBlaze[i]["RightBlazeAnimation"]:setImage( startX + 50       , startY            , 50*RightLength , 50       , 352-32*power , 352-32*(power - RightLength)      , 64           , 96             ,  BombBlaze[i]["Depth"]);
		BombBlaze[i]["CentreBlazeAnimation"]:setImage(startX            , startY            , 50       , 50       , 64           , 96       , 480          , 512            ,  BombBlaze[i]["Depth"]);
		BombBlaze[i]["UpBlazeAnimation"]:setImage(    startX            , startY + 50       , 50       , 50*UpLength , 64           , 96       , 128 + 32*(power - UpLength)          , 128 + 32*power ,  BombBlaze[i]["Depth"]);
		BombBlaze[i]["DownBlazeAnimation"]:setImage(  startX            , startY - 50*DownLength , 50       , 50*DownLength , 64           , 96       , 480-32*power , 480-32*(power - DownLength)            ,  BombBlaze[i]["Depth"]);
	elseif fr == 4 then
		BombBlaze[i]["LeftBlazeAnimation"]:setImage(  startX - 50*LeftLength , startY            , 50*LeftLength , 50       , 0 + 32*(power - LeftLength)            , 32*power , 96           , 128            ,  BombBlaze[i]["Depth"]);
		BombBlaze[i]["RightBlazeAnimation"]:setImage( startX + 50       , startY            , 50*RightLength , 50       , 352-32*power , 352-32*(power - RightLength)      , 96           , 128            ,  BombBlaze[i]["Depth"]);
		BombBlaze[i]["CentreBlazeAnimation"]:setImage(startX            , startY            , 50       , 50       , 96           , 128      , 480          , 512            ,  BombBlaze[i]["Depth"]);
		BombBlaze[i]["UpBlazeAnimation"]:setImage(    startX            , startY + 50       , 50       , 50*UpLength , 96           , 128      , 128 + 32*(power - UpLength)          , 128 + 32*power ,  BombBlaze[i]["Depth"]);
		BombBlaze[i]["DownBlazeAnimation"]:setImage(  startX            , startY - 50*DownLength , 50       , 50*DownLength , 96           , 128      , 480-32*power , 480-32*(power - DownLength)            ,  BombBlaze[i]["Depth"]);
		BombBlaze[i]["IsEnd"] = 1
	end
	BombBlaze[i]["LeftBlazeAnimation"]:DrawImage();
	BombBlaze[i]["RightBlazeAnimation"]:DrawImage();
	BombBlaze[i]["CentreBlazeAnimation"]:DrawImage();
	BombBlaze[i]["UpBlazeAnimation"]:DrawImage();
	BombBlaze[i]["DownBlazeAnimation"]:DrawImage();
end

--»­Ç½Ìå±»Õ¨»Ù¶¯»­
function DrawDynamiteFunc(i)
	local startX = DynamiteWall[i]["Wall"]["StartX"] + originX
	local startY = DynamiteWall[i]["Wall"]["StartY"] + originY
	local fr = DynamiteWall[i]["Wall"]:TimerGo()
	if DynamiteWall[i]["IsEnd"] == 1 and fr == 1 then
		DynamiteWall[i]["IsWrite"] = 0
		DynamiteWall[i]["IsEnd"] = 0
		mapTable[DynamiteWall[i]["Wall"]["StartY"]/BlockSize + 1][DynamiteWall[i]["Wall"]["StartX"]/BlockSize + 1][4] = 0
		return
	end
	if fr == 1 then
		DynamiteWall[i]["WallAnimation"]:setImage(startX, startY, 50 , 50 , 0   , 50 , 0 , 50 ,  2);
	elseif fr == 2 then
		DynamiteWall[i]["WallAnimation"]:setImage(startX, startY, 50 , 50 , 50  , 100, 0 , 50 ,  2);
	elseif fr == 3 then
		DynamiteWall[i]["WallAnimation"]:setImage(startX, startY, 50 , 50 , 100 , 150, 0 , 50 ,  2);
		DynamiteWall[i]["IsEnd"] = 1
	end
	DynamiteWall[i]["WallAnimation"]:DrawImage();
end

--¼ì²â»ðÑæÅö×²
function TestBlazeImpact(i)
	--ÉÏ·½»ðÑæÅö×²¼ì²â
	while(BombBlaze[i]["UpImpact"] <= UserData["Power"]) do
		if(BombBlaze[i]["Blaze"]["StartY"] + BombBlaze[i]["UpImpact"] * BlockSize == TotalHeightPixels) then
			BombBlaze[i]["UpImpact"] = BombBlaze[i]["UpImpact"] - 1
			break
		end
		
		if(mapTable[(BombBlaze[i]["Blaze"]["StartY"] + BombBlaze[i]["UpImpact"] * BlockSize)/BlockSize + 1][BombBlaze[i]["Blaze"]["StartX"]/BlockSize + 1][3] == 1 ) then
			BombBlaze[i]["UpImpact"] = BombBlaze[i]["UpImpact"] - 1
			break
		end
		
		if (mapTable[(BombBlaze[i]["Blaze"]["StartY"] + BombBlaze[i]["UpImpact"] * BlockSize)/BlockSize + 1][BombBlaze[i]["Blaze"]["StartX"]/BlockSize + 1][4] <= BoxRandRate 
			and 0 < mapTable[(BombBlaze[i]["Blaze"]["StartY"] + BombBlaze[i]["UpImpact"] * BlockSize)/BlockSize + 1][BombBlaze[i]["Blaze"]["StartX"]/BlockSize + 1][4]) then
			mapTable[(BombBlaze[i]["Blaze"]["StartY"] + BombBlaze[i]["UpImpact"] * BlockSize)/BlockSize + 1][BombBlaze[i]["Blaze"]["StartX"]/BlockSize + 1][4] = 1000
			for j = 1,24 do
				if(DynamiteWall[j]["IsWrite"] == 0) then
					DynamiteWall[j]["IsWrite"] = 1
					DynamiteWall[j]:Init(BombBlaze[i]["Blaze"]["StartX"],BombBlaze[i]["Blaze"]["StartY"] + BombBlaze[i]["UpImpact"] * BlockSize)
					break
				end
			end
			BombBlaze[i]["UpImpact"] = BombBlaze[i]["UpImpact"] - 1
			break
		end
		
		if(mapTable[(BombBlaze[i]["Blaze"]["StartY"] + BombBlaze[i]["UpImpact"] * BlockSize)/BlockSize + 1][BombBlaze[i]["Blaze"]["StartX"]/BlockSize + 1][7] == 1) then
			BombBlaze[i]["UpImpact"] = BombBlaze[i]["UpImpact"] - 1
			break
		end
		BombBlaze[i]["UpImpact"] = BombBlaze[i]["UpImpact"] + 1
	end
	if (BombBlaze[i]["UpImpact"] > UserData["Power"]) then
		BombBlaze[i]["UpImpact"] = UserData["Power"]
	end
	
	--×ó·½»ðÑæÅö×²¼ì²â
	while(BombBlaze[i]["LeftImpact"] <= UserData["Power"]) do
		if(BombBlaze[i]["Blaze"]["StartX"] == 0) then
			BombBlaze[i]["LeftImpact"] = 0
			break
		end
		
		if(BombBlaze[i]["Blaze"]["StartX"] - BombBlaze[i]["LeftImpact"] * BlockSize == 0) then
			if(mapTable[BombBlaze[i]["Blaze"]["StartY"] / BlockSize + 1][(BombBlaze[i]["Blaze"]["StartX"] - BombBlaze[i]["LeftImpact"] * BlockSize)/BlockSize + 1][3] == 1) then
				BombBlaze[i]["LeftImpact"] = BombBlaze[i]["LeftImpact"] - 1
				break
			end
			if(mapTable[BombBlaze[i]["Blaze"]["StartY"] / BlockSize + 1][(BombBlaze[i]["Blaze"]["StartX"] - BombBlaze[i]["LeftImpact"] * BlockSize)/BlockSize + 1][4] <= BoxRandRate 
				and 0 < mapTable[BombBlaze[i]["Blaze"]["StartY"] / BlockSize + 1][(BombBlaze[i]["Blaze"]["StartX"] - BombBlaze[i]["LeftImpact"] * BlockSize)/BlockSize + 1][4]) then
				mapTable[BombBlaze[i]["Blaze"]["StartY"] / BlockSize + 1][(BombBlaze[i]["Blaze"]["StartX"] - BombBlaze[i]["LeftImpact"] * BlockSize)/BlockSize + 1][4] = 1000
				for j = 1,24 do
					if(DynamiteWall[j]["IsWrite"] == 0) then
						DynamiteWall[j]["IsWrite"] = 1
						DynamiteWall[j]:Init(BombBlaze[i]["Blaze"]["StartX"] - BombBlaze[i]["LeftImpact"] * BlockSize,BombBlaze[i]["Blaze"]["StartY"])
						break
					end
				end
				BombBlaze[i]["LeftImpact"] = BombBlaze[i]["LeftImpact"] - 1
				break
			end
			break
		end
		
		if(mapTable[BombBlaze[i]["Blaze"]["StartY"] / BlockSize + 1][(BombBlaze[i]["Blaze"]["StartX"] - BombBlaze[i]["LeftImpact"] * BlockSize)/BlockSize + 1][3] == 1) then
			BombBlaze[i]["LeftImpact"] = BombBlaze[i]["LeftImpact"] - 1
			break
		end
		
		if(mapTable[BombBlaze[i]["Blaze"]["StartY"] / BlockSize + 1][(BombBlaze[i]["Blaze"]["StartX"] - BombBlaze[i]["LeftImpact"] * BlockSize)/BlockSize + 1][4] <= BoxRandRate 
			and 0 < mapTable[BombBlaze[i]["Blaze"]["StartY"] / BlockSize + 1][(BombBlaze[i]["Blaze"]["StartX"] - BombBlaze[i]["LeftImpact"] * BlockSize)/BlockSize + 1][4]) then
			mapTable[BombBlaze[i]["Blaze"]["StartY"] / BlockSize + 1][(BombBlaze[i]["Blaze"]["StartX"] - BombBlaze[i]["LeftImpact"] * BlockSize)/BlockSize + 1][4] = 1000
			for j = 1,24 do
				if(DynamiteWall[j]["IsWrite"] == 0) then
					DynamiteWall[j]["IsWrite"] = 1
					DynamiteWall[j]:Init(BombBlaze[i]["Blaze"]["StartX"] - BombBlaze[i]["LeftImpact"] * BlockSize,BombBlaze[i]["Blaze"]["StartY"])
					break
				end
			end
			BombBlaze[i]["LeftImpact"] = BombBlaze[i]["LeftImpact"] - 1
			break
		end
		
		if(mapTable[BombBlaze[i]["Blaze"]["StartY"] / BlockSize + 1][(BombBlaze[i]["Blaze"]["StartX"] - BombBlaze[i]["LeftImpact"] * BlockSize)/BlockSize + 1][7] == 1) then
			BombBlaze[i]["LeftImpact"] = BombBlaze[i]["LeftImpact"] - 1
			break
		end
		BombBlaze[i]["LeftImpact"] = BombBlaze[i]["LeftImpact"] + 1
	end
	if (BombBlaze[i]["LeftImpact"] > UserData["Power"]) then
		BombBlaze[i]["LeftImpact"] = UserData["Power"]
	end
	
	--ÓÒ·½»ðÑæÅö×²¼ì²â
	while(BombBlaze[i]["RightImpact"] <= UserData["Power"]) do
		if(BombBlaze[i]["Blaze"]["StartX"] + BombBlaze[i]["RightImpact"] * BlockSize == TotalWidthPixels) then
			BombBlaze[i]["RightImpact"] = BombBlaze[i]["RightImpact"] - 1
			break
		end
		
		if(mapTable[BombBlaze[i]["Blaze"]["StartY"] / BlockSize + 1][(BombBlaze[i]["Blaze"]["StartX"] + BombBlaze[i]["RightImpact"] * BlockSize)/BlockSize + 1][3] == 1) then
			BombBlaze[i]["RightImpact"] = BombBlaze[i]["RightImpact"] - 1
			break
		end
		
		if(mapTable[BombBlaze[i]["Blaze"]["StartY"] / BlockSize + 1][(BombBlaze[i]["Blaze"]["StartX"] + BombBlaze[i]["RightImpact"] * BlockSize)/BlockSize + 1][4] <= BoxRandRate
			and 0 < mapTable[BombBlaze[i]["Blaze"]["StartY"] / BlockSize + 1][(BombBlaze[i]["Blaze"]["StartX"] + BombBlaze[i]["RightImpact"] * BlockSize)/BlockSize + 1][4]) then
			mapTable[BombBlaze[i]["Blaze"]["StartY"] / BlockSize + 1][(BombBlaze[i]["Blaze"]["StartX"] + BombBlaze[i]["RightImpact"] * BlockSize)/BlockSize + 1][4] = 1000
			for j = 1,24 do
				if(DynamiteWall[j]["IsWrite"] == 0) then
					DynamiteWall[j]["IsWrite"] = 1
					DynamiteWall[j]:Init(BombBlaze[i]["Blaze"]["StartX"] + BombBlaze[i]["RightImpact"] * BlockSize,BombBlaze[i]["Blaze"]["StartY"])
					break
				end
			end
			BombBlaze[i]["RightImpact"] = BombBlaze[i]["RightImpact"] - 1
			break
		end
		
		if(mapTable[BombBlaze[i]["Blaze"]["StartY"] / BlockSize + 1][(BombBlaze[i]["Blaze"]["StartX"] + BombBlaze[i]["RightImpact"] * BlockSize)/BlockSize + 1][7] == 1) then
			BombBlaze[i]["RightImpact"] = BombBlaze[i]["RightImpact"] - 1
			break
		end
		BombBlaze[i]["RightImpact"] = BombBlaze[i]["RightImpact"] + 1
	end
	if (BombBlaze[i]["RightImpact"] > UserData["Power"]) then
		BombBlaze[i]["RightImpact"] = UserData["Power"]
	end
	
	--ÏÂ·½»ðÑæÅö×²¼ì²â
	while(BombBlaze[i]["DownImpact"] <= UserData["Power"]) do
		if(BombBlaze[i]["Blaze"]["StartY"]== 0) then
			BombBlaze[i]["DownImpact"] = 0
			break
		end
		
		if(BombBlaze[i]["Blaze"]["StartY"] - BombBlaze[i]["DownImpact"] * BlockSize == 0) then
			if(mapTable[(BombBlaze[i]["Blaze"]["StartY"] - BombBlaze[i]["DownImpact"] * BlockSize)/BlockSize + 1][BombBlaze[i]["Blaze"]["StartX"]/BlockSize + 1][3] == 1) then
				BombBlaze[i]["DownImpact"] = BombBlaze[i]["DownImpact"] - 1
				break
			end
			if(mapTable[(BombBlaze[i]["Blaze"]["StartY"] - BombBlaze[i]["DownImpact"] * BlockSize)/BlockSize + 1][BombBlaze[i]["Blaze"]["StartX"]/BlockSize + 1][4] <= BoxRandRate
				and 0 < mapTable[(BombBlaze[i]["Blaze"]["StartY"] - BombBlaze[i]["DownImpact"] * BlockSize)/BlockSize + 1][BombBlaze[i]["Blaze"]["StartX"]/BlockSize + 1][4]) then			
				mapTable[(BombBlaze[i]["Blaze"]["StartY"] - BombBlaze[i]["DownImpact"] * BlockSize)/BlockSize + 1][BombBlaze[i]["Blaze"]["StartX"]/BlockSize + 1][4] = 1000
				for j = 1,24 do
					if(DynamiteWall[j]["IsWrite"] == 0) then
						DynamiteWall[j]["IsWrite"] = 1
						DynamiteWall[j]:Init(BombBlaze[i]["Blaze"]["StartX"],BombBlaze[i]["Blaze"]["StartY"] - BombBlaze[i]["DownImpact"] * BlockSize)
						break
					end
				end
				BombBlaze[i]["DownImpact"] = BombBlaze[i]["DownImpact"] - 1
				break
			end
			break
		end
		
		if(mapTable[(BombBlaze[i]["Blaze"]["StartY"] - BombBlaze[i]["DownImpact"] * BlockSize)/BlockSize + 1][BombBlaze[i]["Blaze"]["StartX"]/BlockSize + 1][3] == 1) then
			BombBlaze[i]["DownImpact"] = BombBlaze[i]["DownImpact"] - 1
			break
		end
		
		if(mapTable[(BombBlaze[i]["Blaze"]["StartY"] - BombBlaze[i]["DownImpact"] * BlockSize)/BlockSize + 1][BombBlaze[i]["Blaze"]["StartX"]/BlockSize + 1][4] <= BoxRandRate
			and 0 < mapTable[(BombBlaze[i]["Blaze"]["StartY"] - BombBlaze[i]["DownImpact"] * BlockSize)/BlockSize + 1][BombBlaze[i]["Blaze"]["StartX"]/BlockSize + 1][4]) then			
			mapTable[(BombBlaze[i]["Blaze"]["StartY"] - BombBlaze[i]["DownImpact"] * BlockSize)/BlockSize + 1][BombBlaze[i]["Blaze"]["StartX"]/BlockSize + 1][4] = 1000
			for j = 1,24 do
				if(DynamiteWall[j]["IsWrite"] == 0) then
					DynamiteWall[j]["IsWrite"] = 1
					DynamiteWall[j]:Init(BombBlaze[i]["Blaze"]["StartX"],BombBlaze[i]["Blaze"]["StartY"] - BombBlaze[i]["DownImpact"] * BlockSize)
					break
				end
			end
			BombBlaze[i]["DownImpact"] = BombBlaze[i]["DownImpact"] - 1
			break
		end	
		
		if(mapTable[(BombBlaze[i]["Blaze"]["StartY"] -  BombBlaze[i]["DownImpact"] * BlockSize)/BlockSize + 1][BombBlaze[i]["Blaze"]["StartX"]/BlockSize + 1][7] == 1) then
			BombBlaze[i]["DownImpact"] = BombBlaze[i]["DownImpact"] - 1
			break
		end
		BombBlaze[i]["DownImpact"] = BombBlaze[i]["DownImpact"] + 1
	end
	if (BombBlaze[i]["DownImpact"] > UserData["Power"]) then
		BombBlaze[i]["DownImpact"] = UserData["Power"]
	end
end