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
    load_modules     => $config['load_modules'],
    lock_file        => $config['lock_file'],
    pcre_jit         => $config['pcre_jit'],
    master_process   => $config['master_process'],
    worker_priority  => $config['worker_priority'],
    worker_shutdown_timeout  => $config['worker_shutdown_timeout'],
    worker_cpu_affinity  => $config['worker_cpu_affinity'],
    worker_rlimit_core  => $config['worker_rlimit_core'],
    worker_rlimit_nofile  => $config['worker_rlimit_nofile'],
    worker_directory  => $config['worker_directory'],
    timer_resolution  => $config['timer_resolution'],
    ssl_engine  => $config['ssl_engine'],
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
