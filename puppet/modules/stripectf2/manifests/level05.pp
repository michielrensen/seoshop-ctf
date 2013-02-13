class stripectf2::level05 (
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

	# This file tells our service to run in production mode
	file {"${destination}/production":
		ensure => 'present',
		content => '',
		require => File[$destination]
	}

	stripectf2::random_password {"${destination}/password.txt":
		require => File[$destination],
	}

	service {'srv.rb':
		ensure => 'running',
		start => "cd ${destination} && bundle install && ./srv.rb &",
		provider => 'base',
		require => File[$destination]
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
	
	$proxy_url = "http://127.0.0.1:4567/"
	file {'/etc/apache2/sites-available/level05':
		content => template('stripectf2/apache2_site_config.erb'),
		notify => Service['apache2'],
	}
	
	stripectf2::apache2_site {'level05':
		ensure => 'present',
		require => File['/etc/apache2/sites-available/level05'],
	}
}
