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
  Optional[String] $owner = $::nginx::params::user,
  Optional[String] $group = $::nginx::params::group,
  Optional[String] $mode = $::nginx::params::mode,
  Optional[String] $base_directory = $::nginx::params::base_directory
) {
  notice("configuring ${name} gzip configuration")

  file { "gzip_config_${name}":
    path    => "/etc/nginx/gzip.d/${name}",
    mode   => $mode,
    owner  => $owner,
    group  => $group,
    content => template('nginx/gzip/gzip.erb'),
  }
}
