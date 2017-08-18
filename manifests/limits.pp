class nginx::limits (
	Options[Hash] $limit_configs = undef,
) inherits nginx::config {
	file { "${base_directory}/limits.d"
		ensure  => 'directory',
		owner   => $user,
		group   => $group,
		mode    => '0750',
	}
}