class stripectf2::level03 (
	$destination,
	$source,
) {
	service {'secretvault.py':
		ensure => 'running',
		start => "cd ${destination} && python secretvault.py &",
		provider => 'base',
		require => Exec['generate_data.py'],
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
	
	file {"${destination}/data":
		ensure => 'directory',
		require => File[$destination],
	}
	
	stripectf2::random_password {"${destination}/data/password.txt":
		require => File["${destination}/data"],
	}
	
	exec {'generate_data.py':
		creates => ["${destination}/data/users.db", "${destination}/data/secrets.json", "${destination}/data/entropy.dat"],
		command => "${destination}/generate_data.py \"${destination}/data\" `cat ${destination}/data/password.txt` \"P = NP because I said so\" \"Perpetual motion is a myth\"",
		require => Stripectf2::Random_password["${destination}/data/password.txt"],
		subscribe => Stripectf2::Random_password["${destination}/data/password.txt"],
		notify => Service['secretvault.py'],
	}
	
	file {"${destination}/local_settings.py":
		content => "url_root = ''",
		mode => '0755',
		owner=> 'vagrant',
		group=> 'vagrant',
	}
}
