define nginx::config::server(
  Hash[
    Enum[
      'host',
      'port',
      'options',
    ],
    Variant[
      String,
      Integer,
      Array[
        Variant[
          Enum[
            'default_server',
            'ssl',
            'http2',
            'spdy',
            'proxy_protocol',
            'deferred',
            'reuseport',
            'bind',
          ],
          Hash[
            Enum[
             'set_fib',
             'fastopen',
             'backlog',
             'rcvbuf',
             'sndbuf',
             'accept_filter',
             'ipv6only',
             'so_keepalive',
            ],
            Variant[
              String,
              Integer,
              Boolean,
            ]
          ]
        ]
      ]
    ]
  ] $listen = undef,
  String $default_type = 'application/octet-stream',
  Optional[Boolean] $absolute_redirect = undef,
  Optional[Boolean] $aio = undef,
  Optional[Boolean] $aio_write = undef,
  Optional[Boolean] $chunked_transfer_encoding = undef,
  Optional[Boolean] $client_body_buffer_size = undef,
  Optional[Variant[Enum['on','off','clean']]] $client_body_in_file_only = undef,
  Optional[Boolean] $client_body_in_single_buffer = undef,
  Optional[String] $client_body_temp_path = undef,
  Optional[String] $client_body_timeout = undef,
  Optional[String] $client_header_buffer_size = undef,
  Optional[String] $client_header_timeout = undef,
  Optional[String] $client_max_body_size = undef,
  Optional[Integer] $connection_pool_size = undef,
  Optional[String] $directio = undef,
  Optional[String] $directio_alignment = undef,
  Optional[Pattern[/^off$|^on$|^if_not_owner/]] $disable_symlinks = undef,
  Optional[String] $error_page = undef,
  Optional[Boolean] $etag = undef,
  Optional[Enum['off','exact','before']] $if_modified_since = undef,
  Optional[Boolean] $ignore_invalid_headers = undef,
  Optional[String] $index = undef,
  Optional[String] $keepalive_disable = undef,
  Optional[Integer] $keepalive_requests = undef,
  Optional[Variant[String, Integer]] $keepalive_timeout = undef,
  Optional[String] $large_client_header_buffers = undef,
  Optional[Variant[String, Integer]] $limit_rate = undef,
  Optional[Variant[String, Integer]] $limit_rate_after = undef,
  Optional[Variant[Enum['on','off','always'], Boolean]] $lingering_close = undef,
  Optional[Variant[String, Integer]] $lingering_time = undef,
  Optional[Variant[String, Integer]] $lingering_timeout = undef,
  Optional[Boolean] $log_not_found = undef,
  Optional[Boolean] $log_subrequest = undef,
  Optional[Integer] $max_ranges = undef,
  Optional[Boolean] $merge_slashes = undef,
  Optional[Boolean] $msie_padding = undef,
  Optional[Boolean] $msie_refresh = undef,
  Optional[Hash[Enum['max','inactive'], Variant[String, Integer]]] $open_file_cache = undef,
  Optional[Boolean] $open_file_cache_errors = undef,
  Optional[Integer] $open_file_cache_min_uses = undef,
  Optional[String] $open_file_cache_valid = undef,
  Optional[String] $output_buffers = undef,
  Optional[Boolean] $port_in_redirect = undef,
  Optional[Variant[String,Integer]] $postpone_output = undef,
  Optional[Variant[String,Integer]] $read_ahead = undef,
  Optional[Boolean] $recursive_error_pages = undef,
  Optional[Variant[String,Integer]] $request_pool_size = undef,
  Optional[Boolean] $reset_timedout_connection = undef,
  Optional[String] $resolver = undef,
  Optional[String] $resolver_timeout = undef,
  Optional[String] $root = undef,
  Optional[Enum['all','any']] $satisfy = undef,
  Optional[Variant[String, Integer]] $send_lowat = undef,
  Optional[Variant[String, Integer]] $send_timeout = undef,
  Optional[Boolean] $sendfile = undef,
  Optional[Variant[String,Integer]] $sendfile_max_chunk = undef,
  Optional[Boolean] $server_name_in_redirect = undef,
  Optional[Variant[Integer, String]] $server_names_hash_bucket_size = undef,
  Optional[Variant[Integer, String]] $server_names_hash_max_size = undef,
  Optional[Variant[String, Boolean]] $server_tokens = undef,
  Optional[Boolean] $tcp_nodelay = undef,
  Optional[Boolean] $tcp_nopush = undef,
  Optional[Variant[Integer,String]] $types_hash_bucket_size = undef,
  Optional[Variant[Integer,String]] $types_hash_max_size = undef,
  Optional[Boolean] $underscores_in_headers = undef,
  Optional[Variant[Integer,String]] $variables_hash_bucket_size = undef,
  Optional[Variant[Integer,String]] $variables_hash_max_size = undef,

  Optional[Array[String]] $includes = undef,
  Optional[Array[String]] $locations = undef,
  Optional[String] $owner = $::nginx::config::user,
  Optional[String] $group = $::nginx::config::group,
  Optional[String] $mode = $::nginx::config::mode,
  Optional[String] $base_directory = $::nginx::config::base_directory,
  Optional[String] $includes_directory = $::nginx::config::includes_directory,
  Optional[String] $servers_directory = $::nginx::servers::servers_directory,
) {
  
  $server_config_name = "${base_directory}/${includes_directory}/${servers_directory}/${name}.conf"

  concat { $server_config_name:
    ensure_newline => true,
    mode           => $mode,
    owner          => $owner,
    group          => $group,
  }

  concat::fragment{ "${name}_server_head":
    content => 'server {',
    target  => $server_config_name,
    order   => '00',
  }

  concat::fragment{ "${name}_server_listen_conf":
    content => template('nginx/server/server.erb'),
    target  => $server_config_name,
    order   => '01',
  }

  concat::fragment{ "${name}_server_conf":
    content => template('nginx/shared/shared.erb'),
    target  => $server_config_name,
    order   => '02',
  }

  concat::fragment{ "${name}_server_locations":
    content => template('nginx/server/locations.erb'),
    target  => $server_config_name,
    order   => '03',
  }

  concat::fragment{ "${name}_server_bottom":
    content => '}',
    target  => $server_config_name,
    order   => '04',
  }
}
