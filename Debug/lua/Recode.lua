--�浵
function Preserve()
	file = io.open("Save/recode.txt","w+") --��д��ʽ�򿪣��ļ��������򴴽����ļ��������������

	io.output(file) --����Ĭ������ļ�

	io.write("GoldCoins = "..UserData["GoldCoins"].."\n")
	
	io.write("AssistantLock = "..UserData["AssistantLock"].."\n")
	
	io.write("AssistantProps = "..UserData["AssistantProps"].."\n")
	
	io.write("BigBombPropsAmount = "..UserData["BigBombPropsAmount"].."\n")
	
	io.write("ShortCutBarBBP = "..UserData["ShortCutBarBBP"].."\n")
	
	io.write("AssistantPropsAmount = "..UserData["AssistantPropsAmount"].."\n")
	
	io.write("ShortCutBarAP = "..UserData["ShortCutBarAP"].."\n")

	io.write("IsPassGame = "..UserData["IsPassGame"].."\n")
	
	io.close(file) --�ر��ļ�
end

--����
function Read()
	file = io.open("Save/recode.txt","r")
	if file == nil then
		return;
	end
	io.input(file)
	
	data = {}
	for i in file:lines() do  --��ȡÿһ��
		table.insert(data,i)
	end
	
	io.close(file)
	
	if table.getn(data) == 8 then
	
		UserData["GoldCoins"] = tonumber(string.match(data[1],"GoldCoins = (%w+)"))
		
		UserData["AssistantLock"] = tonumber(string.match(data[2],"AssistantLock = (%w+)"))
		
		UserData["AssistantProps"] = tonumber(string.match(data[3],"AssistantProps = (%w+)"))
		
		UserData["BigBombPropsAmount"] = tonumber(string.match(data[4],"BigBombPropsAmount = (%w+)"))
		
		UserData["ShortCutBarBBP"] = tonumber(string.match(data[5],"ShortCutBarBBP = (%w+)"))
		
		UserData["AssistantPropsAmount"] = tonumber(string.match(data[6],"AssistantPropsAmount = (%w+)"))
		
		UserData["ShortCutBarAP"] = tonumber(string.match(data[7],"ShortCutBarAP = (%w+)"))
		
		UserData["IsPassGame"] = tonumber(string.match(data[8],"IsPassGame = (%w+)"))
	end
	
end