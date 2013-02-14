class stripectf2::level06 (
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
	
	file {"${destination}/password.txt":
		content => "\"Congrats!\" I'd say", # Need a pw with " and '
		require => File[$destination],
	}
	
	/* srv.rb says this is needed for production, but it doesn't look like it
	file {"${destination}/url_root.txt":
		content => "http://${fqdn}",
		require => File[$destination],
	}
	*/

	service {'srv.rb':
		ensure => 'running',
		start => "cd ${destination} && bundle install && bundle exec ./srv.rb &",
		provider => 'base',
		require => File["${destination}/password.txt"],
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
	file {'/etc/apache2/sites-available/level06':
		content => template('stripectf2/apache2_site_config.erb'),
		notify => Service['apache2'],
	}
	
	stripectf2::apache2_site {'level06':
		ensure => 'present',
		require => File['/etc/apache2/sites-available/level06'],
	}
}
