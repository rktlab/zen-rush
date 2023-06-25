local helper = {}

-- Print the FPS
function helper.printFps(x, y)
  love.graphics.print(
    "FPS: " .. tostring(love.timer.getFPS()),
    x or 10,
    y or 10
  )
end

-- Return the various layer in multi-dimensional format
function helper.load_map(map)
  -- print(map.version)
  local mmap = {}

  for _, layer in ipairs(map.layers) do
    if layer.visible then
      mmap[#mmap + 1] = helper.line_map_to_table(layer.data, layer.width)
    end
  end

  return mmap
end

function helper.line_map_to_table(data, width)
  map = {}

  for k = 1, #data do
    x, y = helper.fk(k, width)

    if not map[y] then
      map[y] = {}
    end

    map[y][x] = data[k]
  end

  return map
end

-- f(k, width) = x,y
-- Return x & y based on the index and width of the table
-- k = current index
-- width = width of the map
function helper.fk(k, width)
  local x, y
  local mod = k % width

  if mod == 0 then
    x = width
  else
    x = mod
  end

  y = math.ceil(k / width)

  return x, y
end

-- Create a spritesheet from the sprites images
function helper.create_spritesheet()
  local sprites = resources.images.spritesheet
  local width = sprites:getWidth()
  local height = sprites:getHeight()

  sheet = {}

  local tile_width = 16
  local tile_height = 16

  local column = width / tile_width
  local lines = height / tile_width

  -- loop on the spritesheet
  -- which has 6 lines, and 8 column
  for y = 0, lines - 1 do
    for x = 0, column - 1 do
      table.insert(
        sheet,
        love.graphics.newQuad(
          x * tile_width,
          y * tile_height,
          tile_width,
          tile_height,
          width,
          height
        )
      )
    end
  end

  return sheet
end

return helper
