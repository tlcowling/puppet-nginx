class nginx::package::ubuntu inherits nginx::package {
  if $managed {
    notice('using managed packages')
    package { 'dirmngr':
      ensure  => latest,
    }->
    apt::source { 'nginx':
      location => 'http://nginx.org/packages/ubuntu/',
      repos    => 'nginx',
      key      => {
        'id'     => '573BFD6B3D8FBC641079A6ABABF5BD827BD9BF62',
        'server' => 'pgp.mit.edu',
      },
    }
    package { $packagename:
      ensure => $packageversion,
    }
  } else {
    package { $packagename:
      ensure => $packageversion,
    } 
  }
}
