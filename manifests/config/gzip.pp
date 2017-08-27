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
  Optional[String] $owner = $::nginx::config::user,
  Optional[String] $group = $::nginx::config::group,
  Optional[String] $mode = $::nginx::config::mode,
  Optional[String] $base_directory = $::nginx::config::base_directory,
  Optional[String] $includes_directory = $::nginx::config::includes_directory,
  Optional[String] $gzip_directory = $::nginx::gzip::include_directory,
) {

  file { "Gzip Config ${name}":
    path    => "${base_directory}/${includes_directory}/${gzip_directory}/${name}",
    mode    => $mode,
    owner   => $owner,
    group   => $group,
    content => template('nginx/gzip/gzip.erb'),
  }
}
