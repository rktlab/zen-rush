--local Energy = require("component.energy")
local Direction = require("component.direction")
--local Move = require("component.move")
local PlayerControlled = require("component.player_controlled")
local Position = require("component.position")
local Velocity = require("component.velocity")
local Sprite = require("component.sprite")

local Player = class("Player")

function Player:create(pos_x, pos_y, sprite, parent)
  local player = Entity(parent)
  player:initialize()

  -- Add all the component to the entity
  --  player:add(Energy())
  --  player:add(Move())
  player:add(Direction())
  player:add(PlayerControlled())
  player:add(Position(pos_x, pos_y))
  -- 16px per seconds
  player:add(Velocity())
  player:add(Sprite(sprite))

  return player
end

return Player
