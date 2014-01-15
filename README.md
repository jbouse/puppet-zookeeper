zookeeper
=========

This is the Apache Zookeeper module.

While not explicitly requiring the Apache Bigtop package repository it does provide
the ability to configure it if needed. The module does assume that there will be a
`zookeeper` package which deploys without the system daemon init routines and a
`zookeeper-server` package which enables daemon operations.

Usage
-----

If you simply want a client installation with the ability to interact with the zookeeper
ensemble than you can simply include the following configuration:

```puppet

# Configure Java JDK
class { 'java': }

# Configure Zookeeper client
class { 'zookeper': }
```

To extend and deploy a single standalone zookeeper server:

```puppet

# Configure Java JDK
class { 'java': }

# Configure Zookeeper server
class { 'zookeeper::server': }
```

Without defining an an `$ensemble` zookeeper will run in a non-redundant standalone
mode useful for development work.

A full zookeeper ensemble would involve configuring all servers like the following:

```puppet

# Configure Java JDK
class { 'java': }

# Configure Zookeeper server
class { 'zookeeper::server':
  ensemble => ['zk1.example.com', 'zk2.example.com', 'zk3.example.com'],
  data_dir => '/opt/zookeeper',
}
```

The module matches the ensemble hostname with the Puppet client certificate name
to determine the `myid` value to set on the host. If there is no match then zookeeper
will not be able to locate a valid server config line in the zoo.cfg to listen for
elections.

License
-------

Apache License Version 2.0

Contact
-------

Jeremy T. Bouse <jeremy.bouse@undergrid.net>

Support
-------

Please log tickets and issues on the [GitHub Project](https://github.com/jbouse/puppet-zookeeper)
