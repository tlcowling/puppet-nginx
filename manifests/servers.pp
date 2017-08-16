class nginx::servers (
  $servers,
) inherits nginx::config {

  file { "${base_directory}/servers.d":
    owner  => $user,
    group  => $group,
    mode   => '0755',
    ensure => 'directory',
  }
  
  $servers.each |$servername, $srv| {
    notice("Creating server ${srv}")
    nginx::server::server { $servername: 
      listen => $srv['listen'],
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
