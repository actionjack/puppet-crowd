# Class crowd::params
#
class crowd::params {
  $version        = '2.7.0'
  $user           = 'crowd'
  $group          = 'crowd'
  $product        = 'crowd'
  $format         = 'tar.gz'
  $installdir     = '/opt/crowd'
  $homedir        = '/var/crowd-home'
  $db             = 'mysql'
  $dbuser         = 'crowdadm'
  $dbpassword     = 'mypassword'
  $dbserver       = 'localhost'
  $dbname         = 'crowd'
  $mavenrepopath  = 'http://repo1.maven.org/maven2/mysql/mysql-connector-java'

case $db {
    'mysql': {
      $dbport            = '3306'
      $dbdriver          = 'com.mysql.jdbc.Driver'
      $jdbcversion       = '5.1.26'
      $dbtype            = 'mysql5'
    }
    'postgres': {
      $dbport            = '5432'
      $dbdriver          = 'org.postgresql.Driver'
      $dbtype            = 'postgres72'
      $jdbcversion       = undef
    }
    default: {
      warning("Database type ${db} is not supported")
    }
  }

  $iddb                = 'mysql'
  $iddbuser            = 'idcrowdadm'
  $iddbpassword        = 'mypassword'
  $iddbserver          = 'localhost'
  $iddbname            = 'crowdiddb'

  case $iddb {
    'mysql': {
      $iddbport            = '3306'
      $iddbdriver          = 'com.mysql.jdbc.Driver'
      $idjdbcversion       = '5.1.26'
      $iddbtype            = 'mysql5'
  }
    'postgres': {
      $iddbport            = '5432'
      $iddbdriver          = 'org.postgresql.Driver'
      $iddbtype            = 'postgres72'
      $idjdbcversion       = undef
    }
    default: {
      warning("Database type ${iddb} is not supported")
    }
  }

}