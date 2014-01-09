# == Class: zookeeper::server
#
# Apache Zookeeper server deployment
#
# === Parameters
#
# [*ensemble*]
# [*data_dir*]
# [*client_port*]
# [*leader_port*]
# [*election_port*]
#
# === Variables
#
# [*certname*]
#   Puppet agent certificate name used to identify host in ensemble listing
#
# === Examples
#
#  class { 'zookeeper::server':
#    ensemble => [ 'zk1.example.com', 'zk2.example.com', 'zk3.example.com' ],
#  }
#
# === Authors
#
# Jeremy T. Bouse <jeremy.bouse@undergrid.net>
#
# === Copyright
#
# Copyright 2014 UnderGrid Network Services
#
class zookeeper::server (
  $ensemble      = $::zookeeper::params::ensemble,
  $data_dir      = $::zookeeper::params::data_dir,
  $client_port   = $::zookeeper::params::client_port,
  $leader_port   = $::zookeeper::params::leader_port,
  $election_port = $::zookeeper::params::election_port,
) inherits zookeeper::params {

  require zookeeper

  package { 'zookeeper-server':
    ensure  => installed,
    require => Package['java']
  }

  file { '/etc/zookeeper/conf/zoo.cfg':
    content => template('zookeeper/zoo.cfg.erb'),
    require => Package['zookeeper-server'],
  }

  if defined($ensemble) {
    file { "${data_dir}/myid":
      content => inline_template('<%= ensemble.index(certname).to_i.to_s %>'),
      require => Package['zookeeper-server'],
    }
  }
}
