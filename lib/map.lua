local map = {}
map.moveSpeed = 10
map.platforms = {}
map.progress = 0
local noiseX = 0

local function createPlatform()
  local platform = {}
  platform.w = math.random() * screenDim.x / 2 + screenDim.x * (3 / 4)
  platform.h = love.math.noise(noiseX) * screenDim.y / 2 + screenDim.y / 6

  noiseX = noiseX + 0.5
  return platform
end

local function cullPlatforms()
  while map.platforms[1] and map.platforms[1].w - map.progress < 0 do
    table.remove(map.platforms, 1)
    map.progress = - screenDim.x / 6
  end
end

local function populatePlatforms()
  while #map.platforms < 2 do
    table.insert(map.platforms, createPlatform())
  end
end

map.update = function()
  cullPlatforms()
  populatePlatforms()

  map.progress = map.progress + map.moveSpeed
end

map.draw = function()
  local offset = 0

  for i=1, #map.platforms do
    local platform = map.platforms[i]
    print()

    love.graphics.setColor(0, 255, 0)
    love.graphics.rectangle("fill", - map.progress + offset, screenDim.y - platform.h, platform.w, platform.h)
    offset = offset + platform.w + screenDim.x / 6
  end
end

return map
