class stripectf2::level02 (
	$destination,
	$source,
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

	file {$destination:
		ensure => 'directory',
		recurse => true,
		purge => true,
		force => true,
		mode => '0755',
		owner => 'www-data',
		group => 'www-data',
		source => $source,
	}

	file {"$destination/uploads":
		ensure => 'directory',
		mode => '0777',
		owner => 'www-data',
		group => 'www-data',
		require => File[$destination],
	}
	
	stripectf2::random_password {"${destination}/password.txt":
		require => File[$destination],
	}
	
	file {"${destination}/password.txt":
		mode => '0333',
		owner => 'www-data',
		group => 'www-data',
		require => Stripectf2::Random_password["${destination}/password.txt"],
	}
	
	$document_root = $destination
	file {'/etc/apache2/sites-available/level02':
		content => template('stripectf2/apache2_site_config.erb'),
		notify => Service['apache2']
	}
	
	stripectf2::apache2_site {'level02':
		ensure => 'present',
		require => File['/etc/apache2/sites-available/level02'],
	}
}
