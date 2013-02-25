class stripectf2::level03 (
	$destination,
	$source,
) {
	service {'secretvault.py':
		ensure => 'running',
		start => "cd ${destination} && python secretvault.py &",
		provider => 'base',
		require => File[$destination]
	}

	file {$destination:
		ensure => 'directory',
		recurse => true,
		purge => true,
		force => true,
		mode => '0755',
		owner=> 'vagrant',
		group=> 'vagrant',
		source => $source,
	}

	stripectf2::apache2 {'level03':
		proxy_url => "http://127.0.0.1:5000/"
	}
}
