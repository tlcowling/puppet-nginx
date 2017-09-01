class nginx {
  include nginx::params

  $config = lookup('config') |$key| { notice('User did not provide a hiera config for ${key}, using defaults') }
  if $config {
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
      error_log               => $config['error_log'],
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
  }

  contain nginx::params
  contain nginx::package
  contain nginx::service

  Class['nginx::params']
  -> Class['nginx::package']
  -> Class['nginx::service']

  include nginx::package
  include nginx::types
  include nginx::service
  include nginx::servers
  include nginx::proxies
  include nginx::locations
  include nginx::gzip
  include nginx::ssl
  include nginx::auth_requests
  include nginx::streams
  include nginx::access_control_lists
  include nginx::realips
  include nginx::access_logs
  include nginx::upstreams
  

  $http = lookup('http')|$key| { notice("This key is ${key}") }
  if $http {
    notice('using hiera config:')
    notice($http)
    class { 'nginx::http':
      absolute_redirect             => $http['absolute_redirect'],
      aio                           => $http['aio'],
      aio_write                     => $http['aio_write'],
      connection_pool_size          => $http['connection_pool_size'],
      directio                      => $http['directio'],
      directio_alignment            => $http['directio_alignment'],
      disable_symlinks              => $http['disable_symlinks'],
      error_log                     => $http['error_log'],
      error_page                    => $http['error_page'],
      etag                          => $http['etag'],
      if_modified_since             => $http['if_modified_since'],
      ignore_invalid_headers        => $http['ignore_invalid_headers'],
      index                         => $http['index'],
      keepalive_disable             => $http['keepalive_disable'],
      keepalive_requests            => $http['keepalive_requests'],
      keepalive_timeout             => $http['keepalive_timeout'],
      large_client_header_buffers   => $http['large_client_header_buffers'],
      limit_rate                    => $http['limit_rate'],
      limit_rate_after              => $http['limit_rate_after'],
      lingering_close               => $http['lingering_close'],
      lingering_time                => $http['lingering_time'],
      lingering_timeout             => $http['lingering_timeout'],
      log_not_found                 => $http['log_not_found'],
      log_subrequest                => $http['log_subrequest'],
      max_ranges                    => $http['max_ranges'],
      merge_slashes                 => $http['merge_slashes'],
      msie_padding                  => $http['msie_padding'],
      msie_refresh                  => $http['msie_refresh'],
      open_file_cache_errors        => $http['open_file_cache_errors'],
      open_file_cache_min_uses      => $http['open_file_cache_min_uses'],
      open_file_cache_valid         => $http['open_file_cache_valid'],
      output_buffers                => $http['output_buffers'],
      port_in_redirect              => $http['port_in_redirect'],
      postpone_output               => $http['postpone_output'],
      read_ahead                    => $http['read_ahead'],
      recursive_error_pages         => $http['recursive_error_pages'],
      request_pool_size             => $http['request_pool_size'],
      reset_timedout_connection     => $http['reset_timedout_connection'],
      resolver                      => $http['resolver'],
      resolver_timeout              => $http['resolver_timeout'],
      root                          => $http['root'],
      satisfy                       => $http['satisfy'],
      send_lowat                    => $http['send_lowat'],
      send_timeout                  => $http['send_timeout'],
      sendfile                      => $http['sendfile'],
      sendfile_max_chunk            => $http['sendfile_max_chunk'],
      server_name_in_redirect       => $http['server_name_in_redirect'],
      server_names_hash_bucket_size => $http['server_names_hash_bucket_size'],
      server_names_hash_max_size    => $http['server_names_hash_max_size'],
      server_tokens                 => $http['server_tokens'],
      tcp_nodelay                   => $http['tcp_nodelay'],
      tcp_nopush                    => $http['tcp_nopush'],
      types_hash_bucket_size        => $http['types_hash_bucket_size'],
      types_hash_max_size           => $http['types_hash_max_size'],
      underscores_in_headers        => $http['underscores_in_headers'],
      variables_hash_bucket_size    => $http['variables_hash_bucket_size'],
      variables_hash_max_size       => $http['variables_hash_max_size'],
      chunked_transfer_encoding     => $http['chunked_transfer_encoding'],
      client_body_buffer_size       => $http['client_body_buffer_size'],
      client_body_in_file_only      => $http['client_body_in_file_only'],
      client_body_in_single_buffer  => $http['client_body_in_single_buffer'],
      client_body_temp_path         => $http['client_body_temp_path'],
      client_body_timeout           => $http['client_body_timeout'],
      client_header_buffer_size     => $http['client_header_buffer_size'],
      client_header_timeout         => $http['client_header_timeout'],
      client_max_body_size          => $http['client_max_body_size'],
      open_file_cache               => $http['open_file_cache'],
      custom                        => $http['custom'],
    }
  } else {
    notice('using default config')
    include nginx::http
  }

  $events = lookup('events') |$key| { notice("This key is ${key}") }
  if $events {
    class { 'nginx::events':
      worker_connections  => $events['worker_connections'],
      multi_accept        => $events['multi_accept'],
      accept_mutex        => $events['accept_mutex'],
      accept_mutex_delay  => $events['accept_mutex_delay'],
      debug_connection    => $events['debug_connection'],
      use                 => $events['use'],
      worker_aio_requests => $events['worker_aio_requests'],
      custom              => $events['custom'],
    }
  }
}
