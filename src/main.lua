local x, y
local incX, incY = true, true


function love.load()
  x = 0
  y = 0
end

function love.update()
  if incX then
    x = x + 1
  else
    x = x - 1
  end
  if incY then
    y = y + 1
  else
    y = y - 1
  end
  
  if ((x <= 0) or (x >= love.graphics.getWidth()))  then
    incX = not incX
  end
  if ((y <= 0) or (y >= love.graphics.getHeight())) then
    incY = not incY
  end
end

function love.draw()
  love.graphics.print("HELLO!", x, y)
end