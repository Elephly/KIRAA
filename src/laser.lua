local laser = {
  target,
  startPoint = { x, y },
  endPoint = { x, y }
}

function laser:update(dt)
  self.endPoint.x = self.target.x
  self.endPoint.y = self.target.y
end

function laser:draw()
  love.graphics.setColor(0, 0, 0)
  love.graphics.line(self.startPoint.x, self.startPoint.y, self.endPoint.x, self.endPoint.y);
  love.graphics.setColor(255, 255, 255)
end

function newLaser(player)
  local l = {
    target = player,
    startPoint = { x = 0, y = 0 },
    endPoint = { x = player.x, y = player.y },
    update = laser.update,
    draw = laser.draw
  }
  return l
end