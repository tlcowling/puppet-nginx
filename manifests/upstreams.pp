class nginx::upstreams (
  Optional[String] $dirname = 'upstreams',
) inherits nginx::config {
  file { "${base_directory}/${includes_directory}/${dirname}":
    ensure  => 'directory',
    owner   => $user,
    group   => $group,
    mode    => '0750',
    recurse => true,
    purge   => true,
  }

  $upstreams_configs = lookup('upstreams')|$key| { notice("No hiera data found for ${key}") }

  if $upstreams_configs {
    $upstreams_configs.each |$n, $config| {
      notice($n, $config)
      nginx::config::upstream { $n:
        servers => $config['servers'],
        zone => $config['zone'],
        state => $config['state'],
        hash => $config['hash'],
        ip_hash => $config['ip_hash'],
        keepalive => $config['keepalive'],
        ntlm => $config['ntlm'],
        least_conn => $config['least_conn'],
        least_time => $config['least_time'],
        queue => $config['queue'],
        sticky_cookie => $config['sticky_cookie'],
        sticky_route => $config['sticky_route'],
        sticky_learn => $config['sticky_learn'],
        sticky_cookie_insert => $config['sticky_cookie_insert'],
        custom => $config["custom"],
      }
    }
  }
}
