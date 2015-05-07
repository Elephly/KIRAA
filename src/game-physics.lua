function collisionPolyPoly(poly1, poly2)
  return false
end

function collisionPolyCircle(poly, circle)
  return false
end

function collisionCircleCircle(circle1, circle2)
  return false
end

function beginContact(a, b, coll)
  --[[
    x,y = coll:getNormal()
    text = a:getUserData().." colliding with "..b:getUserData().." with a vector normal of: "..x..", "..y
    ]]--
  a:getUserData():handleCollisionBegin(b:getUserData())
  b:getUserData():handleCollisionBegin(a:getUserData())
end

function endContact(a, b, coll)
--[[
    persisting = 0
    text = text.."\n"..a:getUserData().." uncolliding with "..b:getUserData()
    ]]--
  a:getUserData():handleCollisionEnd(b:getUserData())
  b:getUserData():handleCollisionEnd(a:getUserData())
end

function preSolve(a, b, coll)
  --[[
    if persisting == 0 then    -- only say when they first start touching
        text = text.."\n"..a:getUserData().." touching "..b:getUserData()
    elseif persisting < 20 then    -- then just start counting
        text = text.." "..persisting
    end
    persisting = persisting + 1    -- keep track of how many updates they've been touching for
    ]]--
end

function postSolve(a, b, coll, normalimpulse1, tangentimpulse1, normalimpulse2, tangentimpulse2)
end
