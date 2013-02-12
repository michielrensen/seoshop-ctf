node 'level02-1.stripe-ctf.com' {
	class {'stripectf2::level02':
		destination => '/levels/02',
		source => '/vagrant/levels/2',
		require => File['/levels'],
	}
}
