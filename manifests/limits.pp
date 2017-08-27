class nginx::limits (
  Options[Hash] $limit_configs = undef,
  Options[String] $limits_directory = 'limits',
) inherits nginx::config {
  file { "${base_directory}/${includes_directory}/${limits_directory}":
    ensure  => 'directory',
    owner   => $user,
    group   => $group,
    mode    => '0750',
    recurse => true,
    purge   => true,
  }
}