return {
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup({})
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			require("mason-lspconfig").setup({
				-- see https://github.com/williamboman/mason-lspconfig.nvim?tab=readme-ov-file#available-lsp-servers
				ensure_installed = { "lua_ls", "tsserver", "html", "jdtls" },
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		config = function()
			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			local lspconfig = require("lspconfig")

			lspconfig.lua_ls.setup({
				capabilities = capabilities,
			})
			lspconfig.tsserver.setup({
				capabilities = capabilities,
			})
			lspconfig.html.setup({
				capabilities = capabilities,
			})
			lspconfig.jdtls.setup({
				capabilities = capabilities,
				cmd = {
					"jdtls",
					"--jvm-arg="
						.. string.format("-javaagent:%s", vim.fn.expand("~/.config/nvim/dependencies/lombok.jar")),
					"-configuration " .. vim.fn.expand("~/.cache/jdlts/config"),
					"-data " .. vim.fn.expand("~/.cache/jdtls/workspace"),
				},
			})

			vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
			vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
			vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})
		end,
	},
}
