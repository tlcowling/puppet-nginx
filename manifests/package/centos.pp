class nginx::package::centos inherits nginx::package {
  notice ("PACKAGE IS ${packagename}")
  notice ("PACKAGE IS ${version}")
  notice ("PACKAGE IS ${release}")
  if $managed {
    case $release {
      'mainline': {
        yumrepo { 'nginx':
          baseurl  => "http://nginx.org/packages/mainline/centos/${::operatingsystemmajrelease}/\$basearch/",
          enabled  => '1',
          gpgkey   => 'http://nginx.org/keys/nginx_signing.key',
          gpgcheck => '1',
          priority => '1',
          descr    => 'nginx mainline repo',
          before   => Package[$packagename],
        }
      }
      'stable': {
        yumrepo { 'nginx':
          baseurl  => "http://nginx.org/packages/centos/${::operatingsystemmajrelease}/\$basearch/",
          descr    => 'nginx repo',
          enabled  => '1',
          gpgcheck => '1',
          priority => '1',
          gpgkey   => 'http://nginx.org/keys/nginx_signing.key',
          before   => Package[$packagename],
        }
      }
    }
    package { $packagename:
      ensure => $version,
    }
  } else {
    package { $packagename:
      ensure => $version,
    }
  }
}
