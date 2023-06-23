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
-- Entities

-- local Beer = require("entities.beer")
-- local Snake = require("entities.beer")
local PlayerEntity = require("entity.player")

-- ---------------------------------------------------------------------------
-- Systems

local DrawSystem = require("system.draw")


-- ---------------------------------------------------------------------------
-- Require the rest of our libraries

local helper = require("game.helper")
require("game.resources")

WorldState = {}

function love.load()
  -- Initialize the world
  WorldState["score"] = 0
  WorldState["tiles_size"] = 32
  width, height = love.graphics.getDimensions()
  WorldState["width"] = width / WorldState["tiles_size"]
  WorldState["height"] = height / WorldState["tiles_size"]

  -- collect all resources to load
  resources = Resources()

  resources:addImage("player", "assets/sprites/player.png")

  -- load all the resources
  resources:load()

  -- Finally, we setup an Engine.
  engine = Engine()

  --  -- We add the initial beer
  --  engine:addEntity(
  --    Beer:create(WorldState["width"] - 2, WorldState["height"] / 2)
  --  )
  --  -- and the snake
  engine:addEntity(PlayerEntity:create(100, 100, resources.images.player))

  -- Let's add the MoveSystem to the Engine. Its update()
  -- method will be invoked within any Engine:update() call.
  --engine:addSystem(MoveSystem())

  -- This will be a 'draw' System, so the
  -- Engine will call its draw method.
  engine:addSystem(DrawSystem(), "draw")
end

function love.update(dt)
  require("vendors.lurker").update()
  -- Will run each system with type == 'update'
  engine:update(dt)
end

function love.draw()
  helper.printFps()
  -- TODO: also show the tick per second
  -- Will invoke the draw() method on each system with type == 'draw'
  engine:draw()
end
