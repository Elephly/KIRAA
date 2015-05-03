function lerp(a,b,t)
  return (((1 - t) * a) + (t * b))
end

function lerp2(a,b,t)
  return (a + ((b - a) * t))
end

-- Does not return value. Modifies vector parameter.
function normalizeVector2(vector, value)
  local hyp = math.sqrt((vector.x * vector.x) + (vector.y * vector.y))
  if hyp > 0 then
    vector.x = vector.x / (hyp / value)
    vector.y = vector.y / (hyp / value)
  end
end

function perpendicularVector2(vector)
  newVector = {
    x = -vector.y,
    y = vector.x
  }
  return newVector
end

function addVector2(vector1, vector2)
  newVector = {
    x = vector1.x + vector2.x,
    y = vector1.y + vector2.y
  }
  return newVector
end

-- Subtract vector2 from vector1
function subtractVector2(vector1, vector2)
  newVector = {
    x = vector1.x - vector2.x,
    y = vector1.y - vector2.y
  }
  return newVector
end

function lineToPolygon(line)
  perpVec = perpendicularVector2(subtractVector2(line.endPoint, line.startPoint))
  normalizeVector2(perpVec, line.width)
  polygon = {
    point1 = addVector2(line.startPoint, perpVec),
    point2 = subtractVector2(line.startPoint, perpVec),
    point3 = subtractVector2(line.endPoint, perpVec),
    point4 = addVector2(line.endPoint, perpVec)
  }
  return polygon
end
