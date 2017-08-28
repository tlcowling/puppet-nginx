class nginx::events (
  Optional[Integer]                            $worker_connections  = undef,
  Optional[Boolean]                            $multi_accept        = undef,
  Optional[Boolean]                            $accept_mutex        = undef,
  Optional[String]                             $accept_mutex_delay  = undef,
  Optional[Array[String]]                      $debug_connection    = [],
  Optional[String]                             $use                 = undef,
  Optional[Integer]                            $worker_aio_requests = undef,
  Optional[Array[String]]                      $custom = undef,
) inherits nginx::config {
  notice('Configuring nginx events')

  concat { 'events':
    path           => "${base_directory}/${includes_directory}/events.conf",
    ensure_newline => true,
    owner          => $user,
    group          => $group,
    mode           => '0640',
  }

  concat::fragment { 'events_top':
    target  => 'events',
    content => 'events {',
    order   => '00',
  }

  concat::fragment { 'events_body':
    target  => 'events',
    content => template('nginx/events/events.erb'),
    order   => '01'
  }

  concat::fragment { 'events_custom':
    target  => 'events',
    content => template('nginx/shared/custom.erb'),
    order   => '02',
  }

  concat::fragment { 'events_bottom':
    target  => 'events',
    content => '}',
    order   => '99',
  }
}
