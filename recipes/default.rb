#
# Cookbook Name:: scout
# Recipe:: default
Chef::Log.info "Loading: #{cookbook_name}::#{recipe_name}"

# create group and user
group node[:scout][:group] do
  action [ :create, :manage ]
end.run_action(:create)

user node[:scout][:user] do
  comment "Scout Agent"
  gid node[:scout][:group]
  home "/home/#{node[:scout][:user]}"
  supports :manage_home => true
  action [ :create, :manage ]
  only_if do node[:scout][:user] != 'root' end
end.run_action(:create)

case node[:scout][:run_mode]
when :daemon
  node.set[:scout][:plugin_path] = '/var/lib/scoutd'
  include_recipe 'scout::configure'
  include_recipe 'scout::daemon'
when :cron
  node.set[:scout][:plugin_path] = if Dir.respond_to?(:home)
    Dir.home(node[:scout][:user])
  else
   File.expand_path("~#{node[:scout][:user]}")
  end
  node.set[:scout][:plugin_path] = File.join(node[:scout][:plugin_path], '.scout')
  include_recipe 'scout::configure'
  include_recipe 'scout::cron'
else
  Chef::Log.error "node[:scout][:run_mode] must be one of (:daemon|:cron)"
  return
end
