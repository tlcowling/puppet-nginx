# nginx::config::limit
#
# @summary Generates configuration for an nginx rate limiting
#
# @description
#
# The ngx_http_limit_req_module module (0.7.21) is used to 
# limit the request processing rate per a defined key, in 
# particular, the processing rate of requests coming from a single 
# IP address.
# 
# The limitation is done using the “leaky bucket” method.
#
# @example Include default http settings
#   include nginx::config::limit 
#
define nginx::config::limit (
  Optional[
    Hash[
      Enum['zone, 'burst','nodelay'],
      Variant[String, Integer, Boolean]
    ],
  ] $limit_req = undef,
  Optional[
    Enum['info','notice','warn','error']
  ] $limit_req_log_level = undef,
  Optional[
    Integer[3]
  ] $limit_req_status = undef,
  Optional[
    Hash[
      Enum['key', 'zone', 'rate'],
      String,
    ]
  ] $limit_req_zone,
  Optional[String] $owner = $::nginx::config::user,
  Optional[String] $group = $::nginx::config::group,
  Optional[String] $mode = $::nginx::config::mode,
  Optional[String] $base_directory = $::nginx::config::base_directory,
  Optional[String] $includes_directory = $::nginx::config::includes_directory,
  Optional[String] $limits_directory = $::nginx::limits::include_directory,
) {
  notice("Configuring nginx limit ${name}")

  file { "Limits Config ${name}":
    path    => "${base_directory}/${includes_directory}/${limits_directory}/${name}",
    ensure  => 'present',
    mode    => $mode,
    owner   => $owner,
    group   => $group,
    content => template('nginx/limits/limits.erb'),
  }
}