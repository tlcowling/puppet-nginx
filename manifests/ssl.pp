class nginx::ssl (
  Optional[String] $ssl_directory = 'ssl',
) inherits nginx::config {

  $ssl_configs = lookup('ssl')|$key| { notice("This key is ${key}") }

  file { "${base_directory}/${includes_directory}/${ssl_directory}":
    ensure  => directory,
    recurse => true,
    purge   => true,
    owner   => $user,
    group   => $group,
    mode    => '0750',
  }

  if $ssl_configs {
    $ssl_configs.each |$n, $config| {
      nginx::config::ssl { $n:
        ssl                       => $config['ssl'],
        ssl_ciphers               => $config['ssl_ciphers'],
        ssl_buffer_size           => $config['ssl_buffer_size'],
        ssl_certificate           => $config['ssl_certificate'],
        ssl_certificate_key       => $config['ssl_certificate_key'],
        ssl_client_certificate    => $config['ssl_client_certificate'],
        ssl_crl                   => $config['ssl_crl'],
        ssl_dhparam               => $config['ssl_dhparam'],
        ssl_ecdh_curve            => $config['ssl_ecdh_curve'],
        ssl_password_file         => $config['ssl_password_file'],
        ssl_prefer_server_ciphers => $config['ssl_prefer_server_ciphers'],
        ssl_protocols             => $config['ssl_protocols'],
        ssl_session_cache         => $config['ssl_session_cache'],
        ssl_session_ticket_key    => $config['ssl_session_ticket_key'],
        ssl_session_tickets       => $config['ssl_session_tickets'],
        ssl_session_timeout       => $config['ssl_session_timeout'],
        ssl_stapling              => $config['ssl_stapling'],
        ssl_stapling_file         => $config['ssl_stapling_file'],
        ssl_stapling_responder    => $config['ssl_stapling_responder'],
        ssl_stapling_verify       => $config['ssl_stapling_verify'],
        ssl_trusted_certificate   => $config['ssl_trusted_certificate'],
        ssl_verify_client         => $config['ssl_verify_client'],
        ssl_verify_depth          => $config['ssl_verify_depth'],
      }
    }
  }
}
