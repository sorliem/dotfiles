local pickers = require("telescope.pickers")
local sorters = require("telescope.sorters")
local finders = require("telescope.finders")
local actions = require("telescope.actions")
local previewers = require("telescope.previewers")
local action_state = require("telescope.actions.state")
local utils = require("telescope.utils")
local work_functions = require("miles.work-commands")
local telescope_functions = require("miles.telescope-functions")

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
	},
	{
		cmd = "GcloudGkeClusters",
		prompt_title = "GKE Clusters",
		list_cmd = "gcloud container clusters list --format=value(name,location)",
		show_cmd = "gcloud container clusters describe CLUSTER_NAME --location=CLUSTER_REGION",
		replace_str = "CLUSTER_NAME",
		region_replace_str = "CLUSTER_REGION",
	},
	{
		cmd = "GcloudRunJobs",
		prompt_title = "Cloud Run Jobs in us-central1",
		list_cmd = "gcloud run jobs list --format=value(name)",
		show_cmd = "gcloud run jobs describe %s --region=us-central1",
	},
	{
		cmd = "GcloudCloudFunctions",
		prompt_title = "Cloud Functions",
		list_cmd = "gcloud functions list --format=value(name)",
		show_cmd = "gcloud functions describe %s",
	},

	-- ============================================================================
	-- STORAGE & DATABASES
	-- ============================================================================
	{
		cmd = "GcloudStorageBuckets",
		prompt_title = "Cloud Storage Buckets",
		list_cmd = "gcloud storage buckets list --format=value(name)",
		show_cmd = "gcloud storage buckets describe gs://%s",
	},
	{
		cmd = "GcloudSqlInstances",
		prompt_title = "Sql Instances",
		list_cmd = "gcloud sql instances list --format=value(name)",
		show_cmd = "gcloud sql instances describe %s",
	},
	{
		cmd = "GcloudSqlUsers",
		prompt_title = "SQL Instance Users",
		list_cmd = "gcloud sql instances list --format=value(name)",
		show_cmd = "gcloud sql users list --instance=%s",
		gcloud_display_format = "[box]",
	},
	{
		cmd = "GcloudMemorystoreInstances",
		prompt_title = "Memorystore Redis Instances",
		list_cmd = "gcloud redis instances list --region=us-central1 --format=value(name.basename())",
		show_cmd = "gcloud redis instances describe %s --region=us-central1",
	},
	{
		cmd = "GcloudSpannerInstances",
		prompt_title = "Cloud Spanner Instances",
		list_cmd = "gcloud spanner instances list --format=value(name.basename())",
		show_cmd = "gcloud spanner instances describe %s",
	},
	{
		cmd = "GcloudBigTableInstances",
		prompt_title = "Bigtable Instances",
		list_cmd = "gcloud bigtable instances list --format=value(name.basename())",
		show_cmd = "gcloud bigtable instances describe %s",
	},

	-- ============================================================================
	-- Load balancing
	-- ============================================================================
	{
		cmd = "GcloudBackendServices",
		prompt_title = "Load Balancer Backend Services",
		list_cmd = "gcloud compute backend-services list --format=value(name)",
		show_cmd = "gcloud compute backend-services describe %s --global",
	},
	{
		cmd = "GcloudHealthChecks",
		prompt_title = "Load Balancer Health Checks",
		list_cmd = "gcloud compute health-checks list --format=value(name)",
		show_cmd = "gcloud compute health-checks describe %s --global",
	},
	{
		cmd = "GcloudSecurityPolicies",
		prompt_title = "Cloud Armor Security Policies",
		list_cmd = "gcloud compute security-policies list --format=value(name)",
		show_cmd = "gcloud compute security-policies describe %s",
	},
	{
		cmd = "GcloudBackendBuckets",
		prompt_title = "Load Balancer Backend Buckets",
		list_cmd = "gcloud compute backend-buckets list --format=value(name)",
		show_cmd = "gcloud compute backend-buckets describe %s",
	},
	{
		cmd = "GcloudForwardingRules",
		prompt_title = "Load Balancer Forwarding Rules",
		list_cmd = "gcloud compute forwarding-rules list --format=value(name)",
		show_cmd = "gcloud compute forwarding-rules describe %s --global",
	},
	-- ============================================================================
	-- NETWORKING
	-- ============================================================================
	{
		cmd = "GcloudUrlMaps",
		prompt_title = "Load Balancer Url Maps",
		list_cmd = "gcloud compute url-maps list --format=value(name)",
		show_cmd = "gcloud compute url-maps describe %s --global",
	},
	{
		cmd = "GcloudFirewallRules",
		prompt_title = "Firewall Rules",
		list_cmd = "gcloud compute firewall-rules list --format=value(name)",
		show_cmd = "gcloud compute firewall-rules describe %s",
	},
	{
		cmd = "GcloudVpcNetworks",
		prompt_title = "VPC Networks",
		list_cmd = "gcloud compute networks list --format=value(name)",
		show_cmd = "gcloud compute networks describe %s",
	},
	{
		cmd = "GcloudVpcSubnets",
		prompt_title = "VPC Subnets",
		list_cmd = "gcloud compute networks subnets list --format=value(name,region)",
		show_cmd = "gcloud compute networks subnets describe SUBNET_NAME --region=SUBNET_REGION",
		replace_str = "SUBNET_NAME",
		region_replace_str = "SUBNET_REGION",
	},
	{
		cmd = "GcloudAddresses",
		prompt_title = "Compute Addresses",
		list_cmd = "gcloud compute addresses list --format=value(name)",
		show_cmd = "gcloud compute addresses describe %s --global",
	},
	{
		cmd = "GcloudTargetHttpProxies",
		prompt_title = "Target HTTP Proxies",
		list_cmd = "gcloud compute target-http-proxies list --format=value(name)",
		show_cmd = "gcloud compute target-http-proxies describe %s --global",
	},
	{
		cmd = "GcloudTargetHttpsProxies",
		prompt_title = "Target HTTPS Proxies",
		list_cmd = "gcloud compute target-https-proxies list --format=value(name)",
		show_cmd = "gcloud compute target-https-proxies describe %s --global",
	},
	{
		cmd = "GcloudTargetGrpcProxies",
		prompt_title = "Target gRPC Proxies",
		list_cmd = "gcloud compute target-grpc-proxies list --format=value(name)",
		show_cmd = "gcloud compute target-grpc-proxies describe %s --global",
	},
	{
		cmd = "GcloudDnsZones",
		prompt_title = "DNS Zones & Records",
		list_cmd = "gcloud dns managed-zones list --format=value(name)",
		show_cmd = "gcloud dns record-sets list --zone=%s",
		gcloud_display_format = "yaml(name,type,ttl,rrdatas)",
		preview_format = "yaml",
	},

	-- ============================================================================
	-- Service Extensions
	-- ============================================================================
	{
		cmd = "GcloudTrafficCalloutExtensions",
		prompt_title = "Traffic callout extensions",
		list_cmd = "gcloud beta service-extensions lb-traffic-extensions list --location=global --format=value(name)",
		show_cmd = "gcloud beta service-extensions lb-traffic-extensions describe %s --location=global",
	},
	{
		cmd = "GcloudRouteCalloutExtensions",
		prompt_title = "Route callout extensions",
		list_cmd = "gcloud beta service-extensions lb-route-extensions list --location=global --format=value(name)",
		show_cmd = "gcloud beta service-extensions lb-route-extensions describe %s --location=global",
	},
	{
		cmd = "GcloudAuthCalloutExtensions",
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
	},
	{
		cmd = "GcloudPubsubSubscriptions",
		prompt_title = "Pubsub Subscriptions",
		list_cmd = "gcloud pubsub subscriptions list --format=value(name.basename())",
		show_cmd = "gcloud pubsub subscriptions describe %s",
	},

	-- ============================================================================
	-- SECURITY & IAM
	-- ============================================================================
	{
		cmd = "GcloudIamRoles",
		prompt_title = "IAM Roles (Predefined)",
		list_cmd = "gcloud iam roles list --format=value(name.basename())",
		show_cmd = "gcloud iam roles describe %s",
	},
	{
		cmd = "GcloudManagedSecrets",
		prompt_title = "Managed Secrets",
		list_cmd = "gcloud secrets list --format=value(name)",
		show_cmd = "gcloud secrets versions access latest --secret=%s",
		gcloud_display_format = "", -- empty string reveals secret
		show_value = false, -- don't show actual secret value by default
	},
	{
		cmd = "GcloudServiceAccountRoles",
		prompt_title = "Service Accounts & Their Roles",
		list_cmd = "gcloud iam service-accounts list --format=value(email)",
		show_cmd = "gcloud projects get-iam-policy PROJECT --flatten=bindings[].members --filter=bindings.members:%s --format=table(bindings.role)",
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
				prompt_title = value.prompt_title,
				list_cmd = value.list_cmd,
				show_cmd = value.show_cmd,
				show_value = show_value,
				replace_str = value.replace_str,
				region_replace_str = value.region_replace_str,
				gcloud_display_format = gcloud_display_format,
				preview_format = value.preview_format or "yaml",
				project = project,
			})
		end, {
			nargs = "?",
			desc = "Explore " .. value.prompt_title,
			complete = function()
				return work_functions.gcloud_projects()
			end,
		})
	end
end)
