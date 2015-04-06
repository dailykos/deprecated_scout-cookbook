#
# Cookbook Name:: scout
# Recipe:: cron
include_recipe 'scout::scout_rbenv_gem'
include_recipe 'scout::scout_plugin_rbenv_gems'

if node[:scout][:key]
  # wrap calls to the Scout library in ruby_block
  ruby_block "find the scout binary" do
    block do
      scout_bin = File.join(node[:rbenv][:root], 'versions', node[:scout][:ruby_version], 'bin', 'scout')
      hostname_attr = node[:scout][:hostname] ? %{ --hostname "#{node[:scout][:hostname]}"} : ""
      name_attr = node[:scout][:name] ? %{ --name "#{node[:scout][:name]}"} : ""
      server_attr = node[:scout][:server] ? %{ --server "#{node[:scout][:server]}"} : ""
      roles_attr = node[:scout][:roles] ? %{ --roles "#{node[:scout][:roles].map(&:to_s).join(',')}"} : ""
      http_proxy_attr = node[:scout][:http_proxy] ? %{ --http-proxy "#{node[:scout][:http_proxy]}"} : ""
      https_proxy_attr = node[:scout][:https_proxy] ? %{ --https-proxy "#{node[:scout][:https_proxy]}"} : ""
      environment_attr = node[:scout][:environment] ? %{ --environment "#{node[:scout][:environment]}"} : ""

      if(File.exist?(scout_bin))
        # schedule scout agent to run via cron
        # need to instantiate the resource manually inside a ruby_block
        cron = Chef::Resource::Cron.new("scout_run", run_context)
        cron.user node[:scout][:user]
        cron.command "#{scout_bin} #{node[:scout][:key]}#{hostname_attr}#{name_attr}#{server_attr}#{roles_attr}#{http_proxy_attr}#{https_proxy_attr}#{environment_attr}"
        cron.run_action :create
      end
    end
  end
else
  Chef::Log.warn "The agent will not report to scoutapp.com as a key wasn't provided. Provide a [:scout][:key] attribute to complete the install."
end
