require "include"
require "ImageClass"
require "MusicClass"
require "UserData"


require "StartView"
require "StartKeyControl"
require "Map"


require "ShopView"
require "ShopKeyControl"

require "BackpackVeiw"
require "BackpackKeyControl"


require "MainKeyFunc"
require "Bomb"

require "Recode"
Read()
--Preserve();
--goShopView();;
goStartView(); -- 转到开始界面
UserBomb = AllBombClass:new();
BombBlaze = AllBlazeClass:new();
Init()
UserBomb[1]:Init(600,300)
UserBomb[1]["IsWrite"] = 1

UserBomb[2]:Init(400,200)
UserBomb[2]["IsWrite"] = 1

LoadBombImageFile();
