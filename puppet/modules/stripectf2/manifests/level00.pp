class stripectf2::level00 (
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
	
	file {"${destination}/level00.db":
		# Include hard-coded sqlite db, instead of trying to generate something random
		source => 'puppet:///modules/stripectf2/level00.db',
		require => File[$destination],
	}

	service {'level00.js':
		ensure => 'running',
		start => "cd ${destination} && npm install && node level00.js &",
		provider => 'base',
		require => [File[$destination], File["${destination}/level00.db"]],
	}
	
	stripectf2::apache2 {'level00':
		proxy_url => "http://127.0.0.1:3000/",
	}
}
