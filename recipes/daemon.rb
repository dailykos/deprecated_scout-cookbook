apt_repository 'scout' do
  uri          'http://archive.scoutapp.com'
  components   ['main']
  distribution node['platform']
  key          'https://archive.scoutapp.com/scout-archive.key'
end

package 'scoutd' do
  action :install
end

runit_service 'scoutd' do
  env 'HOME' => node[:scout][:plugin_path]
end
