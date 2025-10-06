return {
  "MagicDuck/grug-far.nvim",
  -- opts = { headerMaxWidth = 20 },
  cmd = "GrugFar",
  keys = {
    {
      "<leader>sr",
      function()
        local grug = require("grug-far")
        grug.toggle_instance({
          instanceName = "far",
          staticTitle = "Find and Replace",
          openTargetWindow = {
            preferredLocation = "below",
          },
        })
      end,
      mode = { "n", "v" },
      desc = "Search and Replace",
    },
  },
}