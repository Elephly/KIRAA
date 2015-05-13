function lerp(a,b,t)
  return (((1 - t) * a) + (t * b))
end

function lerp2(a,b,t)
  return (a + ((b - a) * t))
end

-- Does not return value. Modifies vector parameter.
function normalizeVec2(vector, value)
  local hyp = math.sqrt((vector.x * vector.x) + (vector.y * vector.y))
  local newVector = { x = 0, y = 0 }
  if hyp > 0 then
    newVector.x = vector.x / (hyp / value)
    newVector.y = vector.y / (hyp / value)
  end
  return newVector
end

function perpendicularVector2(vector)
  return { x = -vector.y, y = vector.x }
end

function addVec2(vector1, vector2)
  return { x = vector1.x + vector2.x, y = vector1.y + vector2.y }
end

-- Subtract vector2 from vector1
function subVec2(vector1, vector2)
  return { x = vector1.x - vector2.x, y = vector1.y - vector2.y }
end

function multByConstVec2(vector, num)
  return { x = vector.x * num, y = vector.y * num }
end

function midVec2(vector1, vector2)
  return addVec2(vector1, multByConstVec2(subVec2(vector2, vector1), 0.5))
end

function lineToPolygon(line)
  perpVec = perpendicularVector2(subVec2(line.endPoint, line.startPoint))
  perpVec = normalizeVec2(perpVec, line.width)
  local polygon = {
    point1 = addVec2(line.startPoint, perpVec),
    point2 = subVec2(line.startPoint, perpVec),
    point3 = subVec2(line.endPoint, perpVec),
    point4 = addVec2(line.endPoint, perpVec)
  }
  return polygon
end
