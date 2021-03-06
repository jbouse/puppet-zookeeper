# == Class: zookeeper::server
#
# Apache Zookeeper server deployment
#
# === Parameters
#
# [*ensemble*]
#   (Array) An array of client certificate names (hostnames) that make up
#   the Zookeeper ensemble.
#   Default: $zookeeper::params::ensemble
#
# [*data_dir*]
#   (String) The path to where Zookeeper will store the in-memory database
#   snapshots and transaction log of updates to the databases
#   Default: $zookeeper::params::data_dir
#
# [*client_port*]
#   (Integer) The port to listen for client connections
#   Default: $zookeeper::params::client_port
#
# [*leader_port*]
#   (Integer) The port followers use to connect to the cluster leader
#   Default: $zookeeper::params::leader_port
#
# [*election_port*]
#   (Integer) The port used for leader election if electionAlg is 1, 2 or
#   3 (default). Not necessary if electionAlg is 0.
#   Default: $zookeeper::params::election_port
#
# === Examples
#
#  class { 'zookeeper::server':
#    ensemble      => ['zk1.example.com', 'zk2.example.com', 'zk3.example.com'],
#    data_dir      => '/opt/zookeeper',
#    leader_port   => 2182,
#    election_port => 2183,
#  }
#
# === Authors
#
# Jeremy T. Bouse <jeremy.bouse@undergrid.net>
#
# === Copyright
#
# Copyright 2014 Cox Media Group
#
class zookeeper::server (
  $ensemble      = $::zookeeper::params::ensemble,
  $data_dir      = $::zookeeper::params::data_dir,
  $client_port   = $::zookeeper::params::client_port,
  $leader_port   = $::zookeeper::params::leader_port,
  $election_port = $::zookeeper::params::election_port,
) inherits zookeeper::params {

  package { 'zookeeper-server':
    ensure  => installed,
    require => Package['java']
  }

  service { 'zookeeper-server':
    ensure     => running,
    enable     => true,
    hasrestart => true,
    hasstatus  => true,
    require    => Package['zookeeper-server'],
    subscribe  => File['/etc/zookeeper/conf/zoo.cfg'],
  }

  # Template Uses:
  # - $data_dir
  # - $clien_port
  # - $ensemble
  # - $leader_port
  # - $election_port
  #
  file { '/etc/zookeeper/conf/zoo.cfg':
    ensure    => present,
    owner     => 'root',
    group     => 'root',
    mode      => '0644',
    content   => template('zookeeper/zoo.cfg.erb'),
    require   => Package['zookeeper-server'],
  }

  # Template Uses:
  # - $ensemble
  # - $::clientcert
  #
  if is_array($ensemble) and member($ensemble, $::clientcert) {
    file { "${data_dir}/myid":
      mode    => '0640',
      owner   => 'zookeeper',
      group   => 'zookeeper',
      content => inline_template('<%= @ensemble.index(clientcert).to_i.to_s %>'),
      require => Package['zookeeper-server'],
      notify  => Service['zookeeper-server'],
    }
  }
}
