class nginx::proxies (
  Optional[String] $dirname = 'proxies'
) inherits nginx::config {
  notice('configuring proxies')

  $proxies = lookup('proxies')|$key| { notice("This key is $key") }

  file { "Proxies Directory":
    path    => "${base_directory}/${includes_directory}/${dirname}",
    ensure  => 'directory',
    mode    => '0750',
    owner   => $user,
    group   => $group,
  }

  if $proxies {
    $proxies.each |$n, $config| {
      nginx::config::proxy { $n:
        proxy_bind => $config['proxy_bind'],
        proxy_buffer_size => $config['proxy_buffer_size'],
        proxy_buffering => $config['proxy_buffering'],
        proxy_buffers => $config['proxy_buffers'],
        proxy_busy_buffers_size => $config['proxy_busy_buffers_size'],
        proxy_cache => $config['proxy_cache'],
        proxy_cache_background_update => $config['proxy_cache_background_update'],
        proxy_cache_bypass => $config['proxy_cache_bypass'],
        proxy_cache_convert_head => $config['proxy_cache_convert_head'],
        proxy_cache_key => $config['proxy_cache_key'],
        proxy_cache_lock => $config['proxy_cache_lock'],
        proxy_cache_lock_age => $config['proxy_cache_lock_age'],
        proxy_cache_lock_timeout => $config['proxy_cache_lock_timeout'],
        proxy_cache_max_range_offset => $config['proxy_cache_max_range_offset'],
        proxy_cache_methods => $config['proxy_cache_methods'],
        proxy_cache_min_uses => $config['proxy_cache_min_uses'],
        proxy_cache_path => $config['proxy_cache_path'],
        proxy_cache_purge => $config['proxy_cache_purge'],
        proxy_cache_revalidate => $config['proxy_cache_revalidate'],
        proxy_cache_use_stale => $config['proxy_cache_use_stale'],
        proxy_cache_valid => $config['proxy_cache_valid'],
        proxy_connect_timeout => $config['proxy_connect_timeout'],
        proxy_cookie_domain => $config['proxy_cookie_domain'],
        proxy_cookie_path => $config['proxy_cookie_path'],
        proxy_force_ranges => $config['proxy_force_ranges'],
        proxy_headers_hash_bucket_size => $config['proxy_headers_hash_bucket_size'],
        proxy_headers_hash_max_size => $config['proxy_headers_hash_max_size'],
        proxy_hide_header => $config['proxy_hide_header'],
        proxy_http_version => $config['proxy_http_version'],
        proxy_ignore_client_abort => $config['proxy_ignore_client_abort'],
        proxy_ignore_headers => $config['proxy_ignore_headers'],
        proxy_intercept_errors => $config['proxy_intercept_errors'],
        proxy_limit_rate => $config['proxy_limit_rate'],
        proxy_max_temp_file_size => $config['proxy_max_temp_file_size'],
        proxy_method => $config['proxy_method'],
        proxy_next_upstream => $config['proxy_next_upstream'],
        proxy_next_upstream_timeout => $config['proxy_next_upstream_timeout'],
        proxy_next_upstream_tries => $config['proxy_next_upstream_tries'],
        proxy_no_cache => $config['proxy_no_cache'],
        proxy_pass => $config['proxy_pass'],
        proxy_pass_header => $config['proxy_pass_header'],
        proxy_pass_request_body => $config['proxy_pass_request_body'],
        proxy_pass_request_headers => $config['proxy_pass_request_headers'],
        proxy_read_timeout => $config['proxy_read_timeout'],
        proxy_redirect => $config['proxy_redirect'],
        proxy_request_buffering => $config['proxy_request_buffering'],
        proxy_send_lowat => $config['proxy_send_lowat'],
        proxy_send_timeout => $config['proxy_send_timeout'],
        proxy_set_body => $config['proxy_set_body'],
        proxy_set_header => $config['proxy_set_header'],
        proxy_ssl_certificate => $config['proxy_ssl_certificate'],
        proxy_ssl_certificate_key => $config['proxy_ssl_certificate_key'],
        proxy_ssl_ciphers => $config['proxy_ssl_ciphers'],
        proxy_ssl_crl => $config['proxy_ssl_crl'],
        proxy_ssl_name => $config['proxy_ssl_name'],
        proxy_ssl_password_file => $config['proxy_ssl_password_file'],
        proxy_ssl_server_name => $config['proxy_ssl_server_name'],
        proxy_ssl_session_reuse => $config['proxy_ssl_session_reuse'],
        proxy_ssl_protocols => $config['proxy_ssl_protocols'],
        proxy_ssl_trusted_certificate => $config['proxy_ssl_trusted_certificate'],
        proxy_ssl_verify => $config['proxy_ssl_verify'],
        proxy_ssl_verify_depth => $config['proxy_ssl_verify_depth'],
        proxy_store => $config['proxy_store'],
        proxy_store_access => $config['proxy_store_access'],
        proxy_temp_file_write_size => $config['proxy_temp_file_write_size'],
        proxy_temp_path => $config['proxy_temp_path'],
        custom => $config['custom'],
      }
    }
  }
}