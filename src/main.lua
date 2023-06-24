-- ---------------------------------------------------------------------------
-- Main Lövetoys Library
lovetoys = require("vendors.lovetoys")

-- ---------------------------------------------------------------------------
-- Initialize lovetoys
--
-- debug = true will enable library console logs
-- globals = true will register lovetoys classes in the global namespace
-- so you can access i.e. Entity() in addition to lovetoys.Entity()
lovetoys.initialize({globals = true, debug = true})

-- ---------------------------------------------------------------------------
-- Screen and scaling

local tile_size = 16
local Terebi = require "vendors.terebi"

-- ---------------------------------------------------------------------------
-- Component

local MapComponent = require("component.map")
local TileSizeComponent = require("component.tile_size")
local ScreenSizeComponent = require("component.screen_size")

-- ---------------------------------------------------------------------------
-- Entities

-- local Beer = require("entities.beer")
-- local Snake = require("entities.beer")
local PlayerEntity = require("entity.player")

-- ---------------------------------------------------------------------------
-- Systems

local DrawMapSystem = require("system.draw_map")
local DrawPlayerSystem = require("system.draw_player")

-- ---------------------------------------------------------------------------
-- Require the rest of our libraries

local helper = require("game.helper")
require("game.resources")

function love.load()
  -- Initialize screen
  Terebi.initializeLoveDefaults()
  screen = Terebi.newScreen(tile_size * 17, tile_size * 13, 3)

  -- Parameters: game width, game height, starting scale factor
  --screen:toggleFullscreen()

  local window_width, window_height = love.graphics.getDimensions()
  local screen_width, screen_height =
    screen:windowToScreen(window_width, window_height)

  -- collect all resources to load
  resources = Resources()

  resources:addImage("player", "assets/sprites/player.png")
  resources:addImage("green", "assets/sprites/green.png")
  resources:addImage("map", "assets/sprites/map_placeholder.png")

  -- load all the resources
  resources:load()

  -- Setup an Engine.
  engine = Engine()

  -- Create an empty map.
  map = {}
  for i = 1, 51 do
    map[i] = {}
    for j = 1, 51 do
      map[i][j] = 0
    end
  end

  -- Initialize the Scene
  Scene = engine:getRootEntity()

  Scene:add(MapComponent(map))
  Scene:add(TileSizeComponent())
  Scene:add(ScreenSizeComponent(screen_width, screen_height))

  -- and the player
  engine:addEntity(
    PlayerEntity:create(
      -- Pos in tile
      25,
      25,
      resources.images.player
    )
  )

  -- Let's add the MoveSystem to the Engine. Its update()
  -- method will be invoked within any Engine:update() call.
  --engine:addSystem(MoveSystem())

  -- This will be a 'draw' System, so the
  -- Engine will call its draw method.
  -- engine:addSystem(DrawMapSystem(), "draw")
  engine:addSystem(DrawPlayerSystem(), "draw")
end

function love.update(dt)
  require("vendors.lurker").update()
  -- Will run each system with type == 'update'
  engine:update(dt)
end

function love.draw()
  screen:draw(
    function()
      helper.printFps()
      -- TODO: also show the tick per second
      -- Will invoke the draw() method on each system with type == 'draw'
      engine:draw()
    end
  )
end

function love.resize(w, h)
  screen:handleResize()
end
