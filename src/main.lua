--[[ File requires ]]--
require("player")
require("laser")

local dTotalPrecise = 0
local dTotalSeconds = 0
local framesPerSecond = 60

function love.load()
  love.graphics.setBackgroundColor(255, 255, 255)
  player = newPlayer(love.graphics.getWidth() / 2, love.graphics.getHeight() * 3 / 4)
  laser = newLaser(0, player, 2)
end

function love.update(deltaTime)
  if love.keyboard.isDown("escape") then
    love.event.quit()
  end
  dTotalPrecise = dTotalPrecise + deltaTime
  if dTotalPrecise >= 1 then
    dTotalPrecise = dTotalPrecise - 1
    dTotalSeconds = dTotalSeconds + 1
  end
  framesPerSecond = 1 / deltaTime

  player:update(deltaTime)
  laser:update(deltaTime)
end

function love.draw()
  love.graphics.setColor(0, 0, 0)
  love.graphics.print(string.format("Uptime: %d seconds\nFPS: %d\nCollision: %s", dTotalSeconds,
    framesPerSecond, tostring(collisionPolyCircle(lineToPolygon(laser.line, laser.width), player))), 0, 0)
  love.graphics.setColor(255, 255, 255)

  player:draw()
  laser:draw()
end
