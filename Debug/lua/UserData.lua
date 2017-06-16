UserData =
{
	GoldCoins = 9999,--金币数量
	AssistantLock = 0, --助手是否被锁住
	AssistantProps = GirlsAssistant,--解锁的助手类型
	BigBombPropsAmount = 0, -- 超级炸弹拥有的个数
	ShortCutBarBBP = 0,--所放置快捷栏
	AssistantPropsAmount = 0, --助手所有个数
	ShortCutBarAP = 0, --所放置快捷栏
	Power = 1, --炸弹威力
	HaveBombNumber = 1, --拥有炸弹个数
	SpeedX = 2, --X轴速度
	SpeedY = 2, --Y轴速度
	CanPassBomb = 0, --能否通过炸弹
	CanPassWall = 0, --能否通过墙
	TimeBomb = 0,    --有没有定时炸弹
	HaveProtect = 0  --有没有保护
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


