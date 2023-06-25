local TilesInfo = Component.create("TilesInfo")

function TilesInfo:initialize(info)
  self.info = {}
  for _, tile in ipairs(info) do
    self.info[tile.id+1] = tile.properties
  end
end

return TilesInfo
