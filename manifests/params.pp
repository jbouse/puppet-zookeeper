# == Class: zookeeper::params
#
# Apache Zookeeper default parameters
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
