UserData =
{
	GoldCoins = 9999,--�������
	AssistantLock = 1, --�����Ƿ���ס
	AssistantProps = GirlsAssistant,--��������������
	BigBombPropsAmount = 0, -- ����ը��ӵ�еĸ���
	ShortCutBarBBP = 1,--�����ÿ����
	AssistantPropsAmount = 0, --�������и���
	ShortCutBarAP = 2, --�����ÿ����
	Power = 8, --ը������
	HaveBombNumber = 6, --ӵ��ը������
	SpeedX = 2, --X���ٶ�
	SpeedY = 2, --Y���ٶ�
	CanPassBomb = 0, --�ܷ�ͨ��ը��
	CanPassWall = 0, --�ܷ�ͨ��ǽ
	TimeBomb = 1,    --��û�ж�ʱը��
	HaveProtect = 0,  --��û�б���
    IsPassGame = 0 --�Ƿ�ͨ��
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


