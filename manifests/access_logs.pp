class nginx::access_logs (
  Optional[String] $access_log_directory = 'access_logs',
) inherits nginx::config {

  $access_logs = lookup('access_logs') |$key| {
    notice("No hiera data found for ${key}")
  }

  file { 'access logs directory':
    ensure => 'directory',
    path   => "${base_directory}/${includes_directory}/${access_log_directory}",
    owner  => $user,
    group  => $group,
    mode   => $mode,
  }

  if $access_logs_configs {
    $access_logs_configs.each |$n, $config| {
      nginx::config::access_log { $n:
        access_log          => $config['access_log'],
        log_format          => $config['log_format'],
        open_log_file_cache => $config['open_log_file_cache'],
      }
    }
  }
}