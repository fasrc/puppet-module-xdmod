# Private class
class xdmod::install (
    $source = $xdmod::params::rpm_download_url
  ) inherits xdmod::params {

  case $::osfamily {
    'RedHat': {
      $provider = 'rpm',
    }
    default: {
      # Do nothing
    }
  }

  package { 'xdmod':
    ensure   => $xdmod::package_ensure,
    name     => $xdmod::package_name,
    provider => $provider,
    source   => $source,
  }

}
