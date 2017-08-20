# 
class nginx::package (
  String $version = latest,
  Enum['stable', 'mainline'] $release = 'stable',
  Boolean $managed = true,
  String $packagename = 'nginx',
) {
  case $operatingsystem {
    'Ubuntu': { 
       notice("ubuntu!")
       include nginx::package::ubuntu 
    }
    'CentOS': {
       notice("centos package!")
       include nginx::package::centos
    }
    default: { fail("Unsupported operating system, I'm truly truly sorry") }
  }
}
