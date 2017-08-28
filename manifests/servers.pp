class nginx::servers (
  Optional[String] $dirname = 'servers',
) inherits nginx::config {

  $servers = lookup('servers')|$key| { notice("Misisng hiera information for ${key}") }

  file { "${base_directory}/${includes_directory}/${dirname}":
    ensure  => 'directory',
    recurse => true,
    purge   => true,
    group   => $group,
    mode    => '0755',
    owner   => $user,
  }

  if $servers {
    $servers.each |$n, $config| {
      notice("Creating server ${config}")
      nginx::config::server { $n:
        listen                        => $config['listen'],
        locations                     => $config['locations'],
        error_log                     => $config['error_log'],
        absolute_redirect             => $config["absolute_redirect"],
        aio                           => $config["aio"],
        aio_write                     => $config["aio_write"],
        chunked_transfer_encoding     => $config["chunked_transfer_encoding"],
        client_body_buffer_size       => $config["client_body_buffer_size"],
        client_body_in_file_only      => $config["client_body_in_file_only"],
        client_body_in_single_buffer  => $config["client_body_in_single_buffer"],
        client_body_temp_path         => $config["client_body_temp_path"],
        client_body_timeout           => $config["client_body_timeout"],
        client_header_buffer_size     => $config["client_header_buffer_size"],
        client_header_timeout         => $config["client_header_timeout"],
        client_max_body_size          => $config["client_max_body_size"],
        connection_pool_size          => $config["connection_pool_size"],
        directio                      => $config["directio"],
        directio_alignment            => $config["directio_alignment"],
        disable_symlinks              => $config["disable_symlinks"],
        error_page                    => $config["error_page"],
        etag                          => $config["etag"],
        if_modified_since             => $config["if_modified_since"],
        ignore_invalid_headers        => $config["ignore_invalid_headers"],
        keepalive_disable             => $config["keepalive_disable"],
        keepalive_requests            => $config["keepalive_requests"],
        keepalive_timeout             => $config["keepalive_timeout"],
        large_client_header_buffers   => $config["large_client_header_buffers"],
        limit_rate                    => $config["limit_rate"],
        limit_rate_after              => $config["limit_rate_after"],
        lingering_close               => $config["lingering_close"],
        lingering_time                => $config["lingering_time"],
        lingering_timeout             => $config["lingering_timeout"],
        log_not_found                 => $config["log_not_found"],
        log_subrequest                => $config["log_subrequest"],
        max_ranges                    => $config["max_ranges"],
        merge_slashes                 => $config["merge_slashes"],
        msie_padding                  => $config["msie_padding"],
        msie_refresh                  => $config["msie_refresh"],
        open_file_cache               => $config["open_file_cache"],
        open_file_cache_errors        => $config["open_file_cache_errors"],
        open_file_cache_min_uses      => $config["open_file_cache_min_uses"],
        open_file_cache_valid         => $config["open_file_cache_valid"],
        output_buffers                => $config["output_buffers"],
        port_in_redirect              => $config["port_in_redirect"],
        postpone_output               => $config["postpone_output"],
        read_ahead                    => $config["read_ahead"],
        recursive_error_pages         => $config["recursive_error_pages"],
        request_pool_size             => $config["request_pool_size"],
        reset_timedout_connection     => $config["reset_timedout_connection"],
        resolver                      => $config["resolver"],
        resolver_timeout              => $config["resolver_timeout"],
        root                          => $config["root"],
        satisfy                       => $config["satisfy"],
        send_lowat                    => $config["send_lowat"],
        send_timeout                  => $config["send_timeout"],
        sendfile                      => $config["sendfile"],
        sendfile_max_chunk            => $config["sendfile_max_chunk"],
        server_name                   => $config["server_name"],
        server_name_in_redirect       => $config["server_name_in_redirect"],
        server_names_hash_bucket_size => $config["server_names_hash_bucket_size"],
        server_names_hash_max_size    => $config["server_names_hash_max_size"],
        server_tokens                 => $config["server_tokens"],
        tcp_nodelay                   => $config["tcp_nodelay"],
        tcp_nopush                    => $config["tcp_nopush"],
        try_files                     => $config["try_files"],
        types_hash_bucket_size        => $config["types_hash_bucket_size"],
        types_hash_max_size           => $config["types_hash_max_size"],
        underscores_in_headers        => $config["underscores_in_headers"],
        custom                        => $config["custom"],
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
