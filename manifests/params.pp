class nginx::params{
  $user = 'nginx'
  $group = 'nginx'
  $mode = '0750'
  $base_directory = '/etc/nginx'
  $includes_directory = 'conf.d'
  $streams_directory = 'streams.d'
  $default_log_directory = '/var/log/nginx'
}