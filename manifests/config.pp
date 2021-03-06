# Class crowd::config
#
class crowd::config {

  require crowd

  File {
    owner => $crowd::user,
    group => $crowd::group,
    mode    => '0644',
    require => Class['crowd::install'],
  }

  file {"${crowd::webappdir}/crowd-webapp/WEB-INF/classes/crowd-init.properties":
    content => template('crowd/crowd-init.properties.erb'),
  }

  file {"${crowd::webappdir}/apache-tomcat/conf/Catalina/localhost/openidserver.xml":
    content => template('crowd/openidserver.xml.erb'),
  }

  file {"${crowd::webappdir}/crowd-openidserver-webapp/WEB-INF/classes/jdbc.properties":
    content => template('crowd/jdbc.properties.erb'),
  }
}
