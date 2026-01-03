return {
  {
    "zbirenbaum/copilot.lua",
    config = true,
    opts = {
      filetypes = {
        markdown = true,
      },
      should_attach = function(_, bufname)
        if string.match(bufname, "novelslop") then
          return false
        end
        if string.match(bufname, "env") then
          return false
        end

        return true
      end
    },
  },
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    dependencies = {
      { "zbirenbaum/copilot.lua" }, -- or zbirenbaum/copilot.lua
      { "nvim-lua/plenary.nvim" },  -- for curl, log and async functions
    },
    config = true,
    keys = {
      { "<leader>ai", "<cmd>CopilotChatToggle<cr>", desc = "Toggle Copilot" }
    }
  }
}
