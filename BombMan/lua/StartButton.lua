require "include"

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
	LuaInitStartButtonIamgePath("Image/ButtonImage.png");
end
