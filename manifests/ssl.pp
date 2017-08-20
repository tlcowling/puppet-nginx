class nginx::ssl (
  Optional[Hash] $ssl_configs = undef,
) inherits nginx::config {

  file { "${base_directory}/ssl.d":
    ensure  => directory,
    recurse => true,
    purge   => true,
    owner   => $user,
    group   => $group,
    mode    => '0750',
  }

  if $ssl_configs {
    $ssl_configs.each |$n, $config| {
      nginx::config::ssl { $n:
        ssl         => $config['ssl'],
        ssl_ciphers => $config['ssl_ciphers'],
      }
    }
  }
}
