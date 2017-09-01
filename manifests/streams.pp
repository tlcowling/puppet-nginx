class nginx::streams (
  Optional[String] $dirname = 'servers',
) inherits nginx::config {

  file { "${base_directory}/${streams_directory}/${dirname}":
    ensure  => 'directory',
    group   => $group,
    mode    => '0755',
    recurse => true,
    purge   => true,
    owner   => $user,
  }

  # $upstreams = lookup('upstreams') |$key| { notice("User specified no ${key} hiera data") }

  # if $upstreams {
  #   $upstreams.each |$upname, $upstream| {
  #     if $upstream == undef {
  #       fail('an upstream must contain something')
  #     }

  #     nginx::stream::upstream { $upname:
  #       method           => $upstream['method'],
  #       method_attribute => $upstream['method_attribute'],
  #       servers          => $upstream['servers'],
  #     }
  #   }
  # }

  $servers = lookup('streams') |$key| { notice("User specified no ${key} hiera data") }
  if $servers {
    $servers.each |$servername, $server| {
      nginx::stream::server { $servername:
        port                 => $server['port'],
        protocol             => $server['protocol'],
        upstream             => $server['upstream'],
        access_control_lists => $server['access_control_lists'],
      }
    }
  }
}
