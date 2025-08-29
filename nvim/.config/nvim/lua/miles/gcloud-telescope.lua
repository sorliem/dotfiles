local pickers = require("telescope.pickers")
local sorters = require("telescope.sorters")
local finders = require("telescope.finders")
local actions = require("telescope.actions")
local previewers = require("telescope.previewers")
local action_state = require("telescope.actions.state")
local utils = require("telescope.utils")
local work_functions = require("miles.work-commands")
local telescope_functions = require("miles.telescope-functions")

local function get_console_url(template, entry_value, project, opts)
	local url = template

	-- Handle entries with multiple values (tab-separated)
	local parts = vim.split(entry_value, "\t")
	local name = parts[1]
	local location = parts[2]

	-- Replace placeholders
	url = string.gsub(url, "{name}", name or entry_value)
	url = string.gsub(url, "{project}", project)
	url = string.gsub(url, "{location}", location or "")
	url = string.gsub(url, "{region}", location or "")

	-- Allow custom replacements if needed
	if opts.url_replacements then
		for placeholder, value in pairs(opts.url_replacements) do
			url = string.gsub(url, placeholder, value)
		end
	end

	return url
end

local gcloud_explore = function(opts)
	local show_value = opts.show_value
	local fmt_cmd = vim.split(string.format("%s --project=%s", opts.list_cmd, opts.project), " ")
	-- print("fmt_cmd = " .. vim.inspect(fmt_cmd))

	pickers
		.new({
			prompt_title = string.format("%s (%s)", opts.prompt_title, opts.project),
			results_title = "Results",
			finder = finders.new_oneshot_job(fmt_cmd, { cwd = vim.uv.cwd() }),
			sorter = sorters.get_fuzzy_file(),
			previewer = previewers.new_buffer_previewer({
				define_preview = function(self, entry, _)
					if not show_value then
						vim.api.nvim_buf_set_lines(self.state.bufnr, 0, -1, false, {
							"VALUE HIDDEN, Press <C-s> to toggle reveal",
						})
						return
					end

					local fmt_show_cmd = opts.show_cmd
					if opts.replace_str then
						local parts = vim.split(entry.value, "\t")
						local name = parts[1]
						local region_or_location = parts[2]

						fmt_show_cmd = string.gsub(fmt_show_cmd, opts.replace_str, name)
						if opts.region_replace_str and region_or_location then
							fmt_show_cmd = string.gsub(fmt_show_cmd, opts.region_replace_str, region_or_location)
						end
					else
						fmt_show_cmd = string.format(opts.show_cmd, entry.value, opts.project)
					end

					fmt_show_cmd = string.gsub(fmt_show_cmd, "PROJECT", opts.project)

					-- add --format flag if not present
					-- print("fmt_show_cmd = " .. vim.inspect(fmt_show_cmd))
					local fmt_show_cmd_split
					if string.find(fmt_show_cmd, "--format") then
						fmt_show_cmd_split =
							vim.split(string.format("%s --project=%s", fmt_show_cmd, opts.project), " ")
					else
						fmt_show_cmd_split = vim.split(
							string.format(
								"%s --format=%s --project=%s",
								fmt_show_cmd,
								opts.gcloud_display_format,
								opts.project
							),
							" "
						)
					end
					-- print("fmt_show_cmd_split = " .. vim.inspect(fmt_show_cmd_split))

					return require("telescope.previewers.utils").job_maker(fmt_show_cmd_split, self.state.bufnr, {
						callback = function(bufnr, content)
							-- print("content = " .. vim.inspect(content))
							if content ~= nil then
								-- print("preview_format = " .. vim.inspect(preview_format))
								require("telescope.previewers.utils").regex_highlighter(bufnr, opts.preview_format)
							end
						end,
					})
				end,
			}),
			attach_mappings = function(prompt_bufnr, map)
				map("i", "<C-s>", function()
					show_value = not show_value
					local current_picker = action_state.get_current_picker(prompt_bufnr)
					current_picker:refresh_previewer()
				end)

				-- Add the C-o mapping if console_url is defined
				if opts.console_url then
					map("i", "<C-o>", function()
						local selection = action_state.get_selected_entry()
						if selection then
							local url = get_console_url(opts.console_url, selection.value, opts.project, opts)
							-- Use the appropriate command for your OS
							local open_cmd = vim.fn.has("mac") == 1 and "open" or "xdg-open"
							vim.fn.system(string.format("%s '%s'", open_cmd, url))
						end
					end)
				end

				actions.select_default:replace(telescope_functions.copy_to_default_register(prompt_bufnr))
				return true
			end,
		}, {})
		:find()
end

local gcloud_mappings = {
	-- ============================================================================
	-- COMPUTE & CONTAINER SERVICES
	-- ============================================================================
	{
		cmd = "GcloudComputeInstances",
		prompt_title = "Compute Engine Instances",
		list_cmd = "gcloud compute instances list --format=value(name)",
		show_cmd = "gcloud compute instances describe %s",
		gcloud_display_format = "",
		console_url = "https://console.cloud.google.com/compute/instancesDetail/zones/{location}/instances/{name}?project={project}",
	},
	{
		cmd = "GcloudGkeClusters",
		prompt_title = "GKE Clusters",
		list_cmd = "gcloud container clusters list --format=value(name,location)",
		show_cmd = "gcloud container clusters describe CLUSTER_NAME --location=CLUSTER_REGION",
		replace_str = "CLUSTER_NAME",
		region_replace_str = "CLUSTER_REGION",
		console_url = "https://console.cloud.google.com/kubernetes/clusters/details/{location}/{name}?project={project}",
	},
	{
		cmd = "GcloudRunJobs",
		prompt_title = "Cloud Run Jobs in us-central1",
		list_cmd = "gcloud run jobs list --format=value(name)",
		show_cmd = "gcloud run jobs describe %s --region=us-central1",
		console_url = "https://console.cloud.google.com/run/jobs/details/us-central1/{name}?project={project}",
	},
	{
		cmd = "GcloudCloudFunctions",
		prompt_title = "Cloud Functions",
		list_cmd = "gcloud functions list --format=value(name)",
		show_cmd = "gcloud functions describe %s",
		console_url = "https://console.cloud.google.com/functions/details/{location}/{name}?project={project}",
	},

	-- ============================================================================
	-- STORAGE & DATABASES
	-- ============================================================================
	{
		cmd = "GcloudStorageBuckets",
		prompt_title = "Cloud Storage Buckets",
		list_cmd = "gcloud storage buckets list --format=value(name)",
		show_cmd = "gcloud storage buckets describe gs://%s",
		console_url = "https://console.cloud.google.com/storage/browser/{name}?project={project}",
	},
	{
		cmd = "GcloudSqlInstances",
		prompt_title = "Sql Instances",
		list_cmd = "gcloud sql instances list --format=value(name)",
		show_cmd = "gcloud sql instances describe %s",
		console_url = "https://console.cloud.google.com/sql/instances/{name}/overview?project={project}",
	},
	{
		cmd = "GcloudSqlUsers",
		prompt_title = "SQL Instance Users",
		list_cmd = "gcloud sql instances list --format=value(name)",
		show_cmd = "gcloud sql users list --instance=%s",
		gcloud_display_format = "[box]",
		console_url = "https://console.cloud.google.com/sql/instances/{name}/users?project={project}",
	},
	{
		cmd = "GcloudMemorystoreInstances",
		prompt_title = "Memorystore Redis Instances",
		list_cmd = "gcloud redis instances list --region=us-central1 --format=value(name.basename())",
		show_cmd = "gcloud redis instances describe %s --region=us-central1",
		console_url = "https://console.cloud.google.com/memorystore/redis/instances/us-central1/{name}/details?project={project}",
	},
	{
		cmd = "GcloudSpannerInstances",
		prompt_title = "Cloud Spanner Instances",
		list_cmd = "gcloud spanner instances list --format=value(name.basename())",
		show_cmd = "gcloud spanner instances describe %s",
		console_url = "https://console.cloud.google.com/spanner/instances/{name}/details/databases?project={project}",
	},
	{
		cmd = "GcloudBigTableInstances",
		prompt_title = "Bigtable Instances",
		list_cmd = "gcloud bigtable instances list --format=value(name.basename())",
		show_cmd = "gcloud bigtable instances describe %s",
		console_url = "https://console.cloud.google.com/bigtable/instances/{name}/overview?project={project}",
	},

	-- ============================================================================
	-- Load balancing
	-- ============================================================================
	{
		cmd = "GcloudBackendServices",
		prompt_title = "Load Balancer Backend Services",
		list_cmd = "gcloud compute backend-services list --format=value(name)",
		show_cmd = "gcloud compute backend-services describe %s --global",
		console_url = "https://console.cloud.google.com/networking/backends/details/{name}?project={project}",
	},
	{
		cmd = "GcloudHealthChecks",
		prompt_title = "Load Balancer Health Checks",
		list_cmd = "gcloud compute health-checks list --format=value(name)",
		show_cmd = "gcloud compute health-checks describe %s --global",
		console_url = "https://console.cloud.google.com/networking/healthchecks/details/{name}?project={project}",
	},
	{
		cmd = "GcloudSecurityPolicies",
		prompt_title = "Cloud Armor Security Policies",
		list_cmd = "gcloud compute security-policies list --format=value(name)",
		show_cmd = "gcloud compute security-policies describe %s",
		console_url = "https://console.cloud.google.com/networking/securitypolicies/details/{name}?project={project}",
	},
	{
		cmd = "GcloudBackendBuckets",
		prompt_title = "Load Balancer Backend Buckets",
		list_cmd = "gcloud compute backend-buckets list --format=value(name)",
		show_cmd = "gcloud compute backend-buckets describe %s",
		console_url = "https://console.cloud.google.com/networking/backends/buckets/details/{name}?project={project}",
	},
	{
		cmd = "GcloudForwardingRules",
		prompt_title = "Load Balancer Forwarding Rules",
		list_cmd = "gcloud compute forwarding-rules list --format=value(name)",
		show_cmd = "gcloud compute forwarding-rules describe %s --global",
		console_url = "https://console.cloud.google.com/networking/loadbalancing/frontendDetails/global/{name}?project={project}",
	},
	-- ============================================================================
	-- NETWORKING
	-- ============================================================================
	{
		cmd = "GcloudUrlMaps",
		prompt_title = "Load Balancer Url Maps",
		list_cmd = "gcloud compute url-maps list --format=value(name)",
		show_cmd = "gcloud compute url-maps describe %s --global",
		console_url = "https://console.cloud.google.com/networking/loadbalancing/loadBalancers/details/{name}?project={project}",
	},
	{
		cmd = "GcloudFirewallRules",
		prompt_title = "Firewall Rules",
		list_cmd = "gcloud compute firewall-rules list --format=value(name)",
		show_cmd = "gcloud compute firewall-rules describe %s",
		console_url = "https://console.cloud.google.com/networking/firewalls/details/{name}?project={project}",
	},
	{
		cmd = "GcloudVpcNetworks",
		prompt_title = "VPC Networks",
		list_cmd = "gcloud compute networks list --format=value(name)",
		show_cmd = "gcloud compute networks describe %s",
		console_url = "https://console.cloud.google.com/networking/networks/details/{name}?project={project}",
	},
	{
		cmd = "GcloudVpcSubnets",
		prompt_title = "VPC Subnets",
		list_cmd = "gcloud compute networks subnets list --format=value(name,region)",
		show_cmd = "gcloud compute networks subnets describe SUBNET_NAME --region=SUBNET_REGION",
		replace_str = "SUBNET_NAME",
		region_replace_str = "SUBNET_REGION",
		console_url = "https://console.cloud.google.com/networking/subnetworks/details/{region}/{name}?project={project}",
	},
	{
		cmd = "GcloudAddresses",
		prompt_title = "Compute Addresses",
		list_cmd = "gcloud compute addresses list --format=value(name)",
		show_cmd = "gcloud compute addresses describe %s --global",
		console_url = "https://console.cloud.google.com/networking/addresses/list?project={project}",
	},
	{
		cmd = "GcloudTargetHttpProxies",
		prompt_title = "Target HTTP Proxies",
		list_cmd = "gcloud compute target-http-proxies list --format=value(name)",
		show_cmd = "gcloud compute target-http-proxies describe %s --global",
		console_url = "https://console.cloud.google.com/networking/loadbalancing/details/http/{name}?project={project}",
	},
	{
		cmd = "GcloudTargetHttpsProxies",
		prompt_title = "Target HTTPS Proxies",
		list_cmd = "gcloud compute target-https-proxies list --format=value(name)",
		show_cmd = "gcloud compute target-https-proxies describe %s --global",
		console_url = "https://console.cloud.google.com/networking/loadbalancing/details/https/{name}?project={project}",
	},
	{
		cmd = "GcloudTargetGrpcProxies",
		prompt_title = "Target gRPC Proxies",
		list_cmd = "gcloud compute target-grpc-proxies list --format=value(name)",
		show_cmd = "gcloud compute target-grpc-proxies describe %s --global",
		console_url = "https://console.cloud.google.com/networking/loadbalancing/details/grpc/{name}?project={project}",
	},
	{
		cmd = "GcloudDnsZones",
		prompt_title = "DNS Zones & Records",
		list_cmd = "gcloud dns managed-zones list --format=value(name)",
		show_cmd = "gcloud dns record-sets list --zone=%s",
		gcloud_display_format = "yaml(name,type,ttl,rrdatas)",
		preview_format = "yaml",
		console_url = "https://console.cloud.google.com/net-services/dns/zones/{name}/details?project={project}",
	},

	-- ============================================================================
	-- Service Extensions
	-- ============================================================================
	{
		cmd = "GcloudTrafficCalloutExtensions",
		prompt_title = "Traffic callout extensions",
		list_cmd = "gcloud beta service-extensions lb-traffic-extensions list --location=global --format=value(name)",
		show_cmd = "gcloud beta service-extensions lb-traffic-extensions describe %s --location=global",
		console_url = "https://console.cloud.google.com/net-services/service-extensions/traffic-extensions/details/global/{name}?project={project}",
	},
	{
		cmd = "GcloudRouteCalloutExtensions",
		prompt_title = "Route callout extensions",
		list_cmd = "gcloud beta service-extensions lb-route-extensions list --location=global --format=value(name)",
		show_cmd = "gcloud beta service-extensions lb-route-extensions describe %s --location=global",
	},
	{
		cmd = "GcloudAuthzCalloutExtensions",
		prompt_title = "Auth callout extensions",
		list_cmd = "gcloud beta service-extensions authz-extensions list --location=global --format=value(name)",
		show_cmd = "gcloud beta service-extensions authz-extensions describe %s --location=global",
	},
	{
		cmd = "GcloudTrafficPluginExtensions",
		prompt_title = "Traffic plugin extensions",
		list_cmd = "gcloud beta service-extensions wasm-plugins list --format=value(name)",
		show_cmd = "gcloud beta service-extensions wasm-plugins describe %s",
	},

	{
		cmd = "GcloudAuthzPolicies",
		prompt_title = "Authz policies",
		list_cmd = "gcloud beta network-security authz-policies list --location global --format=value(name)",
		show_cmd = "gcloud beta network-security authz-policies describe %s --location=global",
	},

	-- ============================================================================
	-- MESSAGING & EVENTS
	-- ============================================================================
	{
		cmd = "GcloudPubsubTopics",
		prompt_title = "Pubsub Topics & Attached Subscriptions",
		list_cmd = "gcloud pubsub topics list --format=value(name.basename())",
		show_cmd = "gcloud pubsub topics list-subscriptions %s",
		console_url = "https://console.cloud.google.com/cloudpubsub/topic/detail/{name}?project={project}",
	},
	{
		cmd = "GcloudPubsubSubscriptions",
		prompt_title = "Pubsub Subscriptions",
		list_cmd = "gcloud pubsub subscriptions list --format=value(name.basename())",
		show_cmd = "gcloud pubsub subscriptions describe %s",
		console_url = "https://console.cloud.google.com/cloudpubsub/subscription/detail/{name}?project={project}",
	},

	-- ============================================================================
	-- SECURITY & IAM
	-- ============================================================================
	{
		cmd = "GcloudIamRoles",
		prompt_title = "IAM Roles (Predefined)",
		list_cmd = "gcloud iam roles list --format=value(name.basename())",
		show_cmd = "gcloud iam roles describe %s",
		console_url = "https://console.cloud.google.com/iam-admin/roles/details/roles%3C{name}?project={project}",
	},
	{
		cmd = "GcloudManagedSecrets",
		prompt_title = "Managed Secrets",
		list_cmd = "gcloud secrets list --format=value(name)",
		show_cmd = "gcloud secrets versions access latest --secret=%s",
		gcloud_display_format = "", -- empty string reveals secret
		show_value = false, -- don't show actual secret value by default
		console_url = "https://console.cloud.google.com/security/secret-manager/secret/{name}/versions?project={project}",
	},
	{
		cmd = "GcloudServiceAccountRoles",
		prompt_title = "Service Accounts & Their Roles",
		list_cmd = "gcloud iam service-accounts list --format=value(email)",
		show_cmd = "gcloud projects get-iam-policy PROJECT --flatten=bindings[].members --filter=bindings.members:%s --format=table(bindings.role)",
		console_url = "https://console.cloud.google.com/iam-admin/serviceaccounts/details/{name}?project={project}",
	},

	-- ============================================================================
	-- PROJECT & API MANAGEMENT
	-- ============================================================================
	{
		cmd = "GcloudProjects",
		prompt_title = "Gcloud Projects",
		list_cmd = "gcloud projects list --format=value(projectId)",
		show_cmd = "gcloud projects describe %s",
	},
	{
		cmd = "GcloudEnabledApis",
		prompt_title = "Enabled APIs & Services",
		list_cmd = "gcloud services list --enabled --format=value(name.basename())",
		show_cmd = "gcloud services describe %s", -- doesn't work, no describe command
		console_url = "https://console.cloud.google.com/apis/library/{name}?project={project}",
	},
}

vim.schedule(function()
	for _, value in pairs(gcloud_mappings) do
		local show_value, gcloud_display_format = nil, nil
		if value.show_value == false then
			show_value = false
		else
			show_value = true
		end

		if value.gcloud_display_format == nil then
			gcloud_display_format = "yaml"
		else
			gcloud_display_format = value.gcloud_display_format
		end

		vim.api.nvim_create_user_command(value.cmd, function(opts)
			local project = nil
			if opts.args ~= "" then
				project = opts.args
			else
				project = utils.get_os_command_output({ "gcloud", "config", "get", "project" })[1]
			end
			gcloud_explore({
				cmd_name = value.cmd,
				prompt_title = value.prompt_title,
				list_cmd = value.list_cmd,
				show_cmd = value.show_cmd,
				show_value = show_value,
				replace_str = value.replace_str,
				region_replace_str = value.region_replace_str,
				gcloud_display_format = gcloud_display_format,
				preview_format = value.preview_format or "yaml",
				project = project,
				console_url = value.console_url, -- Add this line
				url_replacements = value.url_replacements, -- Add this line for custom replacements
			})
		end, {
			nargs = "?",
			desc = "Explore " .. value.prompt_title,
			complete = function()
				return work_functions.gcloud_projects()
			end,
		})

		vim.keymap.set("n", "<leader>mc", ":GcloudManagedSecrets", { desc = "list gcloud managed secrets" })
	end
end)
