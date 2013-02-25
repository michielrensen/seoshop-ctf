node 'level03-1.stripe-ctf.com' {
	class {'stripectf2::level03':
		destination => '/levels/03',
		source => '/vagrant/levels/3',
		require => File['/levels'],
	}
}
