define nginx::config::type (
  Optional[Hash] $lines = undef,
  Optional[String] $owner = $::nginx::config::user,
  Optional[String] $group = $::nginx::config::group,
  Optional[String] $mode = $::nginx::config::mode,
  Optional[String] $base_directory = $::nginx::config::base_directory,
  Optional[String] $includes_directory = $::nginx::config::includes_directory,
  Optional[String] $dirname = $::nginx::types::dirname,
) {
  if $lines {
    file { "${base_directory}/${includes_directory}/${dirname}/${name}":
      mode    => $mode,
      owner   => $owner,
      group   => $group,
      content => template('nginx/types/types.erb'),
    }
  }
}