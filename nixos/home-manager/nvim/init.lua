return {
  colorscheme = "astrolight",
  lsp = {
    config = {
      yamlls = {
        filetypes = { "yaml", "json" },
        settings = {
          yaml = {
            schemaDownload = {
              enable = true,
            },
            trace = {                                                                                                                                                                                       
              server = "verbose"                                                                                                                                                                          
            },
            validate = true,
            schemas = {
              kubernetes = "/*.yaml",
              -- ["file:///Users/andriinasinnyk/.config/nvim/lua/user/yamlls/crds/devops/all.json"] = "*.yaml",
              -- ["https://raw.githubusercontent.com/anasinnyk/astrovim/main/yamlls/crds/devops/all.json"] = "*.yaml",
            },
          },
        },
      },
    },
  },
  plugins = {
    "AstroNvim/astrocommunity",
    { import = "astrocommunity.pack.rust" },
    { import = "astrocommunity.pack.go" },
    { import = "astrocommunity.pack.haskell" },
    { import = "astrocommunity.pack.python" },
    { import = "astrocommunity.pack.yaml" },
    { import = "astrocommunity.pack.json" },
    { import = "astrocommunity.pack.terraform" },
    { import = "astrocommunity.pack.markdown" },
    { import = "astrocommunity.motion.nvim-surround" },
    { import = "astrocommunity.debugging.nvim-bqf" },
    { import = "astrocommunity.diagnostics.trouble-nvim" },
    { import = "astrocommunity.completion.copilot-lua" },
    { import = "astrocommunity.completion.copilot-lua-cmp" },
    {
      "simrat39/rust-tools.nvim",
      keys = {
        { "<leader>lrA", "<cmd>RustHoverActions<cr>",     desc = "Hover Actions" },
        { "<leader>lrm", "<Cmd>RustExpandMacro<cr>",      desc = "Expand Macro" },
        { "<leader>lrH", "<Cmd>RustToggleInlayHints<cr>", desc = "Toggle Inlay Hints" },
        { "<leader>lre", "<Cmd>RustRunnables<cr>",        desc = "Runnables" },
        { "<leader>lrD", "<cmd>RustDebuggables<Cr>",      "Debuggables" },
        { "<leader>lrP", "<cmd>RustParentModule<Cr>",     "Parent Module" },
        { "<leader>lrv", "<cmd>RustViewCrateGraph<Cr>",   "View Crate Graph" },
        { "<leader>lrc", "<Cmd>RustOpenCargo<cr>",        desc = "Open Cargo" },
        { "<leader>lro", "<Cmd>RustOpenExternalDocs<cr>", desc = "Open External Docs" },
      },
    },
    {
      "Saecki/crates.nvim",
      keys = {
        { "<leader>lrt", "<Cmd>lua require('crates').toggle()<cr>",                  desc = "Toggle Crate" },
        { "<leader>lru", "<Cmd>lua require('crates').update_crate()<cr>",            desc = "Update Crate" },
        { "<leader>lrU", "<Cmd>lua require('crates').upgrade_crate()<cr>",           desc = "Upgrade Crate" },
        { "<leader>lrg", "<Cmd>lua require('crates').update_all_crates()<cr>",       desc = "Update All" },
        { "<leader>lrG", "<Cmd>lua require('crates').upgrade_all_crates()<cr>",      desc = "Upgrade All" },
        { "<leader>lrH", "<Cmd>lua require('crates').open_homepage()<cr>",           desc = "Open HomePage" },
        { "<leader>lrD", "<Cmd>lua require('crates').open_documentation()<cr>",      desc = "Open Documentation" },
        { "<leader>lrR", "<Cmd>lua require('crates').open_repository()<cr>",         desc = "Open Repository" },
        { "<leader>lrv", "<Cmd>lua require('crates').show_versions_popup()<cr>",     desc = "Show Versions" },
        { "<leader>lrF", "<Cmd>lua require('crates').show_features_popup()<cr>",     desc = "Show Features" },
        { "<leader>lrD", "<Cmd>lua require('crates').show_dependencies_popup()<cr>", desc = "Show Dependencies" },
      },
    },
    {
      "folke/todo-comments.nvim",
      dependencies = { "nvim-lua/plenary.nvim" },
      opts = {},
      event = "User AstroFile",
      keys = {
        { "<leader>T", "<cmd>TodoTelescope<cr>", desc = "Open TODOs in Telescope" },
      },
    },
    {
      "allaman/kustomize.nvim",
      requires = "nvim-lua/plenary.nvim",
      ft = "yaml",
      opts = { defaults = true },
    },
    {
      'pwntester/octo.nvim',
      requires = {
        'nvim-lua/plenary.nvim',
        'nvim-telescope/telescope.nvim',
        'kyazdani42/nvim-web-devicons',
      },
      event = "User AstroGitFile",
      config = function()
        require "octo".setup()
      end
    },
  }
}
