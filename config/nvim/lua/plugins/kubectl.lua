return {
	{
		"Ramilito/kubectl.nvim",
		cmd = { "Kubectl", "Kubectx", "Kubens" },
		keys = {
			{ "<leader>kc", '<cmd>lua require("kubectl").toggle()<cr>' },
		},
		opts = {
			lineage = { enabled = true },
			kubectl_cmd = {
				env = {
					KUBECONFIG = "$HOME/.kubeconfig",
					AWS_CONFIG_FILE = "$HOME/.config/aws/config",
					AWS_SHARED_CREDENTIALS_FILE = "$HOME/.config/aws/credentials",
				},
			},
		},
	},
}
