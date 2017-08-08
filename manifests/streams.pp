class nginx::streams {
  file { '/etc/nginx':
    ensure => 'directory',
  }->
  file { '/etc/nginx/nginx.conf':
    ensure => 'file',  
    content => "stream {\n  include 'streams.d/*';\n}"
  }->
  file { '/etc/nginx/streams.d':
    ensure => 'directory',
  }
  
  $upstreams = lookup('upstreams')
  
  $upstreams.each |$upname, $upstream| {
    if $upstream == undef {
      fail('an upstream must contain something')
    }
  
    nginx::stream::upstream { $upname:
      method           => $upstream['method'],
      method_attribute => $upstream['method_attribute'],
      servers          => $upstream['servers'],
    }
  }
  
  $servers = lookup('streams')
  notice("Servers: ${servers}")
  $servers.each |$servername, $server| {
    nginx::stream::server { $servername:
      port                 => $server['port'],    
      protocol             => $server['protocol'],
      upstream             => $server['upstream'],
      access_control_lists => $server['access_control_lists'],
    }
  }
}
