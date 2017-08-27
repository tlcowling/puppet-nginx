# nginx::config::auth_request
#
# @summary Generates configuration for an nginx auth_request block
#
# @example Include default http settings
#   nginx::config::auth_request {'backend':
#     auth_request => '/auth',
#     auth_request_set => {
#       "giblets"       => "fresh",
#	      "special_token" => "Kenny Explosion",
#     }
#   }
#
# @param auth_request Enables authorization based on the result of a subrequest and sets the URI to which the subrequest will be sent.
# @param auth_request_set Sets the request variable to the given value after the authorization request completes. The value may contain variables from the authorization request, such as $upstream_http_*.
define nginx::config::auth_request(
  Optional[String] $auth_request = undef,
  Optional[Hash[String, String]] $auth_request_set = undef,
  Optional[String] $owner = $::nginx::config::user,
  Optional[String] $group = $::nginx::config::group,
  Optional[String] $mode = $::nginx::config::mode,
  Optional[String] $base_directory = $::nginx::config::base_directory,
  Optional[String] $includes_directory = $::nginx::config::includes_directory,
  Optional[String] $auth_requests_directory = $::nginx::auth_requests::include_directory,
){
  notice('Creating Auth Request Config...')

  file { "Auth Request ${name}":
    path    => "${base_directory}/${includes_directory}/${auth_requests_directory}/${name}",
    mode    => $mode,
    owner   => $owner,
    group   => $group,
    content => template('nginx/auth_request/auth_request.erb'),
  }

}