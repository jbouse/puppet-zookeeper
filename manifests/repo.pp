# == Class zookeeper::repo
# Configures the Apache Bigtop archive repoisitory.
#
# === Parameters
#
# [*release*]
#   The Apache Bigtop release to deploy. Defaults to 0.7.0 current at this time.
#
# === Examples
#
#  class { 'zookeeper::repo':
#    release = '0.5.0'
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
class zookeeper::repo (
  $release = '0.7.0'
) {
  $baseurl = 'http://bigtop.s3.amazonaws.com/releases'
  $gpgkeyurl = 'http://archive.apache.org/dist/bigtop/KEYS'

  if $::osfamily == 'RedHat' {
    $dist = $::operatingsystem ? {
      default => $::lsbmajdistrelease,
      Amazon  => 6,
    }

    yumrepo { 'bigtop':
      baseurl  => "${baseurl}/${release}/redhat/${dist}/${::architecture}",
      enabled  => 1,
      gpgcheck => 1,
      gpgkey   => $gpgkeyurl,
      descr    => "Apache Bigtop El ${dist} - ${::architecture}",
    }
  }
}
