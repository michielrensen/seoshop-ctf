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
		ignore => ['level02-password.txt', 'secret-combination.txt'], # Don't copy the dummy password or combo file
	}
	
	stripectf2::random_password {"${destination}/level02-password.txt":
		require => File[$destination],
	}
	
	file {"${destination}/level02-password.txt":
		mode => '0777',
		owner => 'www-data',
		group => 'www-data',
		require => Stripectf2::Random_password["${destination}/level02-password.txt"],
	}
	
	stripectf2::random_password {"${destination}/secret-combination.txt":
		require => File[$destination],
	}
	
	file {"${destination}/secret-combination.txt":
		mode => '0777',
		owner => 'www-data',
		group => 'www-data',
		require => Stripectf2::Random_password["${destination}/secret-combination.txt"],
	}
	
	file {"${destination}/.htaccess":
		content => "<FilesMatch \".(txt)\">
 Order allow,deny
 Deny from all
 </FilesMatch>"
	}
	
	stripectf2::apache2 {'level01':
		document_root => $destination,
	}
}