require "include"
require "ImageClass"
require "MusicClass"
require "ActorAssistant"
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


--LoadBombImageFile();
LoadStartViewImageFile();
LoadMapViewImageFile();
LoadShopImageFile();
LoadBakcpackImageFile();



Read()
--Preserve();
--goShopView();;
goStartView(); -- ת����ʼ����
UserBomb = AllBombClass:new();
BombBlaze = AllBlazeClass:new();

Init()



