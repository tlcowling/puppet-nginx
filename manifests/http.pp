class nginx::http (
  String $default_type = 'application/octet-stream',
  Variant[Enum['on','off'], Boolean] $sendfile = 'on',
  Variant[Enum['on','off'], Boolean] $tcp_nopush = 'off',
  Integer $keepalive_timeout = 65,
  Variant[Enum['on','off'], Boolean] $gzip = 'on',
) {


}
