class nginx::gzip (
  Optional[Hash] $gzip_configs = undef,
) inherits nginx::config {
  file { "${base_directory}/gzip.d":
    ensure  => directory,
    recurse => true,
    purge   => true,
    owner   => $user,
    group   => $group,
    mode    => '0750',
  }

  $gzip_configs.each |$config_name, $config| {
    nginx::config::gzip { $config_name:
      gzip              => $config['gzip'],
      gzip_buffers      => $config['gzip_buffers'],
      gzip_comp_level   => $config['gzip_comp_level'],
      gzip_disable      => $config['gzip_disable'],
      gzip_min_length   => $config['gzip_min_length'],
      gzip_http_version => $config['gzip_http_version'],
      gzip_proxied      => $config['gzip_proxied'],
      gzip_types        => $config['gzip_types'],
      gzip_vary         => $config['gzip_vary'],
    }
  }
}