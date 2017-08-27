class nginx::access_control_lists (
  Optional[String] $access_control_lists_directory = 'access_control_lists',
) inherits nginx::config{
  file { "${base_directory}/${includes_directory}/${access_control_lists_directory}":
    ensure  => 'directory',
    recurse => true,
    purge   => true,
    owner   => $user,
    group   => $group,
    mode    => '0750',
  }

  $acls = lookup('access_control_lists')

  if $acls {
    $acls.each |$aclname, $aclactions| {
      notice("Writing acl for ${aclname}")
      nginx::config::access_control_list { $aclname:
        actions => $aclactions,
      }
    }
  }
}
