local map = {}
map.moveSpeed = 10
map.buildings = {}
map.progress = 0
local noiseX = 0

local function createBuilding()
  local building = {}
  building.w = math.random() * screenDim.x / 2 + screenDim.x * (3 / 4)
  building.h = love.math.noise(noiseX) * screenDim.y / 2 + screenDim.y / 6

  noiseX = noiseX + 0.5
  return building
end

local function cullBuildings()
  while map.buildings[1] and map.buildings[1].w - map.progress < 0 do
    table.remove(map.buildings, 1)
    map.progress = - screenDim.x / 6
  end
end

local function populateBuildings()
  while #map.buildings < 2 do
    table.insert(map.buildings, createBuilding())
  end
end

map.update = function()
  cullBuildings()
  populateBuildings()

  map.progress = map.progress + map.moveSpeed
end

map.draw = function()
  local offset = 0

  for i=1, #map.buildings do
    local building = map.buildings[i]
    print()

    love.graphics.setColor(0, 255, 0)
    love.graphics.rectangle("fill", - map.progress + offset, screenDim.y - building.h, building.w, building.h)
    offset = offset + building.w + screenDim.x / 6
  end
end

return map
