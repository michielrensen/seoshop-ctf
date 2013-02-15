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
	
	stripectf2::apache2 {'level06':
		proxy_url => "http://127.0.0.1:4567/",
	}
}
