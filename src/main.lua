--[[ File requires ]]--
require("common")
require("player")
require("laser")

local dTotalPrecise = 0
local dTotalSeconds = 0
local framesPerSecond = 60

function love.load()
  love.graphics.setBackgroundColor(255, 255, 255)

  world = love.physics.newWorld(0, 0, true)
  world:setCallbacks(beginContact, endContact, preSolve, postSolve)

  player = newPlayer(world, love.graphics.getWidth() / 2, love.graphics.getHeight() * 3 / 4)
  laser = newLaser({x=100,y=100}, {x=300,y=300}, 2)
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

  world:update(deltaTime)
end

function love.draw()
  love.graphics.setColor(0, 0, 0)
  love.graphics.print(string.format("Uptime: %d seconds\nFPS: %d\nCollision: %s", dTotalSeconds,
    framesPerSecond, tostring(collisionPolyCircle(lineToPolygon(laser.line), player))), 0, 0)
  love.graphics.setColor(255, 255, 255)

  player:draw()
  laser:draw()
end
