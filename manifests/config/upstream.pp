define nginx::config::upstream (
  Optional[
    Array[
      Hash[
        Enum['address', 'options'],
        Variant[
          String,
          Hash[
            Enum[
              'weight',
              'max_conns',
              'max_fails',
              'fail_timeout',
              'backup',
              'down',
              'resolve',
              'route',
              'service',
              'slow_start',
            ],
            Variant[String,Integer, Boolean]
          ]
        ]
      ]
    ]
  ] $servers = undef,
  Optional[
    Hash[
      Enum['name','size'],
      Variant[String, Integer],
    ]
  ] $zone = undef,
  Optional[String] $state = undef,
  Optional[String] $hash = undef,
  Optional[Boolean] $ip_hash = undef,
  Optional[Variant[String, Integer]] $keepalive = undef,
  Optional[Boolean] $ntlm = undef,
  Optional[Boolean] $least_conn = undef,
  Optional[String] $least_time = undef,
  Optional[
    Hash[
      Enum['number', 'timeout'],
      Variant[String, Integer],
    ]
  ] $queue = undef,
  Optional[
    Hash[
      String,
      Hash[
        Enum[
          'expires',
          'domain',
          'httponly',
          'secure',
          'path',
        ],
        Variant[String, Integer, Boolean]
      ]
    ]
  ] $sticky_cookie = undef,
  Optional[
    Array[String]
  ] $sticky_route = undef,
  Optional[String] $sticky_learn = undef,
  Optional[
    Hash[
      Enum[
        'create',
        'lookup',
        'zone',
        'timeout',
        'header',
      ],
      Variant[
        String,
        Integer,
        Boolean,
      ]
    ]
  ] $sticky_cookie_insert = undef,
  Optional[String] $owner = $::nginx::config::user,
  Optional[String] $group = $::nginx::config::group,
  Optional[String] $mode = $::nginx::config::mode,
  Optional[String] $base_directory = $::nginx::config::base_directory,
  Optional[String] $includes_directory = $::nginx::config::includes_directory,
  Optional[String] $upstreams_directory = $::nginx::upstreams::dirname,
  Optional[Array[String]] $custom = undef,
) {

  file { "${name} upstream config":
    ensure  => 'present',
    path    => "${base_directory}/${includes_directory}/${upstreams_directory}/${name}",
    content => template('nginx/upstreams/upstream.erb'),
    mode    => $mode,
    owner   => $owner,
    group   => $group,
  }
}