--[[ File requires ]]--
require("common")

local laser = {}

function newLaser(world, origVec2, targVec2, force, wid, len)
  local l = {
    alive = true,
    direction = normalizeVec2(subVec2(targVec2, origVec2), 1),
    width = wid,
    length = len,
    userData = "Laser",
    update = laser.update,
    draw = laser.draw,
    getPosition = laser.getPosition,
    getUserData = laser.getUserData,
    handleCollisionBegin = laser.handleCollisionBegin,
    handleCollisionEnd = laser.handleCollisionEnd,
    destroy = laser.destroy
  }
  local midPoint = midVec2(origVec2, addVec2(origVec2, multByConstVec2(l.direction, -l.length)))
  l.initialForce = {
    x = l.direction.x * force * 100,
    y = l.direction.y * force * 100
  }
  l.body = love.physics.newBody(world, midPoint.x, midPoint.y, "dynamic")
  l.body:setMass(0)
  l.shape = love.physics.newEdgeShape(-subVec2(midPoint, origVec2).x,
    -subVec2(midPoint, origVec2).y, subVec2(midPoint, origVec2).x,
    subVec2(midPoint, origVec2).y)
  l.fixture = love.physics.newFixture(l.body, l.shape)
  l.fixture:setUserData(l)
  l.body:applyLinearImpulse(l.initialForce.x, l.initialForce.y)
  return l
end

function laser:update(dt)
  if self.alive then
    local tailCheckVec = addVec2(self:getPosition(), multByConstVec2(self.direction, -self.length))
    if self.direction.x > 0 and tailCheckVec.x > love.graphics.getWidth() or
      self.direction.x < 0 and tailCheckVec.x < 0  or
      self.direction.y > 0 and tailCheckVec.y > love.graphics.getHeight() or
      self.direction.y < 0 and tailCheckVec.y < 0 then
      self:destroy()
    end
  end
  return self.alive
end

function laser:draw()
  if (self.alive) then
    local oldLineWidth = love.graphics.getLineWidth()
    love.graphics.setLineWidth(self.width)
    love.graphics.setColor(255, 0, 0)
    love.graphics.line(self.body:getWorldPoints(self.shape:getPoints()))
    love.graphics.setColor(255, 255, 255)
    love.graphics.setLineWidth(oldLineWidth)
  end
end

function laser:getPosition()
  return { x = self.body:getX(), y = self.body:getY() }
end

function laser:getUserData()
  return self.userData
end

function laser:handleCollisionBegin(other)
  self:destroy()
end

function laser:handleCollisionEnd(other)

end

function laser:destroy()
  self.alive = false
  self.body:destroy()
end
