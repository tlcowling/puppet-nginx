define anet(
Array[
    Variant[
      Enum[
        'default_server',
        'ssl',
        'http2',
        'spdy',
        'proxy_protocol',
        'deferred', 
      ],
      Hash[
        Enum[
         'address',
         'fastopen',
 	 'backlog', 
         'rcvbuf',
         'sndbuf', 
         'accept_filter', 
         'ipv6only', 
         'so_keepalive'
        ],
        Variant[
          String,
          Integer,
        ],
      ]
    ]
  ] $listen = undef,
){ 
  notice($listen)
}

anet { 'test':
  listen => [
    'ssl',
  ]
}
