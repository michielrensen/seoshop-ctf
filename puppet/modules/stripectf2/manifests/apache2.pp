define stripectf2::apache2 (
	$site_name = $title,
	$proxy_url = undef,
	$document_root = undef,
) {
	service {'apache2':
		ensure => 'running',
		enable => true,
		hasrestart => true,
	}
	
	# Disable the default apache2 site
	stripectf2::apache2_site {'000-default':
		ensure => 'absent',
	}
	
	if $proxy_url {
		stripectf2::apache2_module {['proxy', 'proxy_http']:
			ensure => 'present',
		}
	}
	
	file {"/etc/apache2/sites-available/${site_name}":
		content => template('stripectf2/apache2_site_config.erb'),
		notify => Service['apache2']
	}
	
	stripectf2::apache2_site {$site_name:
		ensure => 'present',
		require => File["/etc/apache2/sites-available/${site_name}"],
	}
}
