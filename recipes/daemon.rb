apt_repository 'scout' do
  uri          'http://archive.scoutapp.com'
  components   ['main']
  distribution 'ubuntu'
  key          'https://archive.scoutapp.com/scout-archive.key'
end

package 'scoutd' do
  action :install
end
