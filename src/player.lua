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

function player:draw()
  love.graphics.rectangle("fill", self.x - self.origin.x, self.y - self.origin.y, self.width, self.height)
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
    draw = player.draw
  }
  return p
end