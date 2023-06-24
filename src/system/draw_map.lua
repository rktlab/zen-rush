-- Create a draw System.
local DrawMap = class("DrawMap", System)

-- Define this System requirements.
function DrawMap:requires()
  return { maps = {"Map"}, players = {"PlayerControlled"}}
end

function DrawMap:draw()
  print("Let's draw the map")
  -- Get the player to have its current map position
  -- It's not very ideal to do this grouping things. It feels likes I breaking
  -- the architecture

  local player = self.targets.players[1]
  local player_map_pos = player:get("Position")

  print("Player pos: ".. player_map_pos.x)

  -- Normally there is only one map, but let's loop on nonetheless
  for _, entity in pairs(self.targets.maps) do
    print("We have a map")
    print()

    -- Determine what is visible on the screen based on the player map position.
    -- This will be in Tiles.
    local start_x = player_map_pos.x - entity:get("ScreenSize").x / 2
    local start_y = player_map_pos.y - entity:get("ScreenSize").y / 2

    -- loop from around those bound
    for y = start_y, start_y + entity:get("ScreenSize").y do
      for x = start_x, start_x + entity:get("ScreenSize").x do
        -- Currently we only have one sprite for the map
        -- later on we'll have an if that select the right sprite
        -- if entity.map.tiles[y][x] == whatever, do whatever else

        -- convert x/y to screen pos

        love.graphics.draw(
          resources.images.map,
          x*16,
          y*16
          --0, -- rotation
          --1, -- scale x
          --1, -- scale y
          --entity:get("TileSize").value / 2, -- origin x
          --entity:get("TileSize").value / 2 -- origin y
        )
      end
    end
  end
end

return DrawMap
