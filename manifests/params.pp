class nginx::params{
  $user = 'nginx'
  $group = 'nginx'
  $mode = '0750'
  $base_directory = '/etc/nginx'
  $includes_directory = 'conf.d'
  $streams_directory = 'streams.d'
  $log_directory = '/var/log/nginx'
  $error_log_name = 'error.log'
  $error_log_level = 'error'
  $error_log = [
    {
      'path' => "${log_directory}/${error_log_name}",
      'level' => $error_log_level
    }
  ]
}