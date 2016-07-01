# == Class: xdmod::params
#
# Private class.
#
class xdmod::params {

  $domain_split        = split($::domain, '[.]')
  $resource_name       = $domain_split[0]
  $apache_vhost_name   = "xdmod.${::domain}"
  $portal_settings     = hiera('xdmod_portal_settings', {})
  $hierarchies         = hiera('xdmod_hierarchies', [])
  $group_to_hierarchy  = hiera('xdmod_group_to_hierarchy', {})
  $user_pi_names       = hiera('xdmod_user_pi_names', [])
  $rpm_version         = '4.5.2'
  $rpm_download_source = 'http://heanet.dl.sourceforge.net/project/xdmod/xdmod'
  $rpm_download_url    = "${rpm_download_source}/${rpm_version}/${package_name}-${rpm_version}-1.0.el${::operatingsystemmajrelease}.noarch.rpm"

  case $::osfamily {
    'RedHat': {
      $package_name = 'xdmod'
    }

    default: {
      fail("Unsupported osfamily: ${::osfamily}, module ${module_name} only support osfamily RedHat")
    }
  }

}
