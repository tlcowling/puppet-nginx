class nginx::types (
  Optional $types_configs = undef,
) inherits nginx::config {

  file { "${base_directory}/types.d":
    ensure  => directory,
    recurse => true,
    purge   => true,
    owner   => $user,
    group   => $group,
    mode    => '0640',
  }

  file { "/etc/nginx/types.d/allmime.types":
    owner   => $user,
    group   => $group,
    mode    => '0640',
    source  => 'puppet:///modules/nginx/mime.types',
    require => File["${base_directory}/types.d"],
  }

  if types_configs {
    types_configs.each |$n, $config| {
      

    }
  }
}