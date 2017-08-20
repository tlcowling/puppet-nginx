class nginx::package::ubuntu inherits nginx::package {
  notice ("PACKAGE IS ${packagename}")
  notice ("PACKAGE IS ${version}")
  notice ("PACKAGE IS ${release}")

  if $managed {
    notice('using managed packages')
    package { 'dirmngr':
      ensure  => latest,
    }
    case $release {
      'mainline': {
        apt::source { 'nginx':
          location => 'http://nginx.org/packages/mainline/ubuntu/',
          repos    => 'nginx',
          key      => {
            'id'     => '573BFD6B3D8FBC641079A6ABABF5BD827BD9BF62',
            'server' => 'pgp.mit.edu',
          },
        }
      }
      'stable': {
         apt::source { 'nginx':
          location => 'http://nginx.org/packages/ubuntu/',
          repos    => 'nginx',
          key      => {
            'id'     => '573BFD6B3D8FBC641079A6ABABF5BD827BD9BF62',
            'server' => 'pgp.mit.edu',
          },
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
