class nginx::access_logs (
  Optional[Hash] $access_logs_configs = undef,
) inherits nginx::config {
  file { "access logs directory":
    ensure => 'directory',
    path   => "${base_directory}/access_logs.d",
    owner  => $user,
    group  => $group,
    mode   => '0750',
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