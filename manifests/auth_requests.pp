class nginx::auth_requests (
  Optional[Hash] $auth_request_configs = undef,
  Optional[String] $include_directory = 'auth_requests',
) inherits nginx::config {

  file { "Auth Requests Directory":
    path    => "${base_directory}/${includes_directory}/${include_directory}",
    ensure  => directory,
    mode    => '0750',
    recurse => true,
    purge   => true,
    owner   => $user,
    group   => $group,
   }

   if $auth_request_configs {
     $auth_request_configs.each |$n, $v| {
       nginx::config::auth_request { $n:
         auth_request     => $v['auth_request'],
         auth_request_set => $v['auth_request_set'],
       }
     }
   }
}
