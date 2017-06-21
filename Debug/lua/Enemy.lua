AllEnemy = {n = 10}

EnemyClass = {
	MoveX = 0,
	MoveY = 0,
	EnemyType = 0,
	Speed = 0,
	IsSurvival = 0,
	CanPassWall = 0,
	ImageStartX = 0,
	ImageStartY = 16,
	MoveDirection = 0, --1为右，2为上，3为左，4为下
	Enemy = {},
	EnemyAnimation = {}
}

function EnemyClass:new()
	o = {}
	setmetatable(o, {__index = self});
	return o;
end

function EnemyClass:Init(x,y,enemytype)
	self.EnemyType = enemytype
	if enemytype == 1 then
		self.Speed = 1
		self.IsSurvival = 1
		self.CanPassWall = 0
	elseif enemytype == 2 then
		self.Speed = 2
		self.IsSurvival = 1
		self.CanPassWall = 0
	elseif enemytype == 3 then
		self.Speed = 4
		self.IsSurvival = 1
		self.CanPassWall = 0
	elseif enemytype == 4 then
		self.Speed = 4
		self.IsSurvival = 1
		self.CanPassWall = 0
	elseif enemytype == 5 then
		self.Speed = 2
		self.IsSurvival = 1
		self.CanPassWall = 1
	end

	self.Enemy = AnimationRecord:new();
	self.Enemy:SetValue(x, y, 10, 4);

	self.EnemyAnimation = ImageClass:new();
	self.EnemyAnimation :setImageFileSize(128, 144);
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
		while((x < 7 and y < 7) or mapTable[x][y][3] == 1 or (mapTable[x][y][4] > 0 and mapTable[x][y][4] <= BoxRandRate)) do
			y = math.random(1,40)
			x = math.random(1,24)
		end
		AllEnemy[i]:Init((y - 1) * 50 ,(x - 1) * 50,j)
	end
end

function DrawEnemy()
	for i = 1,10 do
		if(AllEnemy[i]["IsSurvival"] == 1) then
			EnemyMove()
			DrawEnemyFunc(i)
		end
	end
end

function DrawEnemyFunc(i)
	local startX = AllEnemy[i]["Enemy"]["StartX"] + originX + AllEnemy[i]["MoveX"]
	local startY = AllEnemy[i]["Enemy"]["StartY"] + originY + AllEnemy[i]["MoveY"]
	local imageStartX = AllEnemy[i]["ImageStartX"]
	local imageStartY = AllEnemy[i]["ImageStartY"]
	local fr = AllEnemy[i]["Enemy"]:TimerGo()
	if fr == 1 then
		AllEnemy[i]["EnemyAnimation"]:setImage(startX , startY , 50 , 50 , imageStartX 		, imageStartX + 16, imageStartY , imageStartY + 16 ,  2);
	elseif fr == 2 then
		AllEnemy[i]["EnemyAnimation"]:setImage(startX , startY , 50 , 50 , imageStartX + 16 , imageStartX + 32, imageStartY , imageStartY + 16 ,  2);
	elseif fr == 3 then
		AllEnemy[i]["EnemyAnimation"]:setImage(startX , startY , 50 , 50 , imageStartX + 32 , imageStartX + 48, imageStartY , imageStartY + 16 ,  2);
	elseif fr == 4 then
		AllEnemy[i]["EnemyAnimation"]:setImage(startX , startY , 50 , 50 , imageStartX + 48 , imageStartX + 64, imageStartY , imageStartY + 16 ,  2);
	end
	AllEnemy[i]["EnemyAnimation"]:DrawImage();
end

function EnemyMove()
	
	local x = 0
	local y = 0
	for i = 1 , 10 do
		x = AllEnemy[i]["Enemy"]["StartX"] + AllEnemy[i]["MoveX"]
		y = AllEnemy[i]["Enemy"]["StartY"] + AllEnemy[i]["MoveY"]
		if(x % 50 == 0 and y % 50 == 0) then
			AllEnemy[i]["MoveDirection"] = math.random(1,4)
			while(TestEnemyImpact(i,x,y) == 1) do
				AllEnemy[i]["MoveDirection"] = math.random(1,4)
			end
		end
		if(AllEnemy[i]["MoveDirection"] == 1) then
			AllEnemy[i]["MoveX"] = AllEnemy[i]["MoveX"] + AllEnemy[i]["Speed"]
		elseif(AllEnemy[i]["MoveDirection"] == 2) then
			AllEnemy[i]["MoveY"] = AllEnemy[i]["MoveY"] + AllEnemy[i]["Speed"]
		elseif(AllEnemy[i]["MoveDirection"] == 3) then
			AllEnemy[i]["MoveX"] = AllEnemy[i]["MoveX"] - AllEnemy[i]["Speed"]
		elseif(AllEnemy[i]["MoveDirection"] == 4) then
			AllEnemy[i]["MoveY"] = AllEnemy[i]["MoveY"] - AllEnemy[i]["Speed"]
		end
	end
end

function TestEnemyImpact(i,x,y)
	if(AllEnemy[i]["MoveDirection"] == 1) then
		if(x + 50 == TotalWidthPixels or mapTable[y / 50 + 1][(x + 50) / 50 + 1][3] == 1 or mapTable[y / 50 + 1][(x + 50) / 50 + 1][7] == 1 or
		(AllEnemy[i]["CanPassWall"] == 0 and mapTable[y / 50 + 1][(x + 50) / 50 + 1][4] > 0 and mapTable[y / 50 + 1][(x + 50) / 50 + 1][4] < BoxRandRate)) then
			return 1
		end
		return 0
	elseif(AllEnemy[i]["MoveDirection"] == 2) then
		if(y + 50 == TotalHeightPixels or mapTable[(y + 50) / 50 +1][x / 50 + 1][3] == 1 or mapTable[(y + 50) / 50 +1][x / 50 + 1][7] == 1 or
		(AllEnemy[i]["CanPassWall"] == 0 and mapTable[(y + 50) / 50 +1][x / 50 + 1][4] > 0 and  mapTable[(y + 50) / 50 +1][x / 50 + 1][4] < BoxRandRate)) then
			return 1
		end
		return 0
	elseif(AllEnemy[i]["MoveDirection"] == 3) then
		if(x == 0 or mapTable[y / 50 + 1][(x - 50) / 50 + 1][3] == 1 or mapTable[y / 50 + 1][(x - 50) / 50 + 1][7] == 1 or
		(AllEnemy[i]["CanPassWall"] == 0 and mapTable[y / 50 + 1][(x - 50) / 50 + 1][4] > 0 and  mapTable[y / 50 + 1][(x - 50) / 50 + 1][4] < BoxRandRate)) then
			return 1
		end
		return 0
	elseif(AllEnemy[i]["MoveDirection"] == 4) then
		if(y == 0 or mapTable[(y - 50) / 50 + 1][x / 50 + 1][3] == 1 or mapTable[(y - 50) / 50 + 1][x / 50 + 1][7] == 1 or
		(AllEnemy[i]["CanPassWall"] == 0 and mapTable[(y - 50) / 50 + 1][x / 50 + 1][4] > 0 and  mapTable[(y - 50) / 50 + 1][x / 50 + 1][4] < BoxRandRate)) then
			return 1
		end
		return 0
	end
end
