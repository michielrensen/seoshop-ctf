# This file contains default actions to be run, and includes everything from nodes/
# The node specific file (ex: nodes/level02.pp) does level-specific provisioning

import "manifests/**/*.pp"
import "nodes/**/*.pp"

# Set up a default path
Exec {
  path => "/usr/bin:/usr/sbin:/bin:/usr/local/bin"
}

file {'/levels':
	ensure => 'directory',
	mode => '0777',
	owner => 'vagrant',
	group => 'vagrant',
}

# Create directory for code, and make sure it's empty
file {'/level_code':
	ensure => 'directory',
	mode => '0777',
	owner => 'vagrant',
	group => 'vagrant',
	recurse => true,
	purge => true,
	force => true,
}

# Using git, export levels folder from origin/master into /level_code
# Not going directly into /levels because level 4 wants to ignore password.txt
exec {'git archive levels':
	command => 'git archive develop levels | tar -x --strip-components 1 -C /level_code',
	cwd => '/vagrant/',
	user => 'vagrant',
	require => File['/level_code'],
}
