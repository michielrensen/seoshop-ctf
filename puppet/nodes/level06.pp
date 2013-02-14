node 'level06-1.stripe-ctf.com' {
	class {'stripectf2::level06':
		destination => '/levels/06',
		source => '/vagrant/levels/6',
		require => File['/levels'],
	}
}
