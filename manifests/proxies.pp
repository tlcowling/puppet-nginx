class nginx::proxies (
  Optional[String] $dirname = 'proxies'
) inherits nginx::config {
  notice('configuring proxies')

  $proxies = lookup('proxies')|$key| { notice("This key is $key") }

  file { "Proxies Directory":
    path    => "${base_directory}/${includes_directory}/${dirname}",
    ensure  => 'directory',
    mode    => '0750',
    owner   => $user,
    group   => $group,
  }

  if $proxies {
    $proxies.each |$n, $config| {
      nginx::config::proxy { $n:
        custom => $config['custom'],
      }
    }
  }
}