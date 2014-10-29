class stripectf2::level08 (
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
	
	stripectf2::random_password {"${destination}/password.txt":
		validchars => '0-9',
		numchars => '12',
		require => File[$destination],
	}

	service {'password_db_launcher':
		ensure => 'running',
		start => "cd ${destination} && ./password_db_launcher `cat password.txt` 127.0.0.1:3000 &",
		provider => 'base',
		require => [File[$destination],
					Service['apache2'],
					Stripectf2::Random_password["${destination}/password.txt"]],
	}
	
	stripectf2::apache2 {'level08':
		proxy_url => "http://127.0.0.1:3000/",
	}
}
