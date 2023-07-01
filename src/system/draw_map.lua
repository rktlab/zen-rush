-- Create a draw System.
local DrawMap = class("DrawMap", System)

-- Define this System requirements.
function DrawMap:requires()
  return {maps = {"Map"}, players = {"PlayerControlled"}}
end

function DrawMap:draw()
  -- Get the player to have its current map position
  -- It's not very ideal to do this grouping things. It feels likes I breaking
  -- the architecture

  local player = self.targets.players[1]
  -- get the map pos of the player (px)
  local player_map_pos = player:get("Position")

  -- Normally there is only one map, but let's loop on nonetheless
  for _, entity in pairs(self.targets.maps) do
    local tile_size = entity:get("TileSize").value
    local screen_size = entity:get("ScreenSize")
    -- Determine the visible portion of the map on the screen
    local start_x = math.floor(player_map_pos.x - screen_size.x / 2)
    local start_y = math.floor(player_map_pos.y - screen_size.y / 2)

    -- print("Player coord: " .. player_map_pos.x .. ", " .. player_map_pos.y)
    -- print("Screen start pos: " .. start_x .. ", " .. start_y)

    -- loop from around those bound
    for y = start_y, start_y + screen_size.y, tile_size do
      for x = start_x, start_x + screen_size.x, tile_size do
        -- We need to calculate the remainder of the tile, to know how many
        -- pixel we should move it so that we don't stick to the exact tile
        local delta_x = math.fmod(x, tile_size)
        local delta_y = math.fmod(y, tile_size)

        -- print("Map coord to print: " .. x .. ", " .. y)
        -- We go from map coord, to screen coord
        screen_x = x - start_x
        screen_y = y - start_y
        -- print("Screen coord: " .. x .. ", " .. y)

        -- Get the spritesheet
        local quad = entity:get("Spritesheet").sheet
        local tile_x = math.floor(x / tile_size)
        local tile_y = math.floor(y / tile_size)

        -- Here, render each layer
        for _, layer in ipairs(entity:get("Map").layers) do
          --print("Tile coord: " .. tile_x .. ", " .. tile_y)
          local tile_value = layer[tile_y][tile_x]
          -- print("tile_value: " .. tile_value)
          if not (tile_value == 0) then
            -- print("tile_value: " .. tile_value)

            local tile = quad[tile_value]

            love.graphics.draw(
              resources.images.spritesheet,
              tile,
              screen_x,
              screen_y,
              0, -- rotation
              1, -- scale x
              1, -- scale y
              delta_x, -- origin x
              delta_y -- origin y
            )
          end
        end
      end
    end
  end
end

return DrawMap
