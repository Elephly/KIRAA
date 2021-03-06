--[[ File requires ]]--
require("common")
require("entity")

local player = {}

function newPlayer(world, pos)
  local p = newEntity(world, pos, 10)
  p.directionalForce = { x = 0, y = 0 }
  p.moveForce = 500
  p:setUserData("Player")
  p.update = player.update
  p.draw = player.draw
  p.destroy = player.destroy
  p.handleCollisionPreSolve = player.handleCollisionPreSolve
  p.handleInput = player.handleInput
  p.body:setLinearDamping(4)
  p.body:setMass(10)
  p.shape = love.physics.newCircleShape(8)
  p.fixture = love.physics.newFixture(p.body, p.shape)
  p.fixture:setCategory(category.player)
  p.fixture:setUserData(p)
  return p
end

function player:update(dt)
  if (self.alive) then
    self.directionalForce = { x = 0, y = 0 }
    self:handleInput()
    self.directionalForce = normalizeVec2(self.directionalForce, self.moveForce)
    self.body:applyForce(self.directionalForce.x, self.directionalForce.y)
  end
  if self.body:getX() > love.graphics.getWidth() then
    self.body:setX(self.body:getX() - love.graphics.getWidth())
  end
  if self.body:getX() < 0 then
    self.body:setX(self.body:getX() + love.graphics.getWidth())
  end
  if self.body:getY() > love.graphics.getHeight() then
    self.body:setY(self.body:getY() - love.graphics.getHeight())
  end
  if self.body:getY() < 0 then
    self.body:setY(self.body:getY() + love.graphics.getHeight())
  end
  return self.alive
end

function player:draw()
  --if (self.alive) then
    love.graphics.setColor(0, 0, 0)

    love.graphics.circle("fill", self.body:getX(), self.body:getY(), self.shape:getRadius(), 24)

    love.graphics.circle("fill", self.body:getX() + love.graphics.getWidth(), self.body:getY(),
      self.shape:getRadius(), 24)
    love.graphics.circle("fill", self.body:getX() - love.graphics.getWidth(), self.body:getY(),
      self.shape:getRadius(), 24)
    love.graphics.circle("fill", self.body:getX(), self.body:getY() + love.graphics.getHeight(),
      self.shape:getRadius(), 24)
    love.graphics.circle("fill", self.body:getX(), self.body:getY() - love.graphics.getHeight(),
      self.shape:getRadius(), 24)

    love.graphics.circle("fill", self.body:getX() + love.graphics.getWidth(),
      self.body:getY() + love.graphics.getHeight(), self.shape:getRadius(), 24)
    love.graphics.circle("fill", self.body:getX() - love.graphics.getWidth(),
      self.body:getY() - love.graphics.getHeight(), self.shape:getRadius(), 24)
    love.graphics.circle("fill", self.body:getX() + love.graphics.getWidth(),
      self.body:getY() - love.graphics.getHeight(), self.shape:getRadius(), 24)
    love.graphics.circle("fill", self.body:getX() - love.graphics.getWidth(),
      self.body:getY() + love.graphics.getHeight(), self.shape:getRadius(), 24)

    love.graphics.setColor(255, 255, 255)
  --end
end

function player:destroy()
  self.alive = false
  self.body:setLinearDamping(1)
end

function player:handleCollisionPreSolve(other, collData)
  if other:getUserData() == "Laser" then
    self:dealDamage(other:getDamage())
    if self:getHealth() <= 0 then
      self:destroy()
    end
  end
end

function player:handleInput()
  if love.keyboard.isDown('a') then
    self.directionalForce.x = self.directionalForce.x - 1
    --self.body:applyForce(-self.moveForce, 0)
  end
  if love.keyboard.isDown('d') then
    self.directionalForce.x = self.directionalForce.x + 1
    --self.body:applyForce(self.moveForce, 0)
  end
  if love.keyboard.isDown('w') then
    self.directionalForce.y = self.directionalForce.y - 1
    --self.body:applyForce(0, -self.moveForce)
  end
  if love.keyboard.isDown('s') then
    self.directionalForce.y = self.directionalForce.y + 1
    --self.body:applyForce(0, self.moveForce)
  end
end
