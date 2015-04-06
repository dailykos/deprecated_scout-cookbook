# create the scout config directory
directory node[:scout][:config_path] do
  group node[:scout][:group]
  owner node[:scout][:user]
  mode "0755"
end

template File.join(node[:scout][:config_path], 'scoutd.yml') do
  source "scoutd.yml.erb"
  mode 0664
  owner node[:scout][:user]
  group node[:scout][:group]
  variables lazy {
    {
      vars: {
        'account_key' => node[:scout][:key],
        'hostname' => node[:hostname],
        'display_name' => node[:fqdn],
        'ruby_path' => node[:scout][:ruby_path],
        'environment' => node[:scout][:environment] || 'production',
        'roles' => node[:scout][:roles].join(','),
      }
    }
  }
  action :create
end

# create the scout plugin directory
directory node[:scout][:plugin_path] do
  group node[:scout][:group]
  owner node[:scout][:user]
  mode "0755"
end

# Create plugin rsa key
template File.join(node[:scout][:plugin_path], 'scout_rsa.pub') do
  source "scout_rsa.pub.erb"
  mode 0440
  owner node[:scout][:user]
  group node[:scout][:group]
  action :create
end if node[:scout][:public_key]

# Create plugin lookup properties
template File.join(node[:scout][:plugin_path], 'plugins.properties') do
  source "plugins.properties.erb"
  mode 0664
  owner node[:scout][:user]
  group node[:scout][:group]
  variables lazy {
    {
      :plugin_properties => node[:scout][:plugin_properties]
    }
  }
  action :create
end

# Ensure permissions of plugin path
directory node[:scout][:plugin_path] do
  owner node[:scout][:user]
  group node[:scout][:group]
  recursive true
end
