name             'scalex'
maintainer       'Andrey Linko'
maintainer_email 'AndreyLinko@gmail.com'
license          'Apache 2.0'
description      'Installs/Configures Scalex'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.0.1'

recipe           'scalex::default', 'Installs and configures scalex project'

depends 'xml'
depends 'nodejs'
depends 'locales'
depends 'apt-repo'
depends 'memcached'
depends 'deploy_key'
depends 'postgresql'
depends 'imagemagick'
depends 'ssh_known_hosts'

supports 'ubuntu'
