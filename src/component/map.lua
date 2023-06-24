local Map = Component.create("Map")

function Map:initialize(map)
  self.layers = map or {}
end

return Map
