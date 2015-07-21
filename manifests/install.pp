# Private class
class xdmod::install {

  case $::osfamily {
    'RedHat': {
    }
    default: {
      # Do nothing
    }
  }

  package { 'xdmod':
    ensure  => $xdmod::package_ensure,
    name    => $xdmod::package_name,
  }

}
