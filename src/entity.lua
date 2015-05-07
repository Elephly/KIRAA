--[[ File requires ]]--
require("common")

local entity = {}

function newEntity(world, pos)
  local e = {}
  e.body = love.physics.newBody(world, pos.x, pos.y, "dynamic")
end
