ActorClass = 
{
	AcStPosX = 0;
	AcStPosY = 1200;
	actorWindowPosX = 0;
	actorWindowPosY = 600;
}

function ActorClass:moveTOALL(mx,my)
	self.AcStPosX = self.AcStPosX+mx;
	self.AcStPosY = self.AcStPosY+my;
	self.actorWindowPosX = self.actorWindowPosX+mx;	
	self.actorWindowPosY = self.actorWindowPosY+my;		
end

function ActorClass:getWindowPosX()
	return self.actorWindowPosX;
end

function ActorClass:getWindowPosY()
	return self.actorWindowPosY;
end

function ActorClass:getAbsolutePosX()
	return self.AcStPosX;
end

function ActorClass:getAbsolutePosY()
	return self.AcStPosY;
end

function ActorClass:setAbsolutePos(ax,ay)
	self.AcStPosX = ax;
	self.AcStPosY = ay;
end

function ActorClass:setAbsoluteWindowPos(wx,wy)
	self.actorWindowPosX = wx;
	self.actorWindowPosY = wy;
end

function ActorClass:setRelativeWindowPos(wx,wy)
	self.actorWindowPosX = self.actorWindowPosX+wx;
	self.actorWindowPosY = self.actorWindowPosY+wy;
end

function ActorClass:setRelativePos(rx,ry)
	self.AcStPosX = self.AcStPosX+rx;
	self.AcStPosY = self.AcStPosY+ry;
end

function ActorClass:new()
	lk = {};
	setmetatable(lk, {__index = self});
	return lk;
end


AssistantClass = 
{
	AcStPosX = 500,
	AcStPosY = 1000,
	assistantDeath = true
}

function AssistantClass:moveTOALL(mx,my)
	self.AcStPosX = self.AcStPosX+mx;
	self.AcStPosY = self.AcStPosY+my;
	self.actorWindowPosX = self.actorWindowPosX+mx;	
	self.actorWindowPosY = self.actorWindowPosY+my;		
end


function AssistantClass:getAbsolutePosX()
	return self.AcStPosX;
end

function AssistantClass:getAbsolutePosY()
	return self.AcStPosY;
end

function AssistantClass:setAbsolutePos(ax,ay)
	self.AcStPosX = ax;
	self.AcStPosY = ay;
end


function AssistantClass:setRelativePos(rx,ry)
	self.AcStPosX = self.AcStPosX+rx;
	self.AcStPosY = self.AcStPosY+ry;
end

function DrawAssistant()
    
    if AssistantSwitch then
        if ISGameNotPause then
            AssistantMoveDirection = 0;	--助手移动方向	
	        AssistantAlgorithms();  --助手算法
	
	        if AssistantMoveDirection == 1 then		--1表示向右，2表示向上，3表示向左，4表示向下
		        if WindowMoveChecking(1) then	
			        DrawActorGesture(0, 0, Actor2:TimerGo(), 1, Assistantimg);				
		        else 	
			        DrawActorGesture(AssistantUnitXOffset, 0, Actor2:TimerGo(), 1, Assistantimg);			
		        end	
	        --	Assistantimg:setRelativelyStartPos(UnitXOffset,0);
		        assistantinf:setRelativePos(AssistantUnitXOffset,0);	
	        elseif AssistantMoveDirection == 2 then
		        if WindowMoveChecking(2) then	
			        DrawActorGesture(0, 0, Actor2:TimerGo(), 2, Assistantimg);				
		        else 	
			        DrawActorGesture(0, AssistantUnitYOffset, Actor2:TimerGo(), 2, Assistantimg);			
		        end	
		        assistantinf:setRelativePos(0,AssistantUnitYOffset);	
	        elseif	AssistantMoveDirection == 3 then
		        if WindowMoveChecking(3) then	
			        DrawActorGesture(0, 0, Actor2:TimerGo(), 3, Assistantimg);				
		        else 	
			        DrawActorGesture(-AssistantUnitXOffset, 0, Actor2:TimerGo(), 3, Assistantimg);			
		        end	
		        assistantinf:setRelativePos(-AssistantUnitXOffset,0);	
	        elseif	AssistantMoveDirection == 4 then
		        if WindowMoveChecking(4) then	
			        DrawActorGesture(0, 0, Actor2:TimerGo(), 4, Assistantimg);				
		        else 	
			        DrawActorGesture(0, -AssistantUnitYOffset, Actor2:TimerGo(), 4, Assistantimg);			
		        end	
		        assistantinf:setRelativePos(0,-AssistantUnitYOffset);	
	        elseif	AssistantMoveDirection == 0 then
		        if AssistantLastDirection == 1 then
			        Assistantimg:setImagePos(ActorWidth*0, ActorWidth*1, ActorHeight*5, ActorHeight*6);
		        elseif 	AssistantLastDirection == 2 then
			        Assistantimg:setImagePos(ActorWidth*0, ActorWidth*1, ActorHeight*1, ActorHeight*2);
		        elseif	AssistantLastDirection == 3 then
			        Assistantimg:setImagePos(ActorWidth*0, ActorWidth*1, ActorHeight*2, ActorHeight*3);
		        elseif	AssistantLastDirection == 4 then	
			        Assistantimg:setImagePos(ActorWidth*0, ActorWidth*1, ActorHeight*0, ActorHeight*1);
		        end	
              --  DrawActorGesture(0, 0, Actor2:TimerGo(false), 6, Assistantimg);
	        end
	        if AssistantMoveDirection ~= 0 then
		        AssistantLastDirection = AssistantMoveDirection;
	        end		
	        Assistantimg:setAbsoluteStartPos(assistantinf:getAbsolutePosX()+originX,assistantinf:getAbsolutePosY()+originY-BlockSize);	
        end       
	    Assistantimg:DrawImage();
    end
   
end

function AssistantPutBomb()
    local BombX = 0
	local BombY = 0
	while(BombX <= TotalWidthPixels) do
		if(BombX <= assistantinf["AcStPosX"] + 25 and assistantinf["AcStPosX"] + 25 < BombX + 50) then
			break
		end
		BombX = BombX + 50
	end
	while(BombY <= TotalHeightPixels) do
		if(BombY <= assistantinf["AcStPosY"] - 25 and assistantinf["AcStPosY"] - 25 < BombY + 50) then
			break
		end
		BombY = BombY + 50
	end
	if(mapTable[BombY/BlockSize + 1][BombX/BlockSize + 1][7] ~= 1) then
		if(UserBomb[7]["IsWrite"] == 0) then
			UserBomb[7]:Init(BombX,BombY)
			UserBomb[7]["IsWrite"] = 1
			mapTable[BombY/BlockSize + 1][BombX/BlockSize + 1][7] = 1
            for j = 17,24 do
                if(BombBlaze[j]["IsWrite"] == 2) then
				    if(BombBlaze[j]["UpImpact"] > 0) then
                        for k = 1,BombBlaze[j]["UpImpact"] do
                            mapTable[(BombBlaze[j]["Blaze"]["StartY"] + k * 50) / 50 + 1][BombBlaze[j]["Blaze"]["StartX"] / 50 +1][9] = mapTable[(BombBlaze[j]["Blaze"]["StartY"] + k * 50) / 50 + 1][BombBlaze[j]["Blaze"]["StartX"] / 50 +1][9] - 1
                        end
                    end
                    if(BombBlaze[j]["LeftImpact"] > 0) then
                        for k = 1,BombBlaze[j]["LeftImpact"] do
                            mapTable[BombBlaze[j]["Blaze"]["StartY"] / 50 + 1][(BombBlaze[j]["Blaze"]["StartX"] - k * 50) / 50 +1][9] = mapTable[BombBlaze[j]["Blaze"]["StartY"] / 50 + 1][(BombBlaze[j]["Blaze"]["StartX"] - k * 50) / 50 +1][9] - 1
                        end
                    end
                    if(BombBlaze[j]["RightImpact"] > 0) then
                        for k = 1,BombBlaze[j]["RightImpact"] do
                            mapTable[BombBlaze[j]["Blaze"]["StartY"] / 50 + 1][(BombBlaze[j]["Blaze"]["StartX"] + k * 50) / 50 +1][9] = mapTable[BombBlaze[j]["Blaze"]["StartY"] / 50 + 1][(BombBlaze[j]["Blaze"]["StartX"] + k * 50) / 50 +1][9] - 1
                        end
                    end
                    if(BombBlaze[j]["DownImpact"] > 0) then
                        for k = 1,BombBlaze[j]["DownImpact"] do
                            mapTable[(BombBlaze[j]["Blaze"]["StartY"] - k * 50) / 50 + 1][BombBlaze[j]["Blaze"]["StartX"] / 50 +1][9] = mapTable[(BombBlaze[j]["Blaze"]["StartY"] - k * 50) / 50 + 1][BombBlaze[j]["Blaze"]["StartX"] / 50 +1][9] - 1
                        end
                    end
			    end
            end
		    for j = 17,24 do
		        if(BombBlaze[j]["IsWrite"] == 0) then
				    BombBlaze[j]:Init(BombX,BombY)
                    BombBlaze[j]["IsWrite"] = 2
                    break
			    end
		    end
            for j = 17,24 do
			    if(BombBlaze[j]["IsWrite"] == 2) then
                    TestBlazeImpact(j,0)
			    end
		    end
	    end
    end
end




function OneBoxChecking(CheckBlockRow,CheckBlockColumn)
    if CheckBlockRow <= TotalRows and CheckBlockRow > 0 and CheckBlockColumn <= TotalLines and CheckBlockColumn > 0 then
        if (0 == mapTable[CheckBlockRow][CheckBlockColumn][4] or mapTable[CheckBlockRow][CheckBlockColumn][4] > BoxRandRate) and mapTable[CheckBlockRow][CheckBlockColumn][10] == 0 and mapTable[CheckBlockRow][CheckBlockColumn][7] == 0 then
            assistantinf:setAbsolutePos((CheckBlockColumn-1)*BlockSize,CheckBlockRow*BlockSize);
            Assistantimg:setAbsoluteStartPos(assistantinf:getAbsolutePosX()+originX,assistantinf:getAbsolutePosY()+originY-BlockSize);
            return true;
        end
    end
    return false;
end

function OneRoundSearch(CenterRow,CenterColumn,CheckBlockRow,CheckBlockColumn,t)
            --右上方的点
            CheckBlockRow  = CenterRow+1+t;
            CheckBlockColumn  = CenterColumn+1+t;
            if OneBoxChecking(CheckBlockRow,CheckBlockColumn) then  --找到可落脚点
                return true;              
            end
            --右下方的点
            CheckBlockRow  = CenterRow-1-t;
            CheckBlockColumn  = CenterColumn+1+t;                 
            if OneBoxChecking(CheckBlockRow,CheckBlockColumn) then  --找到可落脚点
                return true;
            end
            --左上方的点
            CheckBlockRow  = CenterRow+1+t;
            CheckBlockColumn  = CenterColumn-1-t;  
            if OneBoxChecking(CheckBlockRow,CheckBlockColumn) then  --找到可落脚点
                return true;                     
            end
            --左下方的点
            CheckBlockRow  = CenterRow-1-t;
            CheckBlockColumn  = CenterColumn-1-t;  
            if OneBoxChecking(CheckBlockRow,CheckBlockColumn) then  --找到可落脚点
                return true;
            end

            return false;
end


-- CenterRow表示扩散中心行 CenterColumn表示扩散中心列 SetType表示扩散类型：1表示斜方向以2为基数扩散 0表示斜方向以1为基数扩散 RoundNumber表示扩散轮数
function  CheckingAvaliableAssistantPos(CenterRow,CenterColumn,SetType,RoundNumber)
    local i;
    local j;
    local CheckBlockRow;
    local CheckBlockColumn;
    if SetType == 0 then
        for j=1,RoundNumber do    
            if OneRoundSearch(CenterRow,CenterColumn,CheckBlockRow,CheckBlockColumn,j) then
                return;
            end
        end
       
    else 
        for j=1,RoundNumber do    
            if OneRoundSearch(CenterRow,CenterColumn,CheckBlockRow,CheckBlockColumn,j*2-1) then
                return;
            end
        end
    end
end

function InitAssistantPos(RoundNumber) --初始化助手位置RoundNumber代表扩散轮数
    if ActorHaveUnitStatus == 1 then
      if ActorHOneBoxNoIronCaculate(ActorRow1,ActorColumn1) == 3 then
         CheckingAvaliableAssistantPos(ActorRow1,ActorColumn1,1,RoundNumber);
      else
         CheckingAvaliableAssistantPos(ActorRow1,ActorColumn1,0,RoundNumber);
      end     
    elseif  ActorHaveUnitStatus == 2 then
        if ActorColumn1 % 2 == 0 then
            CheckingAvaliableAssistantPos(ActorRow1,ActorColumn1,0,RoundNumber);
        else
            CheckingAvaliableAssistantPos(ActorRow1,ActorColumn2,0,RoundNumber);
        end
    elseif  ActorHaveUnitStatus == 3 then
        if ActorRow1 % 2 == 0 then
            CheckingAvaliableAssistantPos(ActorRow1,ActorColumn1,0,RoundNumber);
        else
            CheckingAvaliableAssistantPos(ActorRow2,ActorColumn1,0,RoundNumber);
        end
    end
    AssistantSwitch = true;

end


function AssistantAlgorithms()
	--[[local AssistantRow1;	--助手所占第一个位置的地图X坐标
	local AssistantRow2;	--助手所占第二个位置的地图X坐标(AssistantRow1下面一行)
	local AssistantColumn1;	--助手所占第一个位置的地图Y坐标
	local AssistantColumn2;	--助手所占第二个位置的地图Y坐标(AssistantColumn1右面一列)
	-- 2代表所占水平方向两格且位置为mapTable[ActorRow1][ActorColumn1]，mapTable[ActorRow1][ActorColumn2]
	-- 3代表所占竖直方向两格且位置为mapTable[ActorRow1][ActorColumn1]，mapTable[ActorRow2][ActorColumn1]
	local AssistantHaveUnitStatus;	--助手所占格数状况 1代表所占一格 2代表所占水平方向两格 3代表所占竖直方向两格
	local AssistantMoveDirection;	--助手移动方向
	local ISPutBomb = false;	--助手是否放置炸弹
	local AvoidMark = 0; --退避标注位 0代表不退避(主动) 1代表火焰退避 2代表怪物退避 
	AssistantHaveUnitStatus,AssistantRow1,AssistantColumn1,AssistantRow2,AssistantColumn2 = GetObjectHaveBlock(assistantinf:getAbsolutePosX(),assistantinf:getAbsolutePosY());--]]
	
	-- AssistantRow1;	助手所占第一个位置的地图X坐标
	-- AssistantRow2;	助手所占第二个位置的地图X坐标(AssistantRow1下面一行)
	-- AssistantColumn1;	助手所占第一个位置的地图Y坐标
	-- AssistantColumn2;	助手所占第二个位置的地图Y坐标(AssistantColumn1右面一列)
	-- 2代表所占水平方向两格且位置为mapTable[ActorRow1][ActorColumn1]，mapTable[ActorRow1][ActorColumn2]
	-- 3代表所占竖直方向两格且位置为mapTable[ActorRow1][ActorColumn1]，mapTable[ActorRow2][ActorColumn1]
	-- AssistantHaveUnitStatus;	助手所占格数状况 1代表所占一格 2代表所占水平方向两格 3代表所占竖直方向两格
	local TempRandRate;
    local AssistantWillMoveDirection;
    AvoidMark = 0; --退避标注位 0代表不退避(主动) 1代表火焰退避 2代表怪物退避 
	AssistantHaveUnitStatus,AssistantRow1,AssistantColumn1,AssistantRow2,AssistantColumn2 = GetObjectHaveBlock(assistantinf:getAbsolutePosX(),assistantinf:getAbsolutePosY());
    AvoidBlaze(8);
	
	if AvoidMark == 1 then	--需要进行火焰退避
		if AssistantHaveUnitStatus == 1 then 
			if AssistantRow1 == DestinationBlockRow then --若目的格与助手所在格行相同
				if AssistantColumn1 < DestinationBlockColumn then	--若助手所在列小于目的格所在列
					AssistantMoveDirection = 1; --助手向右移动
				else    AssistantMoveDirection = 3; --助手向左移动
				end
			elseif AssistantColumn1 == DestinationBlockColumn then --若目的格与助手所在格列相同
				if 	AssistantRow1 < DestinationBlockRow then  --若助手所在行小于目的格所在行
					AssistantMoveDirection = 2;
				else	AssistantMoveDirection = 4;
				end
			end
		elseif 	AssistantHaveUnitStatus == 2 then --若助手占位于水平两格
			if AssistantColumn1 == DestinationBlockColumn then --若助手所在的第一列就为目的列，则说明助手该左移
				AssistantMoveDirection = 3; 
			else	AssistantMoveDirection = 1;
			end
		elseif	AssistantHaveUnitStatus == 3 then --若助手占位于竖直两格
			if AssistantRow1 == DestinationBlockRow then --若助手所在的第一行就为目的行，则说明助手该下移
				AssistantMoveDirection = 2; 
			else	AssistantMoveDirection = 4;
			end
		end
	end
	
    if AvoidMark == 0 then  --不需要进行火焰退避，助手进入主动状态
        if AssistantHaveUnitStatus ~= 1 then --助手位于两格，则沿着原方向移动
           AssistantMoveDirection =  AssistantLastDirection;
        else    --助手位于一个格子
            AssistantWillMoveDirection = math.random(1,2);	--1代表助手向上移动或向右移动，2代表向下移动或向左移动
            if ActorHOneBoxNoIronCaculate(AssistantRow1,AssistantColumn1) == 1 then  --助手只能竖直移动            
                    if AssistantWillMoveDirection == 1 and AssistantRow1+1 <= TotalRows then
                         if   mapTable[AssistantRow1+1][AssistantColumn1][3] == 0 and (mapTable[AssistantRow1+1][AssistantColumn1][4] > BoxRandRate or mapTable[AssistantRow1+1][AssistantColumn1][4] == 0)
                         and mapTable[AssistantRow1+1][AssistantColumn1][7] == 0 and mapTable[AssistantRow1+1][AssistantColumn1][10] == 0 and mapTable[AssistantRow1+1][AssistantColumn1][9] == 0 then --助手希望往上移动且能往上方移动
                             AssistantMoveDirection = 2;    
                         end
                    end
                    if AssistantWillMoveDirection == 2 and AssistantRow1-1 > 0 then
                         if  mapTable[AssistantRow1-1][AssistantColumn1][3] == 0 and (mapTable[AssistantRow1-1][AssistantColumn1][4] > BoxRandRate or mapTable[AssistantRow1-1][AssistantColumn1][4] == 0)
                         and mapTable[AssistantRow1-1][AssistantColumn1][7] == 0 and mapTable[AssistantRow1-1][AssistantColumn1][10] == 0 and mapTable[AssistantRow1-1][AssistantColumn1][9] == 0 then --助手希望往下移动且能往下方移动
                              AssistantMoveDirection = 4;
                         end
                    end    
            elseif ActorHOneBoxNoIronCaculate(AssistantRow1,AssistantColumn1) == 2 then  --助手只能水平移动
                if AssistantWillMoveDirection == 1 and AssistantColumn1+1 <= TotalLines then
                         if   mapTable[AssistantRow1][AssistantColumn1+1][3] == 0 and (mapTable[AssistantRow1][AssistantColumn1+1][4] > BoxRandRate or mapTable[AssistantRow1][AssistantColumn1+1][4] == 0)
                         and mapTable[AssistantRow1][AssistantColumn1+1][7] == 0 and mapTable[AssistantRow1][AssistantColumn1+1][10] == 0 and mapTable[AssistantRow1][AssistantColumn1+1][9] == 0 then --助手希望往右移动且能往右方移动
                             AssistantMoveDirection = 1;    
                         end
                end
                if AssistantWillMoveDirection == 2 and AssistantColumn1-1 > 0 then
                         if  mapTable[AssistantRow1][AssistantColumn1-1][3] == 0 and (mapTable[AssistantRow1][AssistantColumn1-1][4] > BoxRandRate or mapTable[AssistantRow1][AssistantColumn1-1][4] == 0)
                         and mapTable[AssistantRow1][AssistantColumn1-1][7] == 0 and mapTable[AssistantRow1][AssistantColumn1-1][10] == 0 and mapTable[AssistantRow1][AssistantColumn1-1][9] == 0 then --助手希望往左移动且能往左方移动
                              AssistantMoveDirection = 3;
                         end
                end 
            else 
                AssistantWillMoveDirection = math.random(1,4);
                if AssistantWillMoveDirection == 1 and AssistantColumn1+1 <= TotalLines then
                    if mapTable[AssistantRow1][AssistantColumn1+1][3] == 0 and (mapTable[AssistantRow1][AssistantColumn1+1][4] > BoxRandRate or mapTable[AssistantRow1][AssistantColumn1+1][4] == 0)
                       and mapTable[AssistantRow1][AssistantColumn1+1][7] == 0 and mapTable[AssistantRow1][AssistantColumn1+1][10] == 0 and mapTable[AssistantRow1][AssistantColumn1+1][9] == 0 then --助手希望往右移动且能往右方移动
                          AssistantMoveDirection = 1;    
                    end
                elseif  AssistantWillMoveDirection == 2 and AssistantRow1+1 <= TotalRows then
                    if mapTable[AssistantRow1+1][AssistantColumn1][3] == 0 and (mapTable[AssistantRow1+1][AssistantColumn1][4] > BoxRandRate or mapTable[AssistantRow1+1][AssistantColumn1][4] == 0)
                       and mapTable[AssistantRow1+1][AssistantColumn1][7] == 0 and mapTable[AssistantRow1+1][AssistantColumn1][10] == 0 and mapTable[AssistantRow1+1][AssistantColumn1][9] == 0 then --助手希望往上移动且能往上方移动
                          AssistantMoveDirection = 2;    
                    end
                elseif  AssistantWillMoveDirection == 3 and AssistantColumn1-1 > 0 then
                   if mapTable[AssistantRow1][AssistantColumn1-1][3] == 0 and (mapTable[AssistantRow1][AssistantColumn1-1][4] > BoxRandRate or mapTable[AssistantRow1][AssistantColumn1-1][4] == 0)
                      and mapTable[AssistantRow1][AssistantColumn1-1][7] == 0 and mapTable[AssistantRow1][AssistantColumn1-1][10] == 0 and mapTable[AssistantRow1][AssistantColumn1-1][9] == 0 then --助手希望往左移动且能往左方移动
                          AssistantMoveDirection = 3;
                   end
                elseif  AssistantWillMoveDirection == 4 and AssistantRow1-1 > 0 then
                    if  mapTable[AssistantRow1-1][AssistantColumn1][3] == 0 and (mapTable[AssistantRow1-1][AssistantColumn1][4] > BoxRandRate or mapTable[AssistantRow1-1][AssistantColumn1][4] == 0)
                    and mapTable[AssistantRow1-1][AssistantColumn1][7] == 0 and mapTable[AssistantRow1-1][AssistantColumn1][10] == 0 and mapTable[AssistantRow1-1][AssistantColumn1][9] == 0 then --助手希望往下移动且能往下方移动
                          AssistantMoveDirection = 4;
                    end
                end
            end
        end
        
        TempRandRate = math.random(1,100);
        if TempRandRate <= AssistantPutBombRate then
            AssistantPutBomb();
        end
    end

	
end


function AvoidBlaze(DistanceMaxNum)	--助手可到达最大距离
	InitDistanceArraySet(DistanceMaxNum);
	DistanceArraySetTraversal(DistanceMaxNum);	
	ResetMapTableDistanceNum(DistanceMaxNum);
	DistanceArraySet = nil;
	DistanceLength = nil;
end

function ResetMapTableDistanceNum(DistanceMaxNum)	
	local i;
	local j;
	for i=1,DistanceMaxNum+1 do
		for j=1,DistanceLength[i] do
			mapTable[DistanceArraySet[i][j][2]][DistanceArraySet[i][j][3]][11] = 100;
		end
	end	
end


function DistanceArraySetTraversal(DistanceMaxNum)	--距离数组集的遍历（获取避免火焰的最短路径） DistanceMaxNum表示最大距离数
	local i;
	local j;  
	local IsSafe = false; --临时保存DistanceArraySet距离为0的数组中是否有元素可以不被火焰烧到
	for j=1,DistanceLength[1] do	--距离为0的数组特殊条件遍历（因为需要判断元素是否含有助手当前投掷的炸弹）
		if	mapTable[DistanceArraySet[1][j][2]][DistanceArraySet[1][j][3]][9] == 0 and mapTable[DistanceArraySet[1][j][2]][DistanceArraySet[1][j][3]][7] == 0 then
			DestinationBlockRow  = DistanceArraySet[1][j][2];		--DestinationBlockRow表示目的块在地图的行
			DestinationBlockColumn  = DistanceArraySet[1][j][3];	--DestinationBlockColumn表示目的块在地图的列
			if j == 2 and IsSafe or j == 1 and DistanceLength[1] == 1 then	--若人物所占的两个位置都不会被火焰烧到，或人物只占一个位置， 此时人物不动
			--	MessageBox(1, 1, MB_OK);
				AvoidMark = 0;
				return
			else	
				AvoidMark = 1;
				IsSafe = true;	
			end		
		end
		if j == 2 and IsSafe then	--若距离为0的数组（其中有两个格子）中有一个格子安全，则返回，否则往下执行
			return 
		end
	end
	for i=2,DistanceMaxNum+1 do	--此时人物必须移动才不会将被火焰烧掉
		for j=1,DistanceLength[i] do
			if	mapTable[DistanceArraySet[i][j][2]][DistanceArraySet[i][j][3]][9] == 0 then
				GetAvoidBlazeDestinationBlock(i-1,j);
				AvoidMark = 1;
				return  
			end
		end
	end
	AvoidMark = 0;
	return 
end

function GetAvoidBlazeDestinationBlock(DistanceNum,TempIndex) --DistanceNum表示当前目的格的距离数 --TempIndex表示目的格的索引
	local LoopCondition;
	if AssistantHaveUnitStatus == 1 then
		LoopCondition = 1;
	else	LoopCondition = 0;
	end
	while DistanceNum > LoopCondition do	--以某一节点开始往上获取目的节点(即人物占两格的时候获取其中的某一格为目的格，人物占一格的时候获取相邻的一格为目的格)
		TempIndex = DistanceArraySet[DistanceNum+1][TempIndex][1]; --计算出父节点的索引	
		DistanceNum = DistanceNum-1;
	end
	DestinationBlockRow  = DistanceArraySet[DistanceNum+1][TempIndex][2];
	DestinationBlockColumn  = DistanceArraySet[DistanceNum+1][TempIndex][3];
end

function InitDistanceArraySet(DistanceMaxNum)	--DistanceMaxNum表示最大距离数
	local i;
	local j;
	--DistanceArraySet距离数组集（三维数组），DistanceArraySet[i][j][k] ,i:距离数组的距离数 j:距离数组中元素的下标 k:元素中的分量下标
	--DistanceArraySet[i][j][1]：离助手距离为i-1的第j个方块的父节点在其距离为i-2数组中的下标（位置）（距离为0的数组中元素的父节点为自己）
	--DistanceArraySet[i][j][2]：离助手距离为i-1的第j个方块在地图所在位置的行坐标
	--DistanceArraySet[i][j][3]：离助手距离为i-1的第j个方块在地图所在位置的列坐标
	DistanceArraySet = {};
	DistanceLength = {};
	for i=1,DistanceMaxNum+1 do
		DistanceArraySet[i] = {};
		DistanceLength[i] = 0;
	end
	DistanceArraySet[1][1] = {};
	DistanceArraySet[1][1][1] = 1;	--父节点为自己,在第一个位置
	DistanceArraySet[1][1][2] = AssistantRow1;
	DistanceArraySet[1][1][3] = AssistantColumn1;
	DistanceLength[1] = 1;
	mapTable[AssistantRow1][AssistantColumn1][11] = 0;
	if AssistantHaveUnitStatus > 1 then
		DistanceArraySet[1][2] = {};
		DistanceArraySet[1][2][1] = 2;	--父节点为自己,在第二个位置
		DistanceLength[1] = DistanceLength[1]+1;
		if AssistantHaveUnitStatus == 2 then			
			DistanceArraySet[1][2][2] = AssistantRow1;
			DistanceArraySet[1][2][3] = AssistantColumn2;
			mapTable[AssistantRow1][AssistantColumn2][11] = 0;
		else
			DistanceArraySet[1][2][2] = AssistantRow2;
			DistanceArraySet[1][2][3] = AssistantColumn1;
			mapTable[AssistantRow2][AssistantColumn1][11] = 0;
		end
	end
	for i=1,DistanceMaxNum do	--依次生成距离数组
		for j=1,DistanceLength[i] do
			DistanceDiffusion(j,DistanceArraySet[i][j][2],DistanceArraySet[i][j][3],i);
		end
	end
	
end
--OriginBlockIndex表示基点砖块在所在距离数组中的索引 OriginBlockRow表示基点砖块的在地图的行坐标 
--OriginBlockColumn表示基点砖块的在地图的列坐标 SetDistance表示将要设置的砖块距离 （距离助手）
function DistanceDiffusion(OriginBlockIndex,OriginBlockRow,OriginBlockColumn,SetDistance)
	local RightBlockColumn = OriginBlockColumn+1;
	local UpBlockRow = OriginBlockRow+1;
	local LeftBlockColumn = OriginBlockColumn-1;
	local DownBlockRow = OriginBlockRow-1;
    local RandNumberDir = math.random(1,4);
	if RandNumberDir == 1 and RightBlockColumn <= TotalLines then	--检测右侧格是否超过边界 该格地图坐标为mapTable[OriginBlockRow][RightBlockColumn]
		if mapTable[OriginBlockRow][RightBlockColumn][3] == 0 and (mapTable[OriginBlockRow][RightBlockColumn][4] == 0 or mapTable[OriginBlockRow][RightBlockColumn][4] > BoxRandRate) 
		and mapTable[OriginBlockRow][RightBlockColumn][7] == 0 and mapTable[OriginBlockRow][RightBlockColumn][10] == 0 and  mapTable[OriginBlockRow][RightBlockColumn][11] > SetDistance then
			CreateDistanceElement(OriginBlockIndex,OriginBlockRow,RightBlockColumn,SetDistance);
		end
	end
	if RandNumberDir == 2 and UpBlockRow <= TotalRows then	--检测上侧格是否超过边界 该格地图坐标为mapTable[UpBlockRow][OriginBlockColumn]
		if mapTable[UpBlockRow][OriginBlockColumn][3] == 0 and (mapTable[UpBlockRow][OriginBlockColumn][4] == 0 or mapTable[UpBlockRow][OriginBlockColumn][4] > BoxRandRate) 
		and mapTable[UpBlockRow][OriginBlockColumn][7] == 0 and mapTable[UpBlockRow][OriginBlockColumn][10] == 0 and  mapTable[UpBlockRow][OriginBlockColumn][11] > SetDistance then
			CreateDistanceElement(OriginBlockIndex,UpBlockRow,OriginBlockColumn,SetDistance);			
		end	
	end	
	if RandNumberDir == 3 and LeftBlockColumn > 0 then	--检测左侧格是否超过边界 该格地图坐标为mapTable[OriginBlockRow][LeftBlockColumn]
		if mapTable[OriginBlockRow][LeftBlockColumn][3] == 0 and (mapTable[OriginBlockRow][LeftBlockColumn][4] == 0 or mapTable[OriginBlockRow][LeftBlockColumn][4] > BoxRandRate) 
		and mapTable[OriginBlockRow][LeftBlockColumn][7] == 0 and mapTable[OriginBlockRow][LeftBlockColumn][10] == 0 and  mapTable[OriginBlockRow][LeftBlockColumn][11] > SetDistance then
			CreateDistanceElement(OriginBlockIndex,OriginBlockRow,LeftBlockColumn,SetDistance);			
		end	
	end	
	if RandNumberDir == 4 and DownBlockRow > 0 then	--检测下侧格是否超过边界 该格地图坐标为mapTable[DownBlockRow][OriginBlockColumn]
		if mapTable[DownBlockRow][OriginBlockColumn][3] == 0 and (mapTable[DownBlockRow][OriginBlockColumn][4] == 0 or mapTable[DownBlockRow][OriginBlockColumn][4] > BoxRandRate) 
		and mapTable[DownBlockRow][OriginBlockColumn][7] == 0 and mapTable[DownBlockRow][OriginBlockColumn][10] == 0 and  mapTable[DownBlockRow][OriginBlockColumn][11] > SetDistance then
			CreateDistanceElement(OriginBlockIndex,DownBlockRow,OriginBlockColumn,SetDistance);			
		end	
	end	
	
end
--OriginBlockIndex表示将要创建的节点的父节点在其数组中的下标 
--CreateBlockRow表示将要创建的节点的地图的行数
--CreateBlockColumn表示将要创建的节点的地图的列数
--SetDistance表示将要创建的节点的距离（助手）
function CreateDistanceElement(OriginBlockIndex,CreateBlockRow,CreateBlockColumn,SetDistance)	--创建距离元素
	mapTable[CreateBlockRow][CreateBlockColumn][11] = SetDistance;
	DistanceArraySet[SetDistance+1][DistanceLength[SetDistance+1]+1] = {};
	DistanceArraySet[SetDistance+1][DistanceLength[SetDistance+1]+1][1] = OriginBlockIndex;	--保存父节点位置
	--MessageBox(SetDistance,1 , MB_OK);
	DistanceArraySet[SetDistance+1][DistanceLength[SetDistance+1]+1][2] = CreateBlockRow;
	DistanceArraySet[SetDistance+1][DistanceLength[SetDistance+1]+1][3] = CreateBlockColumn;
	DistanceLength[SetDistance+1] = DistanceLength[SetDistance+1]+1;
end


function AssistantClass:new()
	pk = {};
	setmetatable(pk, {__index = self});
	return pk;
end