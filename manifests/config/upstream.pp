define nginx::config::upstream (
  Optional[String] $upstream = undef,
  Optional[String] $server = undef,
  Optional[String] $zone = undef,
  Optional[String] $state = undef,
  Optional[String] $hash = undef,
  Optional[String] $ip_hash = undef,
  Optional[String] $keepalive = undef,
  Optional[String] $ntlm = undef,
  Optional[String] $least_conn = undef,
  Optional[String] $least_time = undef,
  Optional[String] $queue = undef,
  Optional[String] $sticky = undef,
  Optional[String] $sticky_cookie_insert = undef,
  Optional[String] $owner = $::nginx::params::user,
  Optional[String] $group = $::nginx::params::group,
  Optional[String] $mode = $::nginx::params::mode,
  Optional[String] $base_directory = $::nginx::params::base_directory
){
  file { 
    mode   => $mode,
    owner  => $owner,
    group  => $group,
    content => template('nginx/upstream/upstream.erb')
  }
}