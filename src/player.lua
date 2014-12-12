local player = {
  x,
  y,
  width = 20,
  height = 20,
  origin = {
    x,
    y
  }
}

function player:update(dt)
  handleInput(self, dt)
end

function player:draw()
  love.graphics.setColor(0, 0, 0)
  love.graphics.rectangle("fill", self.x - self.origin.x, self.y - self.origin.y, self.width, self.height)
  love.graphics.setColor(255, 255, 255)
end

function newPlayer(xPos, yPos)
  local p = {
    x = xPos,
    y = yPos,
    width = player.width,
    height = player.height,
    origin = {
      x = (player.width / 2),
      y = (player.height / 2)
    },
    update = player.update,
    draw = player.draw
  }
  return p
end

function handleInput(p, dt)
  if love.keyboard.isDown('a') then
    p.x = p.x - 100 * dt
  end
  if love.keyboard.isDown('d') then
    p.x = p.x + 100 * dt
  end
end