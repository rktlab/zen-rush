local cute = require("vendors.cute")
local helper = require("game.helper")

notion(
  "Can compare numbers, strings, etc",
  function()
    check(1).is(1)
    check("hello").is("hello")
  end
)

notion(
  "fk should work",
  function()
    local width = 2

    check(helper.fk(1, width)).is(1, 1)
    check(helper.fk(2, width)).is(2, 1)
    check(helper.fk(3, width)).is(1, 2)
    check(helper.fk(4, width)).is(2, 2)
  end
)

notion(
  "Converting line map to multi-dimentional table should work",
  function()
    local data = {0, 0, 0, 1, 0, 0, 1, 0, 0, 1, 0, 0, 1, 0, 0, 0}
    local width = 4

    map = helper.line_map_to_table(data, 4)

    check(map[1]).shallowMatches({0, 0, 0, 1})
    check(map[2]).shallowMatches({0, 0, 1, 0})
    check(map[3]).shallowMatches({0, 1, 0, 0})
    check(map[4]).shallowMatches({1, 0, 0, 0})
  end
)

notion(
  "Loading map should return a table of layers",
  function()
    local loaded_map = {
      layers = {
        {
          width = 4,
          visible = true,
          data = {0, 0, 0, 1, 0, 0, 1, 0, 0, 1, 0, 0, 1, 0, 0, 0}
        },
        {
          width = 4,
          visible = false,
          data = {2, 2, 2, 3, 2, 2, 3, 2, 2, 3, 2, 2, 3, 2, 3, 2}
        },
        {
          width = 4,
          visible = true,
          data = {1, 1, 1, 2, 1, 1, 2, 1, 1, 2, 1, 1, 2, 1, 1, 1}
        }
      }
    }

    layers = helper.load_map(loaded_map)

    check(layers[1][1]).shallowMatches({0, 0, 0, 1})
    check(layers[1][2]).shallowMatches({0, 0, 1, 0})
    check(layers[1][3]).shallowMatches({0, 1, 0, 0})
    check(layers[1][4]).shallowMatches({1, 0, 0, 0})

    check(layers[2][1]).shallowMatches({1, 1, 1, 2})
    check(layers[2][2]).shallowMatches({1, 1, 2, 1})
    check(layers[2][3]).shallowMatches({1, 2, 1, 1})
    check(layers[2][4]).shallowMatches({2, 1, 1, 1})
  end
)
