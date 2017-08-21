class nginx::events (
  Optional[Integer]                            $worker_connections  = undef,
  Optional[Boolean]                            $multi_accept        = undef,
  Optional[Boolean]                            $accept_mutex        = undef,
  Optional[String]                             $accept_mutex_delay  = undef,
  Optional[Array[String]]                      $debug_connection    = [],
  Optional[String]                             $use                 = undef,
  Optional[Integer]                            $worker_aio_requests = undef,
) inherits nginx::config {
  notice('Configuring nginx events')

  file { "${base_directory}/events.d":
    ensure => 'directory',
    owner   => $user,
    group   => $group,
    mode    => '0750',
  }

  file { "${base_directory}/events.d/events.conf":
    owner   => $user,
    group   => $group,
    mode    => '0750',
    content => template('nginx/events/events.erb'),
    require => File["${base_directory}/events.d"],
  }

}
