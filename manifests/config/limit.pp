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
) {
	notice("Configuring nginx limit ${name}")

	file { "/etc/nginx/limits.d/${name}":
		ensure  => 'present',
		mode    => '0750',
		owner   => 'nginx',
		group   => 'nginx',
		content => template('nginx/limits/limits.erb'),
	}
}