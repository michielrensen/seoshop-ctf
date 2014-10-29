# Define an apache2 module. Debian packages place the module config
# into /etc/apache2/mods-available.
#
define stripectf2::apache2_module ( $ensure = 'present' ) {
	$apache2_mods = "/etc/apache2/mods"
	case $ensure {
		'present' : {
			exec { "/usr/sbin/a2enmod $name":
				unless => "/bin/readlink -e ${apache2_mods}-enabled/${name}.load",
				notify => Service["apache2"],
			}
		}
		'absent': {
			exec { "/usr/sbin/a2dismod $name":
			   onlyif => "/bin/readlink -e ${apache2_mods}-enabled/${name}.load",
				notify => Service["apache2"],
			}
		}
		default: { err ( "Unknown ensure value: '$ensure'" ) }
	}
}
