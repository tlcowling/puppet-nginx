define nginx::config::ssl (
  Optional[Boolean] $ssl = undef,
  Optional[Variant[String, Integer]] $ssl_buffer_size = undef,
  Optional[String] $ssl_certificate = undef,
  Optional[String] $ssl_certificate_key = undef,
  Optional[String] $ssl_ciphers = undef,
  Optional[String] $ssl_client_certificate = undef,
  Optional[String] $ssl_crl = undef,
  Optional[String] $ssl_dhparam = undef,
  Optional[String] $ssl_ecdh_curve = undef,
  Optional[String] $ssl_password_file = undef,
  Optional[Boolean] $ssl_prefer_server_ciphers = undef,
  Optional[String] $ssl_protocols = undef,
  Optional[String] $ssl_session_cache = undef,
  Optional[String] $ssl_session_ticket_key = undef,
  Optional[Boolean] $ssl_session_tickets = undef,
  Optional[Boolean] $ssl_session_timeout = undef,
  Optional[Boolean] $ssl_stapling = undef,
  Optional[String] $ssl_stapling_file = undef,
  Optional[String] $ssl_stapling_responder = undef,
  Optional[Boolean] $ssl_stapling_verify = undef,
  Optional[String] $ssl_trusted_certificate = undef,
  Optional[Enum['on', 'off', 'optional', 'optional_no_ca']] $ssl_verify_client = undef,
  Optional[Variant[String, Integer]] $ssl_verify_depth = undef,
) {
  notice("creating ssl config ${name}")
  
  file { "${name} ssl config":
    ensure  => 'present',
    path    => "/etc/nginx/ssl.d/${name}",
    content => template('nginx/ssl/ssl.erb'),
    owner   => 'nginx',
    group   => 'nginx',
    mode    => '0750',
  }
}