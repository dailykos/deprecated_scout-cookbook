#
# Cookbook Name:: scout
# Recipe:: scout_plugin_rbenv_gems

(node[:scout][:plugin_gems] || []).each do |gemname|
  rbenv_gem gemname do
    ruby_version node[:scout][:ruby_version]
  end
end
