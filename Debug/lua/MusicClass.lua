

--音效类
seMusicClass = {
	File = ""
}
--设置音效相关数据
function seMusicClass:SetMusicData( Name)
	self.File = Name;
end

function seMusicClass:Play()
	if seMusicStopStatus == 0 and seMusicPauseStatus == 0 then
		PlayMusic(SEDevice,self.File);
	end
end

function seMusicClass:new()
	o = {}
	setmetatable(o, {__index = self});
	return o;
end

function seMusicPlayControl(c)
	if c == MusicStop then
		seMusicStopStatus = 1;
		StopMusic(SEDevice);
	elseif c == MusicOpen then
		seMusicStopStatus = 0;
	elseif c == MusicPause then
		seMusicPauseStatus = 1;
		PlayToPauseMusic(SEDevice);
	elseif c == MusicPlay then
		seMusicPauseStatus = 0;
		PauseToPlayMusic(SEDevice);
	end
end

--背景音乐类
bgmMusicClass = 
{
	File = {},
	Time = {},
	last = 1,
	Timer = 31*100,
	Delay = 1 --延时1s
}

function bgmMusicClass:Play(S)
	
	if bgmMusicStopStatus == 0 and bgmMusicPauseStatus == 0 and WinFocus == WM_SETFOCUS then
		self.Timer = self.Timer + 1;
		if self.Timer >= (self.Time[self.last]+self.Delay)*100 or S == ForcedSwitch then
			local RandNum = math.random(1,7);

			if self.last == RandNum then
				if RandNum == 7 then
					self.last = RandNum - 1;
				else
					self.last = RandNum + 1;
				end
			else
				self.last = RandNum;
			end
			self.Timer = 0;
			PlayMusic(BGMDevice,self.File[self.last]);
		end
	end
end




function bgmMusicClass:new()
	
	o = {}
	setmetatable(o, {__index = self});
	return o;
end



function SetWinFoucsStatus(c)
	WinFocus = c;
end



function bgmMusicPlayControl(c)
	if c == MusicStop then
		bgmMusicStopStatus = 1;
		StopMusic(BGMDevice);
	elseif c == MusicOpen then
		bgmMusicStopStatus = 0;
	elseif c == MusicPause then
		bgmMusicPauseStatus = 1;
		PlayToPauseMusic(BGMDevice);
	elseif c == MusicPlay then
		bgmMusicPauseStatus = 0;
		PauseToPlayMusic(BGMDevice);
	end
end

--只用这个！
Gamebgm = bgmMusicClass:new();
Gamebgm["File"] = {"music/BGM/1.wav","music/BGM/2.mp3","music/BGM/3.mp3","music/BGM/4.mp3","music/BGM/5.mp3","music/BGM/6.mp3","music/BGM/7.mp3"}
Gamebgm["Time"] = {31,237,229,156,98,195,287}


--@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
SetMusicVol(BGMDevice, 10);--音量设置函数
--@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@


--角色移动按键背景音乐
MoveseMusicClass = 
{
	File = "",
	Time = 0,
	Timer = 100,
	Delay = 1 --延时1s
}

function MoveseMusicClass:Play()
	
	if seMusicStopStatus == 0 and seMusicPauseStatus == 0 then
		self.Timer = self.Timer + 1;
		if self.Timer >= self.Time then
			self.Timer = 0;
			PlayMusic(SEDevice,self.File);
		end
	end
end

function MoveseMusicClass:Init(FN, T)
	self.File = FN;
	self.Timer = T;
end

function MoveseMusicClass:new()
	
	oo = {}
	setmetatable(oo, {__index = self});
	return oo;
end


SetMusicVol(SEDevice, 3);

ActorKeyBgm = MoveseMusicClass:new();
ActorKeyBgm["File"] = "music/FootSoundEffect1.mp3"
ActorKeyBgm["Time"] = 14