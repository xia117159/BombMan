UserData =
{
	GoldCoins = 0,--金币数量
	AssistantLock = 0, --助手是否被锁住
	AssistantProps = GirlsAssistant,--解锁的助手类型
	BigBombPropsAmount = 0, -- 超级炸弹拥有的个数
	ShortCutBarBBP = 0,--所放置快捷栏
	AssistantPropsAmount = 0, --助手所有个数
	ShortCutBarAP = 0, --所放置快捷栏
	Power = 9, --炸弹威力
	HaveBombNumber = 3, --拥有炸弹个数
	SpeedX = 1.5,
	SpeedY = 1.5

}



MaxPropsAmount = 99;--道具数量最大值

function DetectPropsAmount()
	if UserData["BigBombPropsAmount"] > MaxPropsAmount then
		UserData["BigBombPropsAmount"]  = 99;
	end

	if UserData["AssistantPropsAmount"]  > MaxPropsAmount then
		UserData["AssistantPropsAmount"]  = 99;
	end
	if UserData["AssistantLock"] == 1 then
		UserData["AssistantPropsAmount"] = 0; --助手所有个数
		UserData["ShortCutBarAP"] = 0;--所放置快捷栏
	end
	
	if UserData["GoldCoins"] > 9999 then
		UserData["GoldCoins"] = 9999;
	end
	
end


