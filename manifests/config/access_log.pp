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
  # Optional[
  #   Hash[
  #     String,
  #     Hash[
  #       Enum['escape', 'format'],
  #       String
  #     ]
  #   ]
  # ] $log_format = undef,
  # Optional[
  #   Hash[
  #     String,
  #     Hash[
  #       Enum['max','inactive','min_uses','valid'],
  #       String
  #     ]
  #   ]
  # ] $open_log_file_cache = undef,
  Optional[String] $owner = $::nginx::params::user,
  Optional[String] $group = $::nginx::params::group,
  Optional[String] $mode = $::nginx::params::mode,
  Optional[String] $base_directory = $::nginx::params::base_directory
) {
  file { "${base_directory}/access_logs.d/${name}":
    ensure => 'present',
    mode   => $mode,
    owner  => $owner,
    group  => $group,
    content => template('nginx/log/access_log.erb'),
  }
}