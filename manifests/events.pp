class nginx::events (
  Integer                                      $worker_connections = 1024,
  Optional[Variant[Enum['on','off'], Boolean]] $multi_accept        = undef,
  Optional[Variant[Enum['on','off'], Boolean]] $accept_mutex        = undef,
  Optional[String]                             $accept_mutex_delay  = undef,
  Optional[Array[String]]                      $debug_connection    = undef,
  Optional[String]                             $use                 = undef,
  Optional[Integer]                            $worker_aio_requests = undef,
) inherits nginx::config  {
  notice('Configuring nginx events')

  concat::fragment { 'nginx_events_header':
    target  => 'nginx_conf',
    content => 'events {}',
    order   => '01',
  }
}
