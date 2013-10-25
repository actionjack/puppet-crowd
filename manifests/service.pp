# Class crowd::install
#
class crowd::service {

  service { 'crowd':
    ensure    => 'running',
    provider  => 'upstart',
    require   => Class['crowd::config'],
  }
}
