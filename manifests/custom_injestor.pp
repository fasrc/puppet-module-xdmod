# Set up Slurm sacct to xdmod injestor
class xdmod::custom_injestor inherits xdmod::params {

  file { '/usr/local/sbin/sacct2xdmod.sh':
    ensure  => file,
    content => template('xdmod/sacct2xdmod.erb'),
    owner   => 'root',
    group   => 'root',
  }
}
