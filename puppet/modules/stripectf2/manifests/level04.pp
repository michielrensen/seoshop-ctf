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
	
	stripectf2::apache2 {'level04':
		proxy_url => "http://127.0.0.1:4567/",
	}
}
