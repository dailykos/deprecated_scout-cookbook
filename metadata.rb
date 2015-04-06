name             'scout'
maintainer       'YOUR_NAME'
maintainer_email 'YOUR_EMAIL'
license          'All rights reserved'
description      'Installs/Configures scout'
long_description 'Installs/Configures scout'
version          '0.1.0'

%w[ubuntu debian].each do |os|
  supports os
end

depends 'apt',   '~> 2.7.0'
depends 'cron',  '~> 1.6.1'
depends 'rbenv', '~> 1.7.1'
