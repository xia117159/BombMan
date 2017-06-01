

MovePropsMem = 0


function bpViewKC()
	--[[if KeyDetect(Right) == KeepPressing then
		ksButton:setRelativelyStartPos(CharacterRate, 0.0);
	end--]]
	Result = 0;
	
	--·µ»Ø¼üÇøÓò
	if DetectMousePos(bpReturnButton) == 1 then
		NotReSetbpButton(1);
		
		Result = GetMouseStatus();
		if Result == MouseHover then --Êó±ê×ó¼üÐüÍ£
			bpReturnButton:setImagePos(173.7, 173.7*2, 0, 172);
			if bpReturnButton["Hover"] == 0 then
				bpReturnButton["Hover"] = 1;
				ShoptViewRBse:Play();
			end
			
		elseif Result == MouseLeftDown then --Êó±ê×ó¼ü°´ÏÂ
			bpReturnButton["Event"] = 1;
			bpReturnButton:setImagePos(173.7*2, 173.7*3, 0, 172);
		elseif Result == MouseLeftUp then --Êó±ê×ó¼üËÉ¿ª
			bpReturnButton:setImagePos(0, 173.7, 0, 172);
			if bpReturnButton["Event"] == 1 then
				bpReturnButton["Event"] = 0;
				Gamebgm:Play(ForcedSwitch);
				goShopView();
			end
		end
		
	--³¬¼¶Õ¨µ¯Í¼±êÇøÓò
	elseif DetectMousePos(bpBigBombProps) == 1 then
		
		NotReSetbpButton(2);
		
		Result = GetMouseStatus();
		if Result == MouseHover then --Êó±ê×ó¼üÐüÍ£
			bpBigBombProps:setImagePos(PropsW*1+5, PropsW*2+5, 0, PropsH);
			
			if bpBigBombProps["Hover"] == 0 then
				bpBigBombProps["Hover"] = 1;
				ShoptViewPropsse:Play();
			end
		elseif Result == MouseLeftDown then --Êó±ê×ó¼ü°´ÏÂ
			bpBigBombProps["Event"] = 1;
			bpBigBombPropsTemp["DrawStatus"] = 1;
			MovePropsMem = 1;
			bpBigBombProps:setImagePos(PropsW*0, PropsW*1, 0, PropsH);
		elseif Result == MouseLeftUp then --Êó±ê×ó¼üËÉ¿ª
			bpBigBombProps:setImagePos(PropsW*0, PropsW*1, 0, PropsH);
			bpBigBombPropsTemp["DrawStatus"] = 0;
			if bpBigBombProps["Event"] == 1 then
				bpBigBombProps["Event"] = 0;
				
				
			end
		end
	--ÖúÊÖÍ¼±êÇøÓò
	elseif DetectMousePos(bpAssistantPropsProps) == 1 then
		if UserData["AssistantLock"] == 0 then
			NotReSetbpButton(3);
			
			Result = GetMouseStatus();
			if Result == MouseHover then --Êó±ê×ó¼üÐüÍ£
				bpAssistantPropsProps:setImagePos(PropsW*1+5+OnePropsImageW*AssistantProps, PropsW*2+5+OnePropsImageW*AssistantProps, OnePropsImageH+16, PropsH+OnePropsImageH+16);
				
				if bpAssistantPropsProps["Hover"] == 0 then
					bpAssistantPropsProps["Hover"] = 1;

					ShoptViewPropsse:Play();
				end
			elseif Result == MouseLeftDown then --Êó±ê×ó¼ü°´ÏÂ
				bpAssistantPropsProps["Event"] = 1;
				bpAssistantPropsPropsTemp["DrawStatus"] = 1;
				MovePropsMem = 2;
				bpAssistantPropsProps:setImagePos(PropsW*0+OnePropsImageW*AssistantProps, PropsW*1+OnePropsImageW*AssistantProps, OnePropsImageH+16, PropsH+OnePropsImageH+16);
			elseif Result == MouseLeftUp then --Êó±ê×ó¼üËÉ¿ª
				bpAssistantPropsProps:setImagePos(PropsW*0+OnePropsImageW*AssistantProps, PropsW*1+OnePropsImageW*AssistantProps, OnePropsImageH+16, PropsH+OnePropsImageH+16);
				bpAssistantPropsPropsTemp["DrawStatus"] = 0;
				if bpAssistantPropsProps["Event"] == 1 then
					bpAssistantPropsProps["Event"] = 0;
				end
			end
		end
	--¿ì½Ý¼ü1ÇøÓò
	elseif DetectMousePos(bpShortCutBar1) == 1 then
		if UserData["AssistantLock"] == 0 then
			NotReSetbpButton(3);
			
			Result = GetMouseStatus();
			if Result == MouseLeftDown then --Êó±ê×ó¼ü°´ÏÂ
				bpShortCutBar1["Event"] = 1;
				
			elseif Result == MouseLeftUp then --Êó±ê×ó¼üËÉ¿ª
				bpBigBombPropsTemp["DrawStatus"] = 0;
				bpAssistantPropsPropsTemp["DrawStatus"] = 0;
				if bpShortCutBar1["Event"] == 1 then
					bpShortCutBar1["Event"] = 0;
					UserData["ShortCutBarBBP"] = 1;
					
				end
				
				if UserData["ShortCutBarBBP"] == 2 or UserData["ShortCutBarAP"] == 2 then
					bpShortCutBar2:setImagePos(ShortCutBarW*3, ShortCutBarW*4,0, ShortCutBarH);
				end
			
				if MovePropsMem == 1 and UserData["BigBombPropsAmount"] >= 1 then
					MovePropsMem = 0;

					UserData["ShortCutBarBBP"] = 1;
					if UserData["ShortCutBarAP"] == 1 then
						UserData["ShortCutBarAP"] = 0;
						bpAssistantPropsPropsSCB["DrawStatus"] = 0;
					end
				elseif  MovePropsMem == 2 and UserData["AssistantPropsAmount"] >= 1 then
					MovePropsMem = 0;

					UserData["ShortCutBarAP"] = 1;
					if UserData["ShortCutBarBBP"] == 1 then
						UserData["ShortCutBarBBP"] = 0;
						bpBigBombPropsSCB["DrawStatus"] = 0;
					end
				end
			end
		end
	--¿ì½Ý¼ü2ÇøÓò
	elseif DetectMousePos(bpShortCutBar2) == 1 then
		if UserData["AssistantLock"] == 0 then
			NotReSetbpButton(3);
			
			Result = GetMouseStatus();
			if Result == MouseLeftDown then --Êó±ê×ó¼ü°´ÏÂ
				bpShortCutBar2["Event"] = 1;
			elseif Result == MouseLeftUp then --Êó±ê×ó¼üËÉ¿ª
				bpBigBombPropsTemp["DrawStatus"] = 0;
				bpAssistantPropsPropsTemp["DrawStatus"] = 0;
				if bpShortCutBar2["Event"] == 1 then
					bpShortCutBar2["Event"] = 0;
				end

				if UserData["ShortCutBarBBP"] == 1 or UserData["ShortCutBarAP"] == 1 then
					bpShortCutBar1:setImagePos(ShortCutBarW*3, ShortCutBarW*4,0, ShortCutBarH);
				end
				
				if MovePropsMem == 1 and UserData["BigBombPropsAmount"] >= 1 then
					MovePropsMem = 0;
					UserData["ShortCutBarBBP"] = 2;
					if UserData["ShortCutBarAP"] == 2 then
						UserData["ShortCutBarAP"] = 0;
						bpAssistantPropsPropsSCB["DrawStatus"] = 0;
					end
				elseif  MovePropsMem == 2  and UserData["AssistantPropsAmount"] >= 1 then
					MovePropsMem = 0;
					UserData["ShortCutBarAP"] = 2;
					if UserData["ShortCutBarBBP"] == 2 then
						UserData["ShortCutBarBBP"] = 0;
						bpBigBombPropsSCB["DrawStatus"] = 0;
					end
				end
			end
		end
	else
		Result = GetMouseStatus();
		if Result == MouseLeftUp then
			bpBigBombPropsTemp["DrawStatus"] = 0;
			bpAssistantPropsPropsTemp["DrawStatus"] = 0;
			if DetectMouseUpSCBPos(MovePropsMouseX, MovePropsMouseY) == 0 then
				
				bpShortCutBar1:setImagePos(ShortCutBarW*1, ShortCutBarW*2,0, ShortCutBarH);
				bpShortCutBar2:setImagePos(ShortCutBarW*3, ShortCutBarW*4,0, ShortCutBarH);
				
				if MovePropsMem == 1 then
					MovePropsMem = 0;
					UserData["ShortCutBarBBP"] = 0;
					bpBigBombPropsSCB["DrawStatus"] = 0;

				elseif  MovePropsMem == 2 then
					MovePropsMem = 0;
					UserData["ShortCutBarAP"] = 0;
					bpAssistantPropsPropsSCB["DrawStatus"] = 0;
				end
				
			end
		end
		
		NotReSetbpButton(0);
	end
	
end	

function NotReSetbpButton(value)

	if value ~= 1 then
		bpReturnButton:setImagePos(0, 173.7, 0, 172);
		bpReturnButton["Hover"] = 0;
		
	end
	if value ~= 2 then
		bpBigBombProps["Hover"] = 0;
		bpBigBombProps:setImagePos(0, bpPropsW, 0, bpPropsH);
	end

	if value ~= 3 then
		bpAssistantPropsProps["Hover"] = 0;
		bpAssistantPropsProps:setImagePos(0+bpOnePropsImageW*AssistantProps, bpPropsW+bpOnePropsImageW*AssistantProps, bpOnePropsImageH+16, bpPropsH+bpOnePropsImageH+16);
	end
end


function DetectMouseUpSCBPos(X, Y)
	if bpShortCutBar1["StartX"] < X and X  < (bpShortCutBar1["StartX"] + bpShortCutBar1["Width"]) and bpShortCutBar1["StartY"] < Y and Y < (bpShortCutBar1["StartY"] + bpShortCutBar1["Height"])   then
		return 1;
	elseif bpShortCutBar2["StartX"] < X and X < (bpShortCutBar2["StartX"] + bpShortCutBar2["Width"]) and bpShortCutBar2["StartY"] < Y and Y < (bpShortCutBar2["StartY"] + bpShortCutBar2["Height"])   then
		
		return 2;
	end
	return 0;
end

















