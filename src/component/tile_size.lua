local TileSize = Component.create("TileSize")

function TileSize:initialize(size)
  self.value = size or 16
end

return TileSize
