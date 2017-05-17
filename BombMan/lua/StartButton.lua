


WindowsWidth     =      1000.0
WindowsHeight    =      600.0
ButtonWidth      =      353.0
ButtonHeight     =      158.0
ButtonWidthF     =      ( ButtonWidth / WindowsWidth )
ButtonHeightF    =      ( ButtonHeight / WindowsHeight )
ButtonImageWidth =      706.0
ButtonImageHeight=      947.0
tuWidth          =      ( ButtonWidth / ButtonImageWidth )
tuHeight         =      ( ButtonHeight / ButtonImageHeight )

i = 0.0;


--[[
DrawButton(-0.8f, 0.5f - i++ * ButtonHeightF, 0.0f,    2 * tuHeight);
DrawButton(-0.8f, 0.5f - i++ * ButtonHeightF, 0.0f,    4 * tuHeight);
DrawButton(-0.8f, 0.5f - i++ * ButtonHeightF, tuWidth, 0 * tuHeight);
DrawButton(-0.8f, 0.5f - i++ * ButtonHeightF, tuWidth, 2 * tuHeight);
DrawButton(-0.8f, 0.5f - i++ * ButtonHeightF, tuWidth, 4 * tuHeight);
]]

function DrawButtonFunc()
	LuaDrawButton(-0.8, 0.5 - 0 * ButtonHeightF,   0.0,     0 * tuHeight);
	LuaDrawButton(-0.8, 0.5 - 1.0 * ButtonHeightF, 0.0,     2 * tuHeight);
	LuaDrawButton(-0.8, 0.5 - 2.0 * ButtonHeightF, 0.0,     4 * tuHeight);
	LuaDrawButton(-0.8, 0.5 - 3.0 * ButtonHeightF, tuWidth, 0 * tuHeight);
	LuaDrawButton(-0.8, 0.5 - 4.0 * ButtonHeightF, tuWidth, 2 * tuHeight);
	LuaDrawButton(-0.8, 0.5 - 5.0 * ButtonHeightF, tuWidth, 4 * tuHeight);
end

--DrawButtonFunc();
function SetButtonImagePath()
	LuaInitStartButtonIamgePath("Image/ButtonImage.png");
end
