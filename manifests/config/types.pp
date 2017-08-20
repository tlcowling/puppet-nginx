define nginx::config::type (
  Optional[Hash] $lines = undef,
) {
  if $lines {
    file { "/etc/nginx/types.d/${name}":
      owner   => 'nginx',
      group   => 'nginx',
      mode    => '0640',
      content => template('nginx/types/types.erb'),
    }
  }
}