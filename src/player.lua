--[[ File requires ]]--
require("common")

local player = {}

function player:update(dt)
  handleInput(self)
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
end

function player:draw()
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
end

function newPlayer(world, xPos, yPos)
  local p = {
    update = player.update,
    draw = player.draw
  }
  p.body = love.physics.newBody(world, xPos, yPos, "dynamic")
  p.body:setLinearDamping(4)
  p.body:setMass(10)
  p.shape = love.physics.newCircleShape(8)
  p.fixture = love.physics.newFixture(p.body, p.shape)
  p.fixture:setRestitution(0.0)
  p.fixture:setUserData("Player")
  p.moveForce = 500
  return p
end

function handleInput(p)
  if love.keyboard.isDown('a') then
    p.body:applyForce(-p.moveForce, 0)
  end
  if love.keyboard.isDown('d') then
    p.body:applyForce(p.moveForce, 0)
  end
  if love.keyboard.isDown('w') then
    p.body:applyForce(0, -p.moveForce)
  end
  if love.keyboard.isDown('s') then
    p.body:applyForce(0, p.moveForce)
  end
end
