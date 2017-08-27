puppet-nginx
=======

A puppet module to configure nginx on linux systems.

Usage
-----

Place this directory structure in your puppet modules
Ensure nginx is included in your manifest or included in whatever mechanism you use, i.e ```hiera_include```


### Site manifest
```puppet
# site.pp
include nginx
```

### Hiera sample example
```puppet
# common.yaml
---
classes:
  - ...whatever other classes you include...
  - nginx
```


Examples
--------

### Default installation
Install the latest version of nginx, using a managed repository and ensure that the service is running with default configuration:

```yaml
# An empty hiera yaml configuration is enough for this
# the module will install with defaults
```

### Modify the nginx base config

```yaml

```

### Create a sample ssl configuration and apply it to a server
```yaml

```

### And much more!

See hieradata/test.yaml...

Motivation
----------

The use case here is 
- to work towards a fully hiera backed nginx config to allow a mechanism for a dynamic change to an nginx config in systems that are highly dependent on puppet
- a way to compose reusable bits of nginx config using the hierarchical concepts of hiera!


I've used variants of this personally for some time, but I figured it was finally time to give back to the community!

The canonical hiera config example: ```hieradata/test.yaml``` 

Development
-----------

To dev on this you can change puppet code and then run

```make test```

Todo (future versions):
----

healthchecks
config logic, more than just param validation, which params make more sense together.
acceptance tests
