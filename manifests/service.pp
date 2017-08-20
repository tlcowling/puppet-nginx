class nginx::service (
  String $ensure = running,
  Boolean $enable = true,
  String $servicename = 'nginx',
){
  case $operatingsystem {
    'Ubuntu': {
       notice('ubuntu!')
       include nginx::service::ubuntu
    }
    'CentOS': {
       notice('centos package!')
       include nginx::service::centos
    }
    default: { fail("Unsupported operating system, I'm truly truly sorry") }
  }

}