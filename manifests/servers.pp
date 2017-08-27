class nginx::servers (
  $servers,
  Optional[String] $servers_directory = 'servers',
) inherits nginx::config {

  file { "${base_directory}/${includes_directory}/${servers_directory}":
    ensure  => 'directory',
    recurse => true,
    purge   => true,
    group   => $group,
    mode    => '0755',
    owner   => $user,
  }

  if $servers {
    $servers.each |$servername, $srv| {
      notice("Creating server ${srv}")
      nginx::config::server { $servername:
        listen    => $srv['listen'],
        locations => $srv['locations'],
        includes  => $srv['includes'],
      }
    }
  }

  # $upstreams.each |$upname, $upstream| {
  #   if $upstream == undef {
  #     fail('an upstream must contain something')
  #   }

  #   nginx::stream::upstream { $upname:
  #     method           => $upstream['method'],
  #     method_attribute => $upstream['method_attribute'],
  #     servers          => $upstream['servers'],
  #   }
  # }

  # $servers = lookup('streams')
  # notice("Servers: ${servers}")
  # $servers.each |$servername, $server| {
  #   nginx::stream::server { $servername:
  #     port                 => $server['port'],    
  #     protocol             => $server['protocol'],
  #     upstream             => $server['upstream'],
  #     access_control_lists => $server['access_control_lists'],
  #   }
  # }
}
