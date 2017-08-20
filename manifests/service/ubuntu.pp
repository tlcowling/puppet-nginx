class nginx::service::ubuntu inherits nginx::service {
  notice ("Service enable IS ${enable}")
  notice ("Service ensure IS ${ensure}")
  notice ("Service name IS ${servicename}")

  service { $servicename:
    ensure => $ensure,
    enable => $enable,
  }
}