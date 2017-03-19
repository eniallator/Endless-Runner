local collision = {}

local function collideAxis(box1, box2, axis, dim)
  if box1[axis] < box2[axis] + box2[dim] and box2[axis] <= box1[axis] + box1[dim] then
    return true
  end
end

collision.aabb = function(box1, box2)
  if collideAxis(box1, box2, "x", "w") and collideAxis(box1, box2, "y", "h") then
    return true
  end
end

collision.playerToPlatform = function(functionMode)
  local playerBox = {
    x = player.pos.x,
    y = player.pos.y + player.velY,
    w = player.dim.w,
    h = player.dim.h
  }

  local offset = 0

  for i=1, #map.platforms do
    local platform = map.platforms[i]
    local platformBox = {
      x = - map.progress + offset,
      y = screenDim.y - platform.h,
      w = platform.w,
      h = platform.h
    }
    offset = offset + platform.w + screenDim.x / 9

    if collision.aabb(playerBox, platformBox) and functionMode(platformBox.y) then
      return true
    end
  end
end

return collision
