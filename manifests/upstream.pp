define nginx::upstream (
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
) {
  notice('define an nginx upstream')
}