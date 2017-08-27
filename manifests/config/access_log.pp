# nginx::access_logs
#
# @summary Generates configuration access_log in nginx
#
# @example Include default http settings
#   include nginx::access_logs
#
# @param access_log Sets the path, format, and configuration for a buffered log write. 
# Several logs can be specified on the same level. Logging to syslog can be configured by specifying the “syslog:” prefix in the first parameter. The special value off cancels all access_log directives on the current level. If the format is not specified then the predefined “combined” format is used.
# @param log_Format Specifies log format.
# @param open_log_file_cache Defines a cache that stores the file descriptors of frequently used logs whose names contain variables. The directive has the following parameters: 
# 
# max
# sets the maximum number of descriptors in a cache; if the cache becomes full the least recently used (LRU) descriptors are closed
# inactive
# sets the time after which the cached descriptor is closed if there were no access during this time; by default, 10 seconds
# min_uses
# sets the minimum number of file uses during the time defined by the inactive parameter to let the descriptor stay open in a cache; by default, 1
# valid
# sets the time after which it should be checked that the file still exists with the same name; by default, 60 seconds
# off
# disables caching
#
define nginx::config::access_log(
  Optional[
    Hash[
      Enum['path', 'format', 'buffer', 'gzip', 'flush', 'if'],
      Variant[String, Integer]
    ]
  ] $access_log = undef,
  Optional[
    Hash[
      Enum['name', 'escape', 'format'],
      String
    ]
  ] $log_format = undef,
  Optional[
    Hash[
      Enum['max','inactive','min_uses','valid'],
      Variant[Integer, String],
    ]
  ] $open_log_file_cache = undef,
  Optional[String] $owner = $::nginx::config::user,
  Optional[String] $group = $::nginx::config::group,
  Optional[String] $mode = $::nginx::config::mode,
  Optional[String] $base_directory = $::nginx::config::base_directory,
  Optional[String] $includes_directory = $::nginx::config::includes_directory,
  Optional[String] $access_log_directory = $::nginx::access_logs::access_log_directory,
) {
  notice("do we even get here?")
  file { "Access Log ${name}":
    path   => "${base_directory}/${includes_directory}/${access_log_directory}/${name}",
    ensure => 'present',
    mode   => $mode,
    owner  => $owner,
    group  => $group,
    content => template('nginx/log/access_log.erb'),
  }
}