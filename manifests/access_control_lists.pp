define nginx::access_control_list (
  Hash[Enum['allow','deny'], Array[String]] $actions
) {
  notice ($actions)
  file { "/etc/nginx/acls/${name}":
    mode    => '0644',
    owner   => 'root',
    group   => 'root',
    content => template('nginx/access_control_list.erb'),
  }
}

class nginx::access_control_lists inherits nginx::config{
  file { '/etc/nginx/acls':
    owner  => $user,
    group  => $group,
    mode   => '0750',
    ensure => 'directory',
  }
  
  $acls = lookup('access_control_lists')

  $acls.each |$aclname, $aclactions| {
    notice("Writing acl for ${aclname}")
    nginx::access_control_list { $aclname:
      actions => $aclactions,
    }
  }
}
