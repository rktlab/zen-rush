-- Create a draw System.
local DrawMap = class("DrawSystem", System)

-- Define this System requirements.
function DrawMap:requires()
  return {"Map"}
end

function DrawMap:draw()
  -- Normally there is only one map, but let's loop on them nonethless
  for _, entity in pairs(self.targets) do
    -- Determine what is visible on the screen based on the player map position
    -- This will be in Tiles
    -- TODO
    -- loop from around those bound
    for y = start_y, end_y do
      for x = start_x, end_x do
        -- Currently we only have one sprite for the map
        -- later on we'll have an if that select the right sprite
        -- if map[y][x] == whatever, do whatever else

        -- convert x/y to screen pos

        love.graphics.draw(
          resources.images.map,
          x,
          y,
          0, -- rotation
          1, -- scale x
          1, -- scale y
          entity:get("TileSize") / 2, -- origin x
          entity:get("TileSize") / 2 -- origin y
        )
      end
    end
  end
end

return DrawMap
