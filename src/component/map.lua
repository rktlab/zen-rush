local Map = Component.create("Map")

function Map:initialize(map)
  self.tiles = map or {}
end

return Map
