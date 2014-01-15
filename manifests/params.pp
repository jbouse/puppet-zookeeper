# == Class: zookeeper::params
#
# Apache Zookeeper default parameters
#
# === Variables
#
# [*ensemble*]
#   (Array) An array of client certificate names (hostnames) that make up
#   the Zookeeper ensemble.
#   Default: undefined
#
# [*data_dir*]
#   (String) The path to where Zookeeper will store the in-memory database
#   snapshots and transaction log of updates to the databases
#   Default: /var/lib/zookeeper
#
# [*client_port*]
#   (Integer) The port to listen for client connections
#   Default: 2181
#
# [*leader_port*]
#   (Integer) The port followers use to connect to the cluster leader
#   Default: 2888
#
# [*election_port*]
#   (Integer) The port used for leader election if electionAlg is 1, 2 or
#   3 (default). Not necessary if electionAlg is 0.
#   Default: 3888
#
# === Authors
#
# Jeremy T. Bouse <jeremy.bouse@undergrid.net>
#
# === Copyright
#
# Copyright 2014 Cox Media Group
#
class zookeeper::params {
  $ensemble      = undef
  $data_dir      = '/var/lib/zookeeper'
  $client_port   = 2181
  $leader_port   = 2888
  $election_port = 3888
}
