# nginx::config::realip
#
# @summary Generates configuration for and nginx realip config
#
# @description The ngx_http_realip_module module is used to change the client
# address and optional port to those sent in the specified header
# field.
#
# @example Include default http settings
#   include nginx::config::realip 
# 
# @param set_real_ip_from Defines trusted addresses that are known to send correct replacement addresses. If the special value unix: is specified, all UNIX-domain sockets will be trusted. 
# @param real_ip_header Defines the request header field whose value will be used to replace the client address.
# @param real_ip_recursive If recursive search is disabled, the original client address that matches one of the trusted addresses is replaced by the last address sent in the request header field defined by the real_ip_header directive. If recursive search is enabled, the original client address that matches one of the trusted addresses is replaced by the last non-trusted address sent in the request header field.
define nginx::config::realip (
  Optional[Array[String]] $set_real_ip_from = undef,
  Optional[String] $real_ip_header = undef,
  Optional[Boolean] $real_ip_recursive = undef,
  Optional[String] $owner = $::nginx::params::user,
  Optional[String] $group = $::nginx::params::group,
  Optional[String] $mode = $::nginx::params::mode,
  Optional[String] $base_directory = $::nginx::params::base_directory
) {

  file { "/etc/nginx/realip.d/${name}":
    path    => "/etc/nginx/realip.d/${name}",
    mode   => $mode,
    owner  => $owner,
    group  => $group,
    content => template('nginx/realip/realip.erb'),
  }
}