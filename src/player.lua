local player = {
  x,
  y,
  radius = 8,
  speed = 200
}

function player:update(dt)
  handleInput(self, dt)
  if self.x >= love.graphics.getWidth() then
    self.x = self.x - love.graphics.getWidth()
  end
  if self.x <= 0 then
    self.x = self.x + love.graphics.getWidth()
  end
  if self.y >= love.graphics.getHeight() then
    self.y = self.y - love.graphics.getHeight()
  end
  if self.y <= 0 then
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
  love.graphics.setColor(255, 255, 255)
end

function newPlayer(xPos, yPos)
  local p = {
    x = xPos,
    y = yPos,
    radius = player.radius,
    speed = player.speed,
    update = player.update,
    draw = player.draw
  }
  return p
end

function handleInput(p, dt)
  if love.keyboard.isDown('a') then
    p.x = p.x - p.speed * dt
  end
  if love.keyboard.isDown('d') then
    p.x = p.x + p.speed * dt
  end
  if love.keyboard.isDown('w') then
    p.y = p.y - p.speed * dt
  end
  if love.keyboard.isDown('s') then
    p.y = p.y + p.speed * dt
  end
end