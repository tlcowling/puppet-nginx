class nginx::config (
  Variant[String, Integer] $worker_processes = 'auto',
  String $user                               = 'nginx',
  String $group                              = 'nginx',
  String $pid                                = '/var/run/nginx.pid',
) {

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
}
