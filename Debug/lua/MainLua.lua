require "include"
require "ImageClass"
require "MusicClass"
require "ActorAssistant"
require "BossClass"
require "UserData"




require "StartView"
require "StartKeyControl"
require "Map"


require "ShopView"
require "ShopKeyControl"

require "BackpackVeiw"
require "BackpackKeyControl"


require "LoadView"

require "MainKeyFunc"
require "Bomb"

require "Recode"


LoadThisBackGroundImage();





Read()

UserBomb = AllBombClass:new();
BombBlaze = AllBlazeClass:new();

Init()



GoLoadView();