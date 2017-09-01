define nginx::stream::server(
  Enum['tcp', 'udp'] $protocol = 'tcp',
  Optional[Integer] $port = undef,
  Optional[String] $upstream = undef,
  Optional[String] $proxy_bind = undef,
  Optional[String] $proxy_buffer_size = undef,
  Optional[String] $zone = undef,
  Optional[Array[String]] $access_control_lists = undef,

  Optional[String] $owner = $::nginx::config::user,
  Optional[String] $group = $::nginx::config::group,
  Optional[String] $mode = $::nginx::config::mode,
  Optional[String] $base_directory = $::nginx::config::base_directory,
  Optional[String] $streams_directory = $::nginx::config::streams_directory,
  Optional[String] $stream_servers_directory = $::nginx::streams::dirname,
  Optional[Array[String]] $custom = undef,
) {

  notice("Test This pl ${base_directory}/${streams_directory}/${stream_servers_directory}/${name}.conf")
  file { "${name} upstream server":
    ensure  => present,
    path    => "${base_directory}/${streams_directory}/${stream_servers_directory}/${name}.conf",
    owner   => $owner,
    group   => $group,
    mode    => $mode,
    content => template('nginx/stream/server.erb'),
  }
}