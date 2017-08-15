define nginx::server(
  Optional[String] $absolute_redirect = undef,
  Optional[String] $aio = undef,
  Optional[String] $aio_write = undef,
  Optional[String] $chunked_transfer_encoding = undef,
  Optional[String] $client_body_buffer_size = undef,
  Optional[String] $client_body_in_file_only = undef,
  Optional[String] $client_body_in_single_buffer = undef,
  Optional[String] $client_body_temp_path = undef,
  Optional[String] $client_body_timeout = undef,
  Optional[String] $client_header_buffer_size = undef,
  Optional[String] $client_header_timeout = undef,
  Optional[String] $client_max_body_size = undef,
  Optional[String] $connection_pool_size = undef,
  Optional[String] $default_type = undef,
  Optional[String] $directio = undef,
  Optional[String] $directio_alignment = undef,
  Optional[String] $disable_symlinks = undef,
  Optional[String] $error_page = undef,
  Optional[String] $etag = undef,
  Optional[String] $if_modified_since = undef,
  Optional[String] $ignore_invalid_headers = undef,
  Optional[String] $keepalive_disable = undef,
  Optional[String] $keepalive_requests = undef,
  Optional[String] $keepalive_timeout = undef,
  Optional[String] $large_client_header_buffers = undef,
  Optional[String] $limit_rate = undef,
  Optional[String] $limit_rate_after = undef,
  Optional[String] $lingering_close = undef,
  Optional[String] $lingering_time = undef,
  Optional[String] $lingering_timeout = undef,

  Array[
    Variant[
      Enum[
        'default_server',
        'ssl',
        'http2',
        'spdy',
        'proxy_protocol',
        'deferred',
      ],
      Hash[
        Enum[
         'address',
         'fastopen',
         'backlog',
         'rcvbuf',
         'sndbuf',
         'accept_filter',
         'ipv6only',
         'so_keepalive'
        ],
        Variant[
          String,
          Integer,
          Boolean,
        ],
      ]
    ]
  ] $listen = undef,


  Optional[String] $location = undef,
  Optional[String] $log_not_found = undef,
  Optional[String] $log_subrequest = undef,
  Optional[String] $max_ranges = undef,
  Optional[String] $merge_slashes = undef,
  Optional[String] $msie_padding = undef,
  Optional[String] $msie_refresh = undef,
  Optional[String] $open_file_cache = undef,
  Optional[String] $open_file_cache_errors = undef,
  Optional[String] $open_file_cache_min_uses = undef,
  Optional[String] $open_file_cache_valid = undef,
  Optional[String] $output_buffers = undef,
  Optional[String] $port_in_redirect = undef,
  Optional[String] $postpone_output = undef,
  Optional[String] $read_ahead = undef,
  Optional[String] $recursive_error_pages = undef,
  Optional[String] $request_pool_size = undef,
  Optional[String] $reset_timedout_connection = undef,
  Optional[String] $resolver = undef,
  Optional[String] $resolver_timeout = undef,
  Optional[String] $root = undef,
  Optional[String] $satisfy = undef,
  Optional[String] $send_lowat = undef,
  Optional[String] $send_timeout = undef,
  Optional[String] $sendfile = undef,
  Optional[String] $sendfile_max_chunk = undef,
  Optional[String] $server_name = undef,
  Optional[String] $server_name_in_redirect = undef,
  Optional[String] $server_tokens = undef,
  Optional[String] $tcp_nodelay = undef,
  Optional[String] $tcp_nopush = undef,
  Optional[String] $try_files = undef,
  Optional[String] $types_hash_bucket_size = undef,
  Optional[String] $types_hash_max_size = undef,
  Optional[String] $underscores_in_headers = undef,
) {
  concat { "/etc/nginx/${name}.conf":
    ensure_newline => true,
  }

  concat::fragment{ "${name}_server_head":
    content => "server {",
    target  => "/etc/nginx/${name}.conf",
    order   => '00',
  }

  concat::fragment{ "${name}_server_conf":
    content => template('nginx/server/server.erb'),
    target  => "/etc/nginx/${name}.conf",
    order   => '01',
  }

  concat::fragment{ "${name}_server_bottom":
    content => "}",
    target  => "/etc/nginx/${name}.conf",
    order   => '02',
  }
}
