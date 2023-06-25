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

local ColisionComponent = require("component.colision")
local MapComponent = require("component.map")
local TileSizeComponent = require("component.tile_size")
local TilesInfoComponent = require("component.tile_info")
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
  resources:addImage("spritesheet", "assets/sprite.png")

  -- load all the resources
  resources:load()

  -- Setup an Engine.
  engine = Engine()

  local scene = Entity()

  -- Add the player
  local player =
    PlayerEntity:create(
    -- Pos in tile
    408,
    408,
    resources.images.player,
    scene
  )

  engine:addEntity(player)

  -- Initialize the Scene
  scene:add(MapComponent(helper.load_map(require("assets.map"))))
  scene:add(TilesInfoComponent(require("assets.sprite").tiles))
  scene:add(TileSizeComponent())
  scene:add(ScreenSizeComponent(screen_width, screen_height))
  scene:add(Spritesheet(helper.create_spritesheet()))
  scene:add(ColisionComponent(scene:get("TileSize").value))

  engine:addEntity(scene)

  -- Initial colision setup
  colision = scene:get("Colision").layer
  colision:add(player, 408, 408, 16, 16)
  add_map_colision(
    colision,
    scene:get("Map").layers,
    scene:get("TilesInfo").info
  )

  -- Add our systems to the engine
  engine:addSystem(MovePlayerSystem(), "update")
  engine:addSystem(DrawMapSystem(), "draw")
  engine:addSystem(DrawPlayerSystem(), "draw")
end

function love.update(dt)
  require("vendors.lurker").update()
  -- Will run each system with type == 'update'
  engine:update(dt)
  require("vendors.lovebird").update()
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

function add_map_colision(colision, layers, tiles_info)
  -- loop on the whole map
  -- not ideal, layer could be different size?
  for y = 1, #layers[1] do
    for x = 1, #layers[1][y] do
      -- determine the id of the upmost tile that is not a 0
      upmost_id = return_upmost_id(x, y, layers)
      --print(upmost_id)
      -- check if it collide
      colide = tiles_info[upmost_id]["colision"]
      --print(colide)
      if colide then
        -- if so, add it the colision map
        colision:add({name = "tile_" .. x .. "_" .. y}, x*16, y*16, 16, 16)
      end
    end
  end
end

function return_upmost_id(x, y, layers)
  for i=#layers, 1, -1 do
    if not ( layers[i][y][x] == 0) then
      return layers[i][y][x]
    end
  end

end
