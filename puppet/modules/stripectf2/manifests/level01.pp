class stripectf2::level01 (
	$destination,
	$source,
) {
	file {$destination:
		ensure => 'directory',
		recurse => true,
		purge => true,
		force => true,
		mode => '0755',
		owner => 'www-data',
		group => 'www-data',
		source => $source,
		ignore => 'level02-password.txt', # Don't copy the dummy password.txt file
	}
	
	stripectf2::random_password {"${destination}/level02-password.txt":
		require => File[$destination],
	}
	
	file {"${destination}/password.txt":
		mode => '0333',
		owner => 'www-data',
		group => 'www-data',
		require => Stripectf2::Random_password["${destination}/level02-password.txt"],
	}
	
	stripectf2::apache2 {'level01':
		document_root => $destination,
	}
}