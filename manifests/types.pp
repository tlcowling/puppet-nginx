class nginx::types (
  Optional $types_configs = undef,
  Optional[String] $dirname = 'types'
) inherits nginx::config {

  file { "${base_directory}/${includes_directory}/${dirname}":
    ensure  => directory,
    recurse => true,
    purge   => true,
    owner   => $user,
    group   => $group,
    mode    => '0640',
  }

  file { "${base_directory}/${includes_directory}/${dirname}/allmime.types":
    owner   => $user,
    group   => $group,
    mode    => '0640',
    source  => 'puppet:///modules/nginx/mime.types',
    require => File["${base_directory}/${includes_directory}/${dirname}"],
  }

  if $types_configs {
    $types_configs.each |$n, $config| {
      nginx::config::type { $n:
        lines => $config['lines'],
      } 
    }
  }
}