--[[ File requires ]]--
require("common")
require("player")
require("laser")

local dTotalPrecise = 0
local dTotalSeconds = 0
local framesPerSecond = 60

local world
local player
local lasers
local laserSpawnTimeElapsed = 0
local laserSpawnTime = 0.001

function love.load()
  love.graphics.setBackgroundColor(255, 255, 255)

  world = love.physics.newWorld(0, 0, true)
  world:setCallbacks(beginContact, endContact, preSolve, postSolve)

  player = newPlayer(world, {x=love.graphics.getWidth() / 2, y=love.graphics.getHeight() * 2 / 3})
  lasers = {}
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

  laserSpawnTimeElapsed = laserSpawnTimeElapsed + deltaTime
  if laserSpawnTimeElapsed >= laserSpawnTime then
    local e = love.math.random(4)
    if edge(e) == "left" then
      local lx = 0
      local ly = love.math.random(love.graphics.getHeight())
      table.insert(lasers, newLaser(world, { x = lx, y = ly },
        player:getPosition(), 5, 2, 30))
    elseif edge(e) == "right" then
      local lx = love.graphics.getWidth()
      local ly = love.math.random(love.graphics.getHeight())
      table.insert(lasers, newLaser(world, { x = lx, y = ly },
        player:getPosition(), 5, 2, 30))
    elseif edge(e) == "top" then
      local lx = love.math.random(love.graphics.getWidth())
      local ly = 0
      table.insert(lasers, newLaser(world, { x = lx, y = ly },
        player:getPosition(), 5, 2, 30))
    elseif edge(e) == "bottom" then
      local lx = love.math.random(love.graphics.getWidth())
      local ly = love.graphics.getHeight()
      table.insert(lasers, newLaser(world, { x = lx, y = ly },
        player:getPosition(), 5, 2, 30))
    end
    laserSpawnTimeElapsed = laserSpawnTimeElapsed - laserSpawnTime
  end
  for i = table.getn(lasers), 1, -1 do
    if not lasers[i]:update(deltaTime) then
      table.remove(lasers, i)
    end
  end

  world:update(deltaTime)
end

function love.draw()
  love.graphics.setColor(0, 0, 0)
  love.graphics.print(string.format("Uptime: %d seconds\nFPS: %d\nLasers: %d",
    dTotalSeconds, framesPerSecond, table.getn(lasers)), 0, 0)
  love.graphics.setColor(255, 255, 255)

  player:draw()
  for i = 1, table.getn(lasers) do
    lasers[i]:draw()
  end
end
