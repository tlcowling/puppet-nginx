class nginx::config (
  Optional[Variant[String, Integer]]           $worker_processes = 'auto',
  Optional[String]                             $pid   = '/var/run/nginx.pid',
  Optional[String]                             $base_directory = $::nginx::params::base_directory,
  Optional[String]                             $includes_directory = $::nginx::params::includes_directory,
  Optional[String]                             $streams_directory = $::nginx::params::streams_directory,
  Optional[String]                             $user  = $::nginx::params::user,
  Optional[String]                             $group = $::nginx::params::group,
  Optional[String]                             $mode  = $::nginx::params::mode,
  Optional[
    Array[
      Hash[
        Enum['path', 'level'],
        String,
      ]
    ]
  ]                                            $error_log = $::nginx::params::error_log,
  Optional[Hash[String, Hash[Enum['threads','max_queue'], Integer]]] $thread_pools = undef,
  Optional[String]                             $timer_resolution = undef,
  Optional[String]                             $ssl_engine = undef,
  Optional[Boolean]                            $daemon = undef,
  Optional[Boolean]                            $master_process = undef,
  Optional[Boolean]                            $pcre_jit = undef,
  Optional[Enum['abort', 'stop']]              $debug_points = undef,
  Optional[String]                             $lock_file = undef,
  Optional[String]                             $worker_cpu_affinity = undef,
  Optional[Integer[-20,20]]                    $worker_priority = undef,
  Optional[String]                             $worker_rlimit_core = undef,
  Optional[String]                             $worker_rlimit_nofile = undef,
  Optional[String]                             $worker_shutdown_timeout = undef,
  Optional[String]                             $worker_directory = undef,
  Optional[Array[String]]                      $include = undef,
  Optional[Array[String]]                      $load_modules = undef,
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
    ensure  => 'directory',
    owner   => $user,
    group   => $group,
    recurse => true,
    purge   => true,
    mode    => '0750',
    require => User[$user],
  }

  file { "${base_directory}/${includes_directory}":
    ensure  => 'directory',
    owner   => $user,
    group   => $group,
    mode    => '0750',
    recurse => true,
    purge   => true,
    require => [
      User[$user],
      File[$base_directory],
    ],
  }

  exec { 'config_test':
    path    => [ '/usr/local/bin' ],
    command => '/bin/true',
    #command => "nginx -t -c ${base_directory}/nginx.conf",
  }

  concat { 'nginx_config':
    ensure         => 'present',
    owner          => $user,
    group          => $group,
    mode           => '0640',
    path           => "${base_directory}/nginx.conf",
    ensure_newline => true,
    require        => File[$base_directory],
    notify         => Exec['config_test'],
  }

  concat::fragment { 'nginx_config_header':
    target  => 'nginx_config',
    content => template('nginx/config/header.erb'),
    order   => '00',
  }

  concat::fragment { 'nginx_config_include_basics':
    target  => 'nginx_config',
    content => template('nginx/config/basic.erb'),
    order   => '02',
  }

  concat::fragment { 'nginx_config_include_workers':
    target  => 'nginx_config',
    content => template('nginx/config/worker.erb'),
    order   => '01',
  }

  concat::fragment { 'nginx_config_include_thread_pools':
    target  => 'nginx_config',
    content => template('nginx/config/thread_pools.erb'),
    order   => '03',
  }

  concat::fragment { 'nginx_config_include_debug_points':
    target  => 'nginx_config',
    content => template('nginx/config/debug.erb'),
    order   => '04',
  }

  concat::fragment { 'nginx_config_include_modules':
    target  => 'nginx_config',
    content => template('nginx/config/include_modules.erb'),
    order   => '05',
  }

  concat::fragment { 'nginx_config_include_custom':
    target  => 'nginx_config',
    content => template('nginx/shared/custom.erb'),
    order   => '06',
  }

  concat::fragment { 'nginx_config_include_includes':
    target  => 'nginx_config',
    content => template('nginx/config/includes.erb'),
    order   => '07',
  }
}
