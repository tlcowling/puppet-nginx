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

  exec { 'config_test':
    path    => [ '/usr/local/bin' ],
    command => "nginx -t -c ${base_directory}/nginx.conf",
  }

  concat { 'nginx_config':
    ensure  => 'present',
    owner   => $user,
    group   => $group,
    mode    => '0640',
    path    => "${base_directory}/nginx.conf",
    ensure_newline => true,
    require => File[$base_directory],
    notify  => Exec['config_test'],
  }

  concat::fragment { 'nginx_config_header':
    target  => 'nginx_config',
    content => template('nginx/config/header.erb'),
    order   => '00',
  }

  concat::fragment { 'nginx_config_include_basics':
    target  => 'nginx_config',
    content => template('nginx/config/basic.erb'),
    order   => '01',
  }

  concat::fragment { 'nginx_config_include_events':
    target  => 'nginx_config',
    content => 'events {}',
    order   => '02',
  }
}
