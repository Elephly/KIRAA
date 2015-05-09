--[[ File requires ]]--
require("game-math")
require("game-physics")

category = {
  player = 1,
  laser = 2,
  specialLaser = 3,
  powerUp = 4,
}

function edge(num)
  if num == 1 then return "left"
  elseif num == 2 then return "right"
  elseif num == 3 then return "top"
  elseif num == 4 then return "bottom"
  else return nil
  end
end
