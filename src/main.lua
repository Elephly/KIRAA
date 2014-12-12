--[[ File requires ]]--
require("player")

local dTotalPrecise = 0
local dTotalSeconds = 0
local framesPerSecond = 60

local player

function love.load()
  player = newPlayer(love.graphics.getWidth() / 2, love.graphics.getHeight() * 3 / 4)
end

function love.update(deltaTime)
  dTotalPrecise = dTotalPrecise + deltaTime
  if dTotalPrecise >= 1 then
    dTotalPrecise = dTotalPrecise - 1
    dTotalSeconds = dTotalSeconds + 1
  end
  framesPerSecond = 1 / deltaTime
end

function love.draw()
  love.graphics.print("Uptime: " .. dTotalSeconds .. " seconds\nFPS: " .. string.format("%d", framesPerSecond), 0, 0)
  player:draw()
end