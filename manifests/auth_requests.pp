class nginx::auth_requests (
  Optional[Hash] $auth_request_configs = undef,
) inherits nginx::config {
  file { "${base_directory}/auth_requests.d":
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
