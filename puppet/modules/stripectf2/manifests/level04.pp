class stripectf2::level04 (
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
		ignore => 'password.txt', # Don't copy the dummy password.txt file
	}
	
	stripectf2::random_password {"${destination}/password.txt":
		require => File[$destination],
	}

	service {'srv.rb':
		ensure => 'running',
		start => "cd ${destination} && bundle install && bundle exec ./srv.rb &",
		provider => 'base',
		require => Stripectf2::Random_password["${destination}/password.txt"],
	}
	
	cron {'casperjs':
		command => "cd ${destination} && /usr/local/bin/casperjs browser.coffee http://localhost:4567",
		minute => '*',
		environment => "PATH=/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/opt/vagrant_ruby/bin",
		user => 'vagrant',
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
	file {'/etc/apache2/sites-available/level04':
		content => template('stripectf2/apache2_site_config.erb'),
		notify => Service['apache2'],
	}
	
	stripectf2::apache2_site {'level04':
		ensure => 'present',
		require => File['/etc/apache2/sites-available/level04'],
	}
}
