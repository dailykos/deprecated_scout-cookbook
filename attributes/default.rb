#
# See the README for a description of each attribute.
#

# required
default[:scout][:key] = nil
default[:scout][:run_mode] = :daemon
default[:scout][:version] = nil

# optional
default[:scout][:user] = "scout"
default[:scout][:group] = "scout"
default[:scout][:hostname] = nil
default[:scout][:name] = nil
default[:scout][:roles] = Array.new
default[:scout][:bin] = nil
default[:scout][:public_key] = nil
default[:scout][:http_proxy] = nil
default[:scout][:https_proxy] = nil
# list of gems to install to support plugins for role
default[:scout][:plugin_gems] = Array.new
default[:scout][:environment] = nil
default[:scout][:plugin_properties] = {}
default[:scout][:ruby_version] = '2.2.1'
default[:scout][:config_path] = '/etc/scout'
default[:scout][:ruby_path] = nil
default[:scout_realtime][:version] = nil
