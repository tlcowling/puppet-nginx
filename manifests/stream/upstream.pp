define nginx::stream::upstream (
  Enum['round-robin', 'least_conn', 'hash'] $method = 'round-robin',
  String                                    $method_attribute = "",
  Array[Hash[Enum['address','max_conns','max_fails','weight','fail_timeout','backup','down'],Variant[String,Integer]]] $servers = [],
) {

  $streams_config_dir = "/etc/nginx/streams.d/upstream_${name}.conf"
  concat { $streams_config_dir:
    ensure => 'present',
  }

  concat::fragment { "${name} block header":
    target  => $streams_config_dir,
    content => template('nginx/upstream_block_top.erb'),
    order   => '01',
  }
 
  $servers.each |$server| {
    concat::fragment { "${server} upstream fragment":
      target => $streams_config_dir,
      content => template('nginx/upstream_server.erb'),
    }
  }

  concat::fragment { "${name} block footer":
    target  => $streams_config_dir,
    content => "}\n",
    order   => '99',
  }
}
