class nginx::auth_requests (
  Optional[String] $auth_requests_directory = 'auth_requests',
) inherits nginx::config {

  $auth_request_configs = lookup('auth_requests') |$key| { notice("No hiera data for ${key}") }

  file { 'Auth Requests Directory':
    ensure  => directory,
    path    => "${base_directory}/${includes_directory}/${auth_requests_directory}",
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
