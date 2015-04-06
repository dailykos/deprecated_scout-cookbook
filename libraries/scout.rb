# Helper functions for the chef-scout cookbook
include Chef::Mixin::ShellOut

module Scout
  def self.scout_binary(node)
    scout_binary = if node[:scout][:rvm_wrapper]
      File.join(node[:scout][:rvm_wrapper],"scout")
    elsif node[:scout][:bin]
      node[:scout][:bin]
    else
      gem_cmd = Mixlib::ShellOut.new("#{gem_binary(node)}", "env", {}.merge(node[:scout][:gem_shell_opts]||{}))
      gem_cmd.run_command
      gem_cmd.error!
      File.join(gem_cmd.stdout.split("\n").grep(/EXECUTABLE DIRECTORY/).first.split.last, "scout") rescue scout_binary = "scout"
    end
    Chef::Log.info "Using scout_binary: #{scout_binary}"
    return scout_binary
  end

  def self.install_gem(node, name_array)
    # name_array can be any array with:
    #   - a single element, e.g. ["scout"]
    #   - multiple elements accepted by 'gem install', e.g. ["scout", "--version", "5.9.5"]
    gem_cmd = Mixlib::ShellOut.new("#{gem_binary(node)}","install", *name_array, {}.merge(node[:scout][:gem_shell_opts]||{}))
    gem_cmd.run_command
    gem_cmd.error!
  end
end
