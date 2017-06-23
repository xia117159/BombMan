AllEnemy = {n = 10}

EnemyClass = {
	MoveX = 0,
	MoveY = 0,
	EnemyType = 0,
	Speed = 0,
	Depth = 0,
	IsSurvival = 0,
	CanPassWall = 0,
	ImageStartX = 0,
	ImageStartY = 0,
	MoveDirection = 0, --1为下，2为左，3为右，4为上
	Enemy = {},
	EnemyAnimation = {}
}

function EnemyClass:new()
	o = {}
	setmetatable(o, {__index = self});
	return o;
end

function EnemyClass:Init(x,y,enemytype,depth)
	self.EnemyType = enemytype
	self.Depth = depth
	if enemytype == 1 then
		self.Speed = 1
		self.IsSurvival = 1
		self.CanPassWall = 0
		self.ImageStartX = 0
		self.ImageStartY = 0
	elseif enemytype == 2 then
		self.Speed = 2
		self.IsSurvival = 1
		self.CanPassWall = 0
		self.ImageStartX = 0
		self.ImageStartY = 200
	elseif enemytype == 3 then
		self.Speed = 2
		self.IsSurvival = 1
		self.CanPassWall = 0
		self.ImageStartX = 400
		self.ImageStartY = 0
	elseif enemytype == 4 then
		self.Speed = 2
		self.IsSurvival = 1
		self.CanPassWall = 0
		self.ImageStartX = 400
		self.ImageStartY = 200
	elseif enemytype == 5 then
		self.Speed = 2
		self.IsSurvival = 1
		self.CanPassWall = 1
		self.ImageStartX = 200
		self.ImageStartY = 200
	end

	self.Enemy = AnimationRecord:new();
	self.Enemy:SetValue(x, y, 10, 4);

	self.EnemyAnimation = ImageClass:new();
	self.EnemyAnimation :setImageFileSize(1600, 400);
end

function EnemyInit()
	local j = 1
	local x = 1
	local y = 1
	for i = 1,10 do 
		AllEnemy[i] = EnemyClass:new()
		j = math.random(1,5)
		y = math.random(1,40)
		x = math.random(1,24)
		while((x < 7 and y > 17) or mapTable[x][y][3] == 1 or (mapTable[x][y][4] > 0 and mapTable[x][y][4] <= BoxRandRate)) do
			y = math.random(1,40)
			x = math.random(1,24)
		end
		AllEnemy[i]:Init((y - 1) * 50 ,(x - 1) * 50,j,2.9+i/10)
	end
end

function DrawEnemy()
	for i = 1,10 do
		if(AllEnemy[i]["IsSurvival"] == 1) then
			EnemyMove(i)
			DrawEnemyFunc(i)
		end
	end
end

function DrawEnemyFunc(i)
	local startX = AllEnemy[i]["Enemy"]["StartX"] + originX + AllEnemy[i]["MoveX"]
	local startY = AllEnemy[i]["Enemy"]["StartY"] + originY + AllEnemy[i]["MoveY"]
	local imageStartX = AllEnemy[i]["ImageStartX"]
	local imageStartY = AllEnemy[i]["ImageStartY"] + (AllEnemy[i]["MoveDirection"] - 1) * 50
	local fr = AllEnemy[i]["Enemy"]:TimerGo()
	if fr == 1 then
		AllEnemy[i]["EnemyAnimation"]:setImage(startX , startY , 50 , 50 , imageStartX       , imageStartX + 50  , imageStartY , imageStartY + 50 ,  AllEnemy[i]["Depth"]);
	elseif fr == 2 then
		AllEnemy[i]["EnemyAnimation"]:setImage(startX , startY , 50 , 50 , imageStartX + 50  , imageStartX + 100 , imageStartY , imageStartY + 50 ,  AllEnemy[i]["Depth"]);
	elseif fr == 3 then
		AllEnemy[i]["EnemyAnimation"]:setImage(startX , startY , 50 , 50 , imageStartX + 100 , imageStartX + 150 , imageStartY , imageStartY + 50 ,  AllEnemy[i]["Depth"]);
	elseif fr == 4 then
		AllEnemy[i]["EnemyAnimation"]:setImage(startX , startY , 50 , 50 , imageStartX + 150 , imageStartX + 200 , imageStartY , imageStartY + 50 ,  AllEnemy[i]["Depth"]);
	end
	AllEnemy[i]["EnemyAnimation"]:DrawImage();
end
   
function EnemyMove(i)
	local x = 0
	local y = 0
	local k = 0
	x = AllEnemy[i]["Enemy"]["StartX"] + AllEnemy[i]["MoveX"]
	y = AllEnemy[i]["Enemy"]["StartY"] + AllEnemy[i]["MoveY"]
	if(x % 50 == 0 and y % 50 == 0) then
		AllEnemy[i]["MoveDirection"] = math.random(1,4)
		for j = 1,4 do
			if(TestEnemyImpact(i,x,y,j) == 0) then
				k = k + 1
			end
		end
		if(k == 0) then
			return
		end
		if(AllEnemy[i]["EnemyType"] == 4) then
			while(TestEnemyImpact(i,x,y,AllEnemy[i]["MoveDirection"]) == 1 or PowerfulEnemy(i) == 1) do
				AllEnemy[i]["MoveDirection"] = math.random(1,4)
			end
		elseif(AllEnemy[i]["EnemyType"] == 5) then
			while(TestEnemyImpact(i,x,y,AllEnemy[i]["MoveDirection"]) == 1) do
				AllEnemy[i]["MoveDirection"] = math.random(1,4)
			end
		else
			while(TestEnemyImpact(i,x,y,AllEnemy[i]["MoveDirection"]) == 1) do
				AllEnemy[i]["MoveDirection"] = math.random(1,4)
			end
		end
	end
	if(AllEnemy[i]["MoveDirection"] == 1) then
		AllEnemy[i]["MoveY"] = AllEnemy[i]["MoveY"] - AllEnemy[i]["Speed"]
	elseif(AllEnemy[i]["MoveDirection"] == 2) then
		AllEnemy[i]["MoveX"] = AllEnemy[i]["MoveX"] - AllEnemy[i]["Speed"]
	elseif(AllEnemy[i]["MoveDirection"] == 3) then
		AllEnemy[i]["MoveX"] = AllEnemy[i]["MoveX"] + AllEnemy[i]["Speed"]
	elseif(AllEnemy[i]["MoveDirection"] == 4) then
		AllEnemy[i]["MoveY"] = AllEnemy[i]["MoveY"] + AllEnemy[i]["Speed"]
	end
end

function TestEnemyImpact(i,x,y,j)
	if(j == 1) then
		if(y == 0 or mapTable[(y - 50) / 50 + 1][x / 50 + 1][3] == 1 or mapTable[(y - 50) / 50 + 1][x / 50 + 1][7] == 1 or
		(AllEnemy[i]["CanPassWall"] == 0 and mapTable[(y - 50) / 50 + 1][x / 50 + 1][4] > 0 and  mapTable[(y - 50) / 50 + 1][x / 50 + 1][4] <= BoxRandRate)) then
			return 1
		end
		return 0
	elseif(j == 2) then
		if(x == 0 or mapTable[y / 50 + 1][(x - 50) / 50 + 1][3] == 1 or mapTable[y / 50 + 1][(x - 50) / 50 + 1][7] == 1 or
		(AllEnemy[i]["CanPassWall"] == 0 and mapTable[y / 50 + 1][(x - 50) / 50 + 1][4] > 0 and  mapTable[y / 50 + 1][(x - 50) / 50 + 1][4] <= BoxRandRate)) then
			return 1
		end
		return 0
	elseif(j == 3) then
		if(x + 50 == TotalWidthPixels or mapTable[y / 50 + 1][(x + 50) / 50 + 1][3] == 1 or mapTable[y / 50 + 1][(x + 50) / 50 + 1][7] == 1 or
		(AllEnemy[i]["CanPassWall"] == 0 and mapTable[y / 50 + 1][(x + 50) / 50 + 1][4] > 0 and mapTable[y / 50 + 1][(x + 50) / 50 + 1][4] <= BoxRandRate)) then
			return 1
		end
		return 0
	elseif(j == 4) then
		if(y + 50 == TotalHeightPixels or mapTable[(y + 50) / 50 +1][x / 50 + 1][3] == 1 or mapTable[(y + 50) / 50 +1][x / 50 + 1][7] == 1 or
		(AllEnemy[i]["CanPassWall"] == 0 and mapTable[(y + 50) / 50 +1][x / 50 + 1][4] > 0 and  mapTable[(y + 50) / 50 +1][x / 50 + 1][4] <= BoxRandRate)) then
			return 1
		end
		return 0
	end
end

function PowerfulEnemy(i)
	local enemyX = (AllEnemy[i]["Enemy"]["StartX"] + AllEnemy[i]["MoveX"] - (AllEnemy[i]["Enemy"]["StartX"] + AllEnemy[i]["MoveX"]) % 50) / 50 +1
	local enemyY = (AllEnemy[i]["Enemy"]["StartY"] + AllEnemy[i]["MoveY"] - (AllEnemy[i]["Enemy"]["StartY"] + AllEnemy[i]["MoveY"]) % 50) / 50 +1
	if(AllEnemy[i]["MoveDirection"] == 1) then
		for j = 1,2 do
			if(enemyY - j > 0) then
				if(mapTable[enemyY - j][enemyX][7] == 1) then
					return 1
				end
			end
		end
		return 0
	elseif(AllEnemy[i]["MoveDirection"] == 2) then
		for j = 1,2 do
			if(enemyX - j > 0) then
				if(mapTable[enemyY][enemyX - j][7] == 1) then
					return 1
				end
			end
		end
		return 0
	elseif(AllEnemy[i]["MoveDirection"] == 3) then
		for j = 1,2 do
			if(enemyX + j <= 40) then
				if(mapTable[enemyY][enemyX + j][7] == 1) then
					return 1
				end
			end
		end
		return 0
	elseif(AllEnemy[i]["MoveDirection"] == 4) then
		for j = 1,2 do
			if(enemyY + j <= 24) then
				if(mapTable[enemyY + j][enemyX][7] == 1) then
					return 1
				end
			end
		end
		return 0
	end
end
