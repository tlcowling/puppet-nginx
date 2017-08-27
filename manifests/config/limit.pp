# nginx::config::limit
#
# @summary Generates configuration for an nginx rate limiting
#
# @example Include default http settings
#   include nginx::config::limit 
#
define nginx::config::limit (
  Optional[Hash[String,String]] $limit_req,
  Optional[Enum['info','notice','warn','error']] $limit_req_log_level,
  Optional $limit_req_status,
  Optional $limit_req_zone,
  Optional[String] $owner = $::nginx::params::user,
  Optional[String] $group = $::nginx::params::group,
  Optional[String] $mode = $::nginx::params::mode,
  Optional[String] $base_directory = $::nginx::params::base_directory
) {
  notice("Configuring nginx limit ${name}")

  file { "/etc/nginx/limits.d/${name}":
    ensure  => 'present',
    mode   => $mode,
    owner  => $owner,
    group  => $group,
    content => template('nginx/limits/limits.erb'),
  }
}