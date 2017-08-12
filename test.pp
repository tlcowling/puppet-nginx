$config = lookup('config')
notice("CONFIG:")
if $config {
  notice('using config from hiera')
  class { 'nginx::config':
    

  }
} else {
  notice('using default hiera config')
  include nginx::config
}

include nginx::types
include nginx::http
include nginx::events
include nginx::streams
include nginx::access_control_lists
