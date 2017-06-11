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

require "Recode"


LoadThisBackGroundImage();


--[[
LoadStartViewImageFile();
LoadMapViewImageFile();
LoadShopImageFile();
LoadBakcpackImageFile();
--]]



Read()
--Preserve();
--goShopView();
--goStartView(); -- 转到开始界面
--GoBackpackVeiw();

GoLoadView();