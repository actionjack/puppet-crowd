
# == Class: crowd
#
# This module is used to install Crowd.
#
# This module requires mkrakowitzer-deploy and maestrodev-wget
#
# === Parameters
#
# === Examples
#
#  class { 'crowd':
#
#  }
#
# === Authors
#
# Martin Jackson
#
#
class crowd (

  # Crowd Settings
  $version           = $crowd::params::version,
  $product           = $crowd::params::product,
  $format            = $crowd::params::format,
  $installdir        = $crowd::params::installdir,
  $homedir           = $crowd::params::homedir,
  $user              = $crowd::params::user,
  $group             = $crowd::params::group,
  $mavenrepopath     = $crowd::params::mavenrepopath,

  # Crowd Database Settings
  $db                = $crowd::params::db,
  $dbuser            = $crowd::params::dbuser,
  $dbpassword        = $crowd::params::dbpassword,
  $dbserver          = $crowd::params::dbserver,
  $dbname            = $crowd::params::dbname,
  $dbport            = $crowd::params::dbport,
  $dbdriver          = $crowd::params::dbdriver,
  $dbtype            = $crowd::params::dbtype,
  $jdbcversion       = $crowd::params::jdbcversion,

  # CrowdID Database Settings
  $iddb                = $crowd::params::iddb,
  $iddbuser            = $crowd::params::iddbuser,
  $iddbpassword        = $crowd::params::iddbpassword,
  $iddbserver          = $crowd::params::iddbserver,
  $iddbname            = $crowd::params::iddbname,
  $iddbport            = $crowd::params::iddbport,
  $iddbdriver          = $crowd::params::iddbdriver,
  $iddbtype            = $crowd::params::iddbtype,
  $idjdbcversion       = $crowd::params::idjdbcversion,


  $poolsize          = '15',

  # JVM Settings
 # $javahome,
  $jvm_xmx      = '1024m',
  $jvm_optional = '-XX:-HeapDumpOnOutOfMemoryError',

  # Misc Settings
  $downloadURL  = 'http://www.atlassian.com/software/crowd/downloads/binary/',

) inherits crowd::params {

  $webappdir    = "${installdir}/atlassian-${product}-${version}-standalone"
  $dburl        = "jdbc:${db}://${dbserver}:${dbport}/${dbname}"
  $iddburl      = "jdbc:${iddb}://${iddbserver}:${iddbport}/${iddbname}"

  include crowd::install
  include crowd::config
  include crowd::service

}
