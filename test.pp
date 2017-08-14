$config = lookup('config')
if $config {
  notice('using hiera config:')
  notice($config)
  class { 'nginx::config':
    user                    => $config['user'],
    group                   => $config['group'],
    pid                     => $config['pid'],
    daemon                  => $config['daemon'],
    worker_processes        => $config['worker_processes'],
    base_directory          => $config['base_directory'],
    thread_pools            => $config['thread_pools'],
    load_modules            => $config['load_modules'],
    lock_file               => $config['lock_file'],
    pcre_jit                => $config['pcre_jit'],
    master_process          => $config['master_process'],
    worker_priority         => $config['worker_priority'],
    worker_shutdown_timeout => $config['worker_shutdown_timeout'],
    worker_cpu_affinity     => $config['worker_cpu_affinity'],
    worker_rlimit_core      => $config['worker_rlimit_core'],
    worker_rlimit_nofile    => $config['worker_rlimit_nofile'],
    worker_directory        => $config['worker_directory'],
    timer_resolution        => $config['timer_resolution'],
    ssl_engine              => $config['ssl_engine'],
  }
} else {
  notice('using default config')
  include nginx::config
}

$http = lookup('http')
if $http {
  notice('using hiera config:')
  notice($http)
  class { 'nginx::http':
    chunked_transfer_encoding    => $http['chunked_transfer_encoding'],
    client_body_buffer_size      => $http['client_body_buffer_size'],
    client_body_in_file_only     => $http['client_body_in_file_only'],
    client_body_in_single_buffer => $http['client_body_in_single_buffer'],
    client_body_temp_path        => $http['client_body_temp_path'],
    client_body_timeout          => $http['client_body_timeout'],
    client_header_buffer_size    => $http['client_header_buffer_size'],
    client_header_timeout        => $http['client_header_timeout'],
    client_max_body_size         => $http['client_max_body_size'],
    open_file_cache              => $http['open_file_cache'],
  }
} else {
  notice('using default config')
  include nginx::http
}

include nginx::types
include nginx::events
include nginx::streams
include nginx::access_control_lists
