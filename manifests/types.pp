class nginx::types (
  
) inherits nginx::config {
  file { '/etc/nginx/mime.types':
    owner   => $user,
    group   => $group,
    mode    => '0640',
    content => 'types {}'
  }
}
