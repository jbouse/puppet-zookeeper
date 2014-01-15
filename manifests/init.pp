# == Class: zookeeper
#
# Apache Zookeeper client deployment.
#
# === Examples
#
#  class { zookeeper: }
#
# === Authors
#
# Jeremy T. Bouse <jeremy.bouse@undergrid.net>
#
# === Copyright
#
# Copyright 2014 Cox Media Group
#
class zookeeper {
  package { 'zookeeper':
    ensure  => installed,
    require => Package['java']
  }
}
