# Class crowd::install
#
class crowd::install {

  require crowd

  File {
    owner   => $crowd::user,
    group   => $crowd::group,
  }

  user { $crowd::user:
    comment          => 'Crowd daemon account',
    shell            => '/bin/true',
    home             => $crowd::homedir,
    managehome       => true,
  } ->

  file { $crowd::homedir:
    ensure  => 'directory',
    recurse => true,
  } ->

  file { $crowd::installdir:
    ensure => 'directory',
  } ->

  deploy::file { "atlassian-${crowd::product}-${crowd::version}.${crowd::format}":
    target  => "${crowd::installdir}/atlassian-${crowd::product}-${crowd::version}-standalone",
    url     => $crowd::downloadURL,
    strip   => true,
    notify  => Exec["chown_${crowd::webappdir}"],
  } ->


  exec { "chown_${crowd::webappdir}":
    command     => "/bin/chown -R ${crowd::user}:${crowd::group} ${crowd::webappdir}",
    refreshonly => true,
    subscribe   => User[$crowd::user]
  } ->

  file { '/etc/init/crowd.conf':
    content => template('crowd/etc/init/crowd.conf.erb'),
    mode    => '0644',
  } ->

  file { '/var/log/crowd':
    ensure => 'directory',
  }

}
