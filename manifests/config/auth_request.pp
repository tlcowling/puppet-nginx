# nginx::config::auth_request
#
# @summary Generates configuration for an nginx auth_request block
#
# @example Include default http settings
#   nginx::config::auth_request {'backend':
#     auth_request => '/auth',
#     auth_request_set => {
#       "giblets"       => "fresh",
#	    "special_token" => "Kenny Explosion",
#     }
#   }
#
# @param auth_request Enables authorization based on the result of a subrequest and sets the URI to which the subrequest will be sent.
# @param auth_request_set Sets the request variable to the given value after the authorization request completes. The value may contain variables from the authorization request, such as $upstream_http_*.
define nginx::config::auth_request(
  Optional[String] $auth_request = undef,
  Optional[Hash[String, String]] $auth_request_set = undef,
){
  notice('Creating Auth Request Config...')

  file { "/etc/nginx/auth_requests.d/${name}":
    path    => "/etc/nginx/auth_requests.d/${name}",
    mode    => '0750',
    owner   => 'nginx',
    group   => 'nginx',
    content => template('nginx/auth_request/auth_request.erb'),
  }

}