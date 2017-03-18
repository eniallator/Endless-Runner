function love.load()
  screenDim = {}
  screenDim.x, screenDim.y = love.graphics.getDimensions()

  player = require "lib.player"
end

function love.update()
  player.update()
end

function love.draw()
  player.draw()
end
