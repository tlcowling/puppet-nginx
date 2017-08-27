class nginx::realips (
  Optional[Hash] $realip_configs = undef,
  Optional[String] $realips_directory = 'realips',
) inherits nginx::config {
  if $realip_configs {
    file { "${base_directory}/${includes_directory}/${realips_directory}":
      ensure  => 'directory',
      mode    => '0750',
      owner   => $user,
      group   => $group,
      purge   => true,
      recurse => true,
    }
  
    $realip_configs.each |$n, $config| {
      notice("Creating ${n} realip config")
      nginx::config::realip { $n:
        set_real_ip_from  => $config['set_real_ip_from'],
        real_ip_header    => $config['real_ip_header'],
        real_ip_recursive => $config['real_ip_recursive'],
      }
    }
  }
}