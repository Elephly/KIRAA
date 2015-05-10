--[[ File requires ]]--
require("common")
require("player")
require("laser-spawner")
require("music-manager")

local dTotalPrecise = 0
local dTotalSeconds = 0
local framesPerSecond = 60

local world
local player
local laserSpawner
local musicManager

function love.load()
  love.graphics.setBackgroundColor(255, 255, 255)

  world = love.physics.newWorld(0, 0, true)
  world:setCallbacks(beginContact, endContact, preSolve, postSolve)

  player = newPlayer(world, {x=love.graphics.getWidth() / 2, y=love.graphics.getHeight() * 2 / 3})

  laserSpawner = newLaserSpawner(world, player)

  musicManager = newMusicManager()
  love.audio.play(musicManager.introSong)
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
  if laserSpawner:getPattern() == nil then
    laserSpawner:setPattern(1)
  end
  laserSpawner:update(deltaTime)

  world:update(deltaTime)
end

function love.draw()
  love.graphics.setColor(0, 0, 0)
  love.graphics.print(string.format("Uptime: %d seconds\nFPS: %d\nLasers: %d",
    dTotalSeconds, framesPerSecond, #laserSpawner:getLasers()), 0, 0)
  love.graphics.setColor(255, 255, 255)

  player:draw()
  laserSpawner:draw()
end
