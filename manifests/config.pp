class nginx::config (
  Variant[String, Integer] $worker_processes = 'auto',
  String $base_directory                     = '/etc/nginx',
  String $user                               = 'nginx',
  String $group                              = 'nginx',
  String $pid                                = '/var/run/nginx.pid',
) {
  validate_absolute_path($base_directory)

  notice('Configuring nginx config')

  user { $user:
    ensure  => present,
    gid     => $group,
    comment => 'nginx process user',
    require => Group[$group],
  }

  group { $group:
    ensure => present,
  }

  file { $base_directory:
    ensure  => directory,
    owner   => $user,
    group   => $group,
    mode    => '0750',
    require => User[$user],
  }

  concat { 'nginx_config':
    ensure  => 'present',
    owner   => $user,
    group   => $group,
    mode    => '0640',
    path    => "${base_directory}/nginx.conf",
    require => File[$base_directory],
  }
}
