--[[ File requires ]]--
require("common")

local entity = {}

function newEntity(world, pos)
  local e = {
    alive = true,
    body = love.physics.newBody(world, pos.x, pos.y, "dynamic"),
    destroy = entity.destroy,
    draw = entity.draw,
    getPosition = entity.getPosition,
    getUserData = entity.getUserData,
    handleCollisionBegin = entity.handleCollisionBegin,
    handleCollisionEnd = entity.handleCollisionEnd,
    handleCollisionPreSolve = entity.handleCollisionPreSolve,
    handleCollisionPostSolve = entity.handleCollisionPostSolve,
    setUserData = entity.setUserData,
    update = entity.update,
    userData,
  }
  return e
end

function entity:destroy()
  self.alive = false
  self.body:destroy()
end

function entity:update(dt)
  if self.alive then

  end
  return self.alive
end

function entity:draw()
  if (self.alive) then

  end
end

function entity:getPosition()
  return { x = self.body:getX(), y = self.body:getY() }
end

function entity:getUserData()
  return self.userData
end

function entity:setUserData(data)
  self.userData = data
end

function entity:handleCollisionBegin(other, collData)

end

function entity:handleCollisionEnd(other, collData)

end

function entity:handleCollisionPreSolve(other, collData)

end

function entity:handleCollisionPostSolve(other, collData)

end
