class nginx::ssl (
	Optional $ssl_configs = undef,
) inherits nginx::config {
	file { "${base_directory}/nginx/ssl.d":
		ensure  => directory,
		recurse => true,
		purge   => true,
		owner   => $user,
		group   => $group,
		mode    => '0750',
	}
}