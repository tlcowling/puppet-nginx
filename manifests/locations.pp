class nginx::locations (
  Optional[Hash] $location_configs = undef,
) inherits nginx::config {
	file { "${base_directory}/locations.d":
		ensure  => 'directory',
		owner   => $user,
		group   => $group,
		mode    => '0750',
		recurse => true,
		purge   => true,
	}

	$location_configs.each |$n, $config| {
		notice($n, $config)
		nginx::config::location { $n:
			uri => $config['uri'],
			alias => $config['alias'],
			limit_except => $config['limit_except'],
			access_control_lists => $config["access_control_lists"],
		}
	}
}
