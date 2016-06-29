# Set up Slurm sacct to xdmod injestor
class xdmod::custom_injestor {

  file { '/usr/local/sbin/sacct2xdmod.sh':
    source  => 'puppet:///modules/xdmod/sacct2xdmod.sh',
    owner   => 'root',
    group   => 'root',
  }

  file { '/etc/crontab':
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    file_line {'Adding sacct2xdmod to crontab':
      path => '/etc/crontab',  
      line => '00 01 * * * root /usr/local/sbin/sacct2xdmod.sh',
    }
  }
}
