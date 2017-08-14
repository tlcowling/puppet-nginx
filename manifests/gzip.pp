define nginx::gzip (
  Optional[Variant[Enum['on', 'off'], Boolean]] $gzip = undef,
  Optional[String] $gzip_buffers = undef,
  Optional[Integer[1]] $gzip_comp_level = undef,
  Optional[String] $gzip_disable = undef,
  Optional[Integer] $gzip_min_length = undef,
  Optional[String] $gzip_http_version = undef,
  Optional[Enum['off', 'expired', 'no-cache', 'no-store', 'private', 'no_last_modified', 'no_etag', 'auth', 'any']] $gzip_proxied = undef,
  Optional[String] $gzip_types = undef,
  Optional[Enum['on', 'off']] $gzip_vary = undef,
) {
	notice('configuring gzip')
}