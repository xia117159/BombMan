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


require "MainKeyFunc"

require "Recode"



LoadStartViewImageFile();
LoadMapViewImageFile();
LoadShopImageFile();
LoadBakcpackImageFile();



Read()
--Preserve();
goShopView();
--goStartView(); -- 转到开始界面
--GoBackpackVeiw();

