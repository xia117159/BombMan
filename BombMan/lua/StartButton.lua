--require "include"
--程序框大小设定，改变无用！

WindowsWidth     =      1000.0
WindowsHeight    =      600.0

--按钮大小设定，不可改变
ButtonWidth      =      353.0
ButtonHeight     =      158.0
ButtonWidthF     =      ( ButtonWidth / WindowsWidth )
ButtonHeightF    =      ( ButtonHeight / WindowsHeight )
ButtonImageWidth =      706.0
ButtonImageHeight=      947.0
tuWidth          =      ( ButtonWidth / ButtonImageWidth )
tuHeight         =      ( ButtonHeight / ButtonImageHeight )
ButtonDefaultX   =      -0.95
ButtonDefaultY   =      0.5
--零时变量
FirstButtonLeftOrRightMove = 0.0;
FirstButtonUpOrDownMove = 0.0;


--按键值设定，改变无用！
KeyUpLua    = 0x11
KeyDownLua  = 0x1F
KeyRightLua = 0x1E
KeyLeftLua  = 0x20

CharacterRate = 0.005

function DrawButtonFunc()
	LuaDrawButton(ButtonDefaultX + FirstButtonLeftOrRightMove, FirstButtonUpOrDownMove + ButtonDefaultY - 0 * ButtonHeightF,   0.0,     0 * tuHeight);
	LuaDrawButton(ButtonDefaultX, ButtonDefaultY - 1.0 * ButtonHeightF, 0.0,     2 * tuHeight);
	LuaDrawButton(ButtonDefaultX, ButtonDefaultY - 2.0 * ButtonHeightF, 0.0,     4 * tuHeight);
	LuaDrawButton(ButtonDefaultX, ButtonDefaultY - 3.0 * ButtonHeightF, tuWidth, 0 * tuHeight);
	LuaDrawButton(ButtonDefaultX, ButtonDefaultY - 4.0 * ButtonHeightF, tuWidth, 2 * tuHeight);
	LuaDrawButton(ButtonDefaultX, ButtonDefaultY - 5.0 * ButtonHeightF, tuWidth, 4 * tuHeight);
end

function FirstButtonMove(key)

	if(key == KeyUpLua) then
		FirstButtonUpOrDownMove = FirstButtonUpOrDownMove + CharacterRate;
	elseif (key == KeyDownLua) then
		FirstButtonUpOrDownMove = FirstButtonUpOrDownMove - CharacterRate;
	elseif (key == KeyLeftLua) then
		FirstButtonLeftOrRightMove = FirstButtonLeftOrRightMove + CharacterRate;
	elseif (key == KeyRightLua) then
		FirstButtonLeftOrRightMove = FirstButtonLeftOrRightMove - CharacterRate;
	end
end

--DrawButtonFunc();
function SetButtonImagePath()
	LuaInitStartViewIamgePath("Image/ButtonImage.png", "Image/BackGround.png");
end
