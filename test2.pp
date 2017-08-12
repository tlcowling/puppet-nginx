define giblets(
  Variant[Integer, Enum['fresh']] $bob,
){
  notice($bob)
}

giblets { 'tests':
  bob => 1,
}

giblets { 'tests2':
  bob => 'fresh',
}
