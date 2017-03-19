function love.load()
  screenDim = {}
  screenDim.x, screenDim.y = love.graphics.getDimensions()

  player = require "lib.player"
  map = require "lib.map"
end

function love.update()
  map.update()
  player.update()
end

function love.draw()
  map.draw()
  player.draw()
end
