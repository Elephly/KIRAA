--[[ File requires ]]--
require("common")

local player = {
  x,
  y,
  radius = 8,
  speed = 200,
  frameSpeed = {
    x = 0,
    y = 0
  }
}

function player:update(dt)
  self.frameSpeed.x = 0
  self.frameSpeed.y = 0
  handleInput(self)
  normalizeVector2(self.frameSpeed, self.speed)
  self.x = self.x + self.frameSpeed.x * dt
  self.y = self.y + self.frameSpeed.y * dt

  if self.x > love.graphics.getWidth() then
    self.x = self.x - love.graphics.getWidth()
  end
  if self.x < 0 then
    self.x = self.x + love.graphics.getWidth()
  end
  if self.y > love.graphics.getHeight() then
    self.y = self.y - love.graphics.getHeight()
  end
  if self.y < 0 then
    self.y = self.y + love.graphics.getHeight()
  end
end

function player:draw()
  love.graphics.setColor(0, 0, 0)
  love.graphics.circle("fill", self.x, self.y, self.radius, 16)

  love.graphics.circle("fill", self.x + love.graphics.getWidth(), self.y, self.radius, 16)
  love.graphics.circle("fill", self.x - love.graphics.getWidth(), self.y, self.radius, 16)
  love.graphics.circle("fill", self.x, self.y + love.graphics.getHeight(), self.radius, 16)
  love.graphics.circle("fill", self.x, self.y - love.graphics.getHeight(), self.radius, 16)

  love.graphics.circle("fill", self.x + love.graphics.getWidth(), self.y + love.graphics.getHeight(), self.radius, 16)
  love.graphics.circle("fill", self.x - love.graphics.getWidth(), self.y - love.graphics.getHeight(), self.radius, 16)
  love.graphics.circle("fill", self.x + love.graphics.getWidth(), self.y - love.graphics.getHeight(), self.radius, 16)
  love.graphics.circle("fill", self.x - love.graphics.getWidth(), self.y + love.graphics.getHeight(), self.radius, 16)

  --Speed stuff
  local hyp = math.sqrt((self.frameSpeed.x * self.frameSpeed.x) + (self.frameSpeed.y * self.frameSpeed.y))
  love.graphics.print("speed.x = " .. self.frameSpeed.x .. "\nspeed.y = " .. self.frameSpeed.y .. "\nspeed = " .. self.speed .. "\nactual = " .. hyp, 0, 40)

  love.graphics.setColor(255, 255, 255)
end

function newPlayer(xPos, yPos)
  local p = {
    x = xPos,
    y = yPos,
    radius = player.radius,
    speed = player.speed,
    frameSpeed = player.frameSpeed,
    update = player.update,
    draw = player.draw
  }
  return p
end

function handleInput(p)
  if love.keyboard.isDown('a') then
    p.frameSpeed.x = p.frameSpeed.x - p.speed
  end
  if love.keyboard.isDown('d') then
    p.frameSpeed.x = p.frameSpeed.x + p.speed
  end
  if love.keyboard.isDown('w') then
    p.frameSpeed.y = p.frameSpeed.y - p.speed
  end
  if love.keyboard.isDown('s') then
    p.frameSpeed.y = p.frameSpeed.y + p.speed
  end
end
