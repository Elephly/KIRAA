--[[ File requires ]]--
require("common")

local laser = {
  target,
  line = {
    startPoint = { x, y },
    endPoint = { x, y },
    width
  }
}

function laser:update(dt)
  self.line.endPoint.x = self.target.x
  self.line.endPoint.y = self.target.y
end

function laser:draw()
  local oldLineWidth = love.graphics.getLineWidth()
  love.graphics.setLineWidth(self.line.width)
  love.graphics.setColor(255, 0, 0)
  love.graphics.line(self.line.startPoint.x, self.line.startPoint.y, self.line.endPoint.x, self.line.endPoint.y);
  love.graphics.setColor(255, 255, 255)
  love.graphics.setLineWidth(oldLineWidth)
end

function newLaser(orig, targ, w)
  local l = {
    target = targ,
    line = {
      startPoint = { x = orig.x, y = orig.y },
      endPoint = { x = targ.x, y = targ.y },
      width = w
    },
    update = laser.update,
    draw = laser.draw
  }
  return l
end
