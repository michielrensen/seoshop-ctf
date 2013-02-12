# Adapted from http://projects.puppetlabs.com/projects/1/wiki/Debian_Apache2_Recipe_Patterns

# Define an apache2 site. Place all site configs into
# /etc/apache2/sites-available and en-/disable them with this type.
define stripectf2::apache2site ( $ensure = 'present' ) {
	$apache2_sites = "/etc/apache2/sites"
	case $ensure {
		'present' : {
			exec { "/usr/sbin/a2ensite $name":
				unless => "/bin/readlink -e ${apache2_sites}-enabled/$name",
				notify => Service["apache2"],
			}
		}
		'absent' : {
			exec { "/usr/sbin/a2dissite $name":
				onlyif => "/bin/readlink -e ${apache2_sites}-enabled/$name",
				notify => Service["apache2"],
			}
		}
		default: { err ( "Unknown ensure value: '$ensure'" ) }
	}
}
