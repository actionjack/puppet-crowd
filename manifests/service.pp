
class crowd::service {

  service { 'crowd':
    ensure    => 'running',
    provider  => base,
    start     => '/etc/init.d/crowd start',
    restart   => '/etc/init.d/crowd restart',
    stop      => '/etc/init.d/crowd stop',
    status    => '/etc/init.d/crowd status',
    require   => Class['crowd::config'],
  }

}
