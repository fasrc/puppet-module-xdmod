# Set up Slurm sacct to xdmod injestor
class xdmod::custom_injestor {

  file { '/usr/local/sbin/sacct2xdmod.sh':
    source  => 'puppet:///modules/xdmod/sacct2xdmod.sh',
    owner   => 'root',
    group   => 'root',
  }

  cron { 'sacct2xdmod':
    command => '/usr/local/sbin/sacct2xdmod.sh',
    user    => 'root',
    group   => 'root',
    hour    => '1',
    minute  => '0',
    require => File['/usr/local/sbin/sacct2xdmod.sh'],
  }
}
