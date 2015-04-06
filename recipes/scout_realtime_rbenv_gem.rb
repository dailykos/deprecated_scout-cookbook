#
# Cookbook Name:: scout
# Recipe:: scout_realtime_rbenv_gem
include_recipe 'rbenv::default'
include_recipe 'rbenv::ruby_build'
rbenv_ruby node[:scout][:ruby_version]

rbenv_gem "scout_realtime" do
  ruby_version node[:scout][:ruby_version]
  version node[:scout_realtime][:version]
end
