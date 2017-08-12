class nginx::events (
  Integer $worker_connections = 1024,
) inherits nginx::config  {
  notice('Configuring nginx events')

  concat::fragment { 'nginx_events':
    target  => 'nginx_conf',
    content => 'events {}',
    order   => '01',
  }
}
