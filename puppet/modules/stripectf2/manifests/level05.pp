class stripectf2::level05 (
	$destination,
	$source,
) {
	file {$destination:
		ensure => 'directory',
		recurse => true,
		purge => true,
		force => true,
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
}
