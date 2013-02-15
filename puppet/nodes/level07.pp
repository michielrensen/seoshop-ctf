node 'level07-1.stripe-ctf.com' {
	class {'stripectf2::level07':
		destination => '/levels/07',
		source => '/vagrant/levels/7',
		require => File['/levels'],
	}
}
