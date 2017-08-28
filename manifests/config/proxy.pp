define nginx::config::proxy(
  Optional[String] $proxy_bind = undef,
  Optional[Variant[String, Integer]] $proxy_buffer_size = undef,
  Optional[Boolean] $proxy_buffering = undef,
  Optional[
    Hash[
      Enum['number', 'size'],
      Variant[String, Integer],
    ]
  ] $proxy_buffers = undef,
  Optional[Variant[String, Integer]] $proxy_busy_buffers_size = undef,
  Optional[String] $proxy_cache = undef,
  Optional[Boolean] $proxy_cache_background_update = undef,
  Optional[Array[String]] $proxy_cache_bypass = undef,
  Optional[Boolean] $proxy_cache_convert_head = undef,
  Optional[String] $proxy_cache_key = undef,
  Optional[Boolean] $proxy_cache_lock = undef,
  Optional[Variant[String,Integer]] $proxy_cache_lock_age = undef,
  Optional[Variant[String,Integer]] $proxy_cache_lock_timeout = undef,
  Optional[Integer] $proxy_cache_max_range_offset = undef,
  Optional[
    Array[
      Enum[
        'GET',
        'HEAD',
        'POST',
      ]
    ]
  ] $proxy_cache_methods = undef,
  Optional[Integer] $proxy_cache_min_uses = undef,
  Optional[
    Hash[
      Enum[
        'path',
        'levels',
        'use_temp_path',
        'keys_zone',
        'inactive',
        'max_size',
        'manager_files',
        'manager_sleep',
        'manager_threshold',
        'loader_files',
        'loader_sleep',
        'loader_threshold',
        'purger',
        'purger_files',
        'purger_sleep',
        'purger_threshold',
      ],
      Variant[String, Integer, Boolean]
    ]
  ] $proxy_cache_path = undef,
  Optional[Array[String]] $proxy_cache_purge = undef,
  Optional[Boolean] $proxy_cache_revalidate = undef,
  Optional[
    Array[
      Enum[
        'error',
        'timeout',
        'invalid_header',
        'updating',
        'http_500',
        'http_502',
        'http_503',
        'http_504',
        'http_403',
        'http_404',
        'http_429',
        'off'
      ]
    ]
  ] $proxy_cache_use_stale = undef,
  Optional[
    Hash[
      Variant[String, Integer[3]],
      String,
    ]
  ] $proxy_cache_valid = undef,
  Optional[Variant[Integer, String]] $proxy_connect_timeout = undef,
  Optional[Array[String]] $proxy_cookie_domain = undef,
  Optional[
    Hash[
      String,
      String,
    ]
  ] $proxy_cookie_path = undef,
  Optional[Boolean] $proxy_force_ranges = undef,
  Optional[Variant[Integer, String]] $proxy_headers_hash_bucket_size = undef,
  Optional[Variant[Integer, String]] $proxy_headers_hash_max_size = undef,
  Optional[Array[String]] $proxy_hide_header = undef,
  Optional[Variant[Float, String]] $proxy_http_version = undef,
  Optional[Boolean] $proxy_ignore_client_abort = undef,
  Optional[Array[String]] $proxy_ignore_headers = undef,
  Optional[Boolean] $proxy_intercept_errors = undef,
  Optional[Variant[Integer, String]] $proxy_limit_rate = undef,
  Optional[Variant[Integer, String]] $proxy_max_temp_file_size = undef,
  Optional[String] $proxy_method = undef,
  Optional[
    Array[
      Enum[
        'error',
        'timeout',
        'invalid_header',
        'http_500',
        'http_502',
        'http_503',
        'http_504',
        'http_403',
        'http_404',
        'http_429',
        'non-idempotent',
        'off',
      ]
    ]
  ] $proxy_next_upstream = undef,
  Optional[Variant[String, Integer]] $proxy_next_upstream_timeout = undef,
  Optional[Variant[String, Integer]] $proxy_next_upstream_tries = undef,
  Optional[Array[String]] $proxy_no_cache = undef,
  Optional[String] $proxy_pass = undef,
  Optional[String] $proxy_pass_header = undef,
  Optional[Boolean] $proxy_pass_request_body = undef,
  Optional[Boolean] $proxy_pass_request_headers = undef,
  Optional[Variant[String,Integer]] $proxy_read_timeout = undef,
  Optional[
    Hash[
      String,
      String,
    ]
  ] $proxy_redirect = undef,
  Optional[Boolean] $proxy_request_buffering = undef,
  Optional[Variant[String, Integer]] $proxy_send_lowat = undef,
  Optional[Variant[String, Integer]] $proxy_send_timeout = undef,
  Optional[String] $proxy_set_body = undef,
  Optional[
    Hash[
      String,
      String,
    ]
  ] $proxy_set_header = undef,
  Optional[String] $proxy_ssl_certificate = undef,
  Optional[String] $proxy_ssl_certificate_key = undef,
  Optional[String] $proxy_ssl_ciphers = undef,
  Optional[String] $proxy_ssl_crl = undef,
  Optional[String] $proxy_ssl_name = undef,
  Optional[String] $proxy_ssl_password_file = undef,
  Optional[Boolean] $proxy_ssl_server_name = undef,
  Optional[Boolean] $proxy_ssl_session_reuse = undef,
  Optional[
    Array[
      Enum[
        'SSLv2',
        'SSLv3',
        'TLSv1',
        'TLSv1.1',
        'TLSv1.2',
        'TLSv1.3'
      ]
    ]
  ] $proxy_ssl_protocols = undef,
  Optional[String] $proxy_ssl_trusted_certificate = undef,
  Optional[Boolean] $proxy_ssl_verify = undef,
  Optional[Integer] $proxy_ssl_verify_depth = undef,
  Optional[Variant[Boolean, String]] $proxy_store = undef,
  Optional[String] $proxy_store_access = undef,
  Optional[Variant[String, Integer]] $proxy_temp_file_write_size = undef,
  Optional[String] $proxy_temp_path = undef,

  Optional[Array[String]] $custom = undef,
  Optional[String] $owner = $::nginx::config::user,
  Optional[String] $group = $::nginx::config::group,
  Optional[String] $mode = $::nginx::config::mode,
  Optional[String] $base_directory = $::nginx::config::base_directory,
  Optional[String] $includes_directory = $::nginx::config::includes_directory,
  Optional[String] $dirname = $::nginx::proxies::dirname,
) {
  concat { "Proxy ${name}":
    path    => "${base_directory}/${includes_directory}/${dirname}/${name}",
    owner   => $owner,
    group   => $group,
    mode    => $mode,
  }

  concat::fragment { "proxy_config_basic":
    target  => "Proxy ${name}",
    order   => '00',
    content => template('nginx/proxies/proxy.erb'),
  }

  concat::fragment { "proxy_config_custom":
    target  => "Proxy ${name}",
    order   => '01',
    content => template('nginx/shared/custom.erb'),
  }
}