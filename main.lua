function love.load()
  screenDim = {}
  screenDim.x, screenDim.y = love.graphics.getDimensions()

  player = require "lib.player"
  map = require "lib.map"
end

function love.update()
  if not gameOver then
    map.update()
    player.update()
  end
end

function love.draw()
  map.draw()
  player.draw()
end
