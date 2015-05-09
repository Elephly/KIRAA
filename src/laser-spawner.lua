--[[ File requires ]]--
require("common")
require("laser")

--[[ Laser Types ]]--
weakLaser = {
  health = 3,
  force = 1,
  width = 2,
  length = 50,
}

--[[ Pattern Types ]]--
patterns = {
  weakLaserTarget = {
    laserType = weakLaser,
    laserSpawnTime = 1,
    laserSpawnTimeElapsed = 0,
    minLevel = 1,
    maxLevel = 5,
    update = function (self, dt, spawner)
      self.laserSpawnTimeElapsed = self.laserSpawnTimeElapsed + dt
      if self.laserSpawnTimeElapsed >= self.laserSpawnTime then
        local e = love.math.random(4)
        if edge(e) == "left" then
          local lx = 0
          local ly = love.math.random(love.graphics.getHeight())
          spawner:spawnNew(self.laserType, { x = lx, y = ly }, spawner.player:getPosition())
        elseif edge(e) == "right" then
          local lx = love.graphics.getWidth()
          local ly = love.math.random(love.graphics.getHeight())
          spawner:spawnNew(self.laserType, { x = lx, y = ly }, spawner.player:getPosition())
        elseif edge(e) == "top" then
          local lx = love.math.random(love.graphics.getWidth())
          local ly = 0
          spawner:spawnNew(self.laserType, { x = lx, y = ly }, spawner.player:getPosition())
        elseif edge(e) == "bottom" then
          local lx = love.math.random(love.graphics.getWidth())
          local ly = love.graphics.getHeight()
          spawner:spawnNew(self.laserType, { x = lx, y = ly }, spawner.player:getPosition())
        end
        self.laserSpawnTimeElapsed = self.laserSpawnTimeElapsed - self.laserSpawnTime
      end

      for i = #spawner.lasers, 1, -1 do
        if not spawner.lasers[i]:update(dt) then
          table.remove(spawner.lasers, i)
        end
      end
    end,
  },
}

function patternsForLevel(level)
  local pttrns = {}
  for k, v in pairs(patterns) do
    if level >= v.minLevel and level <= v.maxLevel then
      table.insert(pttrns, v)
    end
  end
  return pttrns
end

laserSpawner = {}

function newLaserSpawner(aWorld, aPlayer)
  local ls = {
    world = aWorld,
    player = aPlayer,
    lasers = {},
    pattern = nil,
    spawnNew = laserSpawner.spawnNew,
    update = laserSpawner.update,
    draw = laserSpawner.draw,
    getLasers = laserSpawner.getLasers,
    getPattern = laserSpawner.getPattern,
    setPattern = laserSpawner.setPattern,
  }
  return ls
end

function laserSpawner:spawnNew(laserType, orig, targ)
  table.insert(self.lasers, newLaser(self.world, orig, targ, laserType.health,
    laserType.force, laserType.width, laserType.length))
end

function laserSpawner:update(dt)
  if self.pattern then
    self.pattern:update(dt, self)
    return true
  else
    return false
  end
end

function laserSpawner:draw()
  for i = 1, #self.lasers do
    self.lasers[i]:draw()
  end
end

function laserSpawner:getLasers()
  return self.lasers
end

function laserSpawner:getPattern()
  return self.pattern
end

function laserSpawner:setPattern(level)
  local pttrns = patternsForLevel(level)
  if #pttrns > 0 then
    self.pattern = pttrns[love.math.random(#pttrns)]
  end
end
