# 
class nginx::package (
  String $version = latest,
  Boolean $managed = true,
) {
  case $operatingsystem {
    'Ubuntu': { include nginx::package::ubuntu }
    default: { fail("Unsupported operating system, I'm truly truly sorry") }
  }
}
