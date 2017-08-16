define nginx::stream::server(
  Integer $port,
  Enum['tcp', 'udp'] $protocol = 'tcp',
  String $upstream,
  String $proxy_bind = '',
  String $proxy_buffer_size = '',
  String $zone = '',
  Array[String] $access_control_lists = [],
) {

  $streams_config_dir = "/etc/nginx/streams.d/server_${name}.conf"

  concat { $streams_config_dir:
    ensure  => present,
  }

  concat::fragment { "${name} server_block_top}":
    target  => $streams_config_dir,
    content => template('nginx/server_block_top.erb'),
    order   => '01',
  }

  concat::fragment { "${name} server":
    target  => $streams_config_dir,
    content => template('nginx/server.erb'),
    order   => '02',
  }

  concat::fragment { "${name} server_block_bottom}":
    target  => $streams_config_dir,
    content => "}\n",
    order   => '99',
  }
}

