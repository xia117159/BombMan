UserData =
{
	GoldCoins = 0,--�������
	AssistantLock = 0, --�����Ƿ���ס
	AssistantProps = GirlsAssistant,--��������������
	BigBombPropsAmount = 0, -- ����ը��ӵ�еĸ���
	ShortCutBarBBP = 0,--�����ÿ����
	AssistantPropsAmount = 0, --�������и���
	ShortCutBarAP = 0, --�����ÿ����
	Power = 9, --ը������
	HaveBombNumber = 3, --ӵ��ը������
	SpeedX = 1.5,
	SpeedY = 1.5

}



MaxPropsAmount = 99;--�����������ֵ

function DetectPropsAmount()
	if UserData["BigBombPropsAmount"] > MaxPropsAmount then
		UserData["BigBombPropsAmount"]  = 99;
	end

	if UserData["AssistantPropsAmount"]  > MaxPropsAmount then
		UserData["AssistantPropsAmount"]  = 99;
	end
	if UserData["AssistantLock"] == 1 then
		UserData["AssistantPropsAmount"] = 0; --�������и���
		UserData["ShortCutBarAP"] = 0;--�����ÿ����
	end
	
	if UserData["GoldCoins"] > 9999 then
		UserData["GoldCoins"] = 9999;
	end
	
end


