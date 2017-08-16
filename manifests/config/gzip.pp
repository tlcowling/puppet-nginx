define nginx::config::gzip (
  Optional[Boolean] $gzip = undef,
  Optional[String] $gzip_buffers = undef,
  Optional[Integer[1]] $gzip_comp_level = undef,
  Optional[String] $gzip_disable = undef,
  Optional[Integer] $gzip_min_length = undef,
  Optional[String] $gzip_http_version = undef,
  Optional[Enum['off', 'expired', 'no-cache', 'no-store', 'private', 'no_last_modified', 'no_etag', 'auth', 'any']] $gzip_proxied = undef,
  Optional[String] $gzip_types = undef,
  Optional[Boolean] $gzip_vary = undef,
) {
  notice("configuring ${name} gzip configuration")

  file { "gzip_config_${name}":
    path    => "/etc/nginx/gzip.d/${name}",
    mode    => '0750',
    content => template('nginx/gzip/gzip.erb'),
  }
}
