--[[ File requires ]]--
require("common")
require("entity")

local laser = {}

function newLaser(world, origVec2, targVec2, force, wid, len)
  local direction = normalizeVec2(subVec2(targVec2, origVec2), 1)
  local midPoint = midVec2(origVec2, addVec2(origVec2, multByConstVec2(direction, -len)))
  local l = newEntity(world, { x = midPoint.x, y = midPoint.y })
  l.direction = direction
  l.width = wid
  l.length = len
  l:setUserData("Laser")
  l.update = laser.update
  l.draw = laser.draw
  l.handleCollisionBegin = laser.handleCollisionBegin
  l.initialForce = {
    x = l.direction.x * force * 100,
    y = l.direction.y * force * 100
  }
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

function laser:handleCollisionBegin(other, collData)
  self:destroy()
end
