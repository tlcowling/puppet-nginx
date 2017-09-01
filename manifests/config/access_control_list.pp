define nginx::config::access_control_list (
  Hash[Enum['allow','deny'], Array[String]] $actions,
  Optional[Array[String]] $custom = undef,
  Optional[String] $owner = $::nginx::config::user,
  Optional[String] $group = $::nginx::config::group,
  Optional[String] $mode = $::nginx::config::mode,
  Optional[String] $base_directory = $::nginx::config::base_directory,
  Optional[String] $includes_directory = $::nginx::config::includes_directory,
  Optional[String] $dirname = $::nginx::access_control_lists::dirname,
) {
  notice ($actions)
  file { "${base_directory}/${includes_directory}/${dirname}/${name}":
    mode    => '0644',
    owner   => $owner,
    group   => $group,
    content => template('nginx/acl/access_control_lists.erb'),
  }
}