$config = lookup('config')
if $config {
  notice('using hiera config:')
  notice($config)
  class { 'nginx::config':
    user             => $config['user'],
    group            => $config['group'],
    pid              => $config['pid'],
    daemon           => $config['daemon'],
    worker_processes => $config['worker_processes'],
    base_directory   => $config['base_directory'],
    thread_pools     => $config['thread_pools'],
  }
} else {
  notice('using default config')
  include nginx::config
}

include nginx::types
include nginx::http
include nginx::events
include nginx::streams
include nginx::access_control_lists
