define nginx::config::type (
  Optional[Hash] $lines = undef,
) {
  if $lines {
    file { "/etc/nginx/types.d/${name}":
      mode   => $mode,
    owner  => $owner,
    group  => $group,
      content => template('nginx/types/types.erb'),
    }
  }
}