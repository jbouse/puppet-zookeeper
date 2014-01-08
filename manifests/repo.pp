# == Class zookeeper::repo
# Configures the Apache Bigtop archive repoisitory.
#
class zookeeper::repo (
  $version = '0.7.0'
) {
  $baseurl = 'http://bigtop.s3.amazonaws.com/releases'

  if $::osfamily == 'RedHat' {
    $dist = $::operatingsystem ? {
      default => $::lsbmajdistrelease,
      Amazon  => 6,
    }

    yumrepo { "bigtop":
      baseurl  => "${baseurl}/${version}/redhat/${dist}/${::architecture}",
      enabled  => true,
      gpgcheck => true,
      gpgkey   => 'http://archive.apache.org/dist/bigtop/KEYS',
      descr    => 'Bigtop'
    }
  }
}
