local collision = require "lib.collision"

local player = {}

player.dim = {w = screenDim.y / 37.5, h = screenDim.y / 18.75}
player.pos = {x = screenDim.x / 5}
player.velY = 0
player.jumpSpeed = -17

local jumpHeld = false

local function getInput(dt)
  if love.keyboard.isDown('space') and not jumpHeld and player.onGround then
    player.velY = player.velY + player.jumpSpeed
  end

  jumpHeld =love.keyboard.isDown('space')
end

local function updateMovement()
  player.velY = player.velY + 0.9
  player.onGround = false

  if collision.playerToPlatform(function(platformY) return player.pos.y + player.dim.h < platformY end) then
    player.velY = 0
    player.onGround = true

  elseif collision.playerToPlatform(function() return true end) then
    gameOver = true

  elseif player.pos.y + player.velY > screenDim.y - player.dim.h then
    player.velY = 0
    player.onGround = true

  elseif player.pos.y + player.velY < 0 then
    player.velY = player.velY * 0.5

  else
    player.pos.y = player.pos.y + player.velY
  end
end

player.update = function()
  if not player.pos.y then
    player.pos.y = screenDim.y - map.platforms[1].h - player.dim.h - 5
  end

  getInput()
  updateMovement()
end

player.draw = function()
  love.graphics.setColor(0, 0, 255)
  love.graphics.rectangle('fill', player.pos.x, player.pos.y, player.dim.w, player.dim.h)
end

return player
