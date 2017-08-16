# nginx::http
#
# @summary Generates configuration for an nginx http block
#
# @example Include default http settings
#   include nginx::http
#
# @param absolute_redirect If disabled, redirects issued by nginx will be relative.
# @param aio Enables or disables the use of asynchronous file I/O (AIO) on FreeBSD and Linux
# @param aio_write If aio is enabled, specifies whether it is used for writing files. Currently, this only works when using aio threads and is limited to writing temporary files with data received from proxied servers.
# @param chunked_transfer_encoding Allows disabling chunked transfer encoding in HTTP/1.1. It may come in handy when using a software failing to support chunked encoding despite the standard’s requirement. 
# @param client_body_buffer_size Sets buffer size for reading client request body. In case the request body is larger than the buffer, the whole body or only its part is written to a temporary file.  By default, buffer size is equal to two memory pages. This is 8K on x86, other 32-bit platforms, and x86-64. It is usually 16K on other 64-bit platforms.
# @param client_body_in_file_only Determines whether nginx should save the entire client request body into a file. This directive can be used during debugging, or when using the $request_body_file variable, or the $r->request_body_file method of the module ngx_http_perl_module.
#
# When set to the value on, temporary files are not removed after request processing.
#
# The value clean will cause the temporary files left after request processing to be removed.
# @param client_body_in_single_buffer Determines whether nginx should save the entire client request body in a single buffer. The directive is recommended when using the $request_body variable, to save the number of copy operations involved.
class nginx::http (
  String $default_type = 'application/octet-stream',
  Variant[Enum['on','off'], Boolean] $gzip = 'on',
  Optional[Variant[Enum['on','off'], Boolean]] $absolute_redirect = undef,
  Optional[Variant[Enum['on','off'], Boolean]] $aio = undef,
  Optional[Variant[Enum['on','off'], Boolean]] $aio_write = undef,
  Optional[Variant[Enum['on','off'], Boolean]] $chunked_transfer_encoding = undef,
  Optional[Variant[Enum['on','off'], Boolean]] $client_body_buffer_size = undef,
  Optional[Variant[Enum['on','off','clean']]] $client_body_in_file_only = undef,
  Optional[Variant[Enum['on','off'], Boolean]] $client_body_in_single_buffer = undef,
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
  Optional[Variant[Enum['on','off'], Boolean]] $etag = undef,
  Optional[Enum['off','exact','before']] $if_modified_since = undef,
  Optional[Variant[Enum['on','off'], Boolean]] $ignore_invalid_headers = undef,
  Optional[String] $keepalive_disable = undef,
  Optional[Integer] $keepalive_requests = undef,
  Optional[Variant[String, Integer]] $keepalive_timeout = undef,
  Optional[String] $large_client_header_buffers = undef,
  Optional[Variant[String, Integer]] $limit_rate = undef,
  Optional[Variant[String, Integer]] $limit_rate_after = undef,
  Optional[Variant[Enum['on','off','always'], Boolean]] $lingering_close = undef,
  Optional[Variant[String, Integer]] $lingering_time = undef,
  Optional[Variant[String, Integer]] $lingering_timeout = undef,
  Optional[Variant[Enum['on','off'], Boolean]] $log_not_found = undef,
  Optional[Variant[Enum['on', 'off'], Boolean]] $log_subrequest = undef,
  Optional[Integer] $max_ranges = undef,
  Optional[Variant[Enum['on', 'off'], Boolean]] $merge_slashes = undef,
  Optional[Variant[Enum['on', 'off'], Boolean]] $msie_padding = undef,
  Optional[Variant[Enum['on', 'off'], Boolean]] $msie_refresh = undef,
  Optional[Variant[Enum['off'], Hash[Enum['max','inactive'], Variant[String, Integer]]]] $open_file_cache = undef,
  Optional[Variant[Enum['on', 'off'], Boolean]] $open_file_cache_errors = undef,
  Optional[Integer] $open_file_cache_min_uses = undef,
  Optional[String] $open_file_cache_valid = undef,
  Optional[String] $output_buffers = undef,
  Optional[Variant[Enum['on', 'off'], Boolean]] $port_in_redirect = undef,
  Optional[Variant[String,Integer]] $postpone_output = undef,
  Optional[Variant[String,Integer]] $read_ahead = undef,
  Optional[Variant[Enum['on', 'off'], Boolean]] $recursive_error_pages = undef,
  Optional[Variant[String,Integer]] $request_pool_size = undef,
  Optional[Variant[Enum['on', 'off'], Boolean]] $reset_timedout_connection = undef,
  Optional[String] $resolver = undef,
  Optional[String] $resolver_timeout = undef,
  Optional[String] $root = undef,
  Optional[Enum['all','any']] $satisfy = undef,
  Optional[Variant[String, Integer]] $send_lowat = undef,
  Optional[Variant[String, Integer]] $send_timeout = undef,
  Optional[Variant[Enum['on', 'off'], Boolean]] $sendfile = undef,
  Optional[Variant[String,Integer]] $sendfile_max_chunk = undef,
  Optional[Variant[Enum['on', 'off'], Boolean]] $server_name_in_redirect = undef,
  Optional[Variant[Integer, String]] $server_names_hash_bucket_size = undef,
  Optional[Variant[Integer, String]] $server_names_hash_max_size = undef,
  Optional[Variant[String, Boolean]] $server_tokens = undef,
  Optional[Variant[Enum['on','off'], Boolean]] $tcp_nodelay = undef,
  Optional[Variant[Enum['on','off'], Boolean]] $tcp_nopush = undef,
  Optional[Variant[Integer,String]] $types_hash_bucket_size = undef,
  Optional[Variant[Integer,String]] $types_hash_max_size = undef,
  Optional[Variant[Enum['on','off'], Boolean]] $underscores_in_headers = undef,
  Optional[Variant[Integer,String]] $variables_hash_bucket_size = undef,
  Optional[Variant[Integer,String]] $variables_hash_max_size = undef,
) inherits nginx::config {
  concat { 'http_conf':
    path  => "${base_directory}/http.conf",
    owner => $user,
    group => $group,
    mode  => '0750',
    ensure_newline => true,
  }

  concat::fragment { 'http_header':
    target => 'http_conf',
    content => 'http {',
    order  => '00',
  }

  concat::fragment { 'http_conf_client':
    target => 'http_conf',
    content => template('nginx/http/client.erb'),
    order  => '01',
  }

  concat::fragment { 'http_conf_http':
    target => 'http_conf',
    content => template('nginx/http/http.erb'),
    order  => '02',
  }

  concat::fragment { 'http_conf_servers':
    target => 'http_conf',
    content => '  include servers.d/*;',
    order  => '03',
  }

  concat::fragment { 'http_footer':
    target => 'http_conf',
    content => '}',
    order  => '04',
  }

}
