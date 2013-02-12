# This file contains default actions to be run, and includes everything from nodes/
# The node specific file (ex: nodes/level02.pp) does level-specific provisioning

import "manifests/**/*.pp"
import "nodes/**/*.pp"

# Set up a default path
Exec {
  path => "/usr/bin:/usr/sbin:/bin:/usr/local/bin"
}

# TODO: Pull in all the level code from ? (github?)
file {'/levels':
	ensure => 'directory',
	mode => '0777',
	owner => 'vagrant',
	group => 'vagrant',
}

# Disable the default apache2 site
stripectf2::apache2_site {'000-default':
	ensure => 'absent',
}

