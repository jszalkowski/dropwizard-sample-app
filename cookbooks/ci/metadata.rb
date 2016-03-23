name             'ci'
maintainer       'YOUR_COMPANY_NAME'
maintainer_email 'YOUR_EMAIL'
license          'All rights reserved'
description      'Installs/Configures ci'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'

depends 'java', '~> 1.39.0'
depends 'jenkins', '~> 2.4.1'
depends 'maven', '~> 2.1.1'
depends 'mysql', '~> 6.1.2'
depends 'mysql2_chef_gem', '~> 1.0.2'
depends 'database', '~> 4.0.9'
