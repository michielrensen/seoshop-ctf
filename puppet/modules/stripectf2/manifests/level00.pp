class stripectf2::level00 (
	$destination,
	$source,
) {
	file {$destination:
		ensure => 'directory',
		recurse => true,
		mode => '0755',
		owner => 'vagrant',
		group => 'vagrant',
		source => $source,
	}
	
	file {"${destination}/level00.db":
		# Include hard-coded sqlite db, instead of trying to generate something random
		source => 'puppet:///modules/stripectf2/level00.db',
		require => File[$destination],
	}

	service {'level00.js':
		ensure => 'running',
		start => "cd ${destination} && npm install && node level00.js &",
		provider => 'base',
		require => [File[$destination], File["${destination}/level00.db"]],
	}
	
	service {'apache2':
		ensure => 'running',
		enable => true,
		hasrestart => true,
	}
	
	# Disable the default apache2 site
	stripectf2::apache2_site {'000-default':
		ensure => 'absent',
	}
	
	stripectf2::apache2_module {['proxy', 'proxy_http']:
		ensure => 'present',
	}
	
	$proxy_url = "http://127.0.0.1:3000/"
	file {'/etc/apache2/sites-available/level00':
		content => template('stripectf2/apache2_site_config.erb'),
		notify => Service['apache2'],
	}
	
	stripectf2::apache2_site {'level00':
		ensure => 'present',
		require => File['/etc/apache2/sites-available/level00'],
	}
}
