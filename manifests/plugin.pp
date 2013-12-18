# Type: eclipse::plugin
#
# This type installs a Eclipse plugin
#
# Sample Usage:
#
#  eclipse::plugin { 'egit': }
#
define eclipse::plugin (
  $method     = 'package',
  $iu         = $title,
  $repository = '',
  $ensure     = present
) {

  include eclipse
  include eclipse::params

  if $method == 'package' and $eclipse::method != 'package' {
    fail('Eclipse plugins cannot be installed as package if Eclipse itself is not')
  }

  case $method {
    package: {
      eclipse::plugin::install::package { $title:
        ensure  => $ensure,
        require => Class['eclipse']
      }
    }
    p2_director: {
      eclipse::plugin::install::p2_director { $title:
        iu         => $iu,
        repository => $repository,
        ensure     => $ensure,
        require    => Class['eclipse']
      }
    }
    default: { fail("Installation method ${method} is not supported") }
  }

}
