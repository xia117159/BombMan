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
	MoveDirection = 0,
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
		self.Speed = 2
		self.IsSurvival = 1
		self.CanPassWall = 0
	elseif enemytype == 2 then
		self.Speed = 3
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
	local j = 0
	local x = 0
	local y = 0
	for i = 1,10 do
		AllEnemy[i] = EnemyClass:new()
		j = math.random(1,5)
		x = math.random(1,48)
		y = math.random(1,24)
		while(x < 7 and y < 7) do
			x = math.random(1,48)
			y = math.random(1,24)
		end
		AllEnemy[i]:Init((x - 1) * 50 ,(y - 1) * 50,j)
	end
end

function DrawEnemy()
	for i = 1,10 do
		if(AllEnemy[i]["IsSurvival"] == 1) then
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
