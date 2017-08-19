class nginx::package::ubuntu inherits nginx::package {
  if $managed {
    notice('using managed packages')
    apt::key { 'nginx':
      id      => '573BFD6B3D8FBC641079A6ABABF5BD827BD9BF62',
      server  => 'pgp.mit.edu',
    }
  } else {
    package { 'nginx':
      ensure => absent,
    } 
  }
}
