UserBomb={n = 7}

BombBlaze={n = 24}

DynamiteWall={n = 28}

BombOrder = {n = 6}

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
	self.Blaze:SetValue(NowX, NowY, 12, 4);
	
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
	self.Wall:SetValue(NowX, NowY, 16, 3);
	
	self.WallAnimation = ImageClass:new();
	self.WallAnimation :setImageFileSize(150, 50);
end

--³õÊ¼»¯
function BombInit()
    for i = 1,UserBomb.n do
		UserBomb[i] = BombClass:new()
	end

	for i = 1,BombBlaze.n do
		BombBlaze[i] = BlazeClass:new()
		BombBlaze[i]["Depth"] = 5.5 - i/10
	end
	
	for i = 1, DynamiteWall.n do
		DynamiteWall[i] = WallClass:new()
	end
	
	BombOrder[1] = 0
	BombOrder[2] = 0
	BombOrder[3] = 0
	BombOrder[4] = 0
	BombOrder[5] = 0
	BombOrder[6] = 0
end

--ÅÐ¶ÏÌõ¼þµ÷ÓÃ»­Õ¨µ¯º¯Êý
function DrawBomb()
	local i = 1
	while(i <= UserBomb.n) do
		if UserBomb[i]["IsWrite"] == 1 then
			DrawBombFunc(i);
		end
		i = i + 1
	end
end

--ÅÐ¶ÏÌõ¼þµ÷ÓÃ»­»ðÑæº¯Êý
function DrawBlaze()
	local i = 1
	while(i <= 16) do
		if BombBlaze[i]["IsWrite"] == 1 then
			DrawBlazeFunc(i);
		end
		i = i + 1
	end
end

--ÅÐ¶ÏÌõ¼þµ÷ÓÃ»­Ç½±»Õ¨»Ù¶¯»­º¯Êý
function DrawDynamite()
	for i = 1,28 do
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
	if(ISGameNotPause == true) then
		local fr = UserBomb[i]["Bomb"]:TimerGo()
		if UserBomb[i]["IsBlast"] == 1 and fr == 1 then
			if(i == 7 or UserData["TimeBomb"] == 0) then
				while(b <= 8) do
					if BombBlaze[b]["IsWrite"] == 0 then
						BombBlaze[b]:Init(UserBomb[i]["Bomb"]["StartX"],UserBomb[i]["Bomb"]["StartY"])
						mapTable[UserBomb[i]["Bomb"]["StartY"]/BlockSize + 1][UserBomb[i]["Bomb"]["StartX"]/BlockSize + 1][7] = 0
						BombBlaze[b]["IsWrite"] = 1
						TestBlazeImpact(b,1)
						break
					end
					b = b + 1
				end
				UserBomb[i]["IsBlast"] = 0
				UserBomb[i]["IsWrite"] = 0
				return
			end
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
	end
	UserBomb[i]["BombAnimation"]:DrawImage();
end

--»­»ðÑæ
function DrawBlazeFunc(i)
	local startX = BombBlaze[i]["Blaze"]["StartX"] + originX
	local startY = BombBlaze[i]["Blaze"]["StartY"] + originY
	local power = UserData["Power"]
	local UpLength = BombBlaze[i]["UpImpact"]
	local LeftLength  = BombBlaze[i]["LeftImpact"]
	local RightLength  = BombBlaze[i]["RightImpact"]
	local DownLength  = BombBlaze[i]["DownImpact"]
	
	if(ISGameNotPause == true) then 
		local fr = BombBlaze[i]["Blaze"]:TimerGo()
		if BombBlaze[i]["IsEnd"] == 1 and fr == 1 then
			BombBlaze[i]["IsWrite"] = 0
			BombBlaze[i]["IsEnd"] = 0
			if(UpLength > 0) then
				for j = 1,UpLength do
					mapTable[(BombBlaze[i]["Blaze"]["StartY"] + j * BlockSize)/BlockSize + 1][BombBlaze[i]["Blaze"]["StartX"]/BlockSize + 1][10] = 0
				end
			end
			if(LeftLength > 0) then
				for j = 1,LeftLength do
					mapTable[BombBlaze[i]["Blaze"]["StartY"] / BlockSize + 1][(BombBlaze[i]["Blaze"]["StartX"] - j * BlockSize)/BlockSize + 1][10] = 0
				end
			end
			if(RightLength > 0) then
				for j = 1,RightLength do
					mapTable[BombBlaze[i]["Blaze"]["StartY"] / BlockSize + 1][(BombBlaze[i]["Blaze"]["StartX"] + j * BlockSize)/BlockSize + 1][10] = 0
				end
			end
			if(DownLength > 0) then
				for j = 1,DownLength do
					mapTable[(BombBlaze[i]["Blaze"]["StartY"] - j * BlockSize)/BlockSize + 1][BombBlaze[i]["Blaze"]["StartX"]/BlockSize + 1][10] = 0
				end
			end
			return
		end
        TestImpact(i)
		if fr == 1 then
			BombBlaze[i]["LeftBlazeAnimation"]:setImage(  startX - 50*LeftLength , startY                 , 50*LeftLength  , 50            , 32*(power - LeftLength) , 32*power                     , 0                           , 32                          ,  BombBlaze[i]["Depth"]);
			BombBlaze[i]["RightBlazeAnimation"]:setImage( startX +50             , startY                 , 50*RightLength , 50            , 352-32*power            , 352-32*(power - RightLength) , 0                           , 32                          ,  BombBlaze[i]["Depth"]);
			BombBlaze[i]["CentreBlazeAnimation"]:setImage(startX                 , startY                 , 50             , 50            , 0                       , 32                           , 480                         , 512                         ,  BombBlaze[i]["Depth"]);
			BombBlaze[i]["UpBlazeAnimation"]:setImage(    startX                 , startY + 50            , 50             , 50*UpLength   , 0                       , 32                           , 128 + 32*(power - UpLength) , 128 + 32*power              ,  BombBlaze[i]["Depth"]);
			BombBlaze[i]["DownBlazeAnimation"]:setImage(  startX                 , startY - 50*DownLength , 50             , 50*DownLength , 0                       , 32                           , 480-32*power                , 480-32*(power - DownLength) ,  BombBlaze[i]["Depth"]);
		elseif fr == 2 then
			BombBlaze[i]["LeftBlazeAnimation"]:setImage(  startX - 50*LeftLength , startY                 , 50*LeftLength  , 50            , 32*(power - LeftLength) , 32*power 					, 32          				  , 64            				,  BombBlaze[i]["Depth"]);
			BombBlaze[i]["RightBlazeAnimation"]:setImage( startX + 50            , startY                 , 50*RightLength , 50            , 352-32*power            , 352-32*(power - RightLength) , 32           				  , 64            				,  BombBlaze[i]["Depth"]);
			BombBlaze[i]["CentreBlazeAnimation"]:setImage(startX                 , startY                 , 50             , 50            , 32                      , 64       					, 480          				  , 512            			    ,  BombBlaze[i]["Depth"]);
			BombBlaze[i]["UpBlazeAnimation"]:setImage(    startX                 , startY + 50            , 50             , 50*UpLength   , 32                      , 64       					, 128 + 32*(power - UpLength) , 128 + 32*power 				,  BombBlaze[i]["Depth"]);
			BombBlaze[i]["DownBlazeAnimation"]:setImage(  startX                 , startY - 50*DownLength , 50             , 50*DownLength , 32                      , 64       					, 480-32*power                , 480-32*(power - DownLength) ,  BombBlaze[i]["Depth"]);
		elseif fr == 3 then
			BombBlaze[i]["LeftBlazeAnimation"]:setImage(  startX - 50*LeftLength , startY                 , 50*LeftLength  , 50            , 32*(power - LeftLength) , 32*power 					, 64           				  , 96             				,  BombBlaze[i]["Depth"]);
			BombBlaze[i]["RightBlazeAnimation"]:setImage( startX + 50            , startY                 , 50*RightLength , 50            , 352-32*power 			 , 352-32*(power - RightLength) , 64           				  , 96             				,  BombBlaze[i]["Depth"]);
			BombBlaze[i]["CentreBlazeAnimation"]:setImage(startX                 , startY                 , 50             , 50            , 64           			 , 96      					    , 480          				  , 512           				,  BombBlaze[i]["Depth"]);
			BombBlaze[i]["UpBlazeAnimation"]:setImage(    startX                 , startY + 50            , 50             , 50*UpLength   , 64           			 , 96       					, 128 + 32*(power - UpLength) , 128 + 32*power				,  BombBlaze[i]["Depth"]);
			BombBlaze[i]["DownBlazeAnimation"]:setImage(  startX                 , startY - 50*DownLength , 50             , 50*DownLength , 64             		 , 96       					, 480-32*power 				  , 480-32*(power - DownLength) ,  BombBlaze[i]["Depth"]);
		elseif fr == 4 then
			BombBlaze[i]["LeftBlazeAnimation"]:setImage(  startX - 50*LeftLength , startY           	  , 50*LeftLength  , 50            , 32*(power - LeftLength) , 32*power 					, 96           				  , 128            				,  BombBlaze[i]["Depth"]);
			BombBlaze[i]["RightBlazeAnimation"]:setImage( startX + 50       	 , startY            	  , 50*RightLength , 50            , 352-32*power 			 , 352-32*(power - RightLength) , 96           				  , 128            				,  BombBlaze[i]["Depth"]);
			BombBlaze[i]["CentreBlazeAnimation"]:setImage(startX            	 , startY          	  	  , 50       	   , 50            , 96           			 , 128      					, 480          				  , 512            				,  BombBlaze[i]["Depth"]);
			BombBlaze[i]["UpBlazeAnimation"]:setImage(    startX            	 , startY + 50      	  , 50       	   , 50*UpLength   , 96           			 , 128      					, 128 + 32*(power - UpLength) , 128 + 32*power 				,  BombBlaze[i]["Depth"]);
			BombBlaze[i]["DownBlazeAnimation"]:setImage(  startX            	 , startY - 50*DownLength , 50             , 50*DownLength , 96           			 , 128     						, 480-32*power 				  , 480-32*(power - DownLength) ,  BombBlaze[i]["Depth"]);
			BombBlaze[i]["IsEnd"] = 1
		end
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
	local buffId = 0
	
	if(ISGameNotPause == true) then
		local fr = DynamiteWall[i]["Wall"]:TimerGo()
		if DynamiteWall[i]["IsEnd"] == 1 and fr == 1 then
			DynamiteWall[i]["IsWrite"] = 0
			DynamiteWall[i]["IsEnd"] = 0
			mapTable[DynamiteWall[i]["Wall"]["StartY"]/BlockSize + 1][DynamiteWall[i]["Wall"]["StartX"]/BlockSize + 1][4] = 0
			buffId = math.random(1,7);		
			if(buffId > 0 and buffId <= 7) then
				mapTable[DynamiteWall[i]["Wall"]["StartY"]/BlockSize + 1][DynamiteWall[i]["Wall"]["StartX"]/BlockSize + 1][8] = buffId
			end	
			return
		end
		if fr == 1 then
			DynamiteWall[i]["WallAnimation"]:setImage(startX, startY, 50 , 50 , 0   , 50 , 0 , 50 ,  4);
		elseif fr == 2 then
			DynamiteWall[i]["WallAnimation"]:setImage(startX, startY, 50 , 50 , 50  , 100, 0 , 50 ,  4);
		elseif fr == 3 then
			DynamiteWall[i]["WallAnimation"]:setImage(startX, startY, 50 , 50 , 100 , 150, 0 , 50 ,  4);
			DynamiteWall[i]["IsEnd"] = 1
		end
	end
	DynamiteWall[i]["WallAnimation"]:DrawImage();
end

function TestImpact(i)
    local userLeftX = actorinf["AcStPosX"];
    local userUpY = actorinf["AcStPosY"];
    local assistantLeftX = assistantinf["AcStPosX"]
    local assistantUpY = assistantinf["AcStPosY"]

    local leftBlazeStartX = BombBlaze[i]["Blaze"]["StartX"] - BombBlaze[i]["LeftImpact"] * 50;
    local rightBlazeEndX = BombBlaze[i]["Blaze"]["StartX"] + BombBlaze[i]["RightImpact"] * 50 + 50;
    local upBlazeEndY = BombBlaze[i]["Blaze"]["StartY"] + BombBlaze[i]["UpImpact"] * 50 + 50;
    local downBlazeStartY = BombBlaze[i]["Blaze"]["StartY"] - BombBlaze[i]["DownImpact"] * 50;

    if(userLeftX < rightBlazeEndX and userLeftX + 50 > rightBlazeEndX) or (userLeftX < leftBlazeStartX and userLeftX + 50 > leftBlazeStartX) or
    (userLeftX >= leftBlazeStartX and userLeftX + 50 <= rightBlazeEndX) then
        if(userUpY > BombBlaze[i]["Blaze"]["StartY"] and userUpY - 50 < BombBlaze[i]["Blaze"]["StartY"]) or (userUpY > BombBlaze[i]["Blaze"]["StartY"] + 50 and userUpY - 50 < BombBlaze[i]["Blaze"]["StartY"] + 50) or 
        (userUpY == BombBlaze[i]["Blaze"]["StartY"] + 50) then
            --MessageBox("1","1",MB_OK)
            DrawActorGesture(0, 0, Actor1:TimerGo(true), 6, actorimg);  --ÈËÎïËÀÍö
        end
    end

    if(userUpY > downBlazeStartY and userUpY - 50 < downBlazeStartY) or (userUpY > upBlazeEndY and userUpY - 50 < upBlazeEndY) or
    (userUpY <= upBlazeEndY and userUpY - 50 >= downBlazeStartY) then
        if(userLeftX < BombBlaze[i]["Blaze"]["StartX"] and userLeftX + 50 > BombBlaze[i]["Blaze"]["StartX"]) or (userLeftX > BombBlaze[i]["Blaze"]["StartX"] and userLeftX < BombBlaze[i]["Blaze"]["StartX"] + 50) or 
        (userLeftX == BombBlaze[i]["Blaze"]["StartX"]) then
            --MessageBox("1","1",MB_OK)
            DrawActorGesture(0, 0, Actor1:TimerGo(true), 6, actorimg);  --ÈËÎïËÀÍö
        end
    end

    if(assistantLeftX < rightBlazeEndX and assistantLeftX + 50 > rightBlazeEndX) or (assistantLeftX < leftBlazeStartX and assistantLeftX + 50 > leftBlazeStartX) or
    (assistantLeftX >= leftBlazeStartX and assistantLeftX + 50 <= rightBlazeEndX) then
        if(assistantUpY > BombBlaze[i]["Blaze"]["StartY"] and assistantUpY - 50 < BombBlaze[i]["Blaze"]["StartY"]) or (assistantUpY > BombBlaze[i]["Blaze"]["StartY"] + 50 and assistantUpY - 50 < BombBlaze[i]["Blaze"]["StartY"] + 50) or 
        (assistantUpY == BombBlaze[i]["Blaze"]["StartY"] + 50) then
            --MessageBox("1","1",MB_OK)
            DrawActorGesture(0, 0, Actor1:TimerGo(true), 6, Assistantimg);  
            AssistantSwitch = false;
        end
    end

    if(assistantUpY > downBlazeStartY and assistantUpY - 50 < downBlazeStartY) or (assistantUpY > upBlazeEndY and assistantUpY - 50 < upBlazeEndY) or
    (assistantUpY <= upBlazeEndY and assistantUpY - 50 >= downBlazeStartY) then
        if(assistantLeftX < BombBlaze[i]["Blaze"]["StartX"] and assistantLeftX + 50 > BombBlaze[i]["Blaze"]["StartX"]) or (assistantLeftX > BombBlaze[i]["Blaze"]["StartX"] and assistantLeftX < BombBlaze[i]["Blaze"]["StartX"] + 50) or 
        (assistantLeftX == BombBlaze[i]["Blaze"]["StartX"]) then
            --MessageBox("1","1",MB_OK)
             DrawActorGesture(0, 0, Actor1:TimerGo(true), 6, Assistantimg);
             AssistantSwitch = false;  
        end
    end


    for j = 1,AllEnemy.n do
        if(AllEnemy[j]["IsSurvival"] == 1) then
            if(AllEnemy[j]["Enemy"]["StartX"] + AllEnemy[j]["MoveX"] < rightBlazeEndX and AllEnemy[j]["Enemy"]["StartX"] + AllEnemy[j]["MoveX"] + 50 > rightBlazeEndX) or (AllEnemy[j]["Enemy"]["StartX"] + AllEnemy[j]["MoveX"] < leftBlazeStartX and AllEnemy[j]["Enemy"]["StartX"] + AllEnemy[j]["MoveX"] + 50 > leftBlazeStartX) or
            (AllEnemy[j]["Enemy"]["StartX"] + AllEnemy[j]["MoveX"] >= leftBlazeStartX and AllEnemy[j]["Enemy"]["StartX"] + AllEnemy[j]["MoveX"] + 50 <= rightBlazeEndX) then
                if(AllEnemy[j]["Enemy"]["StartY"] + AllEnemy[j]["MoveY"] + 50 > BombBlaze[i]["Blaze"]["StartY"] and AllEnemy[j]["Enemy"]["StartY"] + AllEnemy[j]["MoveY"] < BombBlaze[i]["Blaze"]["StartY"]) or (AllEnemy[j]["Enemy"]["StartY"] + AllEnemy[j]["MoveY"] > BombBlaze[i]["Blaze"]["StartY"] and AllEnemy[j]["Enemy"]["StartY"] + AllEnemy[j]["MoveY"] < BombBlaze[i]["Blaze"]["StartY"] + 50) or 
                (AllEnemy[j]["Enemy"]["StartY"] + AllEnemy[j]["MoveY"] == BombBlaze[i]["Blaze"]["StartY"]) then
                    --MessageBox("1","1",MB_OK)
                    AllEnemy[j]["IsSurvival"] = 0
                end
            end
            if(AllEnemy[j]["Enemy"]["StartY"] + AllEnemy[j]["MoveY"] + 50 > downBlazeStartY and AllEnemy[j]["Enemy"]["StartY"] + AllEnemy[j]["MoveY"] < downBlazeStartY) or (AllEnemy[j]["Enemy"]["StartY"] + AllEnemy[j]["MoveY"] + 50 > upBlazeEndY and AllEnemy[j]["Enemy"]["StartY"] + AllEnemy[j]["MoveY"] < upBlazeEndY) or
            (AllEnemy[j]["Enemy"]["StartY"] + AllEnemy[j]["MoveY"] + 50 <= upBlazeEndY and AllEnemy[j]["Enemy"]["StartY"] + AllEnemy[j]["MoveY"] >= downBlazeStartY) then
                if(AllEnemy[j]["Enemy"]["StartX"] + AllEnemy[j]["MoveX"] < BombBlaze[i]["Blaze"]["StartX"] and AllEnemy[j]["Enemy"]["StartX"] + AllEnemy[j]["MoveX"] + 50 > BombBlaze[i]["Blaze"]["StartX"]) or (AllEnemy[j]["Enemy"]["StartX"] + AllEnemy[j]["MoveX"] > BombBlaze[i]["Blaze"]["StartX"] and AllEnemy[j]["Enemy"]["StartX"] + AllEnemy[j]["MoveX"] < BombBlaze[i]["Blaze"]["StartX"] + 50) or 
                (AllEnemy[j]["Enemy"]["StartX"] + AllEnemy[j]["MoveX"] == BombBlaze[i]["Blaze"]["StartX"]) then
                    --MessageBox("1","1",MB_OK)
                    AllEnemy[j]["IsSurvival"] = 0
                end
            end
        end
    end
end

--¼ì²â»ðÑæÅö×²
function TestBlazeImpact(i,j)
    if(j == 1 and i < 9) then
        for k = 17,24 do
            if(BombBlaze[i]["Blaze"]["StartY"] == BombBlaze[k]["Blaze"]["StartY"] and BombBlaze[i]["Blaze"]["StartX"] == BombBlaze[k]["Blaze"]["StartX"] and BombBlaze[k]["IsWrite"] == 2) then
                BombBlaze[k]["IsWrite"] = 0
                break
            end
        end
    end
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
		
		if(mapTable[(BombBlaze[i]["Blaze"]["StartY"] + BombBlaze[i]["UpImpact"] * BlockSize)/BlockSize + 1][BombBlaze[i]["Blaze"]["StartX"]/BlockSize + 1][4] == 1000 ) then
			BombBlaze[i]["UpImpact"] = BombBlaze[i]["UpImpact"] - 1
			break
		end
		
		if (mapTable[(BombBlaze[i]["Blaze"]["StartY"] + BombBlaze[i]["UpImpact"] * BlockSize)/BlockSize + 1][BombBlaze[i]["Blaze"]["StartX"]/BlockSize + 1][4] <= BoxRandRate 
			and 0 < mapTable[(BombBlaze[i]["Blaze"]["StartY"] + BombBlaze[i]["UpImpact"] * BlockSize)/BlockSize + 1][BombBlaze[i]["Blaze"]["StartX"]/BlockSize + 1][4]) then
			if(j == 1) then
				mapTable[(BombBlaze[i]["Blaze"]["StartY"] + BombBlaze[i]["UpImpact"] * BlockSize)/BlockSize + 1][BombBlaze[i]["Blaze"]["StartX"]/BlockSize + 1][4] = 1000
				for j = 1,24 do
					if(DynamiteWall[j]["IsWrite"] == 0) then
						DynamiteWall[j]["IsWrite"] = 1
						DynamiteWall[j]:Init(BombBlaze[i]["Blaze"]["StartX"],BombBlaze[i]["Blaze"]["StartY"] + BombBlaze[i]["UpImpact"] * BlockSize)
						break
					end
				end
			end
			BombBlaze[i]["UpImpact"] = BombBlaze[i]["UpImpact"] - 1
			break
		end
		
		if (mapTable[(BombBlaze[i]["Blaze"]["StartY"] + BombBlaze[i]["UpImpact"] * BlockSize)/BlockSize + 1][BombBlaze[i]["Blaze"]["StartX"]/BlockSize + 1][8] <= 7 
			and 0 < mapTable[(BombBlaze[i]["Blaze"]["StartY"] + BombBlaze[i]["UpImpact"] * BlockSize)/BlockSize + 1][BombBlaze[i]["Blaze"]["StartX"]/BlockSize + 1][8]) then
			if(j == 1) then
				mapTable[(BombBlaze[i]["Blaze"]["StartY"] + BombBlaze[i]["UpImpact"] * BlockSize)/BlockSize + 1][BombBlaze[i]["Blaze"]["StartX"]/BlockSize + 1][8] = 0
			end
			BombBlaze[i]["UpImpact"] = BombBlaze[i]["UpImpact"] - 1
			break
		end
		
		if(mapTable[(BombBlaze[i]["Blaze"]["StartY"] + BombBlaze[i]["UpImpact"] * BlockSize)/BlockSize + 1][BombBlaze[i]["Blaze"]["StartX"]/BlockSize + 1][7] == 1) then
			if(j == 1) then
				for j = 1,6 do
					if(UserBomb[j]["Bomb"]["StartX"] == BombBlaze[i]["Blaze"]["StartX"] and 
					UserBomb[j]["Bomb"]["StartY"] == BombBlaze[i]["Blaze"]["StartY"] + BombBlaze[i]["UpImpact"] * BlockSize) then
						UserBomb[j]["IsWrite"] = 0
						UserBomb[j]["IsBlast"] = 0
						mapTable[UserBomb[j]["Bomb"]["StartY"]/BlockSize + 1][UserBomb[j]["Bomb"]["StartX"]/BlockSize + 1][7] = 0
						for n = 1,6 do
							if(BombOrder[n] == j) then
								BombOrder[n] = 0
								if n~=6 then
									while(n <= 5) do
										BombOrder[n] = BombOrder[n + 1]
										n = n + 1
									end
								end
								break
							end
						end
						for k = 1,6 do
							if BombBlaze[k]["IsWrite"] == 0 then
								BombBlaze[k]:Init(UserBomb[j]["Bomb"]["StartX"],UserBomb[j]["Bomb"]["StartY"])
								BombBlaze[k]["IsWrite"] = 1
								TestBlazeImpact(k,1)
								break
							end
						end
						break
					end
				end
			end
			BombBlaze[i]["UpImpact"] = BombBlaze[i]["UpImpact"] - 1
			break
		end
		if(j == 0) then
			mapTable[(BombBlaze[i]["Blaze"]["StartY"] + BombBlaze[i]["UpImpact"] * BlockSize)/BlockSize + 1][BombBlaze[i]["Blaze"]["StartX"]/BlockSize + 1][9] = mapTable[(BombBlaze[i]["Blaze"]["StartY"] + BombBlaze[i]["UpImpact"] * BlockSize)/BlockSize + 1][BombBlaze[i]["Blaze"]["StartX"]/BlockSize + 1][9] + 1
		elseif(j == 1) then
			mapTable[(BombBlaze[i]["Blaze"]["StartY"] + BombBlaze[i]["UpImpact"] * BlockSize)/BlockSize + 1][BombBlaze[i]["Blaze"]["StartX"]/BlockSize + 1][9] = mapTable[(BombBlaze[i]["Blaze"]["StartY"] + BombBlaze[i]["UpImpact"] * BlockSize)/BlockSize + 1][BombBlaze[i]["Blaze"]["StartX"]/BlockSize + 1][9] - 1
			mapTable[(BombBlaze[i]["Blaze"]["StartY"] + BombBlaze[i]["UpImpact"] * BlockSize)/BlockSize + 1][BombBlaze[i]["Blaze"]["StartX"]/BlockSize + 1][10] = 1
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
				if(j == 1) then
					mapTable[BombBlaze[i]["Blaze"]["StartY"] / BlockSize + 1][(BombBlaze[i]["Blaze"]["StartX"] - BombBlaze[i]["LeftImpact"] * BlockSize)/BlockSize + 1][4] = 1000
					for j = 1,24 do
						if(DynamiteWall[j]["IsWrite"] == 0) then
							DynamiteWall[j]["IsWrite"] = 1
							DynamiteWall[j]:Init(BombBlaze[i]["Blaze"]["StartX"] - BombBlaze[i]["LeftImpact"] * BlockSize,BombBlaze[i]["Blaze"]["StartY"])
							break
						end
					end
				end
				BombBlaze[i]["LeftImpact"] = BombBlaze[i]["LeftImpact"] - 1
				break
			end
			if(mapTable[BombBlaze[i]["Blaze"]["StartY"] / BlockSize + 1][(BombBlaze[i]["Blaze"]["StartX"] - BombBlaze[i]["LeftImpact"] * BlockSize)/BlockSize + 1][8] <= 7 
				and 0 < mapTable[BombBlaze[i]["Blaze"]["StartY"] / BlockSize + 1][(BombBlaze[i]["Blaze"]["StartX"] - BombBlaze[i]["LeftImpact"] * BlockSize)/BlockSize + 1][8]) then
				if(j == 1) then
					mapTable[BombBlaze[i]["Blaze"]["StartY"] / BlockSize + 1][(BombBlaze[i]["Blaze"]["StartX"] - BombBlaze[i]["LeftImpact"] * BlockSize)/BlockSize + 1][8] = 0
				end
				BombBlaze[i]["LeftImpact"] = BombBlaze[i]["LeftImpact"] - 1
				break
			end
			if(mapTable[BombBlaze[i]["Blaze"]["StartY"] / BlockSize + 1][(BombBlaze[i]["Blaze"]["StartX"] - BombBlaze[i]["LeftImpact"] * BlockSize)/BlockSize + 1][7] == 1) then
				if(j == 1) then
					for j = 1,6 do
						if(UserBomb[j]["Bomb"]["StartX"] == BombBlaze[i]["Blaze"]["StartX"] - BombBlaze[i]["LeftImpact"] * BlockSize and 
						UserBomb[j]["Bomb"]["StartY"] == BombBlaze[i]["Blaze"]["StartY"]) then
							UserBomb[j]["IsWrite"] = 0
							UserBomb[j]["IsBlast"] = 0
							mapTable[UserBomb[j]["Bomb"]["StartY"]/BlockSize + 1][UserBomb[j]["Bomb"]["StartX"]/BlockSize + 1][7] = 0
							for n = 1,6 do
								if(BombOrder[n] == j) then
									BombOrder[n] = 0
									if n~=6 then
										while(n <= 5) do
											BombOrder[n] = BombOrder[n + 1]
											n = n + 1
										end
									end
									break
								end
							end
							for k = 1,6 do
								if BombBlaze[k]["IsWrite"] == 0 then
									BombBlaze[k]:Init(UserBomb[j]["Bomb"]["StartX"],UserBomb[j]["Bomb"]["StartY"])
									BombBlaze[k]["IsWrite"] = 1
									TestBlazeImpact(k,1)
									break
								end
							end
							break
						end
					end
				end
				BombBlaze[i]["LeftImpact"] = BombBlaze[i]["LeftImpact"] - 1
			end
			break
		end
		
		if(mapTable[BombBlaze[i]["Blaze"]["StartY"] / BlockSize + 1][(BombBlaze[i]["Blaze"]["StartX"] - BombBlaze[i]["LeftImpact"] * BlockSize)/BlockSize + 1][3] == 1) then
			BombBlaze[i]["LeftImpact"] = BombBlaze[i]["LeftImpact"] - 1
			break
		end
		
		if(mapTable[BombBlaze[i]["Blaze"]["StartY"] / BlockSize + 1][(BombBlaze[i]["Blaze"]["StartX"] - BombBlaze[i]["LeftImpact"] * BlockSize)/BlockSize + 1][4] == 1000) then
			BombBlaze[i]["LeftImpact"] = BombBlaze[i]["LeftImpact"] - 1
			break
		end
		
		if(mapTable[BombBlaze[i]["Blaze"]["StartY"] / BlockSize + 1][(BombBlaze[i]["Blaze"]["StartX"] - BombBlaze[i]["LeftImpact"] * BlockSize)/BlockSize + 1][4] <= BoxRandRate 
			and 0 < mapTable[BombBlaze[i]["Blaze"]["StartY"] / BlockSize + 1][(BombBlaze[i]["Blaze"]["StartX"] - BombBlaze[i]["LeftImpact"] * BlockSize)/BlockSize + 1][4]) then
			if(j == 1) then
				mapTable[BombBlaze[i]["Blaze"]["StartY"] / BlockSize + 1][(BombBlaze[i]["Blaze"]["StartX"] - BombBlaze[i]["LeftImpact"] * BlockSize)/BlockSize + 1][4] = 1000
				for j = 1,24 do
					if(DynamiteWall[j]["IsWrite"] == 0) then
						DynamiteWall[j]["IsWrite"] = 1
						DynamiteWall[j]:Init(BombBlaze[i]["Blaze"]["StartX"] - BombBlaze[i]["LeftImpact"] * BlockSize,BombBlaze[i]["Blaze"]["StartY"])
						break
					end
				end
			end
			BombBlaze[i]["LeftImpact"] = BombBlaze[i]["LeftImpact"] - 1
			break
		end
		
		if(mapTable[BombBlaze[i]["Blaze"]["StartY"] / BlockSize + 1][(BombBlaze[i]["Blaze"]["StartX"] - BombBlaze[i]["LeftImpact"] * BlockSize)/BlockSize + 1][8] <= 7 
			and 0 < mapTable[BombBlaze[i]["Blaze"]["StartY"] / BlockSize + 1][(BombBlaze[i]["Blaze"]["StartX"] - BombBlaze[i]["LeftImpact"] * BlockSize)/BlockSize + 1][8]) then
			if(j == 1) then
				mapTable[BombBlaze[i]["Blaze"]["StartY"] / BlockSize + 1][(BombBlaze[i]["Blaze"]["StartX"] - BombBlaze[i]["LeftImpact"] * BlockSize)/BlockSize + 1][8] = 0
			end
			BombBlaze[i]["LeftImpact"] = BombBlaze[i]["LeftImpact"] - 1
			break
		end		
		
		if(mapTable[BombBlaze[i]["Blaze"]["StartY"] / BlockSize + 1][(BombBlaze[i]["Blaze"]["StartX"] - BombBlaze[i]["LeftImpact"] * BlockSize)/BlockSize + 1][7] == 1) then
			if(j == 1) then
				for j = 1,6 do
					if(UserBomb[j]["Bomb"]["StartX"] == BombBlaze[i]["Blaze"]["StartX"] - BombBlaze[i]["LeftImpact"] * BlockSize and 
					UserBomb[j]["Bomb"]["StartY"] == BombBlaze[i]["Blaze"]["StartY"]) then
						UserBomb[j]["IsWrite"] = 0
						UserBomb[j]["IsBlast"] = 0
						mapTable[UserBomb[j]["Bomb"]["StartY"]/BlockSize + 1][UserBomb[j]["Bomb"]["StartX"]/BlockSize + 1][7] = 0
						for n = 1,6 do
							if(BombOrder[n] == j) then
								BombOrder[n] = 0
								if n~=6 then
									while(n <= 5) do
										BombOrder[n] = BombOrder[n + 1]
										n = n + 1
									end
								end
								break
							end
						end
						for k = 1,6 do
							if BombBlaze[k]["IsWrite"] == 0 then
								BombBlaze[k]:Init(UserBomb[j]["Bomb"]["StartX"],UserBomb[j]["Bomb"]["StartY"])
								BombBlaze[k]["IsWrite"] = 1
								TestBlazeImpact(k,1)
								break
							end
						end
						break
					end
				end
			end
			BombBlaze[i]["LeftImpact"] = BombBlaze[i]["LeftImpact"] - 1
			break
		end
		if(j == 0) then
			mapTable[BombBlaze[i]["Blaze"]["StartY"] / BlockSize + 1][(BombBlaze[i]["Blaze"]["StartX"] - BombBlaze[i]["LeftImpact"] * BlockSize)/BlockSize + 1][9] = mapTable[BombBlaze[i]["Blaze"]["StartY"] / BlockSize + 1][(BombBlaze[i]["Blaze"]["StartX"] - BombBlaze[i]["LeftImpact"] * BlockSize)/BlockSize + 1][9] + 1
		elseif(j == 1) then
			mapTable[BombBlaze[i]["Blaze"]["StartY"] / BlockSize + 1][(BombBlaze[i]["Blaze"]["StartX"] - BombBlaze[i]["LeftImpact"] * BlockSize)/BlockSize + 1][9] = mapTable[BombBlaze[i]["Blaze"]["StartY"] / BlockSize + 1][(BombBlaze[i]["Blaze"]["StartX"] - BombBlaze[i]["LeftImpact"] * BlockSize)/BlockSize + 1][9] - 1
			mapTable[BombBlaze[i]["Blaze"]["StartY"] / BlockSize + 1][(BombBlaze[i]["Blaze"]["StartX"] - BombBlaze[i]["LeftImpact"] * BlockSize)/BlockSize + 1][10] = 1
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
		
		if(mapTable[BombBlaze[i]["Blaze"]["StartY"] / BlockSize + 1][(BombBlaze[i]["Blaze"]["StartX"] + BombBlaze[i]["RightImpact"] * BlockSize)/BlockSize + 1][4] == 1000) then
			BombBlaze[i]["RightImpact"] = BombBlaze[i]["RightImpact"] - 1
			break
		end
		
		if(mapTable[BombBlaze[i]["Blaze"]["StartY"] / BlockSize + 1][(BombBlaze[i]["Blaze"]["StartX"] + BombBlaze[i]["RightImpact"] * BlockSize)/BlockSize + 1][4] <= BoxRandRate
			and 0 < mapTable[BombBlaze[i]["Blaze"]["StartY"] / BlockSize + 1][(BombBlaze[i]["Blaze"]["StartX"] + BombBlaze[i]["RightImpact"] * BlockSize)/BlockSize + 1][4]) then
			if(j == 1) then
				mapTable[BombBlaze[i]["Blaze"]["StartY"] / BlockSize + 1][(BombBlaze[i]["Blaze"]["StartX"] + BombBlaze[i]["RightImpact"] * BlockSize)/BlockSize + 1][4] = 1000
				for j = 1,24 do
					if(DynamiteWall[j]["IsWrite"] == 0) then
						DynamiteWall[j]["IsWrite"] = 1
						DynamiteWall[j]:Init(BombBlaze[i]["Blaze"]["StartX"] + BombBlaze[i]["RightImpact"] * BlockSize,BombBlaze[i]["Blaze"]["StartY"])
						break
					end
				end
			end
			BombBlaze[i]["RightImpact"] = BombBlaze[i]["RightImpact"] - 1
			break
		end
		
		if(mapTable[BombBlaze[i]["Blaze"]["StartY"] / BlockSize + 1][(BombBlaze[i]["Blaze"]["StartX"] + BombBlaze[i]["RightImpact"] * BlockSize)/BlockSize + 1][8] <= 7
			and 0 < mapTable[BombBlaze[i]["Blaze"]["StartY"] / BlockSize + 1][(BombBlaze[i]["Blaze"]["StartX"] + BombBlaze[i]["RightImpact"] * BlockSize)/BlockSize + 1][8]) then
			if(j == 1) then
				mapTable[BombBlaze[i]["Blaze"]["StartY"] / BlockSize + 1][(BombBlaze[i]["Blaze"]["StartX"] + BombBlaze[i]["RightImpact"] * BlockSize)/BlockSize + 1][8] = 0
			end
			BombBlaze[i]["RightImpact"] = BombBlaze[i]["RightImpact"] - 1
			break
		end
		
		if(mapTable[BombBlaze[i]["Blaze"]["StartY"] / BlockSize + 1][(BombBlaze[i]["Blaze"]["StartX"] + BombBlaze[i]["RightImpact"] * BlockSize)/BlockSize + 1][7] == 1) then
			if(j == 1) then
				for j = 1,6 do
					if(UserBomb[j]["Bomb"]["StartX"] == BombBlaze[i]["Blaze"]["StartX"] + BombBlaze[i]["RightImpact"] * BlockSize and 
					UserBomb[j]["Bomb"]["StartY"] == BombBlaze[i]["Blaze"]["StartY"]) then
						UserBomb[j]["IsWrite"] = 0
						UserBomb[j]["IsBlast"] = 0
						mapTable[UserBomb[j]["Bomb"]["StartY"]/BlockSize + 1][UserBomb[j]["Bomb"]["StartX"]/BlockSize + 1][7] = 0
						for n = 1,6 do
							if(BombOrder[n] == j) then
								BombOrder[n] = 0
								if n~=6 then
									while(n <= 5) do
										BombOrder[n] = BombOrder[n + 1]
										n = n + 1
									end
								end
								break
							end
						end
						for k = 1,6 do
							if BombBlaze[k]["IsWrite"] == 0 then
								BombBlaze[k]:Init(UserBomb[j]["Bomb"]["StartX"],UserBomb[j]["Bomb"]["StartY"])
								BombBlaze[k]["IsWrite"] = 1
								TestBlazeImpact(k,1)
								break
							end
						end
						break
					end
				end
			end
			BombBlaze[i]["RightImpact"] = BombBlaze[i]["RightImpact"] - 1
			break
		end
		if(j == 0) then
			mapTable[BombBlaze[i]["Blaze"]["StartY"] / BlockSize + 1][(BombBlaze[i]["Blaze"]["StartX"] + BombBlaze[i]["RightImpact"] * BlockSize)/BlockSize + 1][9] = mapTable[BombBlaze[i]["Blaze"]["StartY"] / BlockSize + 1][(BombBlaze[i]["Blaze"]["StartX"] + BombBlaze[i]["RightImpact"] * BlockSize)/BlockSize + 1][9] + 1
		elseif(j == 1) then
			mapTable[BombBlaze[i]["Blaze"]["StartY"] / BlockSize + 1][(BombBlaze[i]["Blaze"]["StartX"] + BombBlaze[i]["RightImpact"] * BlockSize)/BlockSize + 1][9] = mapTable[BombBlaze[i]["Blaze"]["StartY"] / BlockSize + 1][(BombBlaze[i]["Blaze"]["StartX"] + BombBlaze[i]["RightImpact"] * BlockSize)/BlockSize + 1][9] - 1
			mapTable[BombBlaze[i]["Blaze"]["StartY"] / BlockSize + 1][(BombBlaze[i]["Blaze"]["StartX"] + BombBlaze[i]["RightImpact"] * BlockSize)/BlockSize + 1][10] = 1
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
				if(j == 1) then
					mapTable[(BombBlaze[i]["Blaze"]["StartY"] - BombBlaze[i]["DownImpact"] * BlockSize)/BlockSize + 1][BombBlaze[i]["Blaze"]["StartX"]/BlockSize + 1][4] = 1000
					for j = 1,24 do
						if(DynamiteWall[j]["IsWrite"] == 0) then
							DynamiteWall[j]["IsWrite"] = 1
							DynamiteWall[j]:Init(BombBlaze[i]["Blaze"]["StartX"],BombBlaze[i]["Blaze"]["StartY"] - BombBlaze[i]["DownImpact"] * BlockSize)
							break
						end
					end
				end
				BombBlaze[i]["DownImpact"] = BombBlaze[i]["DownImpact"] - 1
				break
			end
			if(mapTable[(BombBlaze[i]["Blaze"]["StartY"] - BombBlaze[i]["DownImpact"] * BlockSize)/BlockSize + 1][BombBlaze[i]["Blaze"]["StartX"]/BlockSize + 1][8] <= 7
				and 0 < mapTable[(BombBlaze[i]["Blaze"]["StartY"] - BombBlaze[i]["DownImpact"] * BlockSize)/BlockSize + 1][BombBlaze[i]["Blaze"]["StartX"]/BlockSize + 1][8]) then
				if(j == 1) then
					mapTable[(BombBlaze[i]["Blaze"]["StartY"] - BombBlaze[i]["DownImpact"] * BlockSize)/BlockSize + 1][BombBlaze[i]["Blaze"]["StartX"]/BlockSize + 1][8] = 0
				end
				BombBlaze[i]["DownImpact"] = BombBlaze[i]["DownImpact"] - 1
				break
			end
			if(mapTable[(BombBlaze[i]["Blaze"]["StartY"] -  BombBlaze[i]["DownImpact"] * BlockSize)/BlockSize + 1][BombBlaze[i]["Blaze"]["StartX"]/BlockSize + 1][7] == 1) then
				if(j == 1) then
					for j = 1,6 do
						if(UserBomb[j]["Bomb"]["StartX"] == BombBlaze[i]["Blaze"]["StartX"] and 
						UserBomb[j]["Bomb"]["StartY"] == BombBlaze[i]["Blaze"]["StartY"] -  BombBlaze[i]["DownImpact"] * BlockSize) then
							UserBomb[j]["IsWrite"] = 0
							UserBomb[j]["IsBlast"] = 0
							mapTable[UserBomb[j]["Bomb"]["StartY"]/BlockSize + 1][UserBomb[j]["Bomb"]["StartX"]/BlockSize + 1][7] = 0
							for n = 1,6 do
								if(BombOrder[n] == j) then
									BombOrder[n] = 0
									if n~=6 then
										while(n <= 5) do
											BombOrder[n] = BombOrder[n + 1]
											n = n + 1
										end
									end
									break
								end
							end
							for k = 1,6 do
								if BombBlaze[k]["IsWrite"] == 0 then
									BombBlaze[k]:Init(UserBomb[j]["Bomb"]["StartX"],UserBomb[j]["Bomb"]["StartY"])
									BombBlaze[k]["IsWrite"] = 1
									TestBlazeImpact(k,1)
									break
								end
							end
							break
						end
					end
				end
				BombBlaze[i]["DownImpact"] = BombBlaze[i]["DownImpact"] - 1
			end
			break
		end
		
		if(mapTable[(BombBlaze[i]["Blaze"]["StartY"] - BombBlaze[i]["DownImpact"] * BlockSize)/BlockSize + 1][BombBlaze[i]["Blaze"]["StartX"]/BlockSize + 1][3] == 1) then
			BombBlaze[i]["DownImpact"] = BombBlaze[i]["DownImpact"] - 1
			break
		end
		
		if(mapTable[(BombBlaze[i]["Blaze"]["StartY"] - BombBlaze[i]["DownImpact"] * BlockSize)/BlockSize + 1][BombBlaze[i]["Blaze"]["StartX"]/BlockSize + 1][4] == 1000) then
			BombBlaze[i]["DownImpact"] = BombBlaze[i]["DownImpact"] - 1
			break
		end		
		
		if(mapTable[(BombBlaze[i]["Blaze"]["StartY"] - BombBlaze[i]["DownImpact"] * BlockSize)/BlockSize + 1][BombBlaze[i]["Blaze"]["StartX"]/BlockSize + 1][8] <= 7
			and 0 < mapTable[(BombBlaze[i]["Blaze"]["StartY"] - BombBlaze[i]["DownImpact"] * BlockSize)/BlockSize + 1][BombBlaze[i]["Blaze"]["StartX"]/BlockSize + 1][8]) then
			if(j == 1) then
				mapTable[(BombBlaze[i]["Blaze"]["StartY"] - BombBlaze[i]["DownImpact"] * BlockSize)/BlockSize + 1][BombBlaze[i]["Blaze"]["StartX"]/BlockSize + 1][8] = 0
			end
			BombBlaze[i]["DownImpact"] = BombBlaze[i]["DownImpact"] - 1
			break
		end
		
		if(mapTable[(BombBlaze[i]["Blaze"]["StartY"] - BombBlaze[i]["DownImpact"] * BlockSize)/BlockSize + 1][BombBlaze[i]["Blaze"]["StartX"]/BlockSize + 1][4] <= BoxRandRate
			and 0 < mapTable[(BombBlaze[i]["Blaze"]["StartY"] - BombBlaze[i]["DownImpact"] * BlockSize)/BlockSize + 1][BombBlaze[i]["Blaze"]["StartX"]/BlockSize + 1][4]) then
			if(j == 1) then
				mapTable[(BombBlaze[i]["Blaze"]["StartY"] - BombBlaze[i]["DownImpact"] * BlockSize)/BlockSize + 1][BombBlaze[i]["Blaze"]["StartX"]/BlockSize + 1][4] = 1000
				for j = 1,24 do
					if(DynamiteWall[j]["IsWrite"] == 0) then
						DynamiteWall[j]["IsWrite"] = 1
						DynamiteWall[j]:Init(BombBlaze[i]["Blaze"]["StartX"],BombBlaze[i]["Blaze"]["StartY"] - BombBlaze[i]["DownImpact"] * BlockSize)
						break
					end
				end
			end
			BombBlaze[i]["DownImpact"] = BombBlaze[i]["DownImpact"] - 1
			break
		end	
		
		if(mapTable[(BombBlaze[i]["Blaze"]["StartY"] -  BombBlaze[i]["DownImpact"] * BlockSize)/BlockSize + 1][BombBlaze[i]["Blaze"]["StartX"]/BlockSize + 1][7] == 1) then
			if(j == 1) then
				for j = 1,6 do
					if(UserBomb[j]["Bomb"]["StartX"] == BombBlaze[i]["Blaze"]["StartX"] and 
					UserBomb[j]["Bomb"]["StartY"] == BombBlaze[i]["Blaze"]["StartY"] -  BombBlaze[i]["DownImpact"] * BlockSize) then
						UserBomb[j]["IsWrite"] = 0
						UserBomb[j]["IsBlast"] = 0
						mapTable[UserBomb[j]["Bomb"]["StartY"]/BlockSize + 1][UserBomb[j]["Bomb"]["StartX"]/BlockSize + 1][7] = 0
						for n = 1,6 do
							if(BombOrder[n] == j) then
								BombOrder[n] = 0
								if n~=6 then
									while(n <= 5) do
										BombOrder[n] = BombOrder[n + 1]
										n = n + 1
									end
								end
								break
							end
						end
						for k = 1,6 do
							if BombBlaze[k]["IsWrite"] == 0 then
								BombBlaze[k]:Init(UserBomb[j]["Bomb"]["StartX"],UserBomb[j]["Bomb"]["StartY"])
								BombBlaze[k]["IsWrite"] = 1
								TestBlazeImpact(k,1)
								break
							end
						end
						break
					end
				end
			end
			BombBlaze[i]["DownImpact"] = BombBlaze[i]["DownImpact"] - 1
			break
		end
		if(j == 0) then
			mapTable[(BombBlaze[i]["Blaze"]["StartY"] -  BombBlaze[i]["DownImpact"] * BlockSize)/BlockSize + 1][BombBlaze[i]["Blaze"]["StartX"]/BlockSize + 1][9] = mapTable[(BombBlaze[i]["Blaze"]["StartY"] -  BombBlaze[i]["DownImpact"] * BlockSize)/BlockSize + 1][BombBlaze[i]["Blaze"]["StartX"]/BlockSize + 1][9] + 1
		elseif(j == 1) then
			mapTable[(BombBlaze[i]["Blaze"]["StartY"] -  BombBlaze[i]["DownImpact"] * BlockSize)/BlockSize + 1][BombBlaze[i]["Blaze"]["StartX"]/BlockSize + 1][9] = mapTable[(BombBlaze[i]["Blaze"]["StartY"] -  BombBlaze[i]["DownImpact"] * BlockSize)/BlockSize + 1][BombBlaze[i]["Blaze"]["StartX"]/BlockSize + 1][9] - 1
			mapTable[(BombBlaze[i]["Blaze"]["StartY"] -  BombBlaze[i]["DownImpact"] * BlockSize)/BlockSize + 1][BombBlaze[i]["Blaze"]["StartX"]/BlockSize + 1][10] = 1
		end
		BombBlaze[i]["DownImpact"] = BombBlaze[i]["DownImpact"] + 1
	end
	if (BombBlaze[i]["DownImpact"] > UserData["Power"]) then
		BombBlaze[i]["DownImpact"] = UserData["Power"]
	end
end