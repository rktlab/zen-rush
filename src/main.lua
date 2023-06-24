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
local Spritesheet = require("component.spritesheet")

-- ---------------------------------------------------------------------------
-- Entities

-- local Beer = require("entities.beer")
-- local Snake = require("entities.beer")
local PlayerEntity = require("entity.player")

-- ---------------------------------------------------------------------------
-- Systems

local DrawMapSystem = require("system.draw_map")
local DrawPlayerSystem = require("system.draw_player")
local MovePlayerSystem = require("system.move_player")

-- ---------------------------------------------------------------------------
-- Require the rest of our libraries

local helper = require("game.helper")
local cute = require("vendors.cute")
require("game.resources")

function love.load(args)
  -- Test
  cute.go(args)

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
  resources:addImage("spritesheet", "assets/sprite.png")

  -- load all the resources
  resources:load()

  -- Setup an Engine.
  engine = Engine()

  local scene = Entity()

  -- and the player
  engine:addEntity(
    PlayerEntity:create(
      -- Pos in tile
      408,
      408,
      resources.images.player,
      scene
    )
  )

  -- Initialize the Scene
  scene:add(MapComponent(helper.load_map(require("assets.map"))))
  scene:add(TileSizeComponent())
  scene:add(ScreenSizeComponent(screen_width, screen_height))
  scene:add(Spritesheet(helper.create_spritesheet()))

  engine:addEntity(scene)

  -- Let's add the MoveSystem to the Engine. Its update()
  -- method will be invoked within any Engine:update() call.
  --engine:addSystem(MoveSystem())

  -- This will be a 'draw' System, so the
  -- Engine will call its draw method.
  engine:addSystem(MovePlayerSystem(), "update")
  engine:addSystem(DrawMapSystem(), "draw")
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
      -- TODO: also show the tick per second
      -- Will invoke the draw() method on each system with type == 'draw'
      engine:draw()
      helper.printFps()
      cute.draw(love.graphics)
    end
  )
end

function love.resize(w, h)
  screen:handleResize()
end

--function love.keypressed(key)
--  print(key)
--    if key == 'right' then
--        direction = 'right'
--    elseif key == 'left' then
--        direction = 'left'
--    elseif key == 'down' then
--        direction = 'down'
--    elseif key == 'up' then
--        direction = 'up'
--    end
--end
