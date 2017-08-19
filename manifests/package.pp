# 
class nginx::package (
  String $packageversion = latest,
  Boolean $managed = true,
  String $packagename = 'nginx-full',
) {
  case $operatingsystem {
    'Ubuntu': { 
       notice("ubuntu!")
       include nginx::package::ubuntu 
    }
    default: { fail("Unsupported operating system, I'm truly truly sorry") }
  }
}
